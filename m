Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWE1F3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWE1F3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWE1F3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:29:03 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:22497 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965248AbWE1F3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:29:02 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Query: No IDE DMA for IBM 365X with PIIX chipset?
Date: Sun, 28 May 2006 15:29:35 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Have an old Thinkpad 365X laptop that 'hdparm -i' tells me is 
running mdma2 but it refuses to set dma mode.  2.6.16.18 also 
refuses to set dma.

With 2.432-hf32.6 running 'hdparm -c 1 /dev/hda' speeds up the 
IDE interface from ~5MB/s to ~7.5MB/s for a reading an unmounted 
500MB partition to /dev/null.

Is there something I forgot to do to get DMA operation, or this 
one of those early PIIX that Alan is doing new drivers for?  

I've yet to try development kernels since udev/pcmciautils not 
setup on the thing (yet).

Comment stripped .config and dmesg for 2.4, 2.6 at:
  <http://bugsplatter.mine.nu/test/boxen/hal/>

Thanks,
Grant.

appended:
  dmesg excerpt
  IDE config
  uname -r
  hdparm -v /dev/hda
  lspci -vvvx
  /proc/interrupts
  /proc/dma

dmesg:
...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 00:01.0
PIIXa: chipset revision 2
PIIXa: not 100% native mode: will probe irqs later
PIIXa: neither IDE port enabled (BIOS)
hda: TOSHIBA MK6014MAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 11733120 sectors (6007 MB), CHS=776/240/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >

2.4 IDE settings:
-------------------- IDE, ATA and ATAPI Block devices ------------------
 <*> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
 --- Please see Documentation/ide.txt for help/info on IDE drives
 [ ]   Use old disk-only driver on primary interface
 [ ]   Support for SATA (deprecated; conflicts with libata SATA driver)
 <*>   Include IDE/ATA-2 DISK support
 [ ]     Use multi-mode by default
 [ ]     Auto-Geometry Resizing support
 <M>   PCMCIA IDE support			<<== for CompactFlash (/dev/hdc)
 < >   Cardbus IDE support (Delkin/ASKA/Workbit)
 < >   Include IDE/ATAPI CDROM support
 < >   Include IDE/ATAPI TAPE support
 < >   Include IDE/ATAPI FLOPPY support
 [ ]   IDE Taskfile Access
 --- IDE chipset support/bugfixes
 [ ]   CMD640 chipset bugfix/support
 [ ]   ISA-PNP EIDE support
 [*]   PCI IDE chipset support
 [ ]     Generic PCI IDE Chipset Support	<<== on/off: no difference
 [ ]     Sharing PCI IDE interrupts support
 [*]     Generic PCI bus-master DMA support
 [ ]     Boot off-board chipsets first support
 [ ]       Force enable legacy 2.0.X HOSTS to use DMA
 [*]       Use PCI DMA by default when available
 [ ]     Enable DMA only for disks
 ... (in between off)
 <*>     Intel PIIXn chipsets support
 ... (rest are off)

root@stinkpad:~# uname -r
2.4.32-hf32.6
root@stinkpad:~# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 776/240/63, sectors = 11733120, start = 0
root@stinkpad:~# hdparm -X mdma2 -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 34 (multiword DMA mode2)
 using_dma    =  0 (off)
root@stinkpad:~# lspci -vvvx
00:00.0 Host bridge: Intel Corporation 430MX - 82437MX Mob. System Ctrlr (MTSC) & 82438MX Data Path (MTDP) (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
00: 86 80 35 12 06 00 00 22 02 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 2e 12 07 00 80 02 02 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 VGA compatible controller: Trident Microsystems TGUI 9320 (rev e3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 08000000 (32-bit, non-prefetchable) [size=2M]
        Region 1: Memory at 08200000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 000c0000 [disabled] [size=64K]
00: 23 10 20 93 03 00 00 02 e3 00 00 03 00 00 00 00
10: 00 00 00 08 00 00 20 08 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 0c 00 00 00 00 00 00 00 00 00 00 01 00 00

root@stinkpad:~# cat /proc/interrupts
           CPU0
  0:     106675          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:        490          XT-PIC  xirc2ps_cs
 12:          3          XT-PIC  PS/2 Mouse
 14:       3820          XT-PIC  ide0
 15:          4          XT-PIC  i82365
NMI:          0
ERR:          0

root@stinkpad:~# cat /proc/dma
 4: cascade

