Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTKXPGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTKXPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:06:00 -0500
Received: from october.skynet.be ([195.238.3.58]:2003 "EHLO october.skynet.be")
	by vger.kernel.org with ESMTP id S263632AbTKXPEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:04:54 -0500
Subject: Error message when aic7xxx is probing devices "Badness in
	kobject_get" on 2.6.0-test10
From: Jean-Yves Simon <lethalwp@tiscali.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069686284.2444.14.camel@little.lethalwp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 24 Nov 2003 16:04:44 +0100
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (october.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[1.] One line summary of the problem:
on boot, an error appear while the aic7xxx module loads on a
2.6.0-test10.


[2.] Full description of the problem/report:
device used:
00:11.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)

dmesg output:
---
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
PCI: Found IRQ 5 for device 0000:00:11.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
Badness in kobject_get at lib/kobject.c:439
Call Trace:
 [<c01c0a3f>] kobject_get+0x4f/0x60
 [<c0203b58>] get_device+0x18/0x20
 [<e0832e0c>] scsi_device_get+0x2c/0xa0 [scsi_mod]
 [<e0832f3b>] __scsi_iterate_devices+0x4b/0x90 [scsi_mod]
 [<e0837507>] scsi_run_host_queues+0x17/0x50 [scsi_mod]
 [<e08ae764>] ahc_linux_release_simq+0x94/0xe0 [aic7xxx]
 [<e08a9b9d>] ahc_linux_dv_thread+0x1fd/0x2c0 [aic7xxx]
 [<e08a99a0>] ahc_linux_dv_thread+0x0/0x2c0 [aic7xxx]
 [<c0108d75>] kernel_thread_helper+0x5/0x10

  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.61
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
SCSI device sda: 8515173 512-byte hdwr sectors (4360 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
kjournald starting.  Commit interval 5 seconds
---

[3.] Keywords (i.e., modules, networking, kernel):
kernel

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test10 (root@little.lethalwp) (gcc version 3.3.2
20031022 (Red Hat Linux 3.3.2-1)) #1 Mon Nov 24 13:00:22 CET 2003


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
It's not an Oops, but an error, see [2.]

[6.] A small shell script or example program which triggers the
     problem (if possible)
Just boot with the aic7xxx.ko module in the initrd, i suppose it will do
this too if you load it manually with modprobe


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux little.lethalwp 2.6.0-test10 #1 Mon Nov 24 13:00:22 CET 2003 i686
i686 i386 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.25
e2fsprogs              1.34
reiserfsprogs          3.6.8
quota-tools            3.06.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         snd_pcm_oss agpgart nvidia vmnet vmmon nfs ide_cd
cdrom snd_mixer_oss uhci_hcd eeprom i2c_sensor usb_storage i2c_viapro
i2c_core binfmt_misc parport_pc lp parport nfsd exportfs lockd sunrpc
capability commoncap iptable_filter ip_tables 8139too mii crc32 ipv6
microcode reiserfs nls_iso8859_1 nls_cp437 vfat fat snd_seq_midi
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul
snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_pcm
snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem
snd_hwdep snd soundcore hid usbcore aic7xxx sd_mod scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.661
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1970.17


[7.3.] Module information (from /proc/modules):
snd_pcm_oss 53700 0 - Live 0xe0d30000
agpgart 32328 0 - Live 0xe0cd1000
nvidia 1706124 10 - Live 0xe0e98000
vmnet 28016 4 - Live 0xe0c79000
vmmon 70105 0 - Live 0xe0c88000
nfs 159328 1 - Live 0xe0c9e000
ide_cd 40836 0 - Live 0xe0c48000
cdrom 35360 1 ide_cd, Live 0xe0c54000
snd_mixer_oss 19264 1 snd_pcm_oss, Live 0xe0b6e000
uhci_hcd 32624 0 - Live 0xe0c09000
eeprom 7048 0 - Live 0xe0a8f000
i2c_sensor 2880 1 eeprom, Live 0xe0a92000
usb_storage 66816 0 - Live 0xe0c5e000
i2c_viapro 5964 0 - Live 0xe0a85000
i2c_core 25352 3 eeprom,i2c_sensor,i2c_viapro, Live 0xe0c01000
binfmt_misc 10504 1 - Live 0xe0b63000
parport_pc 28940 1 - Live 0xe0bf8000
lp 10688 0 - Live 0xe0a6b000
parport 44264 2 parport_pc,lp, Live 0xe0bec000
nfsd 184832 8 - Live 0xe0c19000
exportfs 6464 1 nfsd, Live 0xe0a7b000
lockd 64560 3 nfs,nfsd, Live 0xe0b77000
sunrpc 134184 6 nfs,nfsd,lockd, Live 0xe0b8a000
capability 3748 0 - Live 0xe0860000
commoncap 6464 1 capability, Live 0xe0a78000
iptable_filter 2688 0 - Live 0xe0811000
ip_tables 17888 1 iptable_filter, Live 0xe0a7f000
8139too 20928 0 - Live 0xe0a88000
mii 5120 1 8139too, Live 0xe0a75000
crc32 4320 1 8139too, Live 0xe0a72000
ipv6 255136 16 - Live 0xe0bac000
microcode 6688 0 - Live 0xe0a6f000
reiserfs 240116 1 - Live 0xe0a96000
nls_iso8859_1 3904 4 - Live 0xe080d000
nls_cp437 5568 4 - Live 0xe0a05000
vfat 15744 4 - Live 0xe0a3a000
fat 45568 1 vfat, Live 0xe0a48000
snd_seq_midi 8416 0 - Live 0xe0a01000
snd_emu10k1_synth 7776 0 - Live 0xe09fe000
snd_emux_synth 37856 1 snd_emu10k1_synth, Live 0xe0a25000
snd_seq_virmidi 7488 1 snd_emux_synth, Live 0xe09fb000
snd_seq_midi_emul 7968 1 snd_emux_synth, Live 0xe0958000
snd_seq_oss 34816 0 - Live 0xe0a1b000
snd_seq_midi_event 7680 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Live
0xe0930000
snd_seq 55792 8
snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event, Live 0xe0a0c000
snd_emu10k1 70340 1 snd_emu10k1_synth, Live 0xe0945000
snd_rawmidi 24864 3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1, Live
0xe093d000
snd_pcm 100612 2 snd_pcm_oss,snd_emu10k1, Live 0xe095b000
snd_timer 25572 2 snd_seq,snd_pcm, Live 0xe0935000
snd_seq_device 8040 7
snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi, Live 0xe088e000
snd_ac97_codec 54884 1 snd_emu10k1, Live 0xe0851000
snd_page_alloc 11812 2 snd_emu10k1,snd_pcm, Live 0xe0818000
snd_util_mem 4448 2 snd_emux_synth,snd_emu10k1, Live 0xe0820000
snd_hwdep 9440 1 snd_emu10k1, Live 0xe082d000
snd 51876 16
snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xe0862000
soundcore 9088 1 snd, Live 0xe081c000
hid 32960 0 - Live 0xe0823000
usbcore 110428 5 uhci_hcd,usb_storage,hid, Live 0xe0872000
aic7xxx 211116 6 - Live 0xe0891000
sd_mod 15232 8 - Live 0xe0813000
scsi_mod 118808 3 usb_storage,aic7xxx,sd_mod, Live 0xe0832000


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : viapro-smbus
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:07.2
  d400-d41f : uhci_hcd
d800-d8ff : 0000:00:11.0
dc00-dcff : 0000:00:12.0
  dc00-dcff : 8139too
e000-e01f : 0000:00:13.0
  e000-e01f : EMU10K1
e400-e407 : 0000:00:13.1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d4000-000d93ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-002ade57 : Kernel code
  002ade58-00337eff : Kernel data
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-d807ffff : 0000:01:00.0
e0000000-e7ffffff : 0000:00:00.0
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : 0000:01:00.0
eb000000-eb000fff : 0000:00:11.0
  eb000000-eb000fff : aic7xxx
eb001000-eb0010ff : 0000:00:12.0
  eb001000-eb0010ff : 8139too
ffff0000-ffffffff : reserved




[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev 82)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
(rev 12)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 08) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
(rev 20)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:11.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: I/O ports at d800 [disabled] [size=256]
        Region 1: Memory at eb000000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
        Subsystem: Accton Technology Corporation: Unknown device 9211
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at eb001000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:13.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs SB Live! 5.1 Model SB0100
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at e400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d8000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2



[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: ENTERPRISE       Rev: 1.61
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-20TS   Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03





-- 
Jean-Yves Simon <lethalwp@tiscali.be>

