Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTDVPIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDVPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:08:21 -0400
Received: from [192.67.198.81] ([192.67.198.81]:4264 "EHLO post.webmailer.de")
	by vger.kernel.org with ESMTP id S263199AbTDVPIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:08:17 -0400
Date: Tue, 22 Apr 2003 17:08:35 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.21-rc1: DMA disabled for ide-scsi
Message-Id: <20030422170835.581fc472.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.21-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is odd. Since 2.4.21-pre5 I can't enable dma for my cd-rom drive. (I haven't checked pre1-pre4) This only happens when ide-scsi is been loaded. If I'm using "the normal" ide-cd everything works fine.

When loading ide-scsi, linux explicitely disables dma:

kernel: SCSI subsystem driver Revision: 1.00
kernel: hdb: attached ide-scsi driver.
kernel: hdb: DMA disabled
kernel: hdd: attached ide-scsi driver.
kernel: hdd: DMA disabled
kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
kernel:   Vendor: COMPAQ    Model: CD-ROM LTN485     Rev: KQA4
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
kernel:   Vendor: HP        Model: CD-Writer+ 9100b  Rev: 1.06
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02

Why does linux do this ? I digged in the sources but couldn't find any appropiate changes which can cause this behaviour.

# hdparm -d1 /dev/hdb

/dev/hdb:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


However with ide-cd everything works as expected:

kernel: hdb: attached ide-cdrom driver.
kernel: hdb: ATAPI 48X CD-ROM drive, 120kB Cache
kernel: hdd: attached ide-cdrom driver.
kernel: hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache

Copying with ide-cd is significantly faster and consumes less cpu load (dma enabled), but with ide-scsi it is slow (700 KB/s) like pio/4.

Any clues ?



# hdparm -i /dev/hdb

/dev/hdb:

 Model=LTN485, FwRev=KQA4, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
 AdvancedPM=no

# hdparm -i /dev/hdd

/dev/hdd:

 Model=Hewlett-Packard CD-Writer Plus 9100b, FwRev=1.06, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
 AdvancedPM=no

$ lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:10.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:10.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
00:14.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:14.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:14.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:14.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)


*Kristian

-- 

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 ::                            _\_V
  :.........................:
