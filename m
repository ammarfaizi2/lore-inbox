Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290655AbSARK12>; Fri, 18 Jan 2002 05:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSARK1U>; Fri, 18 Jan 2002 05:27:20 -0500
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:13450 "EHLO
	ace.ulyssis.org") by vger.kernel.org with ESMTP id <S290655AbSARK1I>;
	Fri, 18 Jan 2002 05:27:08 -0500
Date: Fri, 18 Jan 2002 11:27:03 +0100
From: Stijn Opheide <stijn.opheide@kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops in 2.4.18-pre4
Message-ID: <20020118112703.C9703@ace.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. I have a problem with loading the analog module for joystick support.

2. Full description

This problem also exists in 2.4.17. I have an Aureal Vortex 1 PCI
soundcard and compiled all joystick support as module. When I try to
load the analog module, I get an oops:

bifrost:~# modprobe joydev
bifrost:~# modprobe pcigame
PCI: Found IRQ 11 for device 00:10.0
gameport0: Aureal Semiconductor Vortex 1 at pci00:10.0 speed 1657 kHz
bifrost:~# modprobe gameport
bifrost:~# modprobe analog
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
d884312a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d884312a>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: d4f32da0   ecx: 00000001   edx: 00000000
esi: d8867c64   edi: d46cf000   ebp: d4f32da0   esp: d6547eb8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 429, stackpage=d6547000)
Stack: d88412fc d4f32da0 00000001 d4f32da0 d886731d d4f32da0 d8867c64
00000001
        d4f32da0 d8867c64 d46cf88c 00001d00 d6546000 d88675fe d4f32da0
d8867c64
               d46cf000 d4f32da0 d8867c64 00000001 00001d00 d46cf000
00001d00 d8841283
Call Trace: [<d88412fc>] [<d886731d>] [<d8867c64>] [<d8867c64>]
[<d88675fe>]
                  [<d8867c64>] [<d8867c64>] [<d8841283>] [<d8867c64>]
[<d8867817>] [<d8867c64>]
                     [<c011896d>] [<d8866060>] [<c0106e4b>]

Code: 8b 00 c6 04 10 00 31 c0 c3 b8 ff ff ff ff c3 8d 76 00 83 ec
 Segmentation fault

I'm using sounddrivers from www.opensound.com, but I tried to load the
joystick modules before loading soundmodules.


3. Kernel version

bifrost:/var/log# cat /proc/version 
Linux version 2.4.18-pre4 (root@bifrost) (gcc version 2.95.4 20011006
(Debian prerelease)) #2 SMP Thu Jan 17 17:13:57 CET 2002

4. Output of Oops

ksymoops 2.4.3 on i686 2.4.18-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre4/ (default)
     -m /boot/System.map-2.4.18-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 17 14:46:04 bifrost kernel: Oops: 0000
