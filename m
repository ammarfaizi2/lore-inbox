Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVKPKIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVKPKIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVKPKIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:08:16 -0500
Received: from vil93-7-82-241-21-155.fbx.proxad.net ([82.241.21.155]:41880
	"EHLO hubert.bat1.fr.arkeia.com") by vger.kernel.org with ESMTP
	id S932596AbVKPKIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:08:15 -0500
Date: Wed, 16 Nov 2005 11:07:10 +0100
From: Hubert Verstraete <hubskml@free.fr>
To: linux-kernel@vger.kernel.org
Cc: Hubert Verstraete <hubskml@free.fr>
Subject: PROBLEM: DMA issue with the IDE controller
Message-ID: <20051116100710.GA4359@homer.bat1.fr.arkeia.com>
Reply-To: Hubert Verstraete <hubskml@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Here's my kernel's bug report following this bugzilla: 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=172278

Please, CC me the answers, as I have not subscribed to the list.

1. DMA issue on an IDE bus with a cd/dvd recorder.

2. When I use cdrecord on the dvd-recorder on hdc, cdrecord hangs forever.
A few seconds later, I start getting the following kernel messages:
12:33:50 homer kernel: ide-cd: cmd 0x3 timed out
12:33:50 homer kernel: hdc: lost interrupt
12:34:50 homer kernel: ide-cd: cmd 0x3 timed out
12:34:50 homer kernel: hdc: lost interrupt
12:35:50 homer kernel: hdd: lost interrupt
12:36:50 homer kernel: ide-cd: cmd 0x3 timed out
12:36:50 homer kernel: hdd: lost interrupt
12:37:50 homer kernel: ide-cd: cmd 0x3 timed out
12:37:50 homer kernel: hdd: lost interrupt
12:38:50 homer kernel: hdc: lost interrupt
12:39:30 homer kernel: hdc: lost interrupt

I found a work-around on this issue; when disabling DMA on hdc, cdrecord
works and I can burn a CDR.
So this may point a problem within the driver of the IDE controller?
It's an ALi M5229.

3. kernel, ide, DMA, cdrecord, ALi M5229

4. Linux version 2.6.14-1.1637_FC4smp (bhcompile@hs20-bc1-4.build.redhat.com) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 SMP Wed Nov 9 18:34:11 EST 2005
It also happens in Knoppix's 2.6.12, Fedora Core 4's 2.6.13 and 2.6.14,
and the official 2.6.14.

5. Couldn't try before 2.6.12 due to the module sata_uli not working for
my hardware.

6. No Oops are received.

7. cdrecord -atip /dev/hdc

8.1 sh scripts/ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux homer.bat1.fr.arkeia.com 2.6.14-1.1637_FC4smp #1 SMP Wed Nov 9 18:34:11 EST 2005 i686 i686 i386 GNU/Linux
 
Gnu C                  4.0.1
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   058
Modules Loaded         nfsd exportfs lockd nfs_acl parport_pc lp parport autofs4 sunrpc dm_mod video button battery ac usb_storage fglrx ipv6 pcspkr ohci_hcd ehci_hcd i2c_ali15x3 i2c_core snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc r8169 floppy ext3 jbd sata_uli libata sd_mod scsi_mod

8.2. cat /proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 1
cpu MHz		: 3200.751
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx pni monitor ds_cpl cid xtpr
bogomips	: 6412.86

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 1
cpu MHz		: 3200.751
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx pni monitor ds_cpl cid xtpr
bogomips	: 6400.73

8.3. cat /proc/modules:

nfsd 231373 15 - Live 0xe0b85000
exportfs 10432 1 nfsd, Live 0xe0a47000
lockd 64457 2 nfsd, Live 0xe0b11000
nfs_acl 7873 1 nfsd, Live 0xe090a000
parport_pc 32005 1 - Live 0xe0b08000
lp 16905 0 - Live 0xe0a41000
parport 39689 2 parport_pc,lp, Live 0xe0afd000
autofs4 23749 2 - Live 0xe0a3a000
sunrpc 146173 11 nfsd,lockd,nfs_acl, Live 0xe0b25000
dm_mod 61533 0 - Live 0xe0a6a000
video 20293 0 - Live 0xe09f0000
button 10705 0 - Live 0xe0997000
battery 13509 0 - Live 0xe0921000
ac 8901 0 - Live 0xe0974000
usb_storage 79113 0 - Live 0xe0a55000
fglrx 262432 7 - Live 0xe09a6000
ipv6 271009 22 - Live 0xe09f6000
pcspkr 7985 0 - Live 0xe090d000
ohci_hcd 26721 0 - Live 0xe098f000
ehci_hcd 38861 0 - Live 0xe099b000
i2c_ali15x3 11973 0 - Live 0xe08ec000
i2c_core 26433 1 i2c_ali15x3, Live 0xe096c000
snd_hda_intel 22721 1 - Live 0xe095c000
snd_hda_codec 86469 1 snd_hda_intel, Live 0xe0978000
snd_seq_dummy 7749 0 - Live 0xe0844000
snd_seq_oss 36417 0 - Live 0xe0917000
snd_seq_midi_event 11073 1 snd_seq_oss, Live 0xe081f000
snd_seq 55377 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xe094d000
snd_seq_device 13133 3 snd_seq_dummy,snd_seq_oss,snd_seq, Live 0xe08e7000
snd_pcm_oss 55025 0 - Live 0xe093e000
snd_mixer_oss 22209 2 snd_pcm_oss, Live 0xe08ab000
snd_pcm 91973 3 snd_hda_intel,snd_hda_codec,snd_pcm_oss, Live 0xe0926000
snd_timer 29381 2 snd_seq,snd_pcm, Live 0xe08f1000
snd 59429 9 snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xe08fa000
soundcore 13857 2 snd, Live 0xe083f000
snd_page_alloc 14921 2 snd_hda_intel,snd_pcm, Live 0xe0830000
r8169 33097 0 - Live 0xe0835000
floppy 66181 0 - Live 0xe08d5000
ext3 135753 3 - Live 0xe08b2000
jbd 62037 1 ext3, Live 0xe0879000
sata_uli 11073 4 - Live 0xe081b000
libata 51405 1 sata_uli, Live 0xe086b000
sd_mod 22849 5 - Live 0xe0823000
scsi_mod 140009 3 usb_storage,libata,sd_mod, Live 0xe0847000

