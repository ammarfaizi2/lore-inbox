Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284328AbRLCIvn>; Mon, 3 Dec 2001 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284416AbRLCIuL>; Mon, 3 Dec 2001 03:50:11 -0500
Received: from a212-113-187-216.netcabo.pt ([212.113.187.216]:38845 "HELO
	cafeina.think.co.pt") by vger.kernel.org with SMTP
	id <S284678AbRLCCsn>; Sun, 2 Dec 2001 21:48:43 -0500
Date: Mon, 3 Dec 2001 02:52:17 +0000
From: Pedro Alves <pmalves@think.co.pt>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Atapi cdrom problem: wrong speed found by ide-cdrom
Message-ID: <20011203025217.A18798@cosmos.inesc.pt>
Mail-Followup-To: Pedro Alves <pmalves@think.co.pt>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=pt_PT
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi. My cdrom is not working properly in linux (a plain 40x atapi-ide
 cdrom, unbranded as far as I can see from the outside :) ). The
 problem is that it is not working at full speed. Putting a data cd,
 here is the benchmark:

 hdparm -tT /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  2.80 seconds = 45.71 MB/sec
 Timing buffered disk reads:  64 MB in 66.50 seconds =985.50 kB/sec

 If I force speed 40 with hdparm -E 40, for about 20 secs, the
 benchmarks turns into:

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  2.43 seconds = 52.67 MB/sec
 Timing buffered disk reads:  64 MB in 24.82 seconds =  2.58 MB/sec


 After a time of inactivity or if I change media, the cdrom "slows
 down" to the original speed. I tried to play with hdparm, with no
 sucess. If I put an audio cd in the drive, I cannot change the read
 speed, nor with hdparm neither with cdparanoia (forcing speed with
 -S).

 Is there any way to force a default speed for the drive?

 Here goes some data:

___
dmesg | grep CDROM
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive (no, its not dvd reader)

___
hdparm -i -v /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  1 (on)
 readahead    =  8 (on)
 HDIO_GETGEO failed: Invalid argument

 Model=ATAPI CDROM, FwRev=V130H, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 

___
uname -a
Linux neraka 2.4.11 #1 Mon Nov 12 00:37:05 Local time zone must be
set--see zic manuai686 i686 unknown

___
cat /proc/ide/hdc/driver 
ide-cdrom version 4.59

___
cat /proc/ide/hdc/model 
ATAPI CDROM (not very helpfull...)

___
sudo cat /proc/ide/hdc/settings
name        value     min     max   mode
----        -----     ---     ---   ----
breada_readahead    4     0     127   rw
current_speed     0     0     69   rw
dsc_overlap     1     0     1   rw
file_readahead    0     0     2097151   rw
ide_scsi      0     0     1   rw
init_speed      0     0     69   rw
io_32bit      0     0     3   rw
keepsettings    0     0     1   rw
max_kb_per_request  127     1     127   rw
nice1       1     0     1   rw
number      2     0     3   rw
pio_mode      write-only  0     255   w
slow        0     0     1   rw
unmaskirq     0     0     1   rw
using_dma     0     0     1   rw


-- 
Pedro Miguel G. Alves

THINK - Tecnologias de Informação
Av. Defensores de Chaves nº 15 4ºD, 1000-109 Lisboa Portugal
Tel: +351 21 3590285   Fax: +351 21 3582729
HomePage: www.think.co.pt
