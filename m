Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSIPMVR>; Mon, 16 Sep 2002 08:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSIPMVR>; Mon, 16 Sep 2002 08:21:17 -0400
Received: from fep01.tuttopmi.it ([212.131.248.100]:16121 "EHLO
	fep01-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S261666AbSIPMVP> convert rfc822-to-8bit; Mon, 16 Sep 2002 08:21:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: BENCHMARK - contest results
Date: Mon, 16 Sep 2002 14:36:24 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209161436.24243.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some tests with contest 0.11 . The strange thing is that seems that 
in my machine (an old laptop, see below) each new version of the kernel seems 
to go slowlier, at last in contest results. However, hopping that this is 
useful.

I've tested three versions of the kernel, vanilla 2.4.20-pre[67] and 2.4.18-3 
from RedHat. I've booted the 2.4.20-pre[67] kernels with  the vga=771 option 
and the 2.4.18-3 without options, so maybe this has to do something with the 
results.

Please CC me because I'm not subdcribed in the lkml.

So, here it goes:

Hardware:
**************************************************
Dell Latitude cpi d233st

[fredi@crusher src]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 233.871
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr
bogomips        : 466.94

[fredi@crusher src]$ /sbin/lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP 
disabled) (rev 02)
00:02.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 
128XD] (rev 01)
00:03.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:03.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (B/C) 
Cardbus Fast Ethernet Adapter (rev 10)

[fredi@crusher src]$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  64204800 37556224 26648576        0  1003520 30986240
Swap: 136208384  3698688 132509696
MemTotal:        62700 kB
MemFree:         26024 kB
MemShared:           0 kB
Buffers:           980 kB
Cached:          28128 kB
SwapCached:       2132 kB
Active:          15496 kB
Inactive:        16524 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62700 kB
LowFree:         26024 kB
SwapTotal:      133016 kB
SwapFree:       129404 kB

************************************************************************************************
ps aux:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.2  1372  180 ?        S    05:39   0:03 init
root         2  0.0  0.0     0    0 ?        SW   05:39   0:02 [keventd]
root         3  0.0  0.0     0    0 ?        SW   05:39   0:00 [kapmd]
root         4  0.0  0.0     0    0 ?        SWN  05:39   0:00 
[ksoftirqd_CPU0]
root         5  0.0  0.0     0    0 ?        SW   05:39   0:20 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   05:39   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   05:39   0:00 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   05:39   0:00 [khubd]
root       459  0.0  0.3  1428  200 ?        S    05:40   0:00 syslogd -m 0
root       464  0.0  0.2  1364  148 ?        S    05:40   0:00 klogd -x
root       545  0.0  0.2  1488  156 ?        S    05:40   0:00 /sbin/cardmgr
root       697  0.0  0.2  2344  156 ?        S    05:40   0:00 login -- fredi
root       700  0.0  0.2  1344  128 tty4     S    05:40   0:00 /sbin/mingetty 
tt
root       701  0.0  0.2  1344  128 tty5     S    05:40   0:00 /sbin/mingetty 
tt
root       702  0.0  0.2  1344  128 tty6     S    05:40   0:00 /sbin/mingetty 
tt
fredi      705  0.0  1.1  2480  736 tty1     S    05:40   0:00 -bash
root     29375  0.0  0.4  1344  312 tty3     S    14:02   0:00 /sbin/mingetty 
tt
root     29377  0.0  0.4  1344  312 tty2     S    14:02   0:00 /sbin/mingetty 
tt
fredi     8896  0.0  1.0  2580  656 tty1     R    15:41   0:00 ps aux


2.4.18-3  (RedHat kernel, booted without options)
**************************************************
noload          18:13.88                99%
cpuload         21:36.64                83%
ioload            28:22.85                63%
memload       21:42.91                83%


2.4.20-pre6  (Vanilla, booted with "vga=771")
**************************************************
noload         18:17.99                99%
cpuload       21:51.48                81%
ioload          30:28.49                58%
memload      22:01.68                81%


2.4.20-pre7  (Vanilla, booted with "vga=771")
**************************************************
noload       18:22.68                98%
cpuload     21:50.36                81%
ioload        30:22.56                58%
memload   22:00.38                81%

Frederik Nosi


