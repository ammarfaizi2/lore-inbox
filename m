Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTL3TIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTL3TIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:08:43 -0500
Received: from web40210.mail.yahoo.com ([66.218.78.71]:31068 "HELO
	web40210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262758AbTL3TIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:08:22 -0500
Message-ID: <20031230190822.88961.qmail@web40210.mail.yahoo.com>
Date: Tue, 30 Dec 2003 11:08:22 -0800 (PST)
From: Dom <binary1230@yahoo.com>
Subject: KERNEL BUG: 2.4.22 processes occasionally segfault, kernel crashes, machine reboots
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] (seemingly random?) processes occasionally
segfault, kernel crashes, machine reboots

[2.] This particular time I was running oggenc on
bunch of .wav files, and the machine froze and
rebooted.  When it came back up, I found the kernel
error message in syslog.  I have had this happen once
before.  I woke up in the middle of the night to hear
the sound of my floppy drive whirring during the POST.
 I thought I was rooted or something. The box was
playing mp3's in xmms (so maybe its a float thing?). 
The system is debian woody with a stock 2.4.22 kernel,
non-smp. NOTE - it DOESNT say OOPS in the logs, but I
did the oops-tracing anyway.  It says 'kernel BUG at
memory.c:377! invalid operand: 0000' NOTE: I'm not
subscribed to the mailing list, if you want me to run
some tests or something please email me directly.  I
dont know if this still happens in 2.6 or not,as I
havent had a chance to test it on this box.   (if the
stuff below is mangled because of yahoo mail, let me
know and ill resend it nicer)

[3.] reboot, kernel, memory.c, oggenc, wav
[4.] Linux version 2.4.22 (root@localhost) (gcc
version 2.95.4 20011002 (Debian prerelease)) #3 Wed
Oct 15 11:34:26 EDT 2003

[5.] ksymoops 2.4.5 on i686 2.4.22.  Options used
     -v /usr/src/linux-2.4.22/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (default)

kernel BUG at memory.c:377!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01248a8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c68ff080   ebx: c6ef9ee0   ecx: 08073000   edx:
c68ff000
esi: c6ef9ee0   edi: 08073000   ebp: fffe1000   esp:
c283fe84
ds: 0018   es: 0018   ss: 0018
Process oggenc (pid: 1426, stackpage=c283f000)
Stack: c2823e00 c6ef9ee0 08073000 fffe1000 c68ff084
c68ff084 08448000 0000000a 
       0000000a 00000246 c2823c20 00000000 08054000
c0126e65 c6ef9ee0 08073000 
       fffe1000 c6ef9ee0 c283e000 c283e000 0000000b
c28238c0 c0116e3e c6ef9ee0 
Call Trace:    [<c0126e65>] [<c0116e3e>] [<c011ae65>]
[<c011fffa>] [<c0108521>]
  [<c0114c84>] [<c0115ca6>] [<c0125d3b>] [<c0108774>]
[<c01086bc>]
Code: 0f 0b 79 01 80 d4 22 c0 89 cd 89 44 24 28 8b 44
24 30 89 44 


>>EIP; c01248a8 <zap_page_range+34/238>   <=====

>>eax; c68ff080 <_end+65fe198/84ff118>
>>ebx; c6ef9ee0 <_end+6bf8ff8/84ff118>
>>ecx; 08073000 Before first symbol
>>edx; c68ff000 <_end+65fe118/84ff118>
>>esi; c6ef9ee0 <_end+6bf8ff8/84ff118>
>>edi; 08073000 Before first symbol
>>ebp; fffe1000 <END_OF_CODE+376f89bd/????>
>>esp; c283fe84 <_end+253ef9c/84ff118>

Trace; c0126e65 <exit_mmap+b5/118>
Trace; c0116e3e <mmput+4a/60>
Trace; c011ae65 <do_exit+8d/240>
Trace; c011fffa <sig_exit+92/94>
Trace; c0108521 <do_signal+1e9/258>
Trace; c0114c84 <do_page_fault+0/480>
Trace; c0115ca6 <schedule+2fa/324>
Trace; c0125d3b <sys_brk+bb/e4>
Trace; c0108774 <error_code+34/3c>
Trace; c01086bc <signal_return+14/18>

Code;  c01248a8 <zap_page_range+34/238>
00000000 <_EIP>:
Code;  c01248a8 <zap_page_range+34/238>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01248aa <zap_page_range+36/238>
   2:   79 01                     jns    5 <_EIP+0x5>
