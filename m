Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbULaLnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbULaLnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbULaLnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:43:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:61343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbULaLnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:43:08 -0500
Date: Fri, 31 Dec 2004 03:42:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: opengeometry@yahoo.ca, juhl-lkml@dif.dk, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-Id: <20041231034257.7d2f7d39.akpm@osdl.org>
In-Reply-To: <41D5376A.8000705@grupopie.com>
References: <20041227195645.GA2282@node1.opengeometry.net>
	<20041227201015.GB18911@sweep.bur.st>
	<41D07D56.7020702@netshadow.at>
	<20041229005922.GA2520@node1.opengeometry.net>
	<20041230152531.GB5058@logos.cnet>
	<Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
	<Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
	<20041231035834.GA2421@node1.opengeometry.net>
	<20041231014905.30b05a11.akpm@osdl.org>
	<41D5376A.8000705@grupopie.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> wrote:
>
> Andrew Morton wrote:
> > William Park <opengeometry@yahoo.ca> wrote:
> > 
> >>-		printk("VFS: Cannot open root device \"%s\" or %s\n",
> >> -				root_device_name, b);
> >> -		printk("Please append a correct \"root=\" boot option\n");
> >> +		if (--tryagain) {
> >> +		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
> >> +		    ssleep (1);
> >> +		    goto retry;
> >> +		}
> >> +		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
> >> +		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
> > 
> > 
> > Why is this patch needed?  If it is to offer the user a chance to insert
> > the correct medium or to connect the correct device, why not rely upon the
> > user doing that thing and then hitting reset?
> 
> No, no. The problem is not user interaction.
> 
> The problem is that the USB subsystem takes a lot of time to go through 
> the hostcontrollers -> hubs -> devices. By the time it finds the USB 
> mass storage that is supposed to be used as root filesystem, the kernel 
> had already panic'ed.

That would be a USB bug, surely.  If /dev/usb/foo is present and
functioning correctly, and higher-level code tries to access that device,
USB should _not_ error out - it should block the caller until everything is
sorted out.

