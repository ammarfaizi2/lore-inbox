Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbSI1AxU>; Fri, 27 Sep 2002 20:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSI1AxU>; Fri, 27 Sep 2002 20:53:20 -0400
Received: from h004.c015.snv.cp.net ([209.228.35.119]:52214 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id <S262659AbSI1AxP>;
	Fri, 27 Sep 2002 20:53:15 -0400
X-Sent: 28 Sep 2002 00:58:34 GMT
Date: Sat, 28 Sep 2002 02:56:11 +0200
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel crashes when recording audio
Message-ID: <20020928005611.GB1070@cornils.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Malte Cornils <mcornils@cornils.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long description:
When trying to capture audio/video from my bttv card (see lspci output 
below), my system's reaction ranges from hard freezes to instant reboots to
segfaults - the latter variant enabled me to capture a kernel oops. I'm
using avicap from avifile project, with XviD capture codec. Video capture
works flawlessly. When I enable audio capture in addition (48 kHz, 16bit,
Mono) is when the problem starts (not after some time, but at the moment I
start the capture process). I do not have many ideas on why 
smp_apic_timer_interrupt is the problem, since this is a uniprocessor
system.

Suggestions?

-Malte #8-)

Keywords: audio, via, ac97, capture, smp_apic_timer
Kernel version: 2.4.18-k7
Oops output (decoded):

--cut (captured before system was rebooted, so should be accurate)--

ksymoops 2.4.6 on i686 2.4.18-k7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-k7/ (default)
     -m /boot/System.map-2.4.18-k7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.18-k7/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k7/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k7/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k7/kernel/fs/reiserfs/reiserfs.o for module reiserfs has changed since load
Unable to handle kernel paging request at virtual address ffffe0b0
c0111f6b
*pde = 00001063
Oops: 0002
CPU:    0
EIP:    0010:[<c0111f6b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210002
eax: c26bdfc4   ebx: 48ec5ae8   ecx: bf3ff80c   edx: 00000018
esi: 0000042d   edi: 00000038   ebp: 48ec1740   esp: c26bdfb8
ds: 0018   es: 0018   ss: 0018
Process avicap (pid: 1261, stackpage=c26bd000)
Stack: 48ec5ae8 c010abfd c26bdfc4 48ec5ae8 bf3ff80c 0000042d 0000042d
00000038
       48ec1740 0000085a 0000002b 0000002b ffffffef 48e6aa2e 00000023
00200206
       bf3ff7c4 0000002b
Call Trace: [<c010abfd>]
Code: c7 05 b0 e0 ff ff 00 00 00 00 ff 05 84 53 25 c0 31 d2 f6 40


>>EIP; c0111f6b <smp_apic_timer_interrupt+b/d0>   <=====

>>eax; c26bdfc4 <_end+243c618/1058b6b4>
>>esp; c26bdfb8 <_end+243c60c/1058b6b4>

Trace; c010abfd <call_apic_timer_interrupt+5/10>

Code;  c0111f6b <smp_apic_timer_interrupt+b/d0>
00000000 <_EIP>:
Code;  c0111f6b <smp_apic_timer_interrupt+b/d0>   <=====
   0:   c7 05 b0 e0 ff ff 00      movl   $0x0,0xffffe0b0   <=====
Code;  c0111f72 <smp_apic_timer_interrupt+12/d0>
   7:   00 00 00 
Code;  c0111f75 <smp_apic_timer_interrupt+15/d0>
   a:   ff 05 84 53 25 c0         incl   0xc0255384
Code;  c0111f7b <smp_apic_timer_interrupt+1b/d0>
  10:   31 d2                     xor    %edx,%edx
Code;  c0111f7d <smp_apic_timer_interrupt+1d/d0>
  12:   f6 40 00 00               testb  $0x0,0x0(%eax)


5 warnings issued.  Results may not be reliable.

Example program: is avicap from avifile project
Environment: on demand
Software: Avifile CVS-020816-14:06-2.95.4. Base system is Debian woody, with
some elements from testing and sid (e.g. avifile). The kernel is the Debian
standard kernel 2.4.18-k7 without any modification from me.

Further information (as detailed in BUG-REPORTING, but missing
/proc/scsi/scsi information because it's likely irrelevant):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 801.442
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1599.07

parport_pc             22280   1 (autoclean)
lp                      6496   0 (autoclean)
parport                23360   1 (autoclean) [parport_pc lp]
nfsd                   66688   8 (autoclean)
lockd                  48288   1 (autoclean) [nfsd]
sunrpc                 59732   1 (autoclean) [nfsd lockd]
ext3                   57248   2 (autoclean)
jbd                    35640   2 (autoclean) [ext3]
ext2                   30848   1 (autoclean)
ide-cd                 26720   0 (autoclean)
cdrom                  29216   0 (autoclean) [ide-cd]
agpgart                30688   0 (unused)
apm                     9276   2
via82cxxx_audio        18432   1
uart401                 6176   0 [via82cxxx_audio]
ac97_codec              9696   0 [via82cxxx_audio]
sound                  54540   0 [via82cxxx_audio uart401]
soundcore               3684   4 [via82cxxx_audio sound]
ac97                    3024   0 (unused)
tuner                   8196   1 (autoclean)
tvaudio                 9856   1 (autoclean)
msp3400                14160   1 (autoclean)
bttv                   60608   1
i2c-algo-bit            7148   1 [bttv]
i2c-core               12992   0 [tuner tvaudio msp3400 bttv i2c-algo-bit]
videodev                4704   4 [bttv]
ne2k-pci                5056   1
8390                    6016   0 [ne2k-pci]
rtc                     5592   0 (autoclean)
unix                   13636 104 (autoclean)
ide-disk                6816   6 (autoclean)
ide-probe-mod           8096   0 (autoclean)
ide-mod               131404   6 (autoclean) [ide-cd ide-disk ide-probe-mod]
reiserfs              154816   2 (autoclean)
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
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-c00f : VIA Technologies, Inc. Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
cc00-ccff : VIA Technologies, Inc. AC97 Audio Controller
  cc00-ccff : via82cxxx_audio
d000-d003 : VIA Technologies, Inc. AC97 Audio Controller
  d000-d003 : via82cxxx_audio
d400-d403 : VIA Technologies, Inc. AC97 Audio Controller
  d400-d403 : via82cxxx_audio
dc00-dc1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  dc00-dc1f : ne2k-pci
e000-e0ff : Realtek Semiconductor Co., Ltd. RTL-8139
e400-e4ff : ATI Technologies Inc 3D Rage LT Pro
[Here, cat /proc/iomem >> /tmp/bug ended with a segfault!]
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at cc00 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: <available only to root>

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=32]
	Expansion ROM at <unassigned> [disabled] [size=32K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0b.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro (rev dc) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage LT Pro
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e400 [size=256]
	Region 2: Memory at d6001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d6002000 (32-bit, prefetchable) [size=4K]

00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d6003000 (32-bit, prefetchable) [size=4K]




