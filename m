Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLaFeV>; Sun, 31 Dec 2000 00:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbQLaFeM>; Sun, 31 Dec 2000 00:34:12 -0500
Received: from bill.trinity.unimelb.edu.au ([203.28.240.2]:45573 "HELO
	bill.trinity.unimelb.edu.au") by vger.kernel.org with SMTP
	id <S129572AbQLaFd7>; Sun, 31 Dec 2000 00:33:59 -0500
Date: Sun, 31 Dec 2000 16:03:23 +1100
From: Tim Bell <bhat@trinity.unimelb.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Oops using mke2fs on software raid-0 with pre7
Message-ID: <20001231160323.A15940@trinity.unimelb.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, thanks to Marcelo Tosatti for pointing me to pre2 which
fixed my previous mke2fs oops.  Now I've got a new one with pre7 (also
happened with pre5).

[1.] One line summary of the problem:    

Oops while using mke2fs on software raid-0 device with pre7.

[2.] Full description of the problem/report:

While running mke2fs on a SCSI software RAID-0 array, there was an
"Unable to handle kernel NULL pointer dereference at virtual address
00000024" message, along with an oops (below).
The problem has occurred both with pre5 and pre7.  When running SMP, the
oops below was given.  When running a UP pre7 kernel, there was no oops,
just a lockup.

[3.] Keywords (i.e., modules, networking, kernel):

filesystems, raid

[4.] Kernel version (from /proc/version):

Linux version 2.4.0-test13-pre7 (root@vike) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 SMP Sun Dec 31 13:13:12 EST 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Note: oops was hand-copied.  I fixed a couple of typos, but there may be
others.

ksymoops 2.3.4 on i686 2.4.0-test13-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre7/ (default)
     -m /boot/System.map-2.4.0-test13-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address 00000024
Oops:   0002
CPU:    1
EIP:    0010:[<c013479c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: dfbe3780   ebx: 00000001   ecx: dfbe3720   edx: 00000000
esi: 00000008   edi: 00000900   ebp: 0158053d   esp: f7871d28
ds: 0018   es: 0018   ss: 0018
Stack: dfbe3720 c0135223 dfbe3720 00000001 00000900 6014f000 dfbe36c0 00000000 
       00002d10 c013a299 00000900 0158053d 00000400 f79bec80 ffffffea 00000005 
       00008000 00096cd9 00000900 09001547 03f01a80 00000400 00000400 00000000 
Call Trace: [<c0135223>] [<c013a299>] [<fa0a1ad8>] [<c01090a2>] [<c01e6827>] [<c01970ae>] [<c019a843>]
       [<c019a6c3>] [<c0a8d993>] [<c01eb827>] [<c01970ae>] [<c019a843>] [<c018fa79>] [<c0113d32>] [<c01333ab>]
       [<c0108eeb>]
Code: 89 42 24 8d 14 dd 00 00 00 00 bb 60 56 30 c0 39 0c 1a 75 06

>>EIP; c013479c <__remove_from_free_list+2c/58>   <=====
Trace; c0135223 <getblk+df/168>
Trace; c013a299 <block_write+179/4a8>
Trace; fa0a1ad8 <END_OF_CODE+39d66a24/????>
Trace; c01090a2 <nmi+1e/30>
Trace; c01e6827 <vgacon_cursor+1af/1b8>
Trace; c01970ae <set_cursor+6e/80>
Trace; c019a843 <con_flush_chars+23/34>
Trace; c019a6c3 <con_write+23/2c>
Trace; c0a8d993 <END_OF_CODE+7528df/????>
Trace; c01eb827 <xor_pII_mmx_3+f3/184>
Trace; c01970ae <set_cursor+6e/80>
Trace; c019a843 <con_flush_chars+23/34>
Trace; c018fa79 <write_chan+1f1/208>
Trace; c0113d32 <schedule+3ba/5d4>
Trace; c01333ab <sys_write+8f/c4>
Trace; c0108eeb <system_call+33/38>
Code;  c013479c <__remove_from_free_list+2c/58>
00000000 <_EIP>:
Code;  c013479c <__remove_from_free_list+2c/58>   <=====
   0:   89 42 24                  mov    %eax,0x24(%edx)   <=====
Code;  c013479f <__remove_from_free_list+2f/58>
   3:   8d 14 dd 00 00 00 00      lea    0x0(,%ebx,8),%edx
Code;  c01347a6 <__remove_from_free_list+36/58>
   a:   bb 60 56 30 c0            mov    $0xc0305660,%ebx
Code;  c01347ab <__remove_from_free_list+3b/58>
   f:   39 0c 1a                  cmp    %ecx,(%edx,%ebx,1)
Code;  c01347ae <__remove_from_free_list+3e/58>
  12:   75 06                     jne    1a <_EIP+0x1a> c01347b6 <__remove_from_free_list+46/58>


2 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

The command which triggered it was:
mke2fs -m 0 -b 4096 /dev/md0

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux viee 2.4.0-test13-pre7 #1 SMP Sun Dec 31 13:13:12 EST 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 933.444
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1861.22

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 933.444
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1861.22


[7.3.] Module information (from /proc/modules):

[no modules]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-d03f : Intel Corporation 82557 [Ethernet Pro 100]
  d000-d03f : eepro100
d400-d4ff : Adaptec 7892A
  d400-d4fe : aic7xxx
d800-d8ff : ATI Technologies Inc Rage XL
e400-e4ff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
  e400-e4ff : sym53c8xx
e800-e8ff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)
  e800-e8ff : sym53c8xx
ffa0-ffaf : PCI device 1166:0211 (ServerWorks)
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ce5ff : Extension ROM
000ce800-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-002a2c8f : Kernel code
  002a2c90-002bc85f : Kernel data
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe900000-fe9fffff : Intel Corporation 82557 [Ethernet Pro 100]
feafc000-feafcfff : Intel Corporation 82557 [Ethernet Pro 100]
  feafc000-feafcfff : eepro100
feafd000-feafdfff : PCI device 1166:0220 (ServerWorks)
feafe000-feafefff : Adaptec 7892A
feaff000-feafffff : ATI Technologies Inc Rage XL
febfa000-febfbfff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
febfc000-febfdfff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)
febff800-febffbff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
febffc00-febfffff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 set, cache line size 08

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Asustek Computer, Inc.: Unknown device 1043
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d000 [size=64]
	Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe800000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 min, 25 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 18
	BIST result: 00
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at feafe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feaa0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4752 (rev 65) (prog-if 00 [VGA])
	Subsystem: Gateway 2000: Unknown device 6400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 64 set, cache line size 08
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
	Subsystem: Relience Computer: Unknown device 0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: Relience Computer: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]

01:05.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 18 max, 72 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at febff800 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at febfa000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 18 max, 72 set, cache line size 08
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at febffc00 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at febfc000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T36950M     Rev: S94N
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T36950M     Rev: S94N
  Type:   Direct-Access                    ANSI SCSI revision: 03

(scsi0 is the Adaptec)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/etc/raidtab:

raiddev /dev/md0
	raid-level	0
	nr-raid-disks	2
	persistent-superblock	1
	chunk-size	32
	device		/dev/sda8
	raid-disk	0
	device		/dev/sdb9
	raid-disk	1

-- 
Tim Bell - bhat@trinity.unimelb.edu.au - System Administrator & Programmer
    Trinity College, Royal Parade, Parkville, Victoria, 3052, Australia
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
