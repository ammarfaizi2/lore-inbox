Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUCBW3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUCBW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:29:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:15579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbUCBW3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:29:45 -0500
Date: Tue, 2 Mar 2004 14:35:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ppc32: macserial.c missing variable declaration
In-Reply-To: <Pine.LNX.4.58L.0403030014530.30738@alpha.zarz.agh.edu.pl>
Message-ID: <Pine.LNX.4.58.0403021434040.3000@ppc970.osdl.org>
References: <1078263053.21573.176.camel@gaston>
 <Pine.LNX.4.58L.0403030014530.30738@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Mar 2004, Wojciech 'Sas' Cieciwa wrote:
>  {
>  	struct mac_serial * info = (struct mac_serial *)tty->driver_data;
>  	unsigned char control, status;
> +	unsigned int cmd;
>  	unsigned long flags;
>  
>  #ifdef CONFIG_KGDB

This can't be right. Those variables are never initialized anywhere.

The usage of 'cmd' should either be removed entirely, or it should be 
passed in as an argument, it looks like. In the meantime, it's better to 
have code that doesn't compile than code that compiles but can't possibly 
do anything sane.

		Linus