c01248ad <zap_page_range+39/238>
Code;  c01248ac <zap_page_range+38/238>
   4:   80 d4 22                  adc    $0x22,%ah
Code;  c01248af <zap_page_range+3b/238>
   7:   c0 89 cd 89 44 24 28      rorb  
$0x28,0x244489cd(%ecx)
Code;  c01248b6 <zap_page_range+42/238>
   e:   8b 44 24 30               mov   
0x30(%esp,1),%eax
Code;  c01248ba <zap_page_range+46/238>
  12:   89 44 00 00               mov   
%eax,0x0(%eax,%eax,1)

[6.] NO KNOWN WAY TO REPRODUCE (I'll see what I can
do)

[7.1] /usr/src/linux-2.4.22/scripts/ver_linux OUTPUT:
Linux localhost 2.4.22 #3 Wed Oct 15 11:34:26 EDT 2003
i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         parport_pc lp parport sg
ide-scsi tdfx emu10k1 sound soundcore ac97_codec hid
usb-storage usbmouse input usb-uhci usbcore vfat nfsd
nfs lockd sunrpc tulip crc32 af_packet unix

[7.2] /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 451.028
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 897.84

[7.3] /proc/modules :
parport_pc             13892   1 (autoclean)
lp                      6464   0 (autoclean)
parport                24576   1 (autoclean)
[parport_pc lp]
sg                     28740   0 (unused)
ide-scsi                8864   0
tdfx                   35384   0 (unused)
emu10k1                55552   0
sound                  53228   0 [emu10k1]
soundcore               3492   7 [emu10k1 sound]
ac97_codec             12000   0 [emu10k1]
hid                    13856   0 (unused)
usb-storage            22492   0 (unused)
usbmouse                1824   0 (unused)
input                   3296   0 [hid usbmouse]
usb-uhci               21252   0 (unused)
usbcore                55744   1 [hid usb-storage
usbmouse usb-uhci]
vfat                    9308   0 (unused)
nfsd                   66528   0 (unused)
nfs                    63452   0 (unused)
lockd                  47360   0 [nfsd nfs]
sunrpc                 60916   0 [nfsd nfs lockd]
tulip                  37952   1
crc32                   2832   0 [tulip]
af_packet              11752   1
unix                   13924  76 (autoclean)

[7.4] DRIVER AND HARDWARE INFO:
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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
6400-641f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  6400-641f : usb-uhci
6800-68ff : 3Dfx Interactive, Inc. Voodoo 3
6c00-6c1f : Creative Labs SB Live! EMU10k1
  6c00-6c1f : EMU10K1
7000-70ff : Linksys Network Everywhere Fast Ethernet
10/100 model NC100
  7000-70ff : tulip
e000-efff : PCI Bus #01
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0022472e : Kernel code
  0022472f-002af16f : Kernel data
a0000000-afffffff : PCI Bus #01
d0000000-dfffffff : PCI Bus #01
e0000000-e3ffffff : Intel Corp. 440BX/ZX/DX -
82443BX/ZX/DX Host bridge
e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e6000000-e7ffffff : 3Dfx Interactive, Inc. Voodoo 3
e8000000-e80003ff : Linksys Network Everywhere Fast
Ethernet 10/100 model NC100
  e8000000-e80003ff : tulip
ffff0000-ffffffff : reserved

[7.5] pci info:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX
Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX
AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset-
FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev
02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE
(rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB
(rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev
02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 VGA compatible controller: 3Dfx Interactive,
Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device
0057
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e4000000 (32-bit,
non-prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, prefetchable)
[size=32M]
	Region 2: I/O ports at 6800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB
Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 6c00 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Linksys Network
Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
	Subsystem: Linksys: Unknown device 0570
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min, 32000ns max), cache line
size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 7000 [size=256]
	Region 1: Memory at e8000000 (32-bit,
non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6] SCSI INFO:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CDRW/DVD SM-332B Rev: T401
  Type:   CD-ROM                           ANSI SCSI
revision: 02

=====
Dominic C. [binary1230(AT)yahoo.com]
http://einsteinsbreakfast.com

__________________________________
Do you Yahoo!?
Find out what made the Top Yahoo! Searches of 2003
http://search.yahoo.com/top2003
