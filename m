Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSK0WFa>; Wed, 27 Nov 2002 17:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSK0WF3>; Wed, 27 Nov 2002 17:05:29 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:21258 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S264848AbSK0WFV> convert rfc822-to-8bit; Wed, 27 Nov 2002 17:05:21 -0500
Date: Wed, 27 Nov 2002 23:12:38 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] NFS trouble - file corruptions
Message-ID: <Pine.LNX.4.44.0211272227220.1578-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Files created with bzip2/gzip directly to NFS file system gets corrupted

[2.] Full description of the problem/report:

.tar.bz2 archives created directly on an NFS file system gets random
corruptions. Random bytes in the resulting file gets corrupted;
corrupted bytes are usually grouped. Corruptions happen different places
each run.

File creation could happen with "bzip2 -9c t.tar >
/path/to/nfs/t.tar.bz2" (and similar with gzip) but does not happen when
uncompressing files the same way with "bzip2 -dc t.tar.bz2 >
/path/to/nfs/t.tar".

Doing exactly the same on local filesystems (ext3) on local disks
produces no such errors.

No messages show up in log files and no corruptions happen with other
network traffic.

[3.] Keywords (i.e., modules, networking, kernel):

NFS, networking

[4.] Kernel version (from /proc/version):

2.4.19 - also tried with 2.4.18/2.4.19 combination as well as both
2.4.18.

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

No error messages at all.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Client:

# bzip2 -9c test.tar > /path/to/nfs/test1.tar.bz2
# bzip2 -9c test.tar > /path/to/nfs/test2.tar.bz2
# gzip -9c test.tar > /path/to/nfs/test1.tar.gz
# gzip -9c test.tar > /path/to/nfs/test2.tar.gz
# ls -l test.tar
-rw-r--r--    1 root     root     545105920 tir 26 nov 11:04:33 2002 test.tar
# bzip2 -dc t.bz2 > /path/to/nfs/t1
# bzip2 -dc t.bz2 > /path/to/nfs/t2
# bzip2 -dc t.bz2 > /path/to/nfs/t3

Server:

# md5sum test{1,2}.tar.{gz,bz2}
f4d7bf9f6f65ea709659920b9c7afb2d  test1.tar.gz
cf11faec35c927a1fa4e3b4083a94a26  test1.tar.bz2
201541d4e9f573e4f4cba5f198d8f941  test2.tar.gz
d40839327ca2ae7a71c24d7856bc9995  test2.tar.bz2
# ls -l test{1,2}.tar.{gz,bz2}
-rw-r--r--    1 bkup     users    343739406 Nov 26 11:56 test1.tar.bz2
-rw-r--r--    1 bkup     users    384536247 Nov 26 20:19 test1.tar.gz
-rw-r--r--    1 bkup     users    343739406 Nov 26 14:50 test2.tar.bz2
-rw-r--r--    1 bkup     users    384536247 Nov 26 20:33 test2.tar.gz
# hexdump test1.tar.bz2 > test1.tar.bz2.hex
# hexdump test2.tar.bz2 > test2.tar.bz2.hex
# cmp -l test1.tar.bz2.hex test2.tar.bz2.hex
94870141 143  40
94870142  40  64
94870144  63 141
151297839  70  65
151297840  62  70
151297841  71  60
151297842 142  63
151297844  61 144
151297845  71  61
151297846  67  60
151297847  61  65
151297849  67 142
151297850 141  62
151297851 145  61
151297852 141  65
151297854  63 145
151297855  65  63
151297856  66  61
151297857  71  60
151297859  66  61
151297860  62 146
151297861  63  71
151297862  60  63
151297864  71 143
151297865 143 145
151297866  67 146
151297867  71  62
188729797  61  60
188729798  70 143
188729799  65 142
188729800  64  63
188729802  63  64
188729803  66 143
188729804  64 146
188729805 144  66
188729807  66 144
188729808  67  65
188729809  62 141
188729810 146  67
188729812  64  70
188729813  63  61
188729814  66 142
188729815 141  70
188729826  67 143
188729827  67 142
188729828  71  63
188729830  62  64
188729832  60 146
188729833  71  66
188729835  70 144
188729836 141  65
188729837  61 141
188729838 141  67
188729840  62  70
188729841  71  61
188729842  70 142
188729843 146  70
188729845  63  61
188729846  66  70
188729847 145  65
188729848 145  64
188729850 144  63
188729851 144  66
188729853  67 144
188729855 144  66
188729856  62  67
188729857  71  62
188729858  67 146
188729860  71  64
188729861  64  63
188729862 143  66
188729863 143 141
251720733  65  70
251720734  12 141
251720735  65  62
251720736  60  40
268261961  60  64
268261962  64  67
268261963  40  67
268261964  60 146
268261965  61  60
268261966 146  40
268261967 143  61
268261968  40  65
268261969  60  64
268261970  63  67
268261971  60  67
268261972 142 146
268261973  40  60
268261974  64  40
268261976  64  65
268261977  61  60
268261978  40  64
268261979 142  40
268261980 143  60
268261981  70  61
268261982  61 146
268261983  40 143
268261984  64  40
292093502  40  63
292093503  66  40
292093504 144 143
328116441  60  40
328116442  40  71
328116443 142  71
328116445  63 146
328116446 144  40
328116447  40  65
328116448  67  60
391339513 141 146
391339514  71 145
391339515  66  70
391339516  65 141
391339518  60  63
391339520 146 144
391339521  62  66
391339523 142  71
391339524 144  60
391339525 141  66
391339526 142  65
391339528  65 142
391339529 141 142
391339530 146  62
391339531 142 143
391339541  60 146
391339542  70 145
391339543  71  70
391339544  70 141
391339546  66  63
391339547 144  67
391339548  60 144
391339549 141  66
391339551  70  71
391339552 142  60
391339553  70  66
391339554  62  65
391339556 145 142
391339557  65 142
391339558  63  62
391339559  70 143
391339561 142 141
391339562 141  71
391339563 146  66
391339564 144  65
391339566  64  60
391339567 144  67
391339568 142 146
391339569  67  62
391339571  62 142
391339572  67 144
391339574 143 142
391339576  70  65
391339577 142 141
391339578  70 146
391339579 145 142
835756921  40  64
835756922  65  71
835756923  62  40
835756924  67  65
835756925 141 142
835756926  40 142
835756928  65  12
977707967  70  60
977707968  62  60
977707969  67  65
977707970 141  67
977707972  62  60
977707973  67  60
977707974  66 141
977707975 141  63
977707978 144  71
977707979  70  61
977707980 144  67
977707982  60 144
977707983 141  65
977707985 146  63
977707996 142  60
977707997  64  60
977707998  70  65
977707999  62  67
977708001  63  60
977708002  70  60
977708003  67 141
977708004  61  63
977708006 144 143
977708008  64  61
977708009  71  67
977708011 146 144
977708012 143  65
977708013 146  71
977708014 146  63
977708016  61  70
977708017  64  62
977708018  64  67
977708019  67 141
977708021 141  62
977708022  70  67
977708023  70  66
977708024  63 141
977708026 141 143
977708027  61 144
977708029 143 144
977708031 143  60
977708032  62 141
977708033 144  71
977708034 143 146
# md5sum t?
a61bc4466814b20621d5734e0a10e317  t1
a61bc4466814b20621d5734e0a10e317  t2
a61bc4466814b20621d5734e0a10e317  t3

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Both machines Debian Woody, self-compiled vanilla 2.4.19:

