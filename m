Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133087AbRDLJnt>; Thu, 12 Apr 2001 05:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRDLJnk>; Thu, 12 Apr 2001 05:43:40 -0400
Received: from p3EE3C797.dip.t-dialin.net ([62.227.199.151]:23556 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S133088AbRDLJna> convert rfc822-to-8bit; Thu, 12 Apr 2001 05:43:30 -0400
Date: Thu, 12 Apr 2001 11:43:14 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19/ide.03252001 bug: "kernel timer added twice"
Message-ID: <20010412114314.A3167@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just spotted these messages in my xconsole:

Apr 12 11:22:19 emma1 kernel: hda: status error: status=0x50 { DriveReady SeekComplete }
Apr 12 11:22:19 emma1 kernel: hda: no DRQ after issuing MULTWRITE
Apr 12 11:22:19 emma1 kernel: hda: ide_set_handler: handler not null; old=c01acc04, new=c01acc04
Apr 12 11:22:19 emma1 kernel: bug: kernel timer added twice at c01a835d.

My system.map mentions these in the vicinity of that address:
c01a8308 T ide_set_handler
c01a836c T current_capacity

The mentioned ide_set_handler:
c01acc04 T task_no_data_intr



The kernel has been compiled with gcc 2.95.2 with some other patches
which should not interfere however. (IDE 2.2.19.03252001, I²C 2.5.5,
ReiserFS 3.5.32, Serial 5.05, autofs4 from 4.0.0pre10, ext3 0.0.6b,
OpenWall OW1 patch)

I cannot tell what has happened exactly, at the time of this writing,
I'm running amanda (backup) which comprises dump and tar and this
message has not shown up again in the past 16 minutes.

This is a Western Digital Caviar AC420400D (seems to be IBM DJNA OEM)
attached to a VIA KT133 (board is a Gigabyte 7ZXR):

lspci info:

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (pr
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0
        Capabilities: [c0] Power Management version 2

hdparm v3.6 info:

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2482/255/63, sectors = 39876480, start = 0

 Model=WDC AC420400D, FwRev=J58OA30K, SerialNo=[NOT SHOWN]
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=3(DualPortCache), BuffSize=1966kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 

-- 
Matthias Andree
