Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTEZSWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTEZSWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:22:38 -0400
Received: from eq12.auctionwatch.com ([66.7.130.107]:33356 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id S261950AbTEZSWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:22:30 -0400
Date: Mon, 26 May 2003 11:35:25 -0700
From: Petro <petro@corp.vendio.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20030526183525.GC21507@corp.vendio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Subject: Oops report.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I'm probably going to complete screw this up: 

    Last night one of our test machines wedged while under a rather
    moderate load. We were able to recover the oops from the serial
    console (screen is your buddy): 

    At the time of the crash the machine was running Mysql 3.23.43 with 
    a rather large dataset--probably filling the available memory space. 
    The machine has been run hard for a couple days (loads of around 50, 
    CPU at 85% user, 15% system), lots of disk and network IO, basically
    doing a lot of jpg->proprietary image conversions, then storing them 
    in the DB.) It had "come down" off this load, and was doing the same 
    thing + a lot of reading other images from the db when it hung.

    I hope I've provided enough information.  

    Here is the output from kysmoops:

ksymoops 2.4.1 on i686 2.4.18.  Options used
     -V (default)
     -k /var/log/ksymoops/20030525062539.ksyms (specified)
     -l /var/log/ksymoops/20030525062539.modules (specified)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0208860, System.map says c0158050.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says f89defb0, /lib/modules/2.4.18/kernel/fs/lockd/lockd.o says f89de408.  Ignoring /lib/modules/2.4.18/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says f89d1524, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f89d1204.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says f89d1528, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f89d1208.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says f89d152c, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f89d120c.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says f89d1520, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f89d1200.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
 Unable to handle kernel NULL pointer dereference at virtual address 00000028
c0164b12
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0164b12>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 0000084d   ebx: 00000000   ecx: 000001d0   edx: 00000000
esi: e5ec0efc   edi: 00000001   ebp: 00000050   esp: c4e55f10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=c4e55000)
Stack: c4caec00 000001d0 00000000 00000017 00000000 c015cb86 f7589c00 c4caec00
       000001d0 c013991c c4caec00 000001d0 c4caec1c c4caec00 c012f712 c4caec00
       000001d0 00000020 000001d0 00000020 00000006 c4e54000 00000200 00024a85
Call Trace: [<c015cb86>] [<c013991c>] [<c012f712>] [<c012f9e6>] [<c012fa43>]
   [<c012fad3>] [<c012fb2e>] [<c012fc3d>] [<c01055c4>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0164b12 <journal_try_to_free_buffers+7a/c0>   <=====
Trace; c015cb86 <ext3_releasepage+22/28>
Trace; c013991c <try_to_release_page+3c/54>
Trace; c012f712 <shrink_cache+23e/3bc>
Trace; c012f9e6 <shrink_caches+56/7c>
Trace; c012fa43 <try_to_free_pages+37/58>
Trace; c012fad3 <kswapd_balance_pgdat+43/8c>
Trace; c012fb2e <kswapd_balance+12/28>
Trace; c012fc3d <kswapd+99/b4>
Trace; c01055c4 <kernel_thread+28/38>


7 warnings issued.  Results may not be reliable.

Now this ksymoops was run well after the reboot--the -k and -l options I
passed were the closest in time prior to the crash. 

Here is the output of ver_linux: 

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dbspare00-red.auctionwatch.com 2.4.18 #1 SMP Wed Nov 20 18:57:08 PST 2002 i686 unknown
 
Gnu C                  command
Gnu make               3.79.1
binutils               2.11.90.0.24
util-linux             2.11h
mount                  2.11h
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc e1000


Note that the kernel was not compiled on this machine, on the machine it
was compiled on the Gnu C line is reads "2.95.4"--everything else is the
same. Well, except for the modules line. 

This machine is a SuperServer 6022P-i (SYS-6022-Pi), with a SUPER P4DPI-G2
motherboard, 2 2.40Ghz CPUs:
(cat /proc/cpuinfo, all 4 entries are identical, here's the last: 
Processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 1799.813
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
 bogomips        : 3591.37

Hyperthreading is enabled. 

cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  4092157952 4079968256 12189696        0 123207680 3683569664
Swap: 1077501952  5050368 1072451584
MemTotal:      3996248 kB
MemFree:         11904 kB
MemShared:           0 kB
Buffers:        120320 kB
Cached:        3594424 kB
SwapCached:       2812 kB
Active:         226780 kB
Inactive:      3622324 kB
HighTotal:     3145152 kB
HighFree:         2044 kB
LowTotal:       851096 kB
LowFree:          9860 kB
SwapTotal:     1052248 kB
SwapFree:      1047316 kB


here is the output of lspci: 

00:00.0 Host bridge: Intel Corporation: Unknown device 2540 (rev 03)
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:00.1 Class ff00: Intel Corporation: Unknown device 2541 (rev 03)
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corporation: Unknown device 2543 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc100000-fc3fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:04.0 PCI bridge: Intel Corporation: Unknown device 2547 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fc400000-fcffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fd000000-fe0fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2480 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 2060 [size=16]
	Region 5: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=48
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc200000-fc2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0003]

01:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc300000-fc3fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0083]

02:01.0 Ethernet controller: Netgear GA620 (rev 01)
	Subsystem: Netgear: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at fc200000 (32-bit, non-prefetchable) [size=16K]

03:02.0 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
	Subsystem: Intel Corporation: Unknown device 1011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fc300000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:02.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
	Subsystem: Intel Corporation: Unknown device 1011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin B routed to IRQ 29
	Region 0: Memory at fc320000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3040 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fc500000-fcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0003]

04:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc401000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0083]

05:01.0 RAID bus controller: 3ware Inc: Unknown device 1001 (rev 01)
	Subsystem: 3ware Inc: Unknown device 1001
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (2250ns min), cache line size 08
	Interrupt: pin A routed to IRQ 96
	Region 0: I/O ports at 4000 [size=16]
	Region 1: Memory at fc500000 (32-bit, non-prefetchable) [size=16]
	Region 2: Memory at fc800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 5000 [size=256]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
"On two occasions, I have been asked [by members of Parliament], 'Pray, 
Mr. Babbage, if you put into the machine wrong figures, will the right 
answers come out?' I am not able to rightly apprehend the kind of confusion 
of ideas that could provoke such a question." -- Charles Babbage 
