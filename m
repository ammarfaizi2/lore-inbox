Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315679AbSEIKWV>; Thu, 9 May 2002 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315680AbSEIKWU>; Thu, 9 May 2002 06:22:20 -0400
Received: from cm108.omega109.scvmaxonline.com.sg ([218.186.109.108]:6383 "EHLO
	lal.cablix.com") by vger.kernel.org with ESMTP id <S315679AbSEIKWU>;
	Thu, 9 May 2002 06:22:20 -0400
Date: Thu, 9 May 2002 18:28:21 +0800 (SGT)
From: Ng Pek Yong <npy@mailhost.net>
To: <linux-kernel@vger.kernel.org>
cc: <npy@mailhost.net>
Subject: Slow harddisk
Message-ID: <Pine.LNX.4.33.0205091822350.2853-100000@lal.cablix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have 2 Maxtor 5T060H6 HD (60G each), attached to a Promise FastTrak 100 
TX2.

I am using the Promise card as a dumb IDE controller card. 
I run Linux's built-in RAID on the 2 drives (RAID1). 
The OS version is 2.4.7-10 (RedHat 7.2)

The problem is that I have exceptionally slow HD performance, despite
playing around w/ hdparm.

Here's how it look like

-------------------------------
 hdparm  -iv /dev/hde

/dev/hde:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 119150/16/63, sectors = 120103200, start = 0

 Model=Maxtor 5T060H6, FwRev=TAH71DP0, SerialNo=T6HM013C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120103200
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3 
ATA-4 ATA-5 ATA-6 

--------------------------------

hdparm -tT /dev/hde


/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.50 seconds =256.00 MB/sec
 Timing buffered disk reads:  64 MB in 18.46 seconds =  3.47 MB/sec

--------------------------------


As u can see, my buffered disk read is maxed out at 3.5MB/sec.
I have tweaked with -c, -m, -u, -d, -X etc, to no avail.

Any idea if it is  RAID1, the Maxtor HD or the Promise card the cause for 
the slowdown?



Thanks,
-PY


----------------------------------

Other info:

cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1500+
stepping        : 2
cpu MHz         : 1333.420
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2660.76

# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525709312 276729856 248979456  2166784 78929920 109309952
Swap: 1083760640        0 1083760640
MemTotal:       513388 kB
MemFree:        243144 kB
MemShared:        2116 kB
Buffers:         77080 kB
Cached:         106748 kB
SwapCached:          0 kB
Active:          32960 kB
Inact_dirty:    152984 kB
Inact_clean:         0 kB
Inact_target:     3172 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513388 kB
LowFree:        243144 kB
SwapTotal:     1058360 kB
SwapFree:      1058360 kB
NrSwapPages:    264590 pages


