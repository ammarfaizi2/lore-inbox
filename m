Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129340AbQKXPhX>; Fri, 24 Nov 2000 10:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129391AbQKXPhN>; Fri, 24 Nov 2000 10:37:13 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:44474 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129340AbQKXPhE>; Fri, 24 Nov 2000 10:37:04 -0500
Message-ID: <3A1E8412.5931B6B2@haque.net>
Date: Fri, 24 Nov 2000 10:06:58 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.21.0011240047520.16450-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following followingon every reboot once.

Nov 23 01:14:37 viper kernel: hdb: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Nov 23 01:14:37 viper kernel: hdb: drive_cmd: error=0x04
Nov 23 01:14:37 viper kernel: hdb: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Nov 23 01:14:37 viper kernel: hdb: drive_cmd: error=0x04

hdb is my DVD drive. But other than that I haven't seen any other ide
related errors.


I found these two lines nested in between alot of other messages that I
missed before.

Nov 23 00:35:11 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: bit already cleared for block 147021
Nov 23 00:35:11 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: bit already cleared for block 147021

Then I get these ....

Nov 23 00:40:06 viper kernel: EXT2-fs warning (device ide0(3,3)):
ext2_unlink: Deleting nonexistent file (622295), 0
Nov 23 00:40:06 viper kernel: = 1
Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 540028982,
count = 1
Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 540024880,
count = 1

[mhaque@viper mhaque]$ sudo hdparm -iv /dev/hda   

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 128 (on)
 geometry     = 1650/255/63, sectors = 26520480, start = 0

 Model=IBM-DJNA-371350, FwRev=J76OA30K, SerialNo=GM0GMFE4929
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=26520480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 

[mhaque@viper mhaque]$ sudo hdparm -iv /dev/hdb

/dev/hdb:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  1 (on)
 readahead    = 128 (on)
 HDIO_GETGEO failed: Invalid argument

 Model=CREATIVEDVD-ROM DVD2240E 12/24/97, FwRev=1.7A, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes: pio0 pio1 pio2 pio4 
 DMA modes: sdma0 sdma1 sdma2 sdma? mdma0 mdma1 *mdma2 

Ion Badulescu wrote:
> 
> Ok. Are there any IDE-related errors in your logs prior to getting the f/s
> corruption? They could be relevant no matter how much time passed between
> them and the first signs of corruption.
> 
> Are your drives running with UDMA transfers enabled?
> 
> Thanks,
> Ion
> 
> --
>   It is better to keep your mouth shut and be thought a fool,
>             than to open it and remove all doubt.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
