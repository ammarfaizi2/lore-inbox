Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVFVSIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVFVSIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFVSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:08:36 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:31163 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261642AbVFVSEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:04:31 -0400
Message-ID: <42B9A46A.2020902@axicon.com>
Date: Wed, 22 Jun 2005 18:48:26 +0100
From: Colin Fletcher <colinf@axicon.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: Kernel panic when disconnecting Edirol USB2 audio interface
Content-Type: multipart/mixed;
 boundary="------------020909020105020502040804"
X-Authenticated-Sender: colinf@axicon.com
X-Spam-Processed: axicon.com, Wed, 22 Jun 2005 18:48:27 +0100
	(not processed: message from valid local sender)
X-MDRemoteIP: 10.2.3.70
X-Return-Path: colinf@axicon.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: colinf@axicon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909020105020502040804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello LKML,

I hope this is the right place for this sort of bug report: if there's a 
better place, please do point me there.


[1.] Oops and panic on disconnecting Edirol UA-1000 usb2 audio interface

[2.] I have an Edirol UA-1000 USB 2.0 Audio Capture unit. When
disconnected (or powered down), it repeatably causes a kernel panic, in
(I think) linux/drivers/usb/host/ehci-q.c, start_unlink_async(), around
line 1015:
	while (prev->qh_next.qh != qh)
		prev = prev->qh_next.qh;
where somehow prev->qh_next.qh==NULL.


[3.] usb2 ehci edirol ua-1000 unplug oops panic

[4.] kernels 2.6.12, 2.6.12-rc4, 2.6.12-rc3, 2.6.12-rc2-mm3,
2.6.11.8, 2.6.11-ac7, and some older kernel.org kernels besides. The
SuSE 9.1-supplied 2.6.5 kernels don't oops or panic, but also don't
recognise the UA-1000 as an audio device at all.

[5.]

Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: netconsole edd sg st sd_mod sr_mod scsi_mod nvram
usbserial parport_pc lp parport snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_usb_audio
snd_usb_lib snd_rawmidi snd_seq_device thermal processor fan button
battery ac snd_intel8x0 snd_ac97_codec snd_pcm ipv6 snd_timer snd
soundcore snd_page_alloc ohci_hcd ehci_hcd i2c_sis96x i2c_core evdev
af_packet pcmcia yenta_socket rsrc_nonstatic pcmcia_core sis900 mii
usbcore binfmt_misc ide_cd cdrom dm_mod reiserfs
CPU: 0
EIP: 0060:[<ded39b72>] Not tainted VLI
EFLAGS: 00010207 (2.6.12-colinf)
EIP is at start_unlink_async+0x62/0xf0 [ehci_hcd]
eax: 00000000 ebx: dae8a100 ecx: 00000000 edx: dae8a100
esi: db5cc520 edi: 00010011 ebp: dae8a100 esp: c03f5dd0
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0, threadinfo=c03f4000 task=c035bc00)
Stack: db903120 00000001 db903120 ded38f5d 02008148 d5b39e04 dae8a14c
01000000
00000000 00000001 00000001 dae8a14c db903060 db903120 c03f5fa0 db5cc520
00000000 00000001 dae8a100 db4b1900 ded3c60e c04325c0 00000001 00000000
Call Trace:
[<ded38f5d>] qh_completions+0x28d/0x310 [ehci_hcd]
[<ded3c60e>] scan_periodic+0x24e/0x300 [ehci_hcd]
[<c0118a30>] try_to_wake_up+0x2b0/0x300
[<ded3d5dd>] ehci_work+0x5d/0xc0 [ehci_hcd]
[<ded3d7fb>] ehci_irq+0x1bb/0x2e0 [ehci_hcd]
[<c0118452>] activate_task+0x92/0xb0
[<c0118a30>] try_to_wake_up+0x2b0/0x300
[<c0118353>] recalc_task_prio+0xd3/0x140
[<c0119885>] find_busiest_group+0x105/0x310
[<c0119c57>] load_balance+0x127/0x1a0
[<decf6bc4>] usb_hcd_irq+0x34/0x70 [usbcore]
[<c0142612>] handle_IRQ_event+0x32/0x70
[<c0142727>] __do_IRQ+0xd7/0x140
[<c0105846>] do_IRQ+0x36/0x70
[<c0103c92>] common_interrupt+0x1a/0x20
[<c0101030>] default_idle+0x0/0x30
[<c0101053>] default_idle+0x23/0x30
[<c0101109>] cpu_idle+0x69/0x80
[<c03f699a>] start_kernel+0x1aa/0x230
[<c03f6380>] unknown_bootoption+0x0/0x1e0
Code: fa e1 d3 de 3b 5e 18 74 75 c6 43 68 02 8d 43 60 e8 04 cd 49 e1 89
5e 1c 8b 4e 18 8b 41 48 39 d8 74 10 8d b4 26 00 00 00 00 89 c1 <8b> 40
48 39 d8 75 f7 8b 03 89 01 8b 43 48 89 41 48 8b 46 fc 85
<0>Kernel panic - not syncing: Fatal exception in interrupt



[6.] I don't know if there's any other USB hardware can cause this; it's
100% reproducible for me with the UA-1000.

[7.1.] ver_linux.txt
[7.2.] cpuinfo.txt
[7.3.] modules.txt
[7.4.] lspci.txt


[X.] The same thing seems to happen without CONFIG_PREEMPT and without
CONFIG_SMP, too.  Also it happens both with the laptop's built-in USB 2
ports and with a Belkin PCMCIA USB 2 card.

