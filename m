Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263993AbUECVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUECVBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUECVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:01:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:56034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263993AbUECVBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:01:48 -0400
Date: Mon, 3 May 2004 14:02:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040503140251.274e1239.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
	<16534.35355.671554.321611@napali.hpl.hp.com>
	<Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> How about this patch? 

Seems sane.  For after 2.6.6 ;)

> +static inline long open(const char * name, int mode, int flags)
> +{
> +	return sys_open((const char __user *) name, mode, flags);
> +}

We may as well stick the get_fs()/set_fs() stuff in here as well - all
callers need to do it, after all.  After which it would best be uninlined.

We can then remove all those `errno's from all over the place, too.  I have
a patch for that.

