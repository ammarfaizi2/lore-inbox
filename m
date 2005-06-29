Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVF2RHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVF2RHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVF2RFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:05:16 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:44588 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262619AbVF2RBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:01:50 -0400
Message-ID: <42C2D3FD.2080306@pantasys.com>
Date: Wed, 29 Jun 2005 10:01:49 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: linux-kernel@vger.kernel.org, kevin.mullins@asusts.com,
       JASON_RILEY@asusts.com, karim@opersys.com,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dave.jones@redhat.com
Subject: Re: ASUS K8N-DL Beta BIOS AKA PROBLEM: Devices behind PCI	Express-to-PCI
 bridge not mapped
References: <1119996349.3484.40.camel@oscar.metro1.com>	 <42C1FD7F.2060003@opersys.com> <1120018942.6936.20.camel@home-lap>
In-Reply-To: <1120018942.6936.20.camel@home-lap>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2005 16:58:48.0609 (UTC) FILETIME=[D1914110:01C57CCB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

I'm glad things are a little further on for you!

Looking at your dmesg the asus bios is still buggy (but i'm not sure 
it's specifically affecting what you're seeing).

Sean Bruno wrote:
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM

this isn't a big deal, but linux expects an apperture of >= 64MB, you 
may want to change this setting in your bios.

> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> timer doesn't work through the IO-APIC - disabling NMI Watchdog!
> ...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 3d.
> Dazed and confused, but trying to continue
> Do you have a strange power saving mode enabled?
>  failed.

I seem to remember that this may be related to the bios doing the wrong 
workaround for the timer. on the nvidia chipsets this shouldn't be required.

> ...trying to set up timer as ExtINT IRQ... works.
> CPU 1: synchronized TSC with CPU 0 (last diff 17 cycles, maxerr 519 cycles)

you might want to try enabling ACPI 2.0 or something similar in your 
bios and use the HPET timer instead.

> ACPI: Subsystem revision 20050309
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace, AE_NOT_FOUND
> search_node ffff810142857280 start_node ffff810142857280 return_node 0000000000000000
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
> search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000

there are problems with the ACPI tables supplied by the bios. Linux is 
expecting to find these items and does not.

> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
> search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
>     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node ffff810142857140), AE_NOT_FOUND

same as above, the acpi tables are missing information.

> ACPI: PCI Interrupt 0000:02:00.0[A]: no GSI - using IRQ 5
> PCI: Setting latency timer of device 0000:02:00.0 to 64

this may be nothing, but it does look a little disturbing (especially 
since it's the USB controller).

> PCI: cache line size of 64 is not supported by device 0000:00:02.1
> ehci_hcd 0000:00:02.1: park 0
> ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004

this is also disconcerting...

i'm not sure that i've provided a lot of enlightenment...

peter
