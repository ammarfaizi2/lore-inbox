Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbRDHUnu>; Sun, 8 Apr 2001 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRDHUnb>; Sun, 8 Apr 2001 16:43:31 -0400
Received: from access.mbnet.mb.ca ([204.112.54.11]:54939 "EHLO
	access.mbnet.mb.ca") by vger.kernel.org with ESMTP
	id <S132603AbRDHUnZ>; Sun, 8 Apr 2001 16:43:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: xOr <xor@x-o-r.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oops in reiserfs under 2.4.2-ac28 and 2.4.3-ac3 when rming files
Date: Sun, 8 Apr 2001 15:43:19 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040815431900.00242@rogue>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] kernel oops in reiserfs under 2.4.2-ac28 and 2.4.3-ac3 when rming files
[2.] when removing a directory on my harddrive with rm -rf, i get this oops. 
it occurs every time i try, and only on this one folder (so far). its 
actually in a subdirectory of the folder, im guessing at one file, but i feel 
it wouldnt help much to find the exact file (and that would require about 100 
reboots). i also get a segfault, though not a kernel oops when running 
reiserfsck on the filesystem.
[3.] reiserfs, kernel
[4.] Linux version 2.4.3-ac3 (root@rogue) (gcc version 2.95.3 20010315 
(release)) #2 
[5.] ksymoops output:
Unable to handle kernel NULL pointer dereference at virtual address 00000008
Oops: 0000
CPU:    0
EIP:    0010:[<c0164149>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 00001000   ebx: c7995b0b   ecx: c7995b40   edx: 00000000
esi: 000083cd   edi: c7ef0018   ebp: c7980210   esp: c642fa68
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 138, stackpage=c642f000)
Stack: c7ef0018 00001000 00000016 00000016 ffffffff c7995b40 00000000 c78fa740
       00000000 c642fcdc 00000030 00000016 c7f08cc0 c0164ce7 c642fb14 c7995b40
       00000001 ffffffff c642fb14 c642fb04 ffffffff 00000016 c0164f34 c642fb14
Call Trace: [<c0164ce7>] [<c0164f34>] [<c0164ffb>] [<c0155023>] [<c0155084>] 
[<c
015fbeb>] [<c015ffd3>]
       [<c0160401>] [<c0157915>] [<c0169c84>] [<c016a007>] [<c016a3bc>] 
[<c01698
c3>] [<c0159b28>] [<c01411be>]
       [<c013fd4c>] [<c0139b69>] [<c0139c47>] [<c0106e43>]
Code: 8b 42 08 ff d0 83 c4 08 85 c0 75 0b 31 c0 e9 9a 03 00 00 8d

>>EIP; c0164149 <leaf_copy_boundary_item+2e9/6a0>   <=====
Trace; c0164ce7 <leaf_copy_items+97/100>
Trace; c0164f34 <leaf_move_items+44/80>
Trace; c0164ffb <leaf_shift_right+1b/50>
Trace; c0155023 <balance_leaf_when_delete+343/360>
Trace; c0155084 <balance_leaf+44/2550>
Trace; c015fbeb <dc_check_balance_internal+29b/510>
Trace; c015ffd3 <dc_check_balance+13/30>
Trace; c0160401 <clear_all_dirty_bits+11/20>
Trace; c0157915 <do_balance+85/100>
Trace; c0169c84 <reiserfs_cut_from_item+94/460>
Trace; c016a007 <reiserfs_cut_from_item+417/460>
Trace; c016a3bc <reiserfs_do_truncate+30c/420>
Trace; c01698c3 <reiserfs_delete_object+23/40>
Trace; c0159b28 <reiserfs_delete_inode+48/a0>
Trace; c01411be <iput+9e/130>
Trace; c013fd4c <d_delete+4c/70>
Trace; c0139b69 <vfs_unlink+f9/130>
Trace; c0139c47 <sys_unlink+a7/120>
Trace; c0106e43 Before first symbol
Code;  c0164149 <leaf_copy_boundary_item+2e9/6a0>
00000000 <_EIP>:
Code;  c0164149 <leaf_copy_boundary_item+2e9/6a0>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c016414c <leaf_copy_boundary_item+2ec/6a0>
   3:   ff d0                     call   *%eax
Code;  c016414e <leaf_copy_boundary_item+2ee/6a0>
   5:   83 c4 08                  add    $0x8,%esp
