Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLSR6F>; Tue, 19 Dec 2000 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLSR5y>; Tue, 19 Dec 2000 12:57:54 -0500
Received: from exit1.i-55.com ([204.27.97.1]:30713 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S129535AbQLSR5u>;
	Tue, 19 Dec 2000 12:57:50 -0500
Message-ID: <3A3F9961.6090906@cs.rose-hulman.edu>
Date: Tue, 19 Dec 2000 11:22:41 -0600
From: Leslie Donaldson <donaldlf@cs.rose-hulman.edu>
Reply-To: donaldlf@cs.rose-hulman.edu
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 alpha; en-US; m18) Gecko/20001106
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dledford@redhat.com, donaldlf@i-55.com
Subject: Krn. 2.4.0-12 Scsi failure(oops) under Alpha Linux aic7xxx driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally hand typed in most of the oops enjoy..

After the oops is my ststem information.

linux-kernel@vger.kernel.org


(scsi1:0:0:0) Data overrun detected in Data-Out phase, tag 5;
Have seen Data Phase. Length =0,NUM SGS=0.
Unable to handle kernel paging request at virtual address 003ffc0000006000
bzip2(8065):Oops 1
pc = [<fffffc000031ab54>]
ra = [<fffffc00003165f8>]
ps = 0007
v0 = [<0000000000000000>]
t1 = [<0000000040000000>]
t2 = [<0000000000800000>]
t3 = [<>]
t4 = [<0000000000000000>]
t5 = [<>]
t6 = [<>]
t7 = [<>]
s0 = [<0000000000000001>]
s1 = [<000000000001fc00>]
s2 = [<ffffc00000006080>]
s3 = [<>]
s4 = [<>]
s5 = [<>]
s6 = [<>]
a0 = [<>]
a1 = [<>]
a2 = [<000000000000000f>]
a3 = [<0000000000000000>]
a4 = [<0000000000000500>]
a5 = [<0000000000000005>]
t8 = [<0000000000000000>]
t9 = [<fffffffc000db8ac>]
t10= [<0000000000000400>]
t11= [<0000000000000010>]
pv = [<fffffc000031b4d0>]
at = [<0>]
gp = [<fffffc00004defa8>]
sp = [<fffffc000f3cbc00>]

Code: 
6bfa8001 
ret zero,(ra)
a4300010 
ldq t0,16(a0)
42210641 
sqaddq a1,t0,t0
ee400005 
blbs a2,.+24
2fe00000 
ldq_u zero,0(v0)
2252ffff 
lda a2,-1(a2)
*** 
b7e1000 
	stq zero,0(t0)
20210008 
lda t0,8(t0)

Trace: 
3d1550 
3da120 
3da250 
3da4f4
3159b4 
316324 
31cea0 
316908
310aa8 
310c54 
32d030 
320b0
310c54

Aiee, Killing interrupt handler.

Scheduling in interrupt
bzip2(8065):Kernel Bug 1
pc = [<fffffc0000323fc8>]
ra = [<ffffffc000323fbc>]
ps = 0000
v0 = [<0000000000000018>]
t0 = [<0000000000000001>]


code: 
a61dc560 
ldq a0,-14928(gp)
a77d9ee8 
ldq pv,-24856(gp)
6bsd4dad 
jsr ra,(pv)
ldah gp,28(ra)
lda gp,-20500(gp)
00000081 
call_pal 129
*** 
		or zero,56,sp
ldq_u zero,0(v0)

Trace:  32b9d0  31175c  31e104  31036c
31bsf8 
31b4d0 
31ab54 
3d1550
3da120 
3da250 
3da4f4 
3159b4
316324 
31cea0 
316908 
310aa8
310b54 
32d030 
32d0b0 
310c84

die if kernel recrsion detected.

cat /proc/version
Linux version 2.4.0-test12 (root@shadowdragon) (gcc version 2.96 
20000731 (Red Hat Linux 7.0)) #17 Tue Dec 19 00:22:49 CST 2000

cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : EB164
system variation        : LX164
system revision         : 0
system serial number    : MILO-2.2-17
cycle frequency [Hz]    : 600000000
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 1191.18
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 10900182 (pc=20000abcd60,va=1203ec97a)
platform string         : N/A
cpus detected           : 0


