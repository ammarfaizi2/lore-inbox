Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129986AbRBZUl3>; Mon, 26 Feb 2001 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130141AbRBZUlU>; Mon, 26 Feb 2001 15:41:20 -0500
Received: from pollux.cse.Buffalo.EDU ([128.205.35.2]:6649 "EHLO
	pollux.cse.Buffalo.EDU") by vger.kernel.org with ESMTP
	id <S129986AbRBZUlF>; Mon, 26 Feb 2001 15:41:05 -0500
Date: Mon, 26 Feb 2001 15:41:04 -0500 (EST)
From: Jason Rappleye <rappleye@cse.Buffalo.EDU>
To: linux-kernel@vger.kernel.org
cc: jonesm@ccr.buffalo.edu
Subject: timeout waiting for DMA
Message-ID: <Pine.GSO.4.21.0102261526330.15135-100000@pollux.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm running kernel 2.4.2 on an SGI 1100 (dual PIIIs) with a Serverworks
III LE based motherboard. The disk is a Seagate ST330630A. The disk has
DMA enabled at boot time :

hda: ST330630A, ATA DISK drive
hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(33)

(also verified using hdparm)

but after a while (eg partway through running bonnie with a 1GB file) I
get the following errors:

Feb 24 22:51:02 nash2 kernel: hda: timeout waiting for DMA 
Feb 24 22:51:02 nash2 kernel: ide_dmaproc: chipset supported ide_dma_timeout 
func only: 14 
Feb 24 22:51:02 nash2 kernel: hda: irq timeout: status=0x58 { DriveReady
SeekComplete DataRequest }
<repeats a few times>
Feb 24 22:51:32 nash2 kernel: hda: DMA disabled

I can reenable DMA without any problems, but after some additional disk
activity (eg running bonnie again), the error occurs again. 

Additional information on my hardware is given below. Any suggestions on
how this can be resolved?

Thanks,

Jason

hdparm -i /dev/hda

/dev/hda:

 Model=ST330630A, FwRev=3.21, SerialNo=3CK0JDFE
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=0(?), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=59777640
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 *mode2 mode3 mode4 

Relevant portion of /proc/pci:

  Bus  0, device  15, function  1:
    IDE interface: PCI device 1166:0211 (ServerWorks) (rev 0).
      Master Capable.  Latency=64.  
      I/O at 0x3080 [0x308f].

Relevant portion of lspci -v:

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a
[Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 3080 [size=16]


--
Jason Rappleye
rappleye@buffalo.edu		
http://www.ccr.buffalo.edu/jason.htm


