Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVF2RQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVF2RQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVF2RPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:15:02 -0400
Received: from iron.pdx.net ([207.149.241.18]:19594 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S262619AbVF2RJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:09:29 -0400
Subject: Re: ASUS K8N-DL Beta BIOS AKA PROBLEM: Devices behind
	PCI	Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Peter Buckingham <peter@pantasys.com>
Cc: linux-kernel@vger.kernel.org, kevin.mullins@asusts.com,
       JASON_RILEY@asusts.com, karim@opersys.com,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dave.jones@redhat.com
In-Reply-To: <42C2D3FD.2080306@pantasys.com>
References: <1119996349.3484.40.camel@oscar.metro1.com>
	 <42C1FD7F.2060003@opersys.com> <1120018942.6936.20.camel@home-lap>
	 <42C2D3FD.2080306@pantasys.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 10:09:27 -0700
Message-Id: <1120064967.3511.4.camel@oscar.metro1.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sean Bruno wrote:
> > Aperture from northbridge cpu 0 too small (32 MB)
> > No AGP bridge found
> > Your BIOS doesn't leave a aperture memory hole
> > Please enable the IOMMU option in the BIOS setup
> > This costs you 64 MB of RAM
> 
> this isn't a big deal, but linux expects an apperture of >= 64MB, you 
> may want to change this setting in your bios.
> 
If the system doesn't have an AGP slot, would it even need to leave an
aperture(this mobo has a 16x PCI-E slot for the video)?

> > init IO_APIC IRQs
> >  IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23 not connected.
> > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> > timer doesn't work through the IO-APIC - disabling NMI Watchdog!
> > ...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 3d.
> > Dazed and confused, but trying to continue
> > Do you have a strange power saving mode enabled?
> >  failed.
> 
> I seem to remember that this may be related to the bios doing the wrong 
> workaround for the timer. on the nvidia chipsets this shouldn't be required.
> 
Would this require ASUS to modify their board/bios?

> > ...trying to set up timer as ExtINT IRQ... works.
> > CPU 1: synchronized TSC with CPU 0 (last diff 17 cycles, maxerr 519 cycles)
> 
> you might want to try enabling ACPI 2.0 or something similar in your 
> bios and use the HPET timer instead.
> 
> > ACPI: Subsystem revision 20050309
> >     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace, AE_NOT_FOUND
> > search_node ffff810142857280 start_node ffff810142857280 return_node 0000000000000000
> >     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
> > search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
> 
> there are problems with the ACPI tables supplied by the bios. Linux is 
> expecting to find these items and does not.
> 
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> >     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
> > search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
> >     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node ffff810142857140), AE_NOT_FOUND
> 
> same as above, the acpi tables are missing information.
So, this is something that ASUS "needs" to fix or is it something that
needs to change in the ACPI part of the kernel?
> 
> > ACPI: PCI Interrupt 0000:02:00.0[A]: no GSI - using IRQ 5
> > PCI: Setting latency timer of device 0000:02:00.0 to 64
> 
> this may be nothing, but it does look a little disturbing (especially 
> since it's the USB controller).
> 
Well not surprisingly, the USB controller doesn't work  :)

> > PCI: cache line size of 64 is not supported by device 0000:00:02.1
> > ehci_hcd 0000:00:02.1: park 0
> > ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
> 
> this is also disconcerting...
> 

> i'm not sure that i've provided a lot of enlightenment...
> 
You have to me at least.  Thanks for the guidance...I hope ASUS can
divine a solution from this information.


> peter

