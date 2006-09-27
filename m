Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWI0Moe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWI0Moe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWI0Moe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:44:34 -0400
Received: from mx1.pretago.de ([89.110.132.150]:19630 "EHLO mx1.pretago.de")
	by vger.kernel.org with ESMTP id S932281AbWI0Moc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:44:32 -0400
From: Markus Schoder <lists@gammarayburst.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM with 2.6.18: BUG: scheduling while atomic
Date: Wed, 27 Sep 2006 14:44:20 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271444.20845.lists@gammarayburst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Twice within the last 4 days the kernel started generating

BUG: scheduling while atomic: swapper/0x00000001/0

messages like crazy (several hundreds per second) and would not stop until
rebooted.  I have no idea what triggered it.

Did not have this problem with the 2.6.17 series which I am back to
using now.

I am using the proprietary nvidia module so if people think it helps I can try
to recreate the problem without this module (might take a few days though).

The logged call traces are not always completely identical here are some
examples:

Sep 24 13:29:24 gondolin kernel: Call Trace:
Sep 24 13:29:24 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 24 13:29:24 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 24 13:29:24 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 24 13:29:24 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

Sep 24 13:29:24 gondolin kernel: Call Trace:
Sep 24 13:29:24 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 24 13:29:24 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 24 13:29:24 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff80256c50>] datagram_poll+0x0/0xf0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 24 13:29:24 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 24 13:29:24 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

Sep 27 11:29:51 gondolin kernel: Call Trace:
Sep 27 11:29:51 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 27 11:29:51 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 27 11:29:51 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 27 11:29:51 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 27 11:29:51 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

Sep 27 13:22:01 gondolin kernel: Call Trace:
Sep 27 13:22:01 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 27 13:22:01 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 27 13:22:01 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 27 13:22:01 gondolin kernel:  [<ffffffff8024a550>] mempool_free_slab+0x0/0x10
Sep 27 13:22:01 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 27 13:22:01 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 27 13:22:01 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

Sep 27 13:22:05 gondolin kernel: Call Trace:
Sep 27 13:22:05 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 27 13:22:05 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 27 13:22:05 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 27 13:22:05 gondolin kernel:  [<ffffffff8043e480>] raid0_unplug+0x0/0x60
Sep 27 13:22:05 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 27 13:22:05 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 27 13:22:05 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

Sep 27 13:22:09 gondolin kernel: Call Trace:
Sep 27 13:22:09 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
Sep 27 13:22:09 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
Sep 27 13:22:09 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
Sep 27 13:22:09 gondolin kernel:  [<ffffffff804191e0>] ata_exec_command+0x0/0x50
Sep 27 13:22:09 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
Sep 27 13:22:09 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
Sep 27 13:22:09 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

ver_linux output:

Linux gondolin 2.6.18 #1 SMP PREEMPT Sat Sep 23 12:56:20 CEST 2006 x86_64 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.8.11
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   100
Modules Loaded         nvidia parport_pc lp parport af_packet nls_iso8859_1 nls_cp437 vfat fat w83627hf hwmon_vid hwmon eeprom i2c_isa sidewinder joydev snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device usbhid snd_timer snd_page_alloc snd_util_mem i2c_nforce2 snd_hwdep emu10k1_gp gameport sky2 evdev i2c_core psmouse ohci_hcd ehci_hcd pcspkr snd soundcore unix

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4800+
stepping        : 2
cpu MHz         : 2412.381
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4826.72
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4800+
stepping        : 2
cpu MHz         : 2412.381
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4823.81
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

