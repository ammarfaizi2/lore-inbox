Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTJJXFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTJJXFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:05:43 -0400
Received: from kerberos.astonia.com ([195.90.31.33]:64944 "EHLO
	kerberos.astonia.com") by vger.kernel.org with ESMTP
	id S263162AbTJJXFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:05:23 -0400
Message-Id: <5.1.0.14.0.20031011002359.048d1ad0@195.90.31.33>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 11 Oct 2003 00:54:27 +0200
To: linux-kernel@vger.kernel.org
From: Daniel Brockhaus <joker@astonia.com>
Subject: Excessive swapping in spite of lots of free memory
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I hope I'm not reporting old news here. I've searched the archive and the 
FAQ, but couldn't find anything. Anyway. Here's the problem:

Ever since I moved from Redhat 7.1 to Redhat 9 (don't remember the old 
kernel version I'm afraid) I had trouble with the system swapping like mad. 
The best example is a computer with 256MB RAM, of which 90MB are used (the 
kernel uses the remaining 160MB for harddisk cache/buffers). But I still 
get about 10 writes and 0.3 reads per second to the swap partition (as 
reported by sar and iostat). I don't mind the reads but the writes are... 
excessive.

I've solved the problem for this server by disabling swap - and it works 
without any problems - but on the other computers I don't have that much 
memory to spare, and I'd really like to have the swap space as a "reserve", 
in case memory gets tight.

I'm running three computers, all of which show this behaviour. They are 
running no processes besides the essentials (syslogd, klogd, crond, atd, 
mingetty, ntpd, sshd and sendmail, plus the usual kernel processes) and a 
server for an online game. This game server (and I assume it is the one 
causing the "bug") uses anonymous mmap() to allocate memory. It allocates 
about 25MB in 14 areas which are grown or shrunk, depending on the memory 
needs in that particular area.

Is this a known problem? Are there any workarounds? Is there anything I can 
do besides buy more RAM and disable swap everywhere?

I won't be able to do a lot of testing, I'm afraid, and I cannot move to 
any "unstable" development kernel. It is a commercial setup, and every 
downtime or crash is expensive.

Here's some more info about the computer I mentioned above. Let me know if 
you need anything else:

# cat /proc/version
Linux version 2.4.20-19.9 (bhcompile@stripples.devel.redhat.com) (gcc 
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Tue Jul 15 17:18:13 EDT 2003

# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  261378048 256589824  4788224        0 50667520 110481408
Swap:        0        0        0
MemTotal:       255252 kB
MemFree:          4676 kB
MemShared:           0 kB
Buffers:         49480 kB
Cached:         107892 kB
SwapCached:          0 kB
Active:         184712 kB
ActiveAnon:      71452 kB
ActiveCache:    113260 kB
Inact_dirty:      1192 kB
Inact_laundry:   39564 kB
Inact_clean:      4492 kB
Inact_target:    45992 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255252 kB
LowFree:          4676 kB
SwapTotal:           0 kB
SwapFree:            0 kB

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1697.167
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3381.65

# cat /proc/pci
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8753 [P4X266 AGP] (rev 1).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device   9, function  0:
     RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 1).
       IRQ 12.
       Master Capable.  Latency=32.  Min Gnt=9.
       I/O at 0xd000 [0xd00f].
       Non-prefetchable 32 bit memory at 0xec821000 [0xec82100f].
       Non-prefetchable 32 bit memory at 0xec000000 [0xec7fffff].
   Bus  0, device  11, function  0:
     Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 12).
       IRQ 5.
       Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xec820000 [0xec820fff].
       I/O at 0xd400 [0xd43f].
       Non-prefetchable 32 bit memory at 0xec800000 [0xec81ffff].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 6).
       Master Capable.  Latency=32.
       I/O at 0xd800 [0xd80f].
   Bus  0, device  17, function  2:
     USB Controller: VIA Technologies, Inc. USB (rev 27).
       IRQ 5.
       Master Capable.  Latency=32.
       I/O at 0xdc00 [0xdc1f].
   Bus  0, device  17, function  3:
     USB Controller: VIA Technologies, Inc. USB (#2) (rev 27).
       IRQ 5.
       Master Capable.  Latency=32.
       I/O at 0xe000 [0xe01f].
   Bus  0, device  17, function  4:
     USB Controller: VIA Technologies, Inc. USB (#3) (rev 27).
       IRQ 5.
       Master Capable.  Latency=32.
       I/O at 0xe400 [0xe41f].
   Bus  1, device   0, function  0:
     VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X (rev 101).
       IRQ 11.
       Master Capable.  Latency=32.  Min Gnt=8.
       Non-prefetchable 32 bit memory at 0xe8000000 [0xe8ffffff].
       I/O at 0xc000 [0xc0ff].
       Non-prefetchable 32 bit memory at 0xea000000 [0xea000fff].

# cat /proc/modules
autofs                 13268   0 (autoclean) (unused)
e100                   54564   1
ipt_REJECT              3992   6 (autoclean)
iptable_filter          2412   1 (autoclean)
ip_tables              15096   2 [ipt_REJECT iptable_filter]
keybdev                 2976   0 (unused)
mousedev                5556   0 (unused)
hid                    22244   0 (unused)
input                   5856   0 [keybdev mousedev hid]
usb-uhci               26412   0 (unused)
usbcore                79040   1 [hid usb-uhci]
ext3                   70784   2
jbd                    51924   2 [ext3]
3w-xxxx                39360   2
sd_mod                 13452   4
scsi_mod              107512   2 [3w-xxxx sd_mod]

Thanks a lot for your help,
Daniel