8.4. cat /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
1000-103f : 0000:00:1e.1
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1010-1015 : ACPI CPU throttle
  1018-1027 : GPE0_BLK
1080-10ff : motherboard
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-afff : PCI Bus #02
  a000-a007 : 0000:02:11.0
  a400-a4ff : 0000:02:11.0
  a800-a8ff : 0000:02:15.0
    a800-a8ff : r8169
b000-b01f : 0000:00:00.0
b400-b40f : 0000:00:1f.1
  b400-b40f : sata_uli
b800-b807 : 0000:00:1f.1
  b800-b807 : sata_uli
bc00-bc0f : 0000:00:1f.1
  bc00-bc0f : sata_uli
c000-c007 : 0000:00:1f.1
  c000-c007 : sata_uli
c400-c41f : 0000:00:1f.1
  c400-c41f : sata_uli
f000-f00f : 0000:00:1f.0
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000d8000-000d9fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00320681 : Kernel code
  00320682-003ea923 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
30000000-300fffff : PCI Bus #02
  30000000-3000ffff : 0000:02:15.0
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
d8000000-d9ffffff : PCI Bus #01
  d8000000-d801ffff : 0000:01:00.0
  d9000000-d900ffff : 0000:01:00.0
  d9010000-d901ffff : 0000:01:00.1
da000000-dbffffff : PCI Bus #02
  db000000-db0000ff : 0000:02:15.0
    db000000-db0000ff : r8169
  db001000-db0010ff : 0000:02:11.0
dc000000-dc003fff : 0000:00:1d.0
  dc000000-dc003fff : ICH HD audio
dc004000-dc004fff : 0000:00:1c.1
  dc004000-dc004fff : ohci_hcd
dc005000-dc005fff : 0000:00:1c.2
  dc005000-dc005fff : ohci_hcd
dc006000-dc0060ff : 0000:00:1c.3
  dc006000-dc0060ff : ehci_hcd
dc007000-dc007fff : 0000:00:1c.0
  dc007000-dc007fff : ohci_hcd
dc008000-dc0083ff : 0000:00:1f.1
  dc008000-dc0083ff : sata_uli
e0000000-efffffff : reserved
fec00000-ffffffff : reserved

8.5. lspci -vvv:
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5a33 (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 2: I/O ports at b000 [disabled] [size=32]
	Region 3: Memory at <ignored> (64-bit, non-prefetchable)

00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Root Port (Slot-) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40b1
	Capabilities: [b0] #0d [0000]
	Capabilities: [b8] HyperTransport: MSI Mapping
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:19.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: da000000-dbffffff
	Prefetchable memory behind bridge: 30000000-300fffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [c0] HyperTransport: MSI Mapping

00:1c.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at dc007000 (32-bit, non-prefetchable) [size=4K]

00:1c.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin B routed to IRQ 209
	Region 0: Memory at dc004000 (32-bit, non-prefetchable) [size=4K]

00:1c.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin C routed to IRQ 209
	Region 0: Memory at dc005000 (32-bit, non-prefetchable) [size=4K]

00:1c.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (4000ns min, 8000ns max)
	Interrupt: pin D routed to IRQ 209
	Region 0: Memory at dc006000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1d.0 Class 0403: ALi Corporation High Definition Audio/AC'97 Host Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 20000ns max)
	Interrupt: pin C routed to IRQ 201
	Region 0: Memory at dc000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 31)
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 6000ns max)

00:1e.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if fa)
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 185
	Region 4: I/O ports at f000 [size=16]

00:1f.1 RAID bus controller: ALi Corporation ULi 5287 SATA (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 80
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at b400 [size=16]
	Region 1: I/O ports at b800 [size=8]
	Region 2: I/O ports at bc00 [size=16]
	Region 3: I/O ports at c000 [size=8]
	Region 4: I/O ports at c400 [size=32]
	Region 5: Memory at dc008000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at d8000000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Advanced Error Reporting

01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
	Subsystem: PC Partner Limited: Unknown device 0501
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Region 0: Memory at d9010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

02:11.0 Communication controller: Agere Systems V.92 56K WinModem (rev 03)
	Subsystem: Agere Systems: Unknown device 044c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at db001000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at a000 [size=8]
	Region 2: I/O ports at a400 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:15.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 007d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max), Cache Line Size 20
	Interrupt: pin A routed to IRQ 193
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at 30000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

8.6. No scsi devices attached.

Regards,
Hubert
