Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161526AbWJ3Vt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161526AbWJ3Vt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161528AbWJ3Vt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:49:58 -0500
Received: from maximus.itgardendrift.se ([193.138.74.3]:20857 "EHLO
	DR2EX01.hosting.itg") by vger.kernel.org with ESMTP
	id S1161526AbWJ3Vt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:49:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PROBLEM: raid5 just dies
Date: Mon, 30 Oct 2006 22:50:06 +0100
Message-ID: <6FDE26082D451C41BE1A3742966200B3B51C66@DR2EX01.hosting.itg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: raid5 just dies
Thread-Index: Acb8bV0Qwn6nE5iERVOEElEQj/a9og==
From: "Andreas Paulsson" <andreas.paulsson@itgarden.se>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Raid5 just dies

[2.] Full description of the problem/report:
During a copy from a ReiserFS system to a raid5 system, it just locks up
and prints out a nice error message:
kernel BUG at mm/slab.c:595!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: tun ipv6 af_packet pcspkr rtc snd_via82xx gameport
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro i2c_core
generic shpchp pci_hotplug via_agp agpgart via82cxxx_audio uart401 sound
soundcore ac97_codec sata_via libata via_rhine mii aes cryptoloop loop
psmouse ide_cd cdrom unix
CPU:    0
EIP:    0060:[<c0160201>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18.1 #4)
EIP is at kmem_cache_free+0x71/0x80
eax: 8000082c   ebx: c18defc0   ecx: 0000000c   edx: c142e4c0
esi: c18def80   edi: e1726a40   ebp: c18d68c0   esp: c1bcdde8
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 897, ti=c1bcc000 task=c1bac580 task.ti=c1bcc000)
Stack: 00000001 c10805a0 c18defc0 c18def80 e1726a40 00000000 c0145879
c18d68c0
       e1726a40 e7fa4ae0 c18def80 e7fa4a80 c0168c71 e1726a40 c18defc0
e7fa4ae0
       00000000 c0168cb8 e7fa4ae0 c18def80 c0168fa9 e7fa4ae0 c0168591
e7fa4ae0
Call Trace:
 [<c0145879>] mempool_free+0x59/0xd0
 [<c0168c71>] bio_free+0x31/0x60
 [<c0168cb8>] bio_fs_destructor+0x18/0x20
 [<c0168fa9>] bio_put+0x29/0x40
 [<c0168591>] end_bio_bh_io_sync+0x41/0x50
 [<c0169ef8>] bio_endio+0x58/0x80
 [<c03b572d>] dec_pending+0x4d/0x90
 [<c03b5817>] clone_endio+0xa7/0xc0
 [<c03a049e>] handle_stripe5+0xc2e/0x1750
 [<c039cf2b>] release_stripe+0x3b/0x70
 [<c03a36f2>] raid5d+0xd2/0x170
 [<c03b04a1>] md_thread+0x61/0x130
 [<c0132130>] autoremove_wake_function+0x0/0x60
 [<c0132130>] autoremove_wake_function+0x0/0x60
 [<c03b0440>] md_thread+0x0/0x130
 [<c0131c32>] kthread+0xb2/0xc0
 [<c0131b80>] kthread+0x0/0xc0
 [<c01013e5>] kernel_thread_helper+0x5/0x10
Code: 89 7c 83 10 40 89 03 56 9d 83 c4 08 5b 5e 5f 5d c3 89 5c 24 04 89
2c 24 e8 bd fc ff ff 8b 03 eb df 0f 0b 6a 0d ca 89 47 c0 eb c2 <0f> 0b
53 02 ca 89 47 c0 eb b3 8b 52 0c eb a8 83 ec 18 89 6c 24
EIP: [<c0160201>] kmem_cache_free+0x71/0x80 SS:ESP 0068:c1bcdde8

[3.] Keywords (i.e., modules, networking, kernel):
raid5, aes-loop, kernel

[4.] Kernel version (from /proc/version):
2.6.18.1

[5.] Most recent kernel version which did not have the bug:
Uncertain, have only tried with this version

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
See above.

[7.] A small shell script or example program which triggers the
     problem (if possible)
cp -avr --target-dir=/mnt/lvm/backup /mnt/disk1 /mnt/disk2 /mnt/disk3
/mnt/disk4

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux knackebrod 2.6.18.1 #4 PREEMPT Mon Oct 30 19:07:21 CET 2006 i686
GNU/Linux
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          3.6.19
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         tun ipv6 af_packet pcspkr rtc snd_via82xx
gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro i2c_core
generic shpchp pci_hotplug via_agp agpgart via82cxxx_audio uart401 sound
soundcore ac97_codec sata_via libata via_rhine mii aes cryptoloop loop
psmouse ide_cd cdrom unix

[8.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Sempron(tm)   3000+
stepping        : 0
cpu MHz         : 1999.918
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow ts
bogomips        : 4004.12

[8.3.] Module information (from /proc/modules):
tun 11776 1 - Live 0xf8ea0000
ipv6 272352 16 - Live 0xf8f56000
af_packet 23176 2 - Live 0xf8eff000
pcspkr 3456 0 - Live 0xf8e53000
rtc 14644 0 - Live 0xf8efa000
snd_via82xx 30488 0 - Live 0xf8ef1000
gameport 17160 1 snd_via82xx, Live 0xf8eeb000
snd_ac97_codec 97568 1 snd_via82xx, Live 0xf8ebb000
snd_ac97_bus 2560 1 snd_ac97_codec, Live 0xf8e04000
snd_pcm 85896 2 snd_via82xx,snd_ac97_codec, Live 0xf8ed5000
snd_timer 26372 1 snd_pcm, Live 0xf8eb3000
snd_page_alloc 11016 2 snd_via82xx,snd_pcm, Live 0xf8e79000
snd_mpu401_uart 9472 1 snd_via82xx, Live 0xf8e75000
snd_rawmidi 27040 1 snd_mpu401_uart, Live 0xf8e92000
snd_seq_device 8844 1 snd_rawmidi, Live 0xf8e71000
snd 56292 7
snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi
,snd_seq_device, Live 0xf8ea4000
i2c_viapro 9236 0 - Live 0xf8e13000
i2c_core 23568 1 i2c_viapro, Live 0xf8e8b000
generic 5508 0 [permanent], Live 0xf8e10000
shpchp 41628 0 - Live 0xf8e7f000
pci_hotplug 36536 1 shpchp, Live 0xf8e49000
via_agp 10496 1 - Live 0xf8dfd000
agpgart 36912 1 via_agp, Live 0xf8e55000
via82cxxx_audio 30344 0 - Live 0xf8e07000
uart401 12484 1 via82cxxx_audio, Live 0xf8dea000
sound 84908 2 via82cxxx_audio,uart401, Live 0xf8e33000
soundcore 11104 3 snd,via82cxxx_audio,sound, Live 0xf8de6000
ac97_codec 20108 1 via82cxxx_audio, Live 0xf8df7000
sata_via 11268 0 - Live 0xf8db4000
libata 109588 1 sata_via, Live 0xf8e17000
via_rhine 26248 0 - Live 0xf8def000
mii 6272 1 via_rhine, Live 0xf8db1000
aes 31808 2 - Live 0xf8ddd000
cryptoloop 4096 2 - Live 0xf8d64000
loop 18824 5 cryptoloop, Live 0xf8dab000
psmouse 42760 0 - Live 0xf8dd1000
ide_cd 44932 0 - Live 0xf8dc5000
cdrom 44064 1 ide_cd, Live 0xf8db9000
unix 30000 30 - Live 0xf8d6b000

[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
00000000-0009c7ff : System RAM
0009c800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000d4000-000d67ff : Adapter ROM
000d7000-000db1ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00440d0c : Kernel code
  00440d0d-00539c73 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-5001ffff : 0000:00:0a.0
50020000-50023fff : 0000:00:09.0
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.1
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e4000000-e401ffff : 0000:01:00.0
  e5000000-e500ffff : 0000:01:00.0
  e5010000-e501ffff : 0000:01:00.1
e7000000-e7003fff : 0000:00:09.0
e7004000-e70040ff : 0000:00:10.4
  e7004000-e70040ff : ehci_hcd
e7005000-e70050ff : 0000:00:12.0
  e7005000-e70050ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:11.5
  1000-10ff : via82cxxx_audio
4000-407f : motherboard
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  4020-4023 : ACPI GPE0_BLK
5000-500f : motherboard
  5000-500f : pnp 00:02
    5000-5007 : vt596_smbus
7000-7fff : PCI Bus #01
  7000-70ff : 0000:01:00.0
8000-8007 : 0000:00:09.0
  8000-8007 : ide2
8400-8403 : 0000:00:09.0
  8402-8402 : ide2
8800-8807 : 0000:00:09.0
  8800-8807 : ide3
8c00-8c03 : 0000:00:09.0
  8c02-8c02 : ide3
9000-900f : 0000:00:09.0
  9000-9007 : ide2
  9008-900f : ide3
9400-9407 : 0000:00:0a.0
  9400-9407 : ide4
9800-9803 : 0000:00:0a.0
  9802-9802 : ide4
9c00-9c07 : 0000:00:0a.0
  9c00-9c07 : ide5
a000-a003 : 0000:00:0a.0
  a002-a002 : ide5
a400-a4ff : 0000:00:0a.0
  a400-a407 : ide4
  a408-a40f : ide5
a800-a807 : 0000:00:0a.1
  a800-a807 : ide6
ac00-ac03 : 0000:00:0a.1
  ac02-ac02 : ide6
b000-b007 : 0000:00:0a.1
  b000-b007 : ide7
b400-b403 : 0000:00:0a.1
  b402-b402 : ide7
b800-b8ff : 0000:00:0a.1
  b800-b807 : ide6
  b808-b80f : ide7
bc00-bc07 : 0000:00:0f.0
  bc00-bc07 : sata_via
c000-c003 : 0000:00:0f.0
  c000-c003 : sata_via
c400-c407 : 0000:00:0f.0
  c400-c407 : sata_via
c800-c803 : 0000:00:0f.0
  c800-c803 : sata_via
cc00-cc0f : 0000:00:0f.0
  cc00-cc0f : sata_via
d000-d0ff : 0000:00:0f.0
  d000-d0ff : sata_via
d400-d40f : 0000:00:0f.1
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : 0000:00:10.0
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.1
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.2
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:10.3
  e400-e41f : uhci_hcd
e800-e8ff : 0000:00:11.6
ec00-ecff : 0000:00:12.0
  ec00-ecff : via-rhine

[8.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset
Host Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 8118
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Unknown mass storage controller: Promise Technology, Inc.
PDC20268 (Ultra100 TX2) (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra100TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at 8000 [size=8]
        Region 1: I/O ports at 8400 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8c00 [size=4]
        Region 4: I/O ports at 9000 [size=16]
        Region 5: Memory at e7000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at 50020000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev
07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9800 [size=4]
        Region 2: I/O ports at 9c00 [size=8]
        Region 3: I/O ports at a000 [size=4]
        Region 4: I/O ports at a400 [size=256]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev
07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at a800 [size=8]
        Region 1: I/O ports at ac00 [size=4]
        Region 2: I/O ports at b000 [size=8]
        Region 3: I/O ports at b400 [size=4]
        Region 4: I/O ports at b800 [size=256]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 185
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at c000 [size=4]
        Region 2: I/O ports at c400 [size=8]
        Region 3: I/O ports at c800 [size=4]
        Region 4: I/O ports at cc00 [size=16]
        Region 5: I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 185
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 193
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 193
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
(prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin C routed to IRQ 193
        Region 0: Memory at e7004000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
        Subsystem: Asustek Computer, Inc. A7V600 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 209
        Region 0: I/O ports at 1000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537
[AC97 Modem] (rev 80)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 0
        Region 0: I/O ports at e800 [disabled] [size=256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 78)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ff
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at e7005000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200] (rev 01) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 4028
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 7000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at e4000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon
9200] (Secondary) (rev 01)
        Subsystem: Giga-byte Technology: Unknown device 4029
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled]
[size=128M]
        Region 1: Memory at e5010000 (32-bit, non-prefetchable)
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[8.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
md0 : active raid5 hdd1[1] hdc1[0] hdh1[4] hdg1[3] hde1[2]
      1250274304 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]

All are 300gb drives and partitions are Linux Raid Autodetect. Md0 is a
physical volume for a volume group /dev/vg0/lv0, which is then
aes-encrypted with losetup as /dev/loop1.


[X.] Other notes, patches, fixes, workarounds:

None.

Regards,
Andreas Paulsson
