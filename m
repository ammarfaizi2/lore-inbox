Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWJ0XKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWJ0XKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWJ0XKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:10:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750990AbWJ0XKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:10:19 -0400
Date: Fri, 27 Oct 2006 16:06:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-Id: <20061027160626.8ac4a910.akpm@osdl.org>
In-Reply-To: <1161989970.16839.45.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<1161989970.16839.45.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 23:59:30 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > different levels.
> 
> Thats actually insufficient. We have link ordered init sequences in
> large numbers of driver subtrees (ATA, watchdog, etc). We'll need
> several more initcall layers to fix that.
> 

It would be nice to express those dependencies in some clearer and less
fragile manner than link order.  I guess finer-grained initcall levels
would do that, but it doesn't scale very well.

But whatever.  I think multithreaded probing just doesn't pass the
benefit-versus-hassle test, sorry.   Make it dependent on CONFIG_GREGKH ;)
