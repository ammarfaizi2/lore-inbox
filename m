Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUFONnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUFONnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUFONnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:43:17 -0400
Received: from denner-dude.demon.co.uk ([80.176.227.19]:5871 "EHLO
	denner.demon.co.uk") by vger.kernel.org with ESMTP id S265540AbUFONlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:41:51 -0400
Message-ID: <40CEFC9E.2030508@denner.demon.co.uk>
Date: Tue, 15 Jun 2004 14:41:50 +0100
From: Matthew Denner <matt@denner.demon.co.uk>
Organization: Code Monkey Consultancy Ltd
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday I installed SuSE 9.1 Personal on my laptop and I'm beginning 
to wonder whether this was a bad idea.  It takes my laptop (a Pentium-M 
Centrino 1.7Ghz with 1GB DDR RAM and 40GB HDD) 45 minutes to boot (from 
selecting "linux" in GRUB to having the KDE interface up and running). 
It spends about 20-25 minutes in the boot procedure before it even gets 
to starting X.  Yesterday I managed to tidy my front room, put some 
washing on, load the dishwasher and read the latest TV guide before my 
laptop had booted!  Starting applications in KDE is extremely slow and I 
gave up 'man vmstat' after about 5 minutes of waiting.  It also has some 
responsiveness issues with the keyboard and mouse but my main concern is 
the boot time!

This happens with the standard kernel (2.6.4) that comes with SuSE 9.1, 
the update kernel (2.6.4-54.5 is what the RPM says), and with 2.6.6 with 
mm5 patches applied (both from a default build where I only set the 
processor and from a specific build where I tailored the options as much 
as possible to my system).  It happens with a normal boot and with 
various options (turning off apm and acpi, elevator=deadline, etc).

The really odd thing is that the Live Eval CD you can get doesn't 
experience these issues, it's zippy and responsive and the reason I 
decided to ditch Windows XP.  I also have SuSE 9.1 installed on a 
Mini-ITX machine (VIA C3 chipset, 500Mhz with 512MB RAM) that I use for 
my mail server and that is actually faster than my laptop (in fact, I 
build kernels on that machine for my laptop).

I have included some of the various things which I think might be useful 
in identifying the problem to the end of this email; if anything else is 
required please let me know.  Unfortunately I have no comparison to make 
with earlier kernels as this is the first install of Linux on this 
laptop, although I do have an old RedHat 7.1 CD lying round somewhere.

The actual laptop is an Alienware Sentia system and Alienware provide 
specific documentation to the system, so I know quite a bit about the 
hardware and performance of the system under Windows if that would be 
useful.

I've done some searching on Google for various things but cannot find 
anything that seems related except for the general "2.6.x is slower than 
2.4.x" messages.  I did see a message somewhere that suggested trying 
the mm patches so that's why I've currently got the 2.6.6-mm5 kernel 
installed.

Can someone please help me out, otherwise I'm going to have to go back 
to Windows XP which I'd rather not do if I can help it.  If you could CC 
me on any replies as I'm not on the mailing list.

Matt

There are three partitions (/, /home, and /usr) each formatted with 
ReiserFS.  The system has 512MB swap space that it doesn't use.

Output from 'uname -a':
Linux linux 2.6.6-mm5 #3 Tue Jun 15 10:37:28 BST 2004 i686 i686 i386 
GNU/Linux

Output from 'cat /proc/cpuinfo':
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1700MHz
stepping        : 5
cpu MHz         : 1693.448
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr mce cx8 apic sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 3358.72

Output from 'cat /proc/meminfo':
MemTotal:      1027412 kB
MemFree:         66740 kB
Buffers:        149948 kB
Cached:         652200 kB
SwapCached:          0 kB
Active:         438168 kB
Inactive:       467240 kB
HighTotal:      122688 kB
HighFree:          252 kB
LowTotal:       904724 kB
LowFree:         66488 kB
SwapTotal:      514072 kB
SwapFree:       514072 kB
Dirty:             696 kB
Writeback:           0 kB
Mapped:         159204 kB
Slab:            44756 kB
Committed_AS:   199868 kB
PageTables:       1384 kB
VmallocTotal:   114680 kB
VmallocUsed:      7296 kB
VmallocChunk:   106880 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

Output from 'hdparm -v /dev/hda':
/dev/hda:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  0 (off)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 65535/16/63, sectors = 78140160, start = 0

Output from 'hdparm -tT /dev/hda':
/dev/hda:
  Timing buffer-cache reads:   1232 MB in  2.00 seconds = 615.17 MB/sec
  Timing buffered disk reads:   86 MB in  3.04 seconds =  28.26 MB/sec

Output from 'lspci -v':
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
         Subsystem: Uniwill Computer Corp: Unknown device 9200
         Flags: bus master, fast devsel, latency 0
         Memory at <unassigned> (32-bit, prefetchable)
         Capabilities: [40] #09 [a105]

0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
         Subsystem: Uniwill Computer Corp: Unknown device 9200
         Flags: bus master, fast devsel, latency 0

0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
         Subsystem: Uniwill Computer Corp: Unknown device 9200
         Flags: bus master, fast devsel, latency 0

0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM 
Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
         Subsystem: Uniwill Computer Corp: Unknown device 9200
         Flags: bus master, fast devsel, latency 0, IRQ 16
         Memory at f0000000 (32-bit, prefetchable)
         Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
         I/O ports at dff0 [size=8]
         Capabilities: [d0] Power Management version 1

0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated 
Graphics Device (rev 02)
         Subsystem: Uniwill Computer Corp: Unknown device 9200
         Flags: bus master, fast devsel, latency 0
         Memory at e8000000 (32-bit, prefetchable) [disabled]
         Memory at fea80000 (32-bit, non-prefetchable) [disabled] 
[size=512K]
         Capabilities: [d0] Power Management version 1

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) 
(prog-if 00 [UHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: bus master, medium devsel, latency 0, IRQ 16
         I/O ports at dea0 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) 
(prog-if 00 [UHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: bus master, medium devsel, latency 0, IRQ 19
         I/O ports at dec0 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) 
(prog-if 00 [UHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: bus master, medium devsel, latency 0, IRQ 18
         I/O ports at df40 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 
20 [EHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: bus master, medium devsel, latency 0, IRQ 23
         Memory at feb7f400 (32-bit, non-prefetchable)
         Capabilities: [50] Power Management version 2
         Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) 
(prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fe800000-fe8fffff
         Prefetchable memory behind bridge: de600000-de6fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller 
(rev 03)
         Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage 
Controller (rev 03) (prog-if 8a [Master SecP PriP])
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: bus master, medium devsel, latency 0, IRQ 18
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at ffa0 [size=16]
         Memory at 3f800000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
         Subsystem: Uniwill Computer Corp: Unknown device 9020
         Flags: medium devsel, IRQ 17
         I/O ports at e800 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 
Audio Controller (rev 03)
         Subsystem: Uniwill Computer Corp: Unknown device 8400
         Flags: bus master, medium devsel, latency 0, IRQ 17
         I/O ports at d400
         I/O ports at df00 [size=64]
         Memory at feb7fc00 (32-bit, non-prefetchable) [size=512]
         Memory at feb7f800 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) 
(prog-if 00 [Generic])
         Subsystem: Uniwill Computer Corp: Unknown device 4007
         Flags: medium devsel, IRQ 17
         I/O ports at d800
         I/O ports at dc00 [size=128]
         Capabilities: [50] Power Management version 2

0000:01:00.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
         Subsystem: Uniwill Computer Corp: Unknown device 3002
         Flags: bus master, stepping, slow devsel, latency 168, IRQ 21
         Memory at 3f801000 (32-bit, non-prefetchable)
         Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
         Memory window 0: 3fc00000-3ffff000 (prefetchable)
         Memory window 1: 40000000-403ff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         16-bit legacy interface ports at 0001

0000:01:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
         Subsystem: Uniwill Computer Corp: Unknown device 8200
         Flags: bus master, medium devsel, latency 64, IRQ 22
         Memory at fe8fd800 (32-bit, non-prefetchable)
         I/O ports at cc00 [size=128]
         Capabilities: [50] Power Management version 2

0000:01:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B 
Mini PCI Adapter (rev 04)
         Subsystem: Intel Corp.: Unknown device 2527
         Flags: bus master, medium devsel, latency 64, IRQ 23
         Memory at fe8fe000 (32-bit, non-prefetchable)
         Capabilities: [dc] Power Management version 2

0000:01:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (CNR) 
Ethernet Controller (rev 83)
         Flags: bus master, medium devsel, latency 64, IRQ 20
         Memory at fe8ff000 (32-bit, non-prefetchable)
         I/O ports at cf00 [size=64]
         Capabilities: [dc] Power Management version 2

Output from 'cat /proc/interrupts':
            CPU0
   0:    7632574    IO-APIC-edge  timer
   1:      27343    IO-APIC-edge  i8042
   8:          2    IO-APIC-edge  rtc
   9:      23697   IO-APIC-level  acpi
  12:     259244    IO-APIC-edge  i8042
  14:      69903    IO-APIC-edge  ide0
  15:         39    IO-APIC-edge  ide1
  16:          0   IO-APIC-level  uhci_hcd
  17:         28   IO-APIC-level  Intel 82801DB-ICH4
  18:          0   IO-APIC-level  uhci_hcd
  19:          0   IO-APIC-level  uhci_hcd
  20:     270154   IO-APIC-level  eth0
  21:          7   IO-APIC-level  yenta
  22:          2   IO-APIC-level  ohci1394
  23:          0   IO-APIC-level  ehci_hcd
NMI:          0
LOC:    7492671
ERR:          0
MIS:          0

Output from 'time ls -l /':
real    0m0.537s
user    0m0.209s
sys     0m0.032s

Output from 'vmstat 5 20' on system (a very slow download in the 
background):
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  0  0      0 114584 145668 608216    0    0    46   133 1087   281 73 
15 12  0
  1  0      0 114352 145696 608412    0    0     0    82 1170   472 44 
5 50  1
  0  0      0 114220 145724 608544    0    0     0    52 1051   257 19 
3 78  1
  2  0      0 114024 145752 608768    0    0     0    61 1096   313 17 
4 79  0
  0  0      0 113748 145780 608956    0    0     0    58 1049   257 19 
4 76  0
  0  0      0 113556 145808 609152    0    0     0    50 1048   253 13 
5 81  1
  0  0      0 113300 145836 609344    0    0     0    62 1050   211  8 
4 87  0
  0  0      0 113108 145864 609504    0    0     0    62 1042   209  9 
4 87  1
  5  1      0 112364 145892 609668    0    0     0    78 1063   109 82 
4 14  0
  8  1      0 111300 145920 609860    0    0     0    79 1147   144 98 
2  0  0
  0  1      0 112324 145948 610012    0    0     0    30 1036   189 39 
4 57  0
  0  0      0 112276 145976 610176    0    0     0    45 1044   237 13 
4 83  0
  0  0      0 112036 146004 610436    0    0     0    54 1060   237 11 
6 83  1
  0  0      0 111876 146032 610592    0    0     0    77 1042   213  9 
4 87  0
  0  0      0 111636 146060 610788    0    0     0    50 1055   219  9 
4 86  1
  0  0      0 111444 146088 610972    0    0     0    61 1060   240  9 
4 87  0
  0  0      0 111252 146116 611132    0    0     0    50 1042   212 10 
3 86  0
  0  0      0 110932 146144 611392    0    0     0    55 1065   267 15 
6 80  0
  0  0      0 110676 146172 611676    0    0     0    77 1057   239 13 
6 81  0
  1  0      0 110412 146208 611868    0    0     0    80 1048   245 12 
4 84  0

