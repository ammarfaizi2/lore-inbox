Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbTGTWLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbTGTWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:10:59 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:24777 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268677AbTGTWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:10:17 -0400
Subject: BUG in 2.4.21 ide-iops.c:1262
From: Daniel Sobe <daniel.sobe@epost.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058739880.1077.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Jul 2003 00:25:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when my TRAXDATA cd writer cannot read a disc which I
either want to mount or play audio from. I do not know whether the
hardware is flawed or there is really a bug in the kernel. My other
drives do not produce this error.

The writer is with used with the ide-scsi module. When I traced this
oops with another computer via serial console the kernel was not tainted
(it is now due to the softmodem driver). The ruby-patch cannot be cause
of the problem, the crashes happened before, too.

Please cc me on any discussion because I'm not subscribed to the list.
Any help would be appreciated.

Regards,

Daniel





cat /proc/version:

Linux version 2.4.21-backstreet-ruby (root@localhost) (gcc version
2.95.4 20011002 (Debian prerelease)) #6 Son Jul 20 23:20:34 MEST 2003



scsi : aborting command due to timeout : pid 67, scsi1, channel 0, id 0,
lun 0 S
tart/Stop Unit 00 00 00 03 00
hdd: irq timeout: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
hdd: irq timeout: status=0x80 { Busy }
scsi : aborting command due to timeout : pid 67, scsi1, channel 0, id 0,
lun 0 S
tart/Stop Unit 00 00 00 03 00
SCSI host 1 abort (pid 67) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
kernel BUG at ide-iops.c:1262!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01e2293>]    Not tainted
EFLAGS: 00013086
eax: cff18480   ebx: 00000000   ecx: c02a5f1c   edx: 00000002
esi: 00000000   edi: c030ecf0   ebp: c030eaf4   esp: c02a5e84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: 00000000 00000000 cfed4dc0 cbda7e00 cff18480 00003082 c01e245c
c030ecf0
       00000000 d093a7a6 c030ecf0 d091919c cbda7e00 00000002 cbda7e00
00003286
       00000000 c02e6240 00000000 d0918739 cbda7e00 00000002 d0923a00
00000001
Call Trace:    [<c01e245c>] [<d093a7a6>] [<d091919c>] [<d0918739>]
[<d0923a00>]
  [<d09186e0>] [<c011d51c>] [<c0119f0a>] [<c0119e36>] [<c0119c2a>]
[<c010834f>]
  [<c010a5b8>] [<c01c1be3>] [<c01c1ae0>] [<c0105240>] [<c01c1ae0>]
[<c01052d2>]
  [<c0105000>] [<c0105027>]

Code: 0f 0b ee 04 ba 14 27 c0 90 8d 74 26 00 80 bf 09 01 00 00 20
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


>>EIP; c01e2293 <set_using_dma+23/a0>   <=====

>>eax; cff18480 <_end+fc0d504/105f1084>
>>ecx; c02a5f1c <print_IO_APIC+30c/450>
>>edi; c030ecf0 <_end+3d74/105f1084>
>>ebp; c030eaf4 <_end+3b78/105f1084>
>>esp; c02a5e84 <print_IO_APIC+274/450>

Trace; c01e245c <ide_add_generic_settings+3c/1e0>
Trace; d093a7a6 <[ide-scsi]idescsi_reset+16/20>
Trace; d091919c <[scsi_mod]scsi_reset+dc/340>
Trace; d0918739 <[scsi_mod]scsi_old_times_out+59/110>
Trace; d0923a00 <[scsi_mod]RCSid+4e0/ac0>
Trace; d09186e0 <[scsi_mod]scsi_old_times_out+0/110>
Trace; c011d51c <timer_bh+24c/370>
Trace; c0119f0a <bh_action+1a/50>
Trace; c0119e36 <tasklet_hi_action+46/70>
Trace; c0119c2a <do_softirq+5a/b0>
Trace; c010834f <do_IRQ+bf/d0>
Trace; c010a5b8 <call_do_IRQ+5/d>
Trace; c01c1be3 <pr_power_idle+103/270>
Trace; c01c1ae0 <pr_power_idle+0/270>
Trace; c0105240 <default_idle+0/30>
Trace; c01c1ae0 <pr_power_idle+0/270>
Trace; c01052d2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/30>

Code;  c01e2293 <set_using_dma+23/a0>
00000000 <_EIP>:
Code;  c01e2293 <set_using_dma+23/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01e2295 <set_using_dma+25/a0>
   2:   ee                        out    %al,(%dx)
Code;  c01e2296 <set_using_dma+26/a0>
   3:   04 ba                     add    $0xba,%al
Code;  c01e2298 <set_using_dma+28/a0>
   5:   14 27                     adc    $0x27,%al
