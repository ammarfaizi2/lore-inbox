Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbUKZWIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUKZWIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbUKZWH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:07:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:30952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263652AbUKZTvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:51:41 -0500
X-Authenticated: #20450766
Date: Thu, 25 Nov 2004 22:41:21 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [SMP, USB] UHCI interrupt wrongly routed?
In-Reply-To: <20041125012629.GA21569@kroah.com>
Message-ID: <Pine.LNX.4.60.0411252233470.2518@poirot.grange>
References: <Pine.LNX.4.60.0411242352370.3896@poirot.grange>
 <20041125012629.GA21569@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Greg KH wrote:

> On Wed, Nov 24, 2004 at 11:57:15PM +0100, Guennadi Liakhovetski wrote:
> > 2-way running 2.6.9 the onboard UHCI device is configured to IRQ 9 via 
> > XT-PIC???
> > 
> >            CPU0       CPU1       
> >   0:     588054        123    IO-APIC-edge  timer
> >   1:        360          0    IO-APIC-edge  i8042
> >   2:          0          0          XT-PIC  cascade
> >   8:          4          0    IO-APIC-edge  rtc
> >   9:          0          0    IO-APIC-edge  acpi
> >  11:          0          0          XT-PIC  uhci_hcd
> >  15:          2          0    IO-APIC-edge  ide1
> >  16:        173          1   IO-APIC-level  ehci_hcd
> >  17:          0          0   IO-APIC-level  ohci_hcd
> >  18:          0          0   IO-APIC-level  ohci_hcd
> >  19:      99999          1   IO-APIC-level  ohci_hcd
> >  20:        332          0   IO-APIC-level  eth0
> >  21:       2576          0   IO-APIC-level  sym53c8xx
> > NMI:          0          0 
> > LOC:     587726     587988 
> > ERR:          0
> > MIS:          0

...

> > Linux version 2.6.9-rc4-tmscsim (lyakh@poirot.grange) (gcc version 3.3.2 (Debian)) #1 SMP Mon Oct 25 23:38:23 CEST 2004
> 
> Can you try 2.6.10-rc2 or the latest -bk snapshot?  Hopefully this is
> fixed there.

Unfortunately, the problem is still there with rc2. Do you expect a later 
bk snapshot to be better? I don't really understand how software can fix 
this - it seems to be a BIOS bug - IRQ 11 in irq-pin. Where, looks like, 
it should be 19 (irq 19: nobody cared immediately on USB-insertion). 
Notice, I already run with pci=noacpi, there was one more mis-assigned irq 
in acpi table, don't remember which one though. So, can it really be fixed 
in (stock) kernel, without quirks? Is my only solution PCI rescan with 
dummy-php? Or fix acpi table?... I just still don't understand why irq 11 
is configured as XT-PIC?

Thanks
Guennadi
---
Guennadi Liakhovetski

