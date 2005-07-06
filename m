Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVGFUCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVGFUCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVGFUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261155AbVGFRRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:17:18 -0400
Date: Wed, 6 Jul 2005 10:16:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: akpm@osdl.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
In-Reply-To: <20050706164724.GB14165@kroah.com>
Message-ID: <Pine.LNX.4.58.0507060958590.3570@g5.osdl.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl>
 <20050706164724.GB14165@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Greg KH wrote:
>
> On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
> > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
> > PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
> > PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1
> 
> Do you also get the above errors on booting with -rc1?

I'd assume so - there are basically no resource changes in -rc2, but -rc1 
has a lot of PCMCIA updates. Dominik - the full dmesg is in the original 
report by Rafael on linux-kernel, mind taking a look?

However, the above also seems to have tried to allocate a 64-bit resource,
and I wonder if that's right. Rafael, what does lspci say? Is that 2:1.1
device actually 64-bit capable? Sounds unlikely (they are pretty rare),
and hat would be a PCI layer bug if not.

> > PCI: Bus 3, cardbus bridge: 0000:02:01.0
> >   IO window: 0000b000-0000bfff
> >   IO window: 0000c000-0000cfff
> >   PREFETCH window: 30000000-31ffffff
> > PCI: Bus 7, cardbus bridge: 0000:02:01.1
> >   PREFETCH window: 32000000-33ffffff
> > PCI: Bridge: 0000:00:0a.0
> >   IO window: b000-dfff
> >   MEM window: f8a00000-feafffff
> >   PREFETCH window: 30000000-34ffffff
> > PCI: Bridge: 0000:00:0b.0
> >   IO window: disabled.
> >   MEM window: f6900000-f89fffff
> >   PREFETCH window: c6800000-e67fffff
> > PCI: Setting latency timer of device 0000:00:0a.0 to 64
> > PCI: Device 0000:02:01.0 not available because of resource collisions
> > PCI: Device 0000:02:01.1 not available because of resource collisions
> 
> And these?  As this is your carbus bridge, I'm guessing that is why -rc2
> is failing for you.

Indeed, if 2:1.1 is your cardbus bridge, I can pretty much guarantee that
it's not using 64-bit windows. So Greg, I think you might be at least
partially involved..

		Linus