Code;  c01e229a <set_using_dma+2a/a0>
   7:   c0 90 8d 74 26 00 80      rclb   $0x80,0x26748d(%eax)
Code;  c01e22a1 <set_using_dma+31/a0>
   e:   bf 09 01 00 00            mov    $0x109,%edi
Code;  c01e22a6 <set_using_dma+36/a0>
  13:   20 00                     and    %al,(%eax)


processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 648.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1294.33

ppp_deflate             3008   0 (autoclean)
zlib_deflate           18016   0 (autoclean) [ppp_deflate]
bsd_comp                4064   0 (autoclean)
ppp_async               6624   0 (autoclean)
hsfbasic2              96012   2 (autoclean)
hsfserial              21792   0 (autoclean)
hsfengine             869324   0 (autoclean) [hsfserial]
hsfosspec              21788   1 (autoclean) [hsfbasic2 hsfserial
hsfengine]
ppp_generic            16076   0 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4720   0 (autoclean) [ppp_generic]
nls_cp437               4384   0 (autoclean)
vfat                    9564   0 (autoclean)
fat                    29912   0 (autoclean) [vfat]
floppy                 46016   0 (autoclean)
nls_iso8859-1           2880   0 (autoclean)
isofs                  25120   0 (autoclean)
zlib_inflate           18592   0 (autoclean) [ppp_deflate isofs]
sr_mod                 12120   0 (autoclean)
pktcdvd                18356   1 (autoclean)
sd_mod                 10204   0 (autoclean) (unused)
parport_pc             25288   1 (autoclean)
lp                      6560   0 (autoclean)
parport                25024   1 (autoclean) [parport_pc lp]
rtc                     6012   0 (autoclean)
usb-ohci               17920   0 (unused)
hid                    23072   0 (unused)
audio                  40576   0 (unused)
usbcore                62176   1 [usb-ohci hid audio]
btaudio                10240   0 (unused)
tuner                   9540   1 (autoclean)
tvaudio                11936   0 (autoclean) (unused)
msp3400                15504   1 (autoclean)
bttv                   77568   0 (unused)
videodev                5664   3 [bttv]
i2c-algo-bit            7180   1 [bttv]
i2c-core               12992   0 [tuner tvaudio msp3400 bttv
i2c-algo-bit]
es1371                 27168   1
soundcore               3588   9 [audio btaudio bttv es1371]
ac97_codec             10912   0 [es1371]
ide-scsi                9120   1
ncr53c8xx              51808   0 (unused)
scsi_mod               82712   4 [sr_mod sd_mod ide-scsi ncr53c8xx]
ide-cd                 29248   0
cdrom                  29280   0 [sr_mod pktcdvd ide-cd]
ide-floppy             12320   0

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
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0778-077a : parport0
0cf8-0cff : PCI conf1
d000-d003 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
d400-d4ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
  d400-d47f : ncr53c8xx
d800-d83f : Ensoniq 5880 AudioPCI
  d800-d83f : es1371
dc00-dcff : 3Dfx Interactive, Inc. Voodoo 3
e000-e007 : Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00241db2 : Kernel code
  00241db3-002a29f7 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX]
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV11 [GeForce2 MX]
e2000000-e3ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e7000000-e700ffff : Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
e7010000-e70100ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
e7011000-e7011fff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
e7012000-e7012fff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
  e7012000-e7012fff : usb-ohci
e7013000-e7013fff : Brooktree Corporation Bt878 Video Capture
  e7013000-e7013fff : bttv
e7014000-e7014fff : Brooktree Corporation Bt878 Audio Capture
  e7014000-e7014fff : btaudio
ffff0000-ffffffff : reserved

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e7011000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d000 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
(rev 03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev
03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
(rev 06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at e7012000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e7013000 (32-bit, prefetchable) [size=4K]

00:08.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e7014000 (32-bit, prefetchable) [size=4K]

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 23)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR) 8100S
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at e7010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at dc00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Rockwell International HCF 56k
Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01)
	Subsystem: Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev a1) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW4260          Rev: 1.0q
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x32      Rev: 1.4B
  Type:   CD-ROM                           ANSI SCSI revision: 02

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
Modules Loaded         ppp_deflate zlib_deflate bsd_comp ppp_async
hsfbasic2 hsfserial hsfengine hsfosspec ppp_generic slhc nls_cp437 vfat
fat floppy nls_iso8859-1 isofs zlib_inflate sr_mod pktcdvd sd_mod
parport_pc lp parport rtc usb-ohci hid audio usbcore btaudio tuner
tvaudio msp3400 bttv videodev i2c-algo-bit i2c-core es1371 soundcore
ac97_codec ide-scsi ncr53c8xx scsi_mod ide-cd cdrom ide-floppy