Code;  c0164151 <leaf_copy_boundary_item+2f1/6a0>
   8:   85 c0                     test   %eax,%eax
Code;  c0164153 <leaf_copy_boundary_item+2f3/6a0>
   a:   75 0b                     jne    17 <_EIP+0x17> c0164160 
<leaf_copy_boun
dary_item+300/6a0>
Code;  c0164155 <leaf_copy_boundary_item+2f5/6a0>
   c:   31 c0                     xor    %eax,%eax
Code;  c0164157 <leaf_copy_boundary_item+2f7/6a0>
   e:   e9 9a 03 00 00            jmp    3ad <_EIP+0x3ad> c01644f6 
<leaf_copy_bo
undary_item+696/6a0>
Code;  c016415c <leaf_copy_boundary_item+2fc/6a0>
  13:   8d 00                     lea    (%eax),%eax
[6.] the command that causes it is:  `rm -rf /root/wine-directx`  its a wine 
source tree. tho any kind of access into the directory seems to screw me. for 
example a cvs update also does the same.
[7.1.] software:
Linux rogue 2.4.3-ac3 #2 Sun Apr 8 04:23:40 CDT 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79
binutils               2.10.1
util-linux             2.11a
mount                  2.11a
modutils               2.4.4
e2fsprogs              1.18
reiserfsprogs          3.x.0b
pcmcia-cs              3.1.16
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.6
Net-tools              1.59
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         interact ns558 gameport hid joydev input NVdriver 
3c59x emu10k1 ac97_codec nls_cp437 vfat fat
[7.2.] processor:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.205
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1608.90
[7.3.] modules:
interact                2528   0 (unused)
ns558                   2176   0 (unused)
gameport                1344   0 [interact ns558]
hid                    11696   0 (unused)
joydev                  5568   0 (unused)
input                   3072   0 [interact hid joydev]
NVdriver              625584  12
3c59x                  23680   1
emu10k1                39280   1 (autoclean)
ac97_codec              7536   0 (autoclean) [emu10k1]
nls_cp437               4384   1 (autoclean)
vfat                    8592   1 (autoclean)
fat                    29280   0 (autoclean) [vfat]
[7.4.] loaded driver/hardware info
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
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8000-803f : Promise Technology, Inc. 20265
  8000-8007 : ide2
  8008-800f : ide3
  8010-803f : PDC20265
8400-8403 : Promise Technology, Inc. 20265
8800-8807 : Promise Technology, Inc. 20265
9000-9003 : Promise Technology, Inc. 20265
9400-9407 : Promise Technology, Inc. 20265
9800-9807 : Creative Labs SB Live!
  9800-9807 : ns558-pci
a000-a01f : Creative Labs SB Live! EMU10000
  a000-a01f : EMU10K1
a400-a47f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
  a400-a47f : eth0
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001fd621 : Kernel code
  001fd622-002470bf : Kernel data
d5000000-d501ffff : Promise Technology, Inc. 20265
d5800000-d580007f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
d6000000-d7dfffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation GeForce 256 DDR
d7f00000-e3ffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation GeForce 256 DDR
e4000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
[7.5]. pci info
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d6000000-d7dfffff
        Prefetchable memory behind bridge: d7f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] 
(rev 04)
        Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 10Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 12000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at a400 [size=128]
        Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 9800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 0d30 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9000 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8400 [size=4]
        Region 4: I/O ports at 8000 [size=64]
        Region 5: Memory at d5000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 
10) (prog-if 00 [VGA])
        Subsystem: Creative Labs CT6971 GeForce 256 DDR
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>
[7.6.] SCSI info:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TDK      Model: CDRW8432         Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: E-IDE    Model: CD-ROM 45X       Rev: 32  
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] other info:
cat /proc/ide/hda/model    
IBM-DTLA-307030
cat /proc/ide/hda/settings 
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                3737            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           68              0               69              rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_kb_per_request      127             1               127             rw
multcount               8               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
NOTE: dma is enabled, but i also tried with dma disabled and got the same 
result.
cat /proc/ide/hda/geometry 
physical     59560/16/63
logical      3737/255/63
   3     0   30018240 hda
   3     1   27013297 hda1
   3     2      16033 hda2
   3     3          1 hda3
   3     4    2923830 hda4
   3     5      64228 hda5
NOTE: the reiser partition is hda1

hope this is all you need.

xOr
--
you have no chance to survive make your time.
