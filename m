Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTKUBZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 20:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTKUBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 20:25:35 -0500
Received: from mailgate.bigskytel.com ([65.165.29.5]:41904 "EHLO
	mailgate.bigkytel.com") by vger.kernel.org with ESMTP
	id S262758AbTKUBZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 20:25:29 -0500
Message-ID: <3FBD67E7.5020405@bigskytel.com>
Date: Thu, 20 Nov 2003 18:18:31 -0700
From: Buck Rekow <rekow@bigskytel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0.0) Gecko/20020622 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: rth@twiddle.net, linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net
Subject: PROBLEM: Aironet compile failure 2.6-test9/Alpha architecture
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Aironet is not listed as i can find in the file MAINTAINERS, however, 
This report needs to go somewhere and do something. The maintainer is 
however listed in airo.c. merry carbon-copy, people.

Quite simply, the compile fails with the following error.   I'm not sure 
anyone else  is using an aironet card under Alpha, so I guess someone 
needs to report this.
I must say Aironet can be a real pain.

predator:/usr/src/linux-2.6.0-test9# make modules
make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/net/wireless/airo.o
drivers/net/wireless/airo.c: In function `emmh32_setseed':
drivers/net/wireless/airo.c:1458: internal error--unrecognizable insn:
(insn:TI 512 478 513 (set (reg:DI 1 $1)
        (plus:DI (reg:DI 30 $30)
            (const_int 4398046511104 [0x40000000000]))) -1 (insn_list 51 
(insn_list:REG_DEP_ANTI 494 (nil)))
    (nil))
cpp0: output pipe has been closed
make[3]: *** [drivers/net/wireless/airo.o] Error 1
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Here is the output of ver_linux
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.15
e2fsprogs              1.34
PPP                    2.4.1
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         sb sb_lib uart401
 Disregard the version of module-init-tools, as i had to reinstall the 
old version to use my current kernel.

predator:/usr/src/linux-2.6.0-test9/scripts# more /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : EB164
system variation        : PC164
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 366300366
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 726.76
kernel unaligned acc    : 347920158 
(pc=fffffc000057a334,va=fffffc000064e2a1)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : Digital AlphaPC 164 366 MHz
cpus detected           : 1
 
A quick rundown on my installed hardware:
predator:/usr/src/linux-2.6.0-test9# lspci -vvv | more
00:05.0 Network controller: AIRONET Wireless Communications: Unknown 
device 0350
 (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 0000000002250000 (32-bit, non-prefetchable) 
[size=12
8]
        Region 1: I/O ports at 8000 [size=128]
        Region 2: I/O ports at 8400 [size=64]

00:06.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02) 
(prog-i
f 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+ 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=248
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: 08000000-092fffff
        Prefetchable memory behind bridge: 00100000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip
Pass 3] (rev 21)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 8080 [size=128]
        Region 1: Memory at 0000000002251000 (32-bit, non-prefetchable) 
[size=12
8]
        Expansion ROM at 0000000002200000 [disabled] [size=256K]

00:08.0 Non-VGA unclassified device: Intel Corp. 82378IB [SIO ISA 
Bridge] (rev 4
3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:09.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) 
(prog-if 00
[VGA])
        Subsystem: S3 Inc. ViRGE/DX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at 0000000004000000 (32-bit, non-prefetchable) 
[size=64
M]
        Expansion ROM at 0000000002240000 [disabled] [size=64K]

00:0b.0 IDE interface: CMD Technology Inc PCI0646 (rev 01) (prog-if 80 
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 8440 [size=16]

01:01.0 SCSI storage controller: Adaptec AHA-3985 / AIC-7873 (rev 03)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at 0000000009230000 (32-bit, non-prefetchable) 
[disable
d] [size=4K]
        Expansion ROM at 0000000009200000 [disabled] [size=64K]

01:02.0 SCSI storage controller: Adaptec AHA-3985 / AIC-7873 (rev 03)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 27
        Region 0: I/O ports at 9400 [size=256]
        Region 1: Memory at 0000000009231000 (32-bit, non-prefetchable) 
[disable
d] [size=4K]
        Expansion ROM at 0000000009210000 [disabled] [size=64K]

01:03.0 SCSI storage controller: Adaptec AHA-3985 / AIC-7873 (rev 03)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 31
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at 0000000009232000 (32-bit, non-prefetchable) 
[disable
d] [size=4K]
        Expansion ROM at 0000000009220000 [disabled] [size=64K]

01:05.0 Memory controller: Adaptec AIC-7810
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 9c00 [size=256]
        Region 1: Memory at 0000000009233000 (32-bit, non-prefetchable) 
[size=4K
]
        Region 2: Memory at 0000000009000000 (32-bit, prefetchable) 
[size=2M]

This is blocking me from further testing of 2.6-test9 on alpha.  (I'll 
test more hardware if someone wants ot kick down a magma PCI breakout, 
as my machhine is full, and literally buried in it's own hardware)
 I'm willing to bet the problem is some 64 bit cleanliness issue.. I 
don't really code (but for pidgin FORTRAN, and i'd likely get killed for 
sending a patch in fortran)
There is a possibility this may be caused by GCC bug PR-9164, which is 
present in debian 3.0  Alpha (Debian people: READ: *fix it*)  which I am 
running.    

  Hope this is fixable.
    Buck Rekow


 

