Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSKCOLY>; Sun, 3 Nov 2002 09:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSKCOLX>; Sun, 3 Nov 2002 09:11:23 -0500
Received: from web20503.mail.yahoo.com ([216.136.226.138]:56166 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261877AbSKCOLV>; Sun, 3 Nov 2002 09:11:21 -0500
Message-ID: <20021103141753.50480.qmail@web20503.mail.yahoo.com>
Date: Sun, 3 Nov 2002 06:17:53 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: Machine's high load when HIGHMEM is enabled
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some strange kind of problem:
When HIGHMEM-enabled kernel is used, there is too high
CPU load on any task - computer get loaded high while
it is doing some minor, usual jobs (load average grows
significantly).
I don't know how to explain - everything is fine,
computer boots ok, there is no errors (warnings, etc.)
in logs, but as to compare, computer is working slower
that i386...
e.g.: 'gzip some_filename' takes about 5-7 times more
than on HIGHMEM-disabled kernel, ssh login to this
machine takes about 2-3 minutes (computing, disk
operations, network throughput)
I have tried different kernels from RH distro's and
updates:
kernel-2.4.18-17.7
kernel-2.4.18-10
kernel-2.4.18-5

machine has 2 processors, but using SMP/non-SMP
kernels does not matter (I've used both variants)

I have also compiled these kernels from source, and my
results are:
HIGHMEM-disabled kernels works fine, but they can see
only ~900 Mb of memory
the same kernels, but only with HIGHMEM=4G enabled has
such strange effect of high load.

I've also tried following kernels from RH:
kernel-enterprise-2.4.9-34
kernel-enterprise-2.4.9-33
kernel-enterprise-2.4.9-31
and effect is the same...


Any ideas ? need more info?


Here follows this computer configuration:

# lspci
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host
bridge
00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP
bridge
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4
ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4
IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB
PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI
(rev 02)
00:0f.0 PCI bridge: Intel Corp. 80960RP [i960 RP
Microprocessor/Bridge] (rev 05)
00:0f.1 I2O: Intel Corp. 80960RP [i960RP
Microprocessor] (rev 05)
00:10.0 Ethernet controller: 3Com Corporation 3c905B
100BaseTX [Cyclone] (rev 64)
01:00.0 VGA compatible controller: ATI Technologies
Inc 3D Rage IIC AGP (rev 3a)


# cat /proc/cpuinfo
processor   : 0
vendor_id   : GenuineIntel
cpu family  : 6
model   : 7
model name  : Pentium III (Katmai)
stepping    : 3
cpu MHz     : 551.261
cache size  : 32 KB
fdiv_bug    : no
hlt_bug     : no
f00f_bug    : no
coma_bug    : no
fpu    : yes
fpu_exception  : yes
cpuid level : 2
wp     : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips    : 1101.00

processor   : 1
vendor_id   : GenuineIntel
cpu family  : 6
model   : 7
model name  : Pentium III (Katmai)
stepping    : 3
cpu MHz     : 551.261
cache size  : 32 KB
fdiv_bug    : no
hlt_bug     : no
f00f_bug    : no
coma_bug    : no
fpu    : yes
fpu_exception  : yes
cpuid level : 2
wp     : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips    : 1101.00


# cat /proc/meminfo
        total:    used:    free:  shared: buffers: 
cached:
Mem:  2100666368 80003072 2020663296        0  5554176
43016192
Swap: 1069277184        0 1069277184
MemTotal:      2051432 kB
MemFree:       1973304 kB
MemShared:           0 kB
Buffers:          5424 kB
Cached:          42008 kB
SwapCached:          0 kB
Active:          34376 kB
Inact_dirty:     13056 kB
Inact_clean:         0 kB
Inact_target:   522240 kB
HighTotal:     1171456 kB
HighFree:      1124452 kB
LowTotal:       879976 kB
LowFree:        848852 kB
SwapTotal:     1044216 kB
SwapFree:      1044216 kB


# lsmod
Module                  Size  Used by    Not tainted
3c59x                  31976   1
reiserfs              181312   1
megaraid               27808   2
sd_mod                 13756   2
scsi_mod              123524   2  [megaraid sd_mod]


binutils-2.11.93.0.2-11
gcc-2.96-112
glibc-2.2.5-40


Thanks in advance.


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