$ cat /proc/modules
nvidia 5425556 12 - Live 0xffffffff88169000
parport_pc 34536 1 - Live 0xffffffff8815f000
lp 11848 0 - Live 0xffffffff88159000
parport 38988 2 parport_pc,lp, Live 0xffffffff8814e000
af_packet 19724 2 - Live 0xffffffff88148000
nls_iso8859_1 5952 1 - Live 0xffffffff88145000
nls_cp437 7616 1 - Live 0xffffffff88142000
vfat 12864 1 - Live 0xffffffff8813d000
fat 48752 1 vfat, Live 0xffffffff88130000
w83627hf 29456 0 - Live 0xffffffff88127000
hwmon_vid 3968 1 w83627hf, Live 0xffffffff88125000
hwmon 3528 1 w83627hf, Live 0xffffffff8802e000
eeprom 7312 0 - Live 0xffffffff88122000
i2c_isa 5376 1 w83627hf, Live 0xffffffff8811f000
sidewinder 11904 0 - Live 0xffffffff8811b000
joydev 10496 0 - Live 0xffffffff88117000
snd_emu10k1_synth 7616 0 - Live 0xffffffff88114000
snd_emux_synth 36864 1 snd_emu10k1_synth, Live 0xffffffff8810a000
snd_seq_virmidi 7168 1 snd_emux_synth, Live 0xffffffff88107000
snd_seq_midi_emul 7552 1 snd_emux_synth, Live 0xffffffff88104000
snd_seq_dummy 3908 0 - Live 0xffffffff8805b000
snd_seq_oss 33728 0 - Live 0xffffffff880fa000
snd_seq_midi 7936 0 - Live 0xffffffff880f7000
snd_seq_midi_event 7936 3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi, Live 0xffffffff880f4000
snd_seq 56256 9 snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live 0xffffffff880e5000
snd_emu10k1 122016 2 snd_emu10k1_synth, Live 0xffffffff880c6000
snd_rawmidi 23712 3 snd_seq_virmidi,snd_seq_midi,snd_emu10k1, Live 0xffffffff880bf000
snd_ac97_codec 104536 1 snd_emu10k1, Live 0xffffffff880a4000
snd_ac97_bus 3200 1 snd_ac97_codec, Live 0xffffffff8801b000
snd_pcm_oss 44320 0 - Live 0xffffffff88098000
snd_mixer_oss 17088 1 snd_pcm_oss, Live 0xffffffff88092000
snd_pcm 80968 3 snd_emu10k1,snd_ac97_codec,snd_pcm_oss, Live 0xffffffff8807d000
snd_seq_device 7956 8 snd_emu10k1_synth,snd_emux_synth,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_emu10k1,snd_rawmidi, Live 0xffffffff8807a000
usbhid 42720 0 - Live 0xffffffff8806e000
snd_timer 22408 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xffffffff88067000
snd_page_alloc 8784 2 snd_emu10k1,snd_pcm, Live 0xffffffff88063000
snd_util_mem 4736 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff88060000
i2c_nforce2 8064 0 - Live 0xffffffff8805d000
snd_hwdep 9352 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff88057000
emu10k1_gp 4160 0 - Live 0xffffffff88054000
gameport 13968 3 sidewinder,emu10k1_gp, Live 0xffffffff8804f000
sky2 36740 0 - Live 0xffffffff88045000
evdev 10368 0 - Live 0xffffffff88041000
i2c_core 20416 5 nvidia,w83627hf,eeprom,i2c_isa,i2c_nforce2, Live 0xffffffff8803b000
psmouse 40080 0 - Live 0xffffffff88030000
ohci_hcd 20036 0 - Live 0xffffffff88028000
ehci_hcd 31688 0 - Live 0xffffffff8801f000
pcspkr 3584 0 - Live 0xffffffff8801d000
snd 55976 15 snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_device,snd_timer,snd_hwdep, Live 0xffffffff8800c000
soundcore 9696 1 snd, Live 0xffffffff88008000
unix 27544 214 - Live 0xffffffff88000000

$ cat /proc/ioports
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
01f0-01f7 : ide0
0295-0296 : w83627hf
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0960-0967 : 0000:00:08.0
  0960-0967 : sata_nv
0970-0977 : 0000:00:07.0
  0970-0977 : sata_nv
09e0-09e7 : 0000:00:08.0
  09e0-09e7 : sata_nv
09f0-09f7 : 0000:00:07.0
  09f0-09f7 : sata_nv
0b60-0b63 : 0000:00:08.0
  0b60-0b63 : sata_nv
0b70-0b73 : 0000:00:07.0
  0b70-0b73 : sata_nv
0be0-0be3 : 0000:00:08.0
  0be0-0be3 : sata_nv
0bf0-0bf3 : 0000:00:07.0
  0bf0-0bf3 : sata_nv
4000-407f : motherboard
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  401c-401c : ACPI PM2_CNT_BLK
  4020-4027 : ACPI GPE0_BLK
4080-40ff : motherboard
4400-447f : motherboard
4480-44ff : motherboard
  44a0-44af : ACPI GPE1_BLK
4800-487f : motherboard
4880-48ff : motherboard
4c00-4c3f : 0000:00:01.1
  4c00-4c3f : nForce2_smbus
4c40-4c7f : 0000:00:01.1
  4c40-4c7f : nForce2_smbus
5000-5fff : PCI Bus #05
  5c00-5c7f : 0000:05:00.0
6000-6fff : PCI Bus #04
7000-7fff : PCI Bus #03
  7c00-7cff : 0000:03:00.0
    7c00-7cff : sky2
8000-8fff : PCI Bus #02
9000-afff : PCI Bus #01
  9000-900f : 0000:01:0d.0
    9000-900f : sata_sil
  9400-9403 : 0000:01:0d.0
    9400-9403 : sata_sil
  9800-9807 : 0000:01:0d.0
    9800-9807 : sata_sil
  9c00-9c03 : 0000:01:0d.0
    9c00-9c03 : sata_sil
  a000-a007 : 0000:01:0d.0
    a000-a007 : sata_sil
  a400-a47f : 0000:01:0c.0
  a800-a807 : 0000:01:09.1
    a800-a807 : emu10k1-gp
  ac00-ac1f : 0000:01:09.0
    ac00-ac1f : EMU10K1