Jan 17 14:46:04 bifrost kernel: CPU:    0
Jan 17 14:46:04 bifrost kernel: EIP:    0010:[<d884312a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 17 14:46:04 bifrost kernel: EFLAGS: 00010246
Jan 17 14:46:04 bifrost kernel: eax: 00000000   ebx: d1e4fb60   ecx:
00000001   edx: 00000000
Jan 17 14:46:04 bifrost kernel: esi: d8867c64   edi: d0d7a000   ebp:
d1e4fb60   esp: d0d5deb8
Jan 17 14:46:04 bifrost kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 14:46:04 bifrost kernel: Process modprobe (pid: 589,
stackpage=d0d5d000)
Jan 17 14:46:04 bifrost kernel: Stack: d88412fc d1e4fb60 00000001
d1e4fb60 d886731d d1e4fb60 d8867c64 00000001
Jan 17 14:46:04 bifrost kernel:        d1e4fb60 d8867c64 d0d7a88c
00001d00 d0d5c000 d88675fe d1e4fb60 d8867c64
Jan 17 14:46:04 bifrost kernel:        d0d7a000 d1e4fb60 d8867c64
00000001 00001d00 d0d7a000 00001d00 d8841283
Jan 17 14:46:04 bifrost kernel: Call Trace: [<d88412fc>] [<d886731d>]
[<d8867c64>] [<d8867c64>] [<d88675fe>]
Jan 17 14:46:04 bifrost kernel:    [<d8867c64>] [<d8867c64>]
[<d8841283>] [<d8867c64>] [<d8867817>] [<d8867c64>]
Jan 17 14:46:04 bifrost kernel: Code: 8b 00 c6 04 10 00 31 c0 c3 b8 ff
ff ff ff c3 8d 76 00 83 ec

>>EIP; d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
>><=====
Trace; d88412fc <[gameport]gameport_open+14/40>
Trace; d886731c <[analog]analog_init_port+38/2d4>
Trace; d8867c64 <[analog]analog_dev+0/e>
Trace; d8867c64 <[analog]analog_dev+0/e>
Trace; d88675fe <[analog]analog_connect+46/d4>
Trace; d8867c64 <[analog]analog_dev+0/e>
Trace; d8867c64 <[analog]analog_dev+0/e>
Trace; d8841282 <[gameport]gameport_register_device+2e/3c>
Trace; d8867c64 <[analog]analog_dev+0/e>
Trace; d8867816 <[analog]init_module+e/18>
Trace; d8867c64 <[analog]analog_dev+0/e>
Code;  d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
00000000 <_EIP>:
Code;  d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
<=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  d884312c <[sndshield]udi_interruptible_sleep_on_timeout+20/30>
   2:   c6 04 10 00               movb   $0x0,(%eax,%edx,1)
Code;  d8843130 <[sndshield]udi_interruptible_sleep_on_timeout+24/30>
   6:   31 c0                     xor    %eax,%eax
Code;  d8843132 <[sndshield]udi_interruptible_sleep_on_timeout+26/30>
   8:   c3                        ret
Code;  d8843132 <[sndshield]udi_interruptible_sleep_on_timeout+26/30>
   9:   b8 ff ff ff ff            mov    $0xffffffff,%eax
Code;  d8843138 <[sndshield]udi_interruptible_sleep_on_timeout+2c/30>
   e:   c3                        ret
Code;  d8843138 <[sndshield]udi_interruptible_sleep_on_timeout+2c/30>
   f:   8d 76 00                  lea    0x0(%esi),%esi
Code;  d884313c <[sndshield]udi_wake_up+0/38>
  12:   83 ec 00                  sub    $0x0,%esp


1 warning issued.  Results may not be reliable.


5. Environment

5.1. ver_linux output

bifrost:/usr/src/linux# sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux bifrost 2.4.18-pre4 #2 SMP Thu Jan 17 17:13:57 CET 2002 i686
unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.10
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         softsynth a3dvortex audiobuf pnp midi ac97
soundbase sndshield analog gameport

5.2. /proc/cpuinfo

bifrost:/var/log# cat /proc/version 
Linux version 2.4.18-pre4 (root@bifrost) (gcc version 2.95.4 20011006
(Debian prerelease)) #2 SMP Thu Jan 17 17:13:57 CET 2002
bifrost:/var/log# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.030
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
mca cmov pat pse36 mmx fxsr
bogomips        : 897.84

5.3. /proc/modules

bifrost:/var/log# cat /proc/modules 
softsynth             109984   2
a3dvortex              32128   2
audiobuf               12320   2 [softsynth a3dvortex]
pnp                    50308   2 [a3dvortex]
midi                   30460   2 [softsynth a3dvortex pnp]
ac97                    8096   2 [a3dvortex]
soundbase             622240   2 [softsynth a3dvortex audiobuf pnp midi
ac97]
sndshield              10668   0 [softsynth a3dvortex audiobuf pnp midi
ac97 soundbase]
analog                  7424 (initializing)
gameport                1564   0 [analog]

5.4. /proc/ioports and /proc/iomem

bifrost:/var/log# cat /proc/io
iomem    ioports  
bifrost:/var/log# cat /proc/ioports 
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0400-043f : Intel Corp. 82371AB PIIX4 ACPI
0440-045f : Intel Corp. 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  bc00-bcff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
d800-d807 : Aureal Semiconductor Vortex 1
da00-da07 : Aureal Semiconductor Vortex 1
dc00-dc1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  dc00-dc1f : ne2k-pci
de00-de1f : Intel Corp. 82371AB PIIX4 USB
  de00-de1f : usb-uhci
ffa0-ffaf : Intel Corp. 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

bifrost:/var/log# cat /proc/iomem 
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17ffffff : System RAM
  00100000-00273109 : Kernel code
  0027310a-002e5cbf : Kernel data
e5c00000-e5cfffff : PCI Bus #01
e8000000-ebffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
ede00000-efefffff : PCI Bus #01
  ee000000-eeffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  efeff000-efefffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
effc0000-effdffff : Aureal Semiconductor Vortex 1

5.5. PCI information

bifrost:/var/log# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: ede00000-efefffff
        Prefetchable memory behind bridge: e5c00000-e5cfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at de00 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
        Subsystem: D-Link System Inc DE-528
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=32]

00:10.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev
02)
        Subsystem: Aztech System Ltd: Unknown device 1002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 3000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at effc0000 (32-bit, non-prefetchable)
[size=128K]
        Region 1: I/O ports at da00 [size=8]
        Region 2: I/O ports at d800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at ee000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: I/O ports at bc00 [size=256]
        Region 2: Memory at efeff000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at efec0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

5.6. SCSI information (I only have scsi emulation for ide-cdwriting)

bifrost:/var/log# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1202 Rev: 1018
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HP       Model: CD-Writer+ 8100  Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02


greetings,

Stijn.

P.S. I'm not experienced in reporting bugs (this was my first one), so I
hope I did it right :-)

-- 
Stijn Opheide
mail: stijn.opheide@kotnet.org -- cernunos@ulyssis.org
web: http://bifrost.kotnet.org -- http://cernunos.studentenweb.org
