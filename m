Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTIUFXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 01:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbTIUFXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 01:23:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262331AbTIUFXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 01:23:37 -0400
Date: Sun, 21 Sep 2003 06:23:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the point of __KERNEL_SYSCALLS__?
Message-ID: <20030921052335.GE7665@parcelfarce.linux.theplanet.co.uk>
References: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk> <20030921045411.GC13172@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921045411.GC13172@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- drivers/media/dvb/frontends/alps_tdlb7.c	29 Jul 2003 17:25:42 -0000	1.2
> +++ drivers/media/dvb/frontends/alps_tdlb7.c	21 Sep 2003 04:01:52 -0000
[snip]
> @@ -161,25 +158,25 @@ static int sp8870_read_code(const char *
>  	loff_t l;
>  	char *dp;
>  
> -	fd = open(fn, 0, 0);
> +	fd = sys_open(fn, 0, 0);

*Ugh*

What context is it executed in?  I'd tried to trace the potential callers,
but I don't see immediate reasons to believe that it never can happen in
user task context.  It either should be shown (and commented) or we'd
better switch to filp_open() and friends.  Descriptor tables can be shared...
