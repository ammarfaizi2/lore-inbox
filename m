Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTFJRfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTFJRfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:35:15 -0400
Received: from hildasay.zetnet.co.uk ([194.247.42.205]:2573 "EHLO
	hildasay.zetnet.co.uk") by vger.kernel.org with ESMTP
	id S263749AbTFJRew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:34:52 -0400
Subject: [bug] 2.4.18 Call Trace: [link_path_walk+889/2008]
	[path_walk+26/28] [open_namei+131/1596] [filp_open+59/92] [sys_open+54/204]
	[system_call+51/56]
From: Jon Miles <jon@cybah.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055267308.18284.260.camel@fusion.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 18:48:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if I should be sending an oops from a Debian 2.4.18 kernel
or not? ... this may be useful. I'm not subscribed to the list.

[1.] One line summary of the problem:

unable to handle kernel NULL pointer dereference at virtual address 00000081

[2.] Full description of the problem/report:

I found this oops in the kern.log on one of our machines and thought it
might be useful?

[3.] Keywords (i.e., modules, networking, kernel):

kernel, seems to be filesystem.

[4.] Kernel version (from /proc/version):

Linux version 2.4.18-686-smp (herbert@gondolin) (gcc version 2.95.4 (Debian prerelease)) #2 SMP Wed Mar 20 20:24:14 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000081
kernel:  printing eip:
kernel: 00000081
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    1
kernel: EIP:    0010:[<00000081>]    Not tainted
kernel: EFLAGS: 00010292
kernel: eax: 00000081   ebx: cf368000   ecx: dfcc65e8   edx: dfcc6408
kernel: esi: ffffffec   edi: cf369f8c   ebp: dfcc51a0   esp: cf369f0c
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process sendmail (pid: 12491, stackpage=cf369000)
kernel: Stack: c01400b1 dfcc51a0 cf369f8c dfcc6400 00000001 00000000 c2b51000 cf369f8c
kernel:        00000001 c2b51006 dfcc51a0 c2b51001 00000004 01baa5b4 c014052a c0140baf
kernel:        000001b6 c2b51000 00000000 bfffd1bc 00000000 00000000 00000004 00000286
kernel: Call Trace: [link_path_walk+889/2008] [path_walk+26/28] [open_namei+131/1596] [filp_open+59/92] [sys_open+54/204]
kernel:    [system_call+51/56]
kernel:
kernel: Code:  Bad EIP value.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Can't seem to reproduce manually, but these happen every now and again.

[7.] Environment

Debian/linux mail server, with quite high average load.

[7.1.] Software (add the output of the ver_linux script here)

This is not the same machine that the kernel was compiled on.

Linux xxxx 2.4.18-686-smp #2 SMP Wed Mar 20 20:24:14 EST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         dummy0 ipx reiserfs eepro100 rtc unix DAC960 ext2 ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 733.016
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1461.45

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 733.016
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1464.72

[7.3.] Module information (from /proc/modules):

dummy0                   960   0 (autoclean) (unused)
ipx                    18548   3 (autoclean)
reiserfs              153184   1
eepro100               17616   1
rtc                     6104   0 (autoclean)
unix                   15236  26 (autoclean)
DAC960                 58304   4 (autoclean)
ext2                   31840   0 (autoclean) (unused)
ext3                   58848   2 (autoclean)
jbd                    38056   2 (autoclean) [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(set)
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
d800-d83f : Intel Corp. 82557 [Ethernet Pro 100]
  d800-d83f : eepro100
ffa0-ffaf : ServerWorks OSB4 IDE Controller

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001e128a : Kernel code
  001e128b-0021fc7f : Kernel data
1fff0000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
20000000-20000fff : ServerWorks OSB4/CSB5 OHCI USB Controller
f8400000-f84fffff : PCI Bus #01
fa000000-fbffffff : nVidia Corporation Vanta [NV6]
fc5fe000-fc5fffff : Mylex Corporation DAC960PX
fc700000-fc7fffff : PCI Bus #01
fd000000-fdffffff : nVidia Corporation Vanta [NV6]
fe900000-fe9fffff : Intel Corp. 82557 [Ethernet Pro 100]
feae7000-feae7fff : Intel Corp. 82557 [Ethernet Pro 100]
  feae7000-feae7fff : eepro100
fec00000-fec01fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, cache line size 08

00:01.0 PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge] (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc700000-fc7fffff
        Prefetchable memory behind bridge: f8400000-f84fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:01.1 RAID bus controller: Mylex Corporation DAC960PX (rev 03)
        Subsystem: Mylex Corporation DAC960PX
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fc5fe000 (32-bit, prefetchable) [size=8K]
        Expansion ROM at feae8000 [disabled] [size=32K]

00:02.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0006
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at fa000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at feaf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 31
        Region 0: Memory at feae7000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d800 [size=64]
        Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
        Subsystem: ServerWorks OSB4 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [disabled] [size=4K]

[7.6.] SCSI information (from /proc/scsi/scsi)

not reported in /proc, but using hardware RAID controller as above.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

kernel-source for DEBIAN
------------------------

These patches were applied:

* NFS client seekdir patch
  http://www.fys.uio.no/~trondmy/src/

These modifications were also made:

* Fixed a couple of argument processing bugs in main.c (Eric Delaunay).
* Added initrd support for cramfs.
* Exported proc_get_inode.
* Hacked ide_xlate_1024 to work when IDE is modularised.
* Fixed pegasus_set_multicast lockup.
* Work around 21143 (rev 65) select_media bug in drivers/net/tulip/21142.c.
* Fixed dead lock on shutdown in 8139too.
* Allow ECN to be compiled in but disabled.
* Removed non-free Keyspan firmware.
* Don't kill page cache entries in set_blocksize.
* Added support for nm256xl+ (Mattia Monga).
* Fixed handling of HIDs with product strings bug no manufacturer.
* CONFIG_SERIAL_ACPI now depends on CONFIG_SERIAL == y.
* Fixed negative inode numbers in /proc/net (Arnaud Giersch).
* pcnet32_purge_tx_ring may be called from IRQ context (Darren Salt).
* Check old_bbpnt in drivers/scsi/sr.c (2.5).
* Removed CONFIG_FT_ALPHA_CLOCK.
* Export est_cycle_freq (needed for removing CONFIG_FT_ALPHA_CLOCK).
* Fixed the use of return values from mem*_io in drivers/isdn/sc.
* Added missing headers in drivers/pcmcia/i82092.c.
* Fixed compile error in drivers/scsi/dpt_i2o.c on alpha.
* Removed -g from driviers/atm/Makefile.
* Added missing personality patch to fs/binfmt_elf.c.
* Extern inline -> static inline in
   drivers/char/specialx.c
   drivers/net/hamradio/soundmodem
* Added asm/io.h for in*/out* to
   drivers/isdn/hisax/hisax_fcpcipnp.c
   drivers/net/wan/farsync.c
* Fixed double free in
   drivers/net/zlib.c
   fs/jffs2/zlib.c

Changes to comments and documentation:

* Fixed typos in asm/socket.h.
* Fixed a typo in Documentation/sound/VIBRA16 (Carlos Valdivia Yag<FC>e).
* Fixed a typo in Documentation/sound/OPL3-SA (Carlos Valdivia Yag<FC>e).
* Fixed comment about epochs in arch/alpha/kernel/time.c.

Herbert Xu <herbert@debian.org>
$Id: README.Debian,v 1.49 2002/03/13 09:24:21 herbert Exp $

-- 
Jon Miles <jon@cybah.co.uk>