b400-b407 : 0000:00:0a.0
  b400-b407 : forcedeth
b800-b80f : 0000:00:08.0
  b800-b80f : sata_nv
cc00-cc0f : 0000:00:07.0
  cc00-cc0f : sata_nv
e000-e00f : 0000:00:06.0
  e000-e007 : ide0
  e008-e00f : ide1
ec00-ecff : 0000:00:04.0
f000-f0ff : 0000:00:04.0
fc00-fc1f : 0000:00:01.1

$ cat /proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00200000-0049e3ff : Kernel code
  0049e400-0058017f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #05
  d0000000-dfffffff : 0000:05:00.0
e0000000-efffffff : reserved
fa000000-fcffffff : PCI Bus #05
  fa000000-faffffff : 0000:05:00.0
    fa000000-faffffff : nvidia
  fb000000-fbffffff : 0000:05:00.0
  fc000000-fc01ffff : 0000:05:00.0
fd800000-fd8fffff : PCI Bus #04
fd900000-fd9fffff : PCI Bus #04
fda00000-fdafffff : PCI Bus #03
  fda00000-fda1ffff : 0000:03:00.0
fdb00000-fdbfffff : PCI Bus #03
  fdbfc000-fdbfffff : 0000:03:00.0
    fdbfc000-fdbfffff : sky2
fdc00000-fdcfffff : PCI Bus #02
fdd00000-fddfffff : PCI Bus #02
fde00000-fdefffff : PCI Bus #01
  fdefe000-fdefe3ff : 0000:01:0d.0
    fdefe000-fdefe3ff : sata_sil
  fdeff000-fdeff7ff : 0000:01:0c.0
fdf00000-fdffffff : PCI Bus #01
  fdf00000-fdf7ffff : 0000:01:0d.0
fe029000-fe029fff : 0000:00:0a.0
  fe029000-fe029fff : forcedeth
fe02a000-fe02afff : 0000:00:08.0
  fe02a000-fe02afff : sata_nv
fe02b000-fe02bfff : 0000:00:07.0
  fe02b000-fe02bfff : sata_nv
fe02d000-fe02dfff : 0000:00:04.0
fe02f000-fe02ffff : 0000:00:02.0
  fe02f000-fe02ffff : ohci_hcd
feb00000-feb000ff : 0000:00:02.1
  feb00000-feb000ff : ehci_hcd
fec00000-ffffffff : reserved

# lspci -vvv
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 1.0GHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at fc00 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7585
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f000 [size=256]
	Region 1: I/O ports at ec00 [size=256]
	Region 2: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at e000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at cc00 [size=16]
	Region 5: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 09e0 [size=8]
	Region 1: I/O ports at 0be0 [size=4]
	Region 2: I/O ports at 0960 [size=8]
	Region 3: I/O ports at 0b60 [size=4]
	Region 4: I/O ports at b800 [size=16]
	Region 5: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: fde00000-fdefffff
	Prefetchable memory behind bridge: fdf00000-fdffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe029000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b400 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: 00000000fdc00000-00000000fdcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x2, ASPM L0s, Port 3
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x4
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 8, PowerLimit 25.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: fdb00000-fdbfffff
	Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 4, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fd900000-fd9fffff
	Prefetchable memory behind bridge: 00000000fd800000-00000000fd8fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x8
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 2, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fa000000-fcffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at ac00 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.1 Input device controller: Creative Labs SB Live! Game Port (rev 06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Unknown device 0574:086c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fdeff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at a400 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=100mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0d.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a000 [size=8]
	Region 1: I/O ports at 9c00 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9400 [size=4]
	Region 4: I/O ports at 9000 [size=16]
	Region 5: Memory at fdefe000 (32-bit, non-prefetchable) [size=1K]
	[virtual] Expansion ROM at fdf00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 15)
	Subsystem: Micro-Star International Co., Ltd. Marvell 88E8053 Gigabit Ethernet Controller (MSI)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fdbfc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at 7c00 [size=256]
	[virtual] Expansion ROM at fda00000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting

05:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7800 GTX] (rev a1) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation Unknown device 02c2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
	Region 5: I/O ports at 5c00 [size=128]
	[virtual] Expansion ROM at fc000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD3200JD-60K Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD3200JD-60K Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05

$ cat /proc/mdstat
Personalities : [raid0]
md0 : active raid0 sdb1[1] sda1[0]
      586131328 blocks 4k chunks

unused devices: <none>
