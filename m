Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSHCSBv>; Sat, 3 Aug 2002 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSHCSBu>; Sat, 3 Aug 2002 14:01:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32242 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317633AbSHCSBu>; Sat, 3 Aug 2002 14:01:50 -0400
Subject: Re: Linux 2.4.19-rc5-ac1 and Intel SCB2 (OSB5) trouble
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aih3v2$11l$1@forge.intermeta.de>
References: <aih3v2$11l$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 20:23:13 +0100
Message-Id: <1028402593.1760.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 18:30, Henning P. Schmiedehausen wrote:
> I fetched 2.4.19-rc5-ac1 and did all my tests with this kernel.
> 
> The problem is: The board does contain the Promise RAID Driver
> BIOS. The customer wants to set up RAID1 with the BIOS and run the box
> under Linux.

Include the ataraid driver for striping on the Promise Fasttrak 100. If
you want to use their own driver boot with ide[n]=off

> 2.4.19 is also not able to set up the OSB5 chipset IDE controller in
> DMA mode. (Yes, I run latest BIOS from Intel)

> PCI: Device 00:0f.1 not available because of resource collisions
> SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.

Linux found the OSB5 but found the BIOS had left colliding PCI
resources. At that point it let that deivce fall back to the generic PIO
legacy IDE driver instead. 2.4.19-ac1 handles this BIOS problem on the
i845 chipset boards, it ought to handle it on the non i845 ones


> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Intel Corp.: Unknown device 3410
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, cache line size 08
> 	Region 0: I/O ports at <unassigned> [size=8]
> 	Region 1: I/O ports at <unassigned> [size=4]
> 	Region 2: I/O ports at <unassigned> [size=8]
> 	Region 3: I/O ports at <unassigned> [size=4]
> 	Region 4: I/O ports at 03a0 [size=16]
> 	Region 5: I/O ports at 0410 [size=4]

I/O ports unassigned. Spank your vendor.

I am curious why the -ac PCI fixups didn't resolve this problem. Out of
interest edit pci-i386.c and remove the IDE test in
pcibios_assign_resources.

