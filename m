Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290602AbSAYId1>; Fri, 25 Jan 2002 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290601AbSAYIdS>; Fri, 25 Jan 2002 03:33:18 -0500
Received: from host-47-84.dsl.innercite.com ([158.222.47.84]:24325 "EHLO
	darkstar.brie.com") by vger.kernel.org with ESMTP
	id <S290602AbSAYIdH>; Fri, 25 Jan 2002 03:33:07 -0500
From: Brian Lavender <brian@brie.com>
Date: Fri, 25 Jan 2002 00:33:06 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: VAIO IRQ assignment problem of USB controller
Message-ID: <20020125003306.A9759@brie.com>
In-Reply-To: <20020124173421.B8732@brie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020124173421.B8732@brie.com>; from brian@brie.com on Thu, Jan 24, 2002 at 05:34:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 05:34:21PM -0800, Brian Lavender wrote:
> I have a Sony VAIO PCG-GR170K laptop with a memory stick which operates
> off of the USB controller with device ID 00:1d.2. The laptop has a total
> of three USB controllers.  The first two are getting IRQ's, but the third
> one is not. Under Win2k, it assigns all three USB controllers IRQ 9. I
> checked the bios for USB options, and the only option I could find is to
> set a "Non PNP" OS.  I found no other USB options. I am currently using
> kernel 2.4.9 from Redhat compiled from the source RPM.  I am guessing
> that this must be a problem somewhere in the PCI IRQ configuration.
> Any other suggestions aside from downloading 2.4.17?

I downloaded the 2.4.17-pre3 kernel from Redhat's site with their patches,
and I compiled it. Still having the same problem with the IRQ. Below is
what I get from lspci and dmesg. This time I did not pass the kernel
pci=biosirq which I had done in the past. Is this something that the
bios just isn't reporting or is there some sort of fix I can do?

$ lspci -vv

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 0
        Region 4: I/O ports at 1840 [size=32]

and the kernel messages give me:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 11:43:41 Jan 24 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:1d.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:1d.2. Please try using pci=biosirq.
usb-uhci.c: found UHCI device with no IRQ assigned. check BIOS settings!
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver

-- 
Brian Lavender
http://www.brie.com/brian/