I hope this report makes sense. I'm still only a few steps on from being 
a Linux beginner, but I'm happy to try out patches, fiddle with my 
.config, or whatever it takes to get to the bottom of this.

Colin Fletcher.

-- 




--------------020909020105020502040804
Content-Type: text/plain;
 name="ver_linux.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux.txt"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux colins-laptop 2.6.12-colinf #1 SMP Sun Jun 19 12:19:41 BST 2005 i686 i686 i386 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
jfsutils               1.1.5
reiserfsprogs          3.6.13
reiser4progs           line
xfsprogs               2.6.3
pcmcia-cs              3.2.7
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        05 16:31 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   021_bk
Modules Loaded         edd sg st sd_mod sr_mod scsi_mod nvram usbserial parport_pc lp parport snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_usb_audio snd_usb_lib snd_rawmidi snd_seq_device thermal processor fan button battery ac snd_intel8x0 ipv6 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd i2c_sis96x i2c_core ohci_hcd evdev af_packet pcmcia yenta_socket rsrc_nonstatic pcmcia_core sis900 mii usbcore binfmt_misc ide_cd cdrom dm_mod reiserfs


--------------020909020105020502040804
Content-Type: text/plain;
 name="cpuinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping	: 9
cpu MHz		: 3066.517
cache size	: 512 KB
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
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 6078.46

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping	: 9
cpu MHz		: 3066.517
cache size	: 512 KB
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
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 6127.61



--------------020909020105020502040804
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 128
	Region 0: Memory at f0000000 (32-bit, non-prefetchable)
	Capabilities: [c0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	Expansion ROM at 0000c000 [disabled] [size=8K]
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 25)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1400 [disabled] [size=32]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at 1100 [size=16]

0000:00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at e000
	Region 1: I/O ports at e100 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at e200
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 000d8000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at 000da000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (20000ns max)
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at f4000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at e400
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 1e000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Mitac: Unknown device 8640
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: Memory at 90000000 (32-bit, prefetchable)
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at c000 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>



--------------020909020105020502040804
Content-Type: text/plain;
 name="modules.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules.txt"

edd 11616 0 - Live 0xdede4000
sg 39456 0 - Live 0xdeeb3000
st 40864 0 - Live 0xdeea8000
sd_mod 20224 0 - Live 0xdee86000
sr_mod 18212 0 - Live 0xdee80000
scsi_mod 138312 4 sg,st,sd_mod,sr_mod, Live 0xdeec6000
nvram 10888 0 - Live 0xdede0000
usbserial 32104 0 - Live 0xdee0f000
parport_pc 41412 1 - Live 0xdee8f000
lp 13060 0 - Live 0xdeddb000
parport 37960 2 parport_pc,lp, Live 0xdee75000
snd_seq_dummy 4740 0 - Live 0xded79000
snd_seq_oss 37504 0 - Live 0xdee6a000
snd_seq_midi_event 9088 1 snd_seq_oss, Live 0xdedd2000
snd_seq 60688 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xdee5a000
snd_pcm_oss 62752 0 - Live 0xdedfe000
snd_mixer_oss 21376 1 snd_pcm_oss, Live 0xded89000
snd_usb_audio 73280 0 - Live 0xdedeb000
snd_usb_lib 17920 1 snd_usb_audio, Live 0xded90000
snd_rawmidi 28064 1 snd_usb_lib, Live 0xdedca000
snd_seq_device 9996 4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi, Live 0xded7e000
thermal 13960 0 - Live 0xded38000
processor 23944 1 thermal, Live 0xded82000
fan 5508 0 - Live 0xded41000
button 7568 0 - Live 0xdecd2000
battery 10244 0 - Live 0xded3d000
ac 5764 0 - Live 0xded35000
snd_intel8x0 34368 4 - Live 0xded5a000
ipv6 265152 15 - Live 0xdee18000
snd_ac97_codec 79480 1 snd_intel8x0, Live 0xdedb5000
snd_pcm 107396 4 snd_pcm_oss,snd_usb_audio,snd_intel8x0,snd_ac97_codec, Live 0xded99000
snd_timer 28420 2 snd_seq,snd_pcm, Live 0xded52000
snd 65540 23 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_usb_audio,snd_usb_lib,snd_rawmidi,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xded67000
soundcore 11104 1 snd, Live 0xded1f000
snd_page_alloc 11396 2 snd_intel8x0,snd_pcm, Live 0xded1b000
ehci_hcd 49288 0 - Live 0xded44000
i2c_sis96x 6404 0 - Live 0xded18000
i2c_core 23552 1 i2c_sis96x, Live 0xded2e000
ohci_hcd 36356 0 - Live 0xded24000
evdev 10112 0 - Live 0xdecd5000
af_packet 24968 2 - Live 0xdece7000
pcmcia 28176 2 - Live 0xde86e000
yenta_socket 23048 1 - Live 0xdecc9000
rsrc_nonstatic 12800 1 yenta_socket, Live 0xde841000
pcmcia_core 51336 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xdecd9000
sis900 23168 0 - Live 0xde877000
mii 6528 1 sis900, Live 0xde83e000
usbcore 131292 6 usbserial,snd_usb_audio,snd_usb_lib,ehci_hcd,ohci_hcd, Live 0xdecf0000
binfmt_misc 13320 1 - Live 0xde839000
ide_cd 41988 0 - Live 0xde862000
cdrom 39840 2 sr_mod,ide_cd, Live 0xde857000
dm_mod 60196 0 - Live 0xde847000
reiserfs 258032 1 - Live 0xdeb81000


--------------020909020105020502040804--

