Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129124AbQJ2XXR>; Sun, 29 Oct 2000 18:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129295AbQJ2XW5>; Sun, 29 Oct 2000 18:22:57 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:55006 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129124AbQJ2XWq>; Sun, 29 Oct 2000 18:22:46 -0500
Message-ID: <39FCB13E.6267C38D@haque.net>
Date: Sun, 29 Oct 2000 18:22:38 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ide/disk perf?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone who knows ide and drive inside and out (Andre?) please
take a look at these figures? Am I forgetting to do something (or doing
something I'm not suposed to) to get the best numbers? I thought I'd be
able to get more than ~4MB/sec off the HPT366 and a UDMA66 drive.

Kernel: 2.4.0-test10-pre6

Onboard PIIX4 (Abit BE6-II):

	[mhaque@viper mhaque]$ sudo hdparm -X34 -d1 -u1 -c3 -m16 /dev/hda

	/dev/hda:
	 setting 32-bit I/O support flag to 3
	 setting multcount to 16
	 setting unmaskirq to 1 (on)
	 setting using_dma to 1 (on)
	 setting xfermode to 34 (multiword DMA mode2)
	 multcount    = 16 (on)
	 I/O support  =  3 (32-bit w/sync)
	 unmaskirq    =  1 (on)
	 using_dma    =  1 (on)

	[mhaque@viper mhaque]$ dmesg|grep '^hda:'; sudo hdparm -Tt /dev/hda
	hda: IBM-DJNA-371350, ATA DISK drive
	hda: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=1650/255/63,
UDMA(33)

	/dev/hda:
	 Timing buffer-cache reads:   128 MB in  1.12 seconds =114.29 MB/sec
	 Timing buffered disk reads:  64 MB in  4.94 seconds = 12.96 MB/sec

	[mhaque@viper mhaque]$ sudo hdparm -i /dev/hda

	/dev/hda:

	 Model=IBM-DJNA-371350, FwRev=J76OA30K, SerialNo=GM0GMFE4929
	 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
	 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
	 BuffType=3(DualPortCache), BuffSize=1966kB, MaxMultSect=16,
MultSect=16
	 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
	 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=26520480
	 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
	 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
	 UDMA modes: mode0 mode1 mode2 mode3 mode4 



Onboard HPT366 (Abit BE6-II):

	[mhaque@viper mhaque]$ sudo hdparm -X66 -d1 -u1 -c3 -m16 /dev/hde

	/dev/hde:
	 setting 32-bit I/O support flag to 3
	 setting multcount to 16
	 setting unmaskirq to 1 (on)
	 setting using_dma to 1 (on)
	 setting xfermode to 66 (UltraDMA mode2)
	 multcount    = 16 (on)
	 I/O support  =  3 (32-bit w/sync)
	 unmaskirq    =  1 (on)
	 using_dma    =  1 (on)

	[mhaque@viper mhaque]$ dmesg|grep '^hde:'; sudo hdparm -Tt /dev/hde
	hde: Maxtor 53073U6, ATA DISK drive
	hde: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63,
UDMA(66)

	/dev/hde:
	 Timing buffer-cache reads:   128 MB in  1.24 seconds =103.23 MB/sec
	 Timing buffered disk reads:  64 MB in 16.18 seconds =  3.96 MB/sec

	[mhaque@viper mhaque]$ sudo hdparm -i /dev/hde

	/dev/hde:

	 Model=Maxtor 53073U6, FwRev=DA6207V0, SerialNo=K608NRYC
	 Config={ Fixed }
	 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
	 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16,
MultSect=16
	 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
	 CurCHS=65535/1/63, CurSects=-4128706, LBA=yes, LBAsects=60030432
	 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
	 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
	 UDMA modes: mode0 mode1 *mode2 mode3 mode4 


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
