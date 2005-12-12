Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVLLVsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVLLVsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLLVsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:48:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750799AbVLLVsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:48:13 -0500
Date: Mon, 12 Dec 2005 13:47:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Message-Id: <20051212134715.2f74bb72.akpm@osdl.org>
In-Reply-To: <200512122239.20264.rjw@sisk.pl>
References: <20051211041308.7bb19454.akpm@osdl.org>
	<200512122155.43632.rjw@sisk.pl>
	<20051212130957.146fbcc3.akpm@osdl.org>
	<200512122239.20264.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Monday, 12 December 2005 22:09, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > >  > It's best to actually send a copy of line 620 - kernels vary a lot, and
> > >  > many developers won't have that particualr -mm tree handy.
> > >  > 
> > >  > The way I normally do this is to do `gdb vmlinux' and then `l
> > >  > *0xffffffff880ad9d0'.
> > > 
> > >  Does it work for modules too?
> > 
> > Ah.  There are certainly ways of doing this - see the kgdb documentation. 
> > Or you can work out the module load address, gdb the module and do the
> > appropriate arithmetic I guess.
> > 
> > Generally I just statically link anything which I want to play with.
> 
> Still, the oops is from a module.  I could link it statically for debugging,
> but then the address would be different to the one in the oops.
> 
> Anyway, please tell me if my reasoning was correct: I thought I couldn't
> figure it out based on the absolute address, but I could use the
> displacements.  Namely, it followed from the oops that the problem
> occured at the address {:ehci_hcd:ehci_irq+224}, which is at the
> offset 224 wrt ehci_irq, so I did:
> 
> gdb drivers/usb/host/ehci-hcd.o
> 
> In gdb I did:
> 
> info line ehci_irq
> 
> and it told me the address the line started at, so I added 224 to it and
> got the line 620.

That's a good way of doing it.