[root@shadowdragon /root]# cat /proc/modules
serial                 58304   1 (autoclean)
adi                     9072   0 (unused)
ns558                   4224   0 (unused)
gameport                2176   0 [adi ns558]
joydev                  6496   0
evdev                   4704   0 (unused)
input                   5168   0 [adi joydev evdev]
es1370                 36496   0 (unused)
soundcore               5392   4 (autoclean) [es1370]
rivafb                 44800   0 (unused)
matroxfb_base          22480  64
matroxfb_Ti3026         8576   0 [matroxfb_base]
matroxfb_DAC1064         496   0 (unused)
matroxfb_accel         11184   0 [matroxfb_base matroxfb_Ti3026 
matroxfb_DAC1064]
matroxfb_misc          14352   0 [matroxfb_base matroxfb_Ti3026 
matroxfb_accel]
fbcon-cfb32             6096   0 [rivafb matroxfb_accel]
fbcon-cfb24             6192   0 [matroxfb_accel]
fbcon-cfb16             6128   0 [rivafb matroxfb_accel]
fbcon-cfb8              5600   0 [rivafb matroxfb_accel]
nfs                    67088   1 (autoclean)
nfsd                   65264   8 (autoclean)
lockd                  54944   1 (autoclean) [nfs nfsd]
sunrpc                 87104   1 (autoclean) [nfs nfsd lockd]
ds                      9936   2
i82365                 18576   2
pcmcia_core            53536   0 [ds i82365]
ppp_async               9280   1 (autoclean)
nls_iso8859-1           4176   1 (autoclean)
nls_cp437               5680   1 (autoclean)
vfat                   16160   1 (autoclean)
fat                    42112   0 (autoclean) [vfat]
unix                   22224  37 (autoclean)
[root@shadowdragon /root]# [root@shadowdragon /root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-0080 : rtc
00a0-00bf : pic2
00c0-00df : dma2
0200-0207 : ns558-isa
0213-0213 : isapnp read
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
03c0-03df : vga+
03c0-03df : matrox
03e0-03e1 : i82365
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
8000-80ff : Adaptec 7899A
8000-80fe : aic7xxx
8400-84ff : Adaptec 7899A (#2)
8400-84fe : aic7xxx
8800-883f : Ensoniq ES1370 [AudioPCI]
8800-883f : es1370
8840-884f : CMD Technology Inc PCI0646
[root@shadowdragon /root]#



[root@shadowdragon /root]# cat /proc/iomem
09000000-09ffffff : nVidia Corporation Vanta [NV6]
09000000-09ffffff : rivafb
0a000000-0bffffff : nVidia Corporation Vanta [NV6]
0a000000-0bffffff : rivafb
0c000000-0c7fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
0c000000-0c7fffff : matroxfb FB
0c800000-0c81ffff : Adaptec 7899A
0c820000-0c83ffff : Adaptec 7899A (#2)
0c840000-0c84ffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
0c850000-0c85ffff : nVidia Corporation Vanta [NV6]
0c860000-0c863fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
0c860000-0c863fff : matroxfb MMIO
0c864000-0c864fff : Adaptec 7899A
0c865000-0c865fff : Adaptec 7899A (#2)
[root@shadowdragon /root]#



[root@shadowdragon /root]# lspci -vv
00:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium] (rev 01) (prog-if 00 [VGA])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 18
Region 0: [virtual] Memory at 000000000c860000 (32-bit, 
non-prefetchable) [size=16K]
Region 1: Memory at 000000000c000000 (32-bit, prefetchable) [size=8M]
Expansion ROM at 000000000c840000 [size=64K]

00:06.0 SCSI storage controller: Adaptec 7899A (rev 01)
Subsystem: Adaptec: Unknown device f620
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (10000ns min, 6250ns max), cache line size 08
Interrupt: pin A routed to IRQ 16
BIST result: 00
Region 0: I/O ports at 8000 [size=256]
Region 1: Memory at 000000000c864000 (64-bit, non-prefetchable) [size=4K]
Expansion ROM at 000000000c800000 [disabled] [size=128K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 SCSI storage controller: Adaptec 7899A (rev 01)
Subsystem: Adaptec: Unknown device f620
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (10000ns min, 6250ns max), cache line size 08
Interrupt: pin B routed to IRQ 23
BIST result: 00
Region 0: I/O ports at 8400 [size=256]
Region 1: Memory at 000000000c865000 (64-bit, non-prefetchable) [size=4K]
Expansion ROM at 000000000c820000 [disabled] [size=128K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 
15) (prog-if 00 [VGA])
Subsystem: Guillemot Corporation: Unknown device 4d21
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (1250ns min, 250ns max)
Interrupt: pin A routed to IRQ 17
Region 0: Memory at 0000000009000000 (32-bit, non-prefetchable) 
[disabled] [size=16M]
Region 1: Memory at 000000000a000000 (32-bit, prefetchable) [disabled] 
[size=32M]
Expansion ROM at 000000000c850000 [size=64K]
Capabilities: [60] Power Management version 1
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA 
Bridge] (rev 43)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0

00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
Subsystem: Unknown device 4942:4c4c
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 32 (3000ns min, 32000ns max)
Interrupt: pin A routed to IRQ 19
Region 0: I/O ports at 8800 [size=64]

00:0b.0 IDE interface: CMD Technology Inc PCI0646 (rev 01) (prog-if 80 
[Master])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (500ns min, 1000ns max)
Interrupt: pin A routed to IRQ 21
Region 4: I/O ports at 8840 [size=16]



[root@shadowdragon /root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
Vendor: FUJITSU  Model: M2512A           Rev: 1408
Type:   Optical Device                   ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
Vendor: TOSHIBA  Model: CD-ROM XM-5701TA Rev: 0167
Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
Vendor: QUANTUM  Model: ATLAS 10K 18WLS  Rev: UC81
Type:   Direct-Access                    ANSI SCSI revision: 03





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
