Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbULaLkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbULaLkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULaLkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:40:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:20895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261861AbULaLkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:40:12 -0500
Date: Fri, 31 Dec 2004 03:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: opengeometry@yahoo.ca, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-Id: <20041231034003.3c975b50.akpm@osdl.org>
In-Reply-To: <20041231082826.GE7081@logos.cnet>
References: <20041227195645.GA2282@node1.opengeometry.net>
	<20041227201015.GB18911@sweep.bur.st>
	<41D07D56.7020702@netshadow.at>
	<20041229005922.GA2520@node1.opengeometry.net>
	<20041230152531.GB5058@logos.cnet>
	<Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
	<Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
	<20041231035834.GA2421@node1.opengeometry.net>
	<20041231014905.30b05a11.akpm@osdl.org>
	<20041231082826.GE7081@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Fri, Dec 31, 2004 at 01:49:05AM -0800, Andrew Morton wrote:
> > William Park <opengeometry@yahoo.ca> wrote:
> > >
> > > -		printk("VFS: Cannot open root device \"%s\" or %s\n",
> > >  -				root_device_name, b);
> > >  -		printk("Please append a correct \"root=\" boot option\n");
> > >  +		if (--tryagain) {
> > >  +		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
> > >  +		    ssleep (1);
> > >  +		    goto retry;
> > >  +		}
> > >  +		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
> > >  +		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
> > 
> > Why is this patch needed?  If it is to offer the user a chance to insert
> > the correct medium or to connect the correct device, 
> 
> The media may take a while to become readable (think of CDROM).
> 

But the device driver should wait while the media spins up.  If it doesn't,
the kernel would get I/O errors all over the place in normal operation.

