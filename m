Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRCZRdn>; Mon, 26 Mar 2001 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRCZRdZ>; Mon, 26 Mar 2001 12:33:25 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132471AbRCZRdE>;
	Mon, 26 Mar 2001 12:33:04 -0500
From: idalton@ferret.phonewave.net
Date: Sun, 25 Mar 2001 20:18:43 -0800
To: linux-kernel@vger.kernel.org
Subject: bug report: paride with devfs
Message-ID: <20010325201843.A18594@ferret.phonewave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found this one out while trying to back up an old win95 system ;)



[1.] One line summary of the problem:

paride and/or devfs bork up and OOPS

[2.] Full description of the problem/report:

When releasing and re-loading the 'pd' module, swapping drives on the
parport box hardware, the devfs entry under /dev/pd/ doesn't get
updated, OOPS happens when creating or removing nodes by hand.

[3.] Keywords (i.e., modules, networking, kernel):

parport paride devfs modules

[4.] Kernel version (from /proc/version):

Linux version 2.4.2cc (root@bicycle) (gcc version 2.95.3 20010125 (prerelease)) #1 Thu Mar 15 13:10:32 PST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.3.7 on i586 2.4.2cc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2cc/ (default)
     -m /boot/System.map-2.4.2cc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(cuecat_process_scancode) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): snd symbol pm_register not found in /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2cc/0.5/snd.o entry

Mar 25 18:42:02 bicycle kernel: paride: version 1.05 installed
Mar 25 18:42:02 bicycle kernel: paride: epat registered as protocol 0
Mar 25 18:42:05 bicycle kernel: pd: pd version 1.05, major 45, cluster 64, nice 0
Mar 25 18:42:05 bicycle kernel: pda: Sharing parport0 at 0x378
Mar 25 18:42:05 bicycle kernel: pda: epat 1.01, Shuttle EPAT chip c6 at 0x378, mode 5 (EPP-32), delay 1
Mar 25 18:42:05 bicycle kernel: pda: Conner Periphe, master, 237744 blocks [116M], (762/8/39), fixed media
Mar 25 18:42:05 bicycle kernel:  pda: p1
Mar 25 18:42:05 bicycle kernel: devfs: devfs_auto_unregister(): only one slave allowed
Mar 25 18:42:05 bicycle kernel:   master: "disc"  old slave: "disc1"  new slave: "disc3"
Mar 25 18:42:05 bicycle kernel: Forcing Oops
Mar 25 18:42:05 bicycle kernel: kernel BUG at base.c:1887!
Mar 25 18:42:05 bicycle kernel: invalid operand: 0000
Mar 25 18:42:05 bicycle kernel: CPU:    0
Mar 25 18:42:05 bicycle kernel: EIP:    0010:[devfs_auto_unregister+98/116]
Mar 25 18:42:05 bicycle kernel: EFLAGS: 00010282
Mar 25 18:42:05 bicycle kernel: eax: 0000001b   ebx: c6541d40   ecx: c7442000   edx: c022e888
Mar 25 18:42:05 bicycle kernel: esi: c6541bc0   edi: c88a84c0   ebp: c6541c40   esp: c276dd90
Mar 25 18:42:05 bicycle kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 18:42:05 bicycle kernel: Process modprobe (pid: 4615, stackpage=c276d000)
Mar 25 18:42:05 bicycle kernel: Stack: c0201f4f c02026c0 0000075f 00000000 00002d00 c014a40e c6541d40 c6541bc0
Mar 25 18:42:05 bicycle kernel:        c023229c 00002d00 c88a84c0 c88a84c0 00000000 00000000 c6541bc0 63736964
Mar 25 18:42:05 bicycle kernel:        00000033 c027c584 c0113e8f 702f2e2e 69642f64 00306373 c7af66c0 c012f371
Mar 25 18:42:05 bicycle kernel: Call Trace: [devfs_register_disc+378/412] [<c88a84c0>] [<c88a84c0>]
Mar 25 18:42:05 bicycle kernel:        [<c88a84c0>] [devfs_register_partitions+26/184] [<c88a84c0>]
[<c88a84c0>] [check_partition+274/288] [<c88a84c0>] [<c88a84c0>] [<c88a8d20>]
Mar 25 18:42:05 bicycle kernel:        [<c88a8d68>] [<c88a1214>] [<c88a1243>] [<c88a8d20>] [<c88a8d20>] [<c88a6e51>] [<c88a8d20>] [<c88a8106>]
[<c88a84c0>] [<c88a74da>] [<c88a84c0>] [<c88a84f0>] [<c88a64f3>]
Mar 25 18:42:05 bicycle kernel:        [<c88a80a0>] [<c88a7e40>] [<c88a7e40>] [<c88a8083>] [<c88a6000>] [<c88a6ab1>] [sys_init_module+1269/1424] [<c88a3000>]
Mar 25 18:42:05 bicycle kernel:        [<c88a6060>] [system_call+51/64]
Mar 25 18:42:05 bicycle kernel: Code: 0f 0b 83 c4 0c 90 8d 74 26 00 89 73 24 5b 5e c3 89 f6 8b 44
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c88a84c0 <[pd]pd_gendisk+0/30>
Trace; c88a84c0 <[pd]pd_gendisk+0/30>
Trace; c88a8d68 <[pd]pd_buf+4c/203>
Trace; c88a1214 <[paride]pi_unclaim+18/1c>
Trace; c88a1243 <[paride]pi_disconnect+13/18>
Trace; c88a8d20 <[pd]pd_buf+4/203>
Trace; c88a8d20 <[pd]pd_buf+4/203>
Trace; c88a6e51 <[pd]pd_init_dev_parms+79/80>
Trace; c88a8d20 <[pd]pd_buf+4/203>
Trace; c88a8106 <[pd].rodata.start+2c6/4d3>
Trace; c88a84c0 <[pd]pd_gendisk+0/30>
Trace; c88a74da <[pd]pd_detect+14e/184>
Trace; c88a84c0 <[pd]pd_gendisk+0/30>
Trace; c88a84f0 <[pd]pd_fops+0/13>
Trace; c88a64f3 <[pd]pd_init+127/150>
Trace; c88a80a0 <[pd].rodata.start+260/4d3>
Trace; c88a7e40 <[pd].rodata.start+0/4d3>
Trace; c88a7e40 <[pd].rodata.start+0/4d3>
Trace; c88a8083 <[pd].rodata.start+243/4d3>
Trace; c88a6000 <[epat].data.end+18d5/1935>
Trace; c88a6ab1 <[pd]init_module+5/8>
Trace; c88a6060 <[pd]ps_set_intr+0/ac>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   90                        nop    
Code;  00000006 Before first symbol
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000a Before first symbol
   a:   89 73 24                  mov    %esi,0x24(%ebx)