Server:

Linux tuborg 2.4.19 #2 Sun Sep 1 18:55:31 CEST 2002 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfsd lockd sunrpc ipv6

Client:

Linux carlsberg 2.4.19 #2 tor okt 31 10:13:09 CET 2002 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    [muligheder...]
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc

[7.2.] Processor information (from /proc/cpuinfo):

(no overclocking or likewise hardware fiddling has ever been done)

Server:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 299.752
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 598.01

Client:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 333.529
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx syscall 3dnow
bogomips        : 665.19

[7.3.] Module information (from /proc/modules):

Server:

nfsd                   64640   8 (autoclean)
lockd                  46560   1 (autoclean) [nfsd]
sunrpc                 56372   1 (autoclean) [nfsd lockd]
ipv6                  121504  -1

(ipv6 module loaded by mistake, but the error happened before also)

Client:

nfs                    70208   1 (autoclean)
lockd                  46544   1 (autoclean) [nfs]
sunrpc                 56220   1 (autoclean) [nfs lockd]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

Server:
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc 3D Rage IIC AGP
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  e800-e8ff : 8139too
/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001c81c3 : Kernel code
  001c81c4-001fc3ff : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C598 [Apollo MVP3]
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
e7000000-e70000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  e7000000-e70000ff : 8139too
ffff0000-ffffffff : reserved

Client:
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  e800-e8ff : 8139too
/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001d4ee9 : Kernel code
  001d4eea-0020e9bf : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
d4000000-d4ffffff : Cirrus Logic GD 5446
d6000000-d60000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d6000000-d60000ff : 8139too
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

Server:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e000 [size=16]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 3a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0084
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at d000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Client:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=32K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=256]


[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Server:

# cat /etc/exports
/home/backup/carlsberg  172.16.0.3(rw,root_squash,anonuid=1003,anongid=100)

Client:

# cat /etc/fstab | grep nfs
tuborg:/home/backup/carlsberg /backup/net nfs rsize=8192,wsize=8192,nfsvers=3 0 0

Both kernels were configured with the following NFS-related parameters:

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y

All filesystems on block devices are ext3 mounted with "default"
parameters.

[X.] Other notes, patches, fixes, workarounds:

Help me help - I am totally lost; I have no idea where to look anymore;
I don't know what more information to include, so tell me what I missed.

I am no kernel hacker, but I am willing to try out patches etc. if
necessary...

TIA
/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Remember, there are no stupid questions
- just stupid people.
             - Mr. Garrison, South Park
----------------------------------[ moffe at amagerkollegiet dot dk ] --

