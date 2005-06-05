Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFEPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFEPco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFEPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:32:44 -0400
Received: from pop.gmx.de ([213.165.64.20]:17868 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261586AbVFEPcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:32:36 -0400
X-Authenticated: #18024098
Message-Id: <6.0.3.0.2.20050605171951.041e0598@pop.chello.at>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.3.0
Date: Sun, 05 Jun 2005 17:32:16 +0200
To: linux-kernel@vger.kernel.org
From: Alexander Oberhuber <lzw77rnc@gmx.at>
Subject: serious bug in IDE-Controller Code: Highpoint 370/2 after
  kernal 3.6.1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I discovered a bug that prevents Linux from booting if the Highpoint 370/2 
IDE controller is being used.

Machine: AMD 1200 Athlon  / Motherboard: Gigabyte 7IXe4 / 660 MB Ram 
/  (yes, old, I know)
Video: Radeon 9200 SE , AGP
Eth:   3com 3c900 combo, PCI
USB: Onboard, plus one extra NEC USB 2.0 controller on PCI.
Sound: SB 16 ISA PNP
Lots of IDE harddisks and devices.
No USB devices connected yet.
Highpoint 370/2 IDE controller (naturally)., Bios Version 2.34


Problem: When detecting the Highpoint 370/2, the kernal 2.6.10.1 , used by 
Knoppix 3.9 (27-5-05) oopses. Also the kernal module loading from UBUNTU 
5.04 fails :

(snip from var/log/messages of Ubuntu) :

----long quote start

Jun  5 14:24:05 localhost kernel: AMD7409: 0000:00:07.1 (rev 07) UDMA66 
controller
Jun  5 14:24:05 localhost kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Jun  5 14:24:05 localhost kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:DMA
Jun  5 14:24:05 localhost kernel: hda: IBM-DHEA-38451, ATA DISK drive
Jun  5 14:24:05 localhost kernel: hdb: ST320423A, ATA DISK drive
Jun  5 14:24:05 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  5 14:24:05 localhost kernel: hda: max request size: 128KiB
Jun  5 14:24:05 localhost kernel: hda: 16514064 sectors (8455 MB) w/472KiB 
Cache, CHS=16383/16/63, UDMA(33)
Jun  5 14:24:05 localhost kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 
< p5 >
Jun  5 14:24:05 localhost kernel: hdb: max request size: 128KiB
Jun  5 14:24:05 localhost kernel: hdb: 40011300 sectors (20485 MB) w/512KiB 
Cache, CHS=39693/16/63, UDMA(66)
Jun  5 14:24:05 localhost kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2
Jun  5 14:24:05 localhost kernel: hdc: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
Jun  5 14:24:05 localhost kernel: hdd: LITE-ON DVDRW LDW-811S, ATAPI 
CD/DVD-ROM drive
Jun  5 14:24:05 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun  5 14:24:05 localhost kernel: HPT372A: IDE controller at PCI slot 
0000:00:0a.0
Jun  5 14:24:05 localhost kernel: PCI: Enabling device 0000:00:0a.0 (0105 
-> 0107)
Jun  5 14:24:05 localhost kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> 
GSI 9 (level, low) -> IRQ 9
Jun  5 14:24:05 localhost kernel: HPT372A: chipset revision 2
Jun  5 14:24:05 localhost kernel: hpt: HPT372N detected, using 372N timing.
Jun  5 14:24:05 localhost kernel: FREQ: 157 PLL: 66
Jun  5 14:24:05 localhost kernel: HPT372A: 100%% native mode on irq 9
Jun  5 14:24:05 localhost kernel: hpt: no known IDE timings, disabling DMA.
Jun  5 14:24:05 localhost kernel: hpt: no known IDE timings, disabling DMA.
Jun  5 14:24:05 localhost kernel: hde: MAXTOR 4K060H3, ATA DISK drive
Jun  5 14:24:05 localhost kernel: e886a2fa
Jun  5 14:24:05 localhost kernel: PREEMPT
Jun  5 14:24:05 localhost kernel: Modules linked in: ide_generic 
pdc202xx_new aec62xx alim15x3 atiixp cmd64x cs5520 cs5530 cy82c693 generic 
hpt34x ns87415 opti621 pdc202xx_old piix rz1000 sc1200 serverworks siimage 
sis5513 slc90e66 triflex trm290 via82cxxx floppy usb_storage scsi_mod 
parport_pc parport fbcon font bitblit vga16fb vgastate vesafb cfbcopyarea 
cfbimgblt cfbfillrect usbserial usbhid usbkbd thermal processor fan hpt366 
ide_disk ehci_hcd ohci_hcd usbcore amd74xx ide_core evdev unix
Jun  5 14:24:05 localhost kernel: CPU:    0
Jun  5 14:24:05 localhost kernel: 
EIP:    0060:[pg0+676193018/1070015488]    Not tainted VLI
Jun  5 14:24:05 localhost kernel: EFLAGS: 00010282   (2.6.10-5-386)
Jun  5 14:24:05 localhost kernel: EIP is at pci_bus_clock_list+0x9/0x22 
[hpt366]
Jun  5 14:24:05 localhost kernel: eax: 00000000   ebx: 30070000   ecx: 
80005050   edx: 0000000c
Jun  5 14:24:05 localhost kernel: esi: 00000040   edi: 00000051   ebp: 
e7c35800   esp: e6c11ef8
Jun  5 14:24:05 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun  5 14:24:05 localhost kernel: Process modprobe (pid: 9983, 
threadinfo=e6c10000 task=e78730c0)
Jun  5 14:24:05 localhost kernel: Stack: e886a611 0000000c 00000000 
0000000c 0cc35800 00000000 00c35800 e885ebf8
Jun  5 14:24:05 localhost kernel:        e885edac 000000a1 e885eb68 
e884b6ea e885ebf8 0000000c 00000009 00000282
Jun  5 14:24:05 localhost kernel:        00000000 01871b60 e885eb68 
00000000 00000010 e6c10000 e884b745 e885eb68
Jun  5 14:24:05 localhost kernel: Call Trace:
Jun  5 14:24:05 localhost kernel:  [pg0+676193809/1070015488] 
hpt372_tune_chipset+0xc5/0x11a [hpt366]
Jun  5 14:24:05 localhost kernel:  [pg0+676067050/1070015488] 
probe_hwif+0x327/0x372 [ide_core]
Jun  5 14:24:05 localhost kernel:  [pg0+676067141/1070015488] 
probe_hwif_init_with_fixup+0x10/0x53 [ide_core]
Jun  5 14:24:05 localhost kernel:  [pg0+676079089/1070015488] 
ide_setup_pci_device+0x43/0x76 [ide_core]
Jun  5 14:24:05 localhost kernel:  [pg0+676199220/1070015488] 
hpt366_init_one+0x62/0x69 [hpt366]
Jun  5 14:24:05 localhost kernel:  [pg0+676079488/1070015488] 
ide_scan_pcidev+0x34/0x59 [ide_core]
Jun  5 14:24:05 localhost kernel:  [pg0+676079568/1070015488] 
ide_scan_pcibus+0x2b/0x97 [ide_core]
Jun  5 14:24:05 localhost kernel:  [pg0+677412869/1070015488] 
ide_generic_init+0x5/0x12 [ide_generic]
Jun  5 14:24:05 localhost kernel:  [sys_init_module+212/451] 
sys_init_module+0xd4/0x1c3
Jun  5 14:24:05 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  5 14:24:05 localhost kernel: Code: c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 
c0 ba 01 00 00 00 74 07 83 3b 00 75 da 31 d2 5b 89 d0 5e 5f 5d c3 8b 44 24 
08 0f b6 54 24 04 <80> 38 00 74 10 38 10 75 04 8b 40 04 c3 83 c0 08 80 38 
00 75 f0
Jun  5 14:24:05 localhost kernel:  hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Jun  5 14:24:05 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Jun  5 14:24:05 localhost kernel: hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 
2048kB Cache
Jun  5 14:24:05 localhost kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 10
Jun  5 14:24:05 localhost kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> 
GSI 10 (level, low) -> IRQ 10
Jun  5 14:24:05 localhost kernel: 3c59x: Donald Becker and others.  [snip]
Jun  5 14:24:05 localhost kernel: 0000:00:0c.0: 3Com PCI 3c900 Boomerang 
10Mbps Combo at 0xdc00. Vers LK1.1.19
Jun  5 14:24:05 localhost kernel: eth0: Dropping NETIF_F_SG since no 
checksum feature.
Jun  5 14:24:05 localhost kernel: NET: Registered protocol family 17
Jun  5 14:24:05 localhost kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> 
GSI 10 (level, low) -> IRQ 10
Jun  5 14:24:05 localhost kernel: cloop: Initializing cloop v2.01
Jun  5 14:24:05 localhost kernel: cloop: loaded (max 8 devices)
Jun  5 14:24:05 localhost kernel: loop: loaded (max 8 devices)

----long quote end

The only _working_ kernal version is 2.6.1 #1 SMP (Jan 15 2004) , which is 
being used in Knoppix 3.4, Special C'T edition 4/2004. On the same CD, 
there is a 2.4 Kernal, which does _NOT_ work, and displays an OOPS msg 
immidately after booting.

Thus, it is my wild guess that some bug was introduced between 2.6.1 and 
2.6.10.y and later versions.

Yes, I know my hardware is weird. Any help, is appreciated, anyway. :-)

Yours
Alex

