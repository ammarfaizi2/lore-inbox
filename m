Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCVMcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCVMcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCVMcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:32:31 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61957 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261167AbVCVMb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:31:56 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Samsung 40G drive locking up 2.6.11
Date: Tue, 22 Mar 2005 14:31:48 +0200
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503221431.31549.vda@ilport.com.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dd if=/dev/hdc of=/dev/null with this disk
kills the system. Drive may do it's work
for minute or two, but then it does 'klak' sound.
With udma5 (default) Linux froze solid, no SysRq key, nothing.
Powercycling helps.

With udma3, it did not die, but still spews IDE errors.
I will try to collect more data points.
--
vda

# hdparm -i
/dev/hdc:

 Model=SAMSUNG SV0411N, FwRev=UA100-07, SerialNo=S01RJ10X122453
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=66055248
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

# lspci
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)

Boot log (IDE unrelated stuff deleted):
Linux version 2.6.11-smp8k (root@firebird) (gcc version 3.4.1) #2 SMP Fri Mar 18 11:15:21 EET 2005
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SV0411N, ATA DISK drive
hdb: OEM CD-ROM F522B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG SV0411N, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: max request size: 1024KiB
hdc: Host Protected Area detected.
        current capacity is 66055248 sectors (33820 MB)
        native  capacity is 78242976 sectors (40060 MB)
hdc: Host Protected Area disabled.
hdc: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4
hdb: ATAPI 48X CD-ROM drive, 0kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.

