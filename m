Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285677AbRLGXoc>; Fri, 7 Dec 2001 18:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285674AbRLGXo1>; Fri, 7 Dec 2001 18:44:27 -0500
Received: from relay-1m.club-internet.fr ([195.36.216.170]:7103 "HELO
	relay-1m.club-internet.fr") by vger.kernel.org with SMTP
	id <S285659AbRLGXoL>; Fri, 7 Dec 2001 18:44:11 -0500
Date: Sat, 8 Dec 2001 00:46:23 +0100
From: Matthieu PATOU <matthieu.patou@escpi.cnam.fr>
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.x doesn't detect irq for pcmcia card socket
Message-Id: <20011208004623.76244dc0.matthieu.patou@escpi.cnam.fr>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm facing an error which seems not frequent in linux :Dec  7 23:20:35 mobile kernel: Linux Kernel Card Services 3.1.22

2 IRQ are not found in the irq router table (according to the kernel)

Dec  7 09:39:34 mobile kernel: IRQ for 01:02.0:0 -> not found in routing table
Dec  7 09:39:34 mobile kernel: IRQ for 01:02.1:1 -> not found in routing table

This trouble cause me this message whith PCMCIA:

Dec  7 23:20:35 mobile kernel:   options:  [pci] [cardbus] [pm]
Dec  7 23:20:53 mobile kernel: IRQ for 01:02.0:0 -> not found in routing table
Dec  7 23:20:53 mobile kernel: PCI: No IRQ known for interrupt pin A of device 01:02.0. Please try using
 pci=biosirq.
Dec  7 23:20:53 mobile kernel: IRQ for 01:02.1:1 -> not found in routing table
Dec  7 23:20:53 mobile kernel: PCI: No IRQ known for interrupt pin B of device 01:02.1. Please try using
 pci=biosirq.

Adding pci=biosirq (in the append parametter of lilo) doesn't change the problem 

The hardware is an VAIO PCG QR20 with an i815 (EM i think but not sure sony has not respond to my questions)
here is 
Extract from /var/log/kern.log for PCI
Dec  7 22:03:39 mobile kernel: PCI: BIOS32 Service Directory structure at 0xc00f7170
Dec  7 22:03:39 mobile kernel: PCI: BIOS32 Service Directory entry at 0xfd878
Dec  7 22:03:39 mobile kernel: PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
Dec  7 22:03:39 mobile kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
Dec  7 22:03:39 mobile kernel: PCI: Probing PCI hardware
Dec  7 22:03:39 mobile kernel: PCI: IDE base address fixup for 00:1f.1
Dec  7 22:03:39 mobile kernel: PCI: Scanning for ghost devices on bus 0
Dec  7 22:03:39 mobile kernel: PCI: Scanning for ghost devices on bus 1
Dec  7 22:03:39 mobile kernel: Unknown bridge resource 2: assuming transparent
Dec  7 22:03:39 mobile kernel: PCI: IRQ init
Dec  7 22:03:39 mobile kernel: PCI: Interrupt Routing Table found at 0xc00fdf30
Dec  7 22:03:39 mobile kernel: 00:1e slot=00 0:60/56b8 1:61/56b8 2:62/56b8 3:63/56b8
Dec  7 22:03:39 mobile kernel: 01:06 slot=01 0:62/56b8 1:63/56b8 2:60/56b8 3:61/56b8
Dec  7 22:03:39 mobile kernel: 01:04 slot=02 0:61/56b8 1:60/56b8 2:62/56b8 3:63/56b8
Dec  7 22:03:39 mobile kernel: 01:09 slot=00 0:62/56b8 1:63/56b8 2:00/56b8 3:00/56b8
Dec  7 22:03:39 mobile kernel: 01:08 slot=00 0:68/0200 1:00/0000 2:00/0000 3:00/0000
Dec  7 22:03:39 mobile kernel: 00:00 slot=00 0:60/56b8 1:61/56b8 2:62/56b8 3:63/56b8
Dec  7 22:03:39 mobile kernel: 00:1f slot=00 0:60/56b8 1:61/56b8 2:6b/56b8 3:63/56b8
Dec  7 22:03:39 mobile kernel: 00:02 slot=00 0:60/def8 1:61/def8 2:00/def8 3:00/def8
Dec  7 22:03:39 mobile kernel: 00:01 slot=00 0:60/def8 1:61/def8 2:00/def8 3:00/def8
Dec  7 22:03:39 mobile kernel: PCI: Attempting to find IRQ router for 8086:122e
Dec  7 22:03:39 mobile kernel: PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
Dec  7 22:03:39 mobile kernel: PCI: IRQ fixup
Dec  7 22:03:39 mobile kernel: IRQ for 01:02.0:0 -> not found in routing table
Dec  7 22:03:39 mobile kernel: IRQ for 01:02.1:1 -> not found in routing table
Dec  7 22:03:39 mobile kernel: PCI: Allocating resources



Extract form /dev/log/kern.log for PCMCIA
Dec  7 23:20:35 mobile kernel: Linux Kernel Card Services 3.1.22
Dec  7 23:20:35 mobile kernel:   options:  [pci] [cardbus] [pm]
Dec  7 23:20:53 mobile kernel: IRQ for 01:02.0:0 -> not found in routing table
Dec  7 23:20:53 mobile kernel: PCI: No IRQ known for interrupt pin A of device 01:02.0. Please try using
 pci=biosirq.
Dec  7 23:20:53 mobile kernel: IRQ for 01:02.1:1 -> not found in routing table
Dec  7 23:20:53 mobile kernel: PCI: No IRQ known for interrupt pin B of device 01:02.1. Please try using
 pci=biosirq.
Dec  7 23:20:53 mobile kernel: Yenta IRQ list 0018, PCI irq0
Dec  7 23:20:53 mobile kernel: Socket status: 30000410
Dec  7 23:20:53 mobile kernel: Yenta IRQ list 0018, PCI irq0
Dec  7 23:20:53 mobile kernel: Socket status: 30000006

output of lspci for 8086:244c

00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (ICH2) (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
00: 86 80 4c 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 81 11 00 00 10 00 00 00
60: 07 05 0a 0a d0 00 00 00 09 80 80 0a 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 02 28 00 00 02 0f 00 00 04 00 00 00 00 00 00 00
e0: 10 10 00 ff 00 00 00 00 33 22 11 00 01 40 67 45
f0: 0f 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

In the mail found at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.2/0465.html
posted in november 2000
I noticed that the problem was nearly the same and was solved by adding the router name into the irq router table (plus some magic code
) i'm not sure this will solve the problem but dump_pirq and PCI code find a 8086:122e router but in fact it's a 8086:244c ...

Well the trouble i get with this is that system often hangs when inserting or ejecting PCMCIA card (i've spent two weeks playing with david hinds pcmcia modules and options cb_pci_irq and pci_irq_list for instance without great results ...)

So if you know how to solve or to progress in email please feel free to respond to this mail 

Btw my bios force the use of ACPI and i have not joined the result of dump_pirq maybe it is needed ?

Regards
Matthieu 
