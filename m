Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTKIAqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTKIAqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:46:39 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:43398 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261678AbTKIAqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:46:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 8 Nov 2003 16:46:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI with SiS: Cannot allocate resource.
In-Reply-To: <200311090038.22057.Alexander.Zviagine@cern.ch>
Message-ID: <Pine.LNX.4.44.0311081555380.2122-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Alexander ZVYAGIN wrote:

> I tried 2.6.0-test9 kernel on my 3-years old laptop and it seems I have 
> exactly the same problems which I had 3 years ago....
> There are mainly three of them
> - graphics framebuffer mode does not work
> - strange messages from the IRQ router
> - sound does not work
> 
> The problem with my graphic card is a driver, I think. I overcame it once with 
> the help of patches from Thomas Winischhofer
> (http://www.winischhofer.net/linuxsisvga.shtml) and I hope I can do this 
> again. So we can forget about it. But the two others are more intresting. May 
> be they are important for the kernel...
> 
> PCI: IRQ 0 for device 0000:00:01.3 doesn't match PIRQ mask - try 
> pci=usepirqmask
> PCI: Cannot allocate resource region 0 of device 0000:00:01.4
> ....
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 0000:00:00.1
> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS630 ATA 66 controller
> 
> I did not try to provide these "idebus=xx" and "pci=usepirqmask" yet... I have 
> no idea what should I do... May be the kernel is right by complaining?
> If I am supposed to have a reduced performance of my HD with 33MHz bus, then I 
> am not sure: Linux definitely works much faster with I/O then Windows on my 
> laptop.

Can you try to apply this over test9:

http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test9-bk13.bz2

Also the output of "lspci -vv -xxx" (from root) would help. Don't worry 
about the "pci=usepirqmask" thing. The default value in the IRQ routing 
table is 0x80 (disabled) and this will make the warning message to show 
up, since the irq_router->get() return 0 on 0x80.



- Davide