Code;  0000000d Before first symbol
   d:   5b                        pop    %ebx
Code;  0000000e Before first symbol
   e:   5e                        pop    %esi
Code;  0000000f Before first symbol
   f:   c3                        ret    
Code;  00000010 Before first symbol
  10:   89 f6                     mov    %esi,%esi
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax


5 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Steps to make the OOPS:

I'm using an H45 3.5" external IDE case with a Shuttle EPAT plus
controller, and a pair of standard IDE hard drives.
The case is connected to the parallal port and the power is disconnected.


* modprobe epat
* Plug in hard drive (set to slave) and plug in power
* modprobe pd
* Wait a minute or so to realise the drive is set to slave
* rmmod pd
* remove power, then re-jumper hard drive to be single/master
* modprobe pd
* Notice there is no /dev/pd/disc0/part1, even though the drive has a partition.
* rmmod pd
* Notice that /dev/pd/disc0/disc still exists
* rm /dev/pd/disc0/disc
* modprobe pd
* see OOPS

Notice that there appears to be a related problem with paride not
refreshing devfs.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Hmmm. I don't have a ver_linux script on this machine. I'm going to
have to ask the kernel-package maintainer to include it in the
kernel-image debs.

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 7
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 0
cpu MHz         : 300.685
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 599.65

[7.3.] Module information (from /proc/modules):

pd                     12144 (initializing)
epat                    6176   1
paride                  3776   1 [pd epat]
nfs                    74304   2 (autoclean)
lockd                  49232   1 (autoclean) [nfs]
sunrpc                 58528   1 (autoclean) [nfs lockd]
mousedev                4000   0 (unused)
hid                    11616   0 (unused)
usbcore                46768   1 [hid]
input                   3424   0 [mousedev hid]
parport_pc             22432   2 (autoclean)
lp                      4624   0 (autoclean) (unused)
parport                25664   2 (autoclean) [paride parport_pc lp]
snd-card-opl3sa2        8720   0
snd-cs4231             18720   0 [snd-card-opl3sa2]
snd-mixer              24112   0 [snd-card-opl3sa2 snd-cs4231]
snd-pcm                32192   0 [snd-cs4231]
snd-mpu401-uart         2688   0 [snd-card-opl3sa2]
snd-rawmidi            10208   0 [snd-mpu401-uart]
snd-seq-device          4272   0 [snd-rawmidi]
snd-opl3                5008   0 [snd-card-opl3sa2]
snd-timer               8672   0 [snd-cs4231 snd-pcm snd-opl3]
snd-hwdep               3504   0 [snd-opl3]
snd                    37488   1 [snd-card-opl3sa2 snd-cs4231 snd-mixer snd-pcm snd-mpu401-uart snd-rawmidi snd-seq-device snd-opl3 snd-timer snd-hwdep]
soundcore               4048   3 [snd]
3c59x                  22624   1 (autoclean)

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
0100-0101 : OPL3-SA control
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0240-024f : OPL3-SA SB
02f8-02ff : serial(set)
0300-0301 : OPL3-SA MPU-401
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
0388-038f : OPL3-SA AdLib FM
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e80-0e87 : OPL3-SA WSS
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
6800-687f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  6800-687f : eth0
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001ef201 : Kernel code
  001ef202-00244af3 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
e0000000-e07fffff : 3DLabs Permedia II 2D+3D
e0800000-e0ffffff : 3DLabs Permedia II 2D+3D
e1000000-e101ffff : 3DLabs Permedia II 2D+3D
e1020000-e102007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 VGA compatible unclassified device: 3DLabs Permedia II 2D+3D (rev 01)
	Subsystem: 3DLabs: Unknown device 0123
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (48000ns min, 48000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [4c] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6800 [size=128]
	Region 1: Memory at e1020000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Don't have SCSI.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Seems to be devfs-related.

[X.] Other notes, patches, fixes, workarounds:
