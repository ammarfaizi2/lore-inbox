Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbUK3QKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUK3QKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUK3QKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:10:13 -0500
Received: from procert.cert.dfn.de ([193.174.13.1]:49866 "EHLO
	procert.cert.dfn.de") by vger.kernel.org with ESMTP id S262145AbUK3QJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:09:20 -0500
Date: Tue, 30 Nov 2004 17:07:17 +0100
From: Friedrich Delgado Friedrichs <delgado@dfn-cert.de>
To: linux-kernel@vger.kernel.org
Subject: Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell Optiplex SX280
Message-ID: <20041130160717.GA13106@kermit.dfn-cert.de>
Reply-To: linux-kernel@vger.kernel.org, delgado@dfn-cert.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Organization: DFN-CERT Services GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Please CC me in all mails regarding this bug, as I'm not subscribed
to the list.

[1.] One line summary of the problem:

Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell Optiplex
SX280


[2.] Full description of the problem/report:


We have a bunch of 15 Dell Optiplex SX280 Workstations, all running
SuSE Linux with (nearly) unpatched 2.6.9. A few times every week, one
of these Machines will halt upon shutdown with a kernel NULL pointer
dereference before all services in the runlevel have been stopped. It
always happens in one of the init scripts, but not always in the same
ones, however it appears that the crash most often appears *after*
arpwatch has been stopped, since the last message before a crash is
most often "device eth0 left promiscuous mode".

The kernel manages to send the "NULL pointer dereference" to syslog,
and sometimes the oops to the console (but not to any log).

I have no idea how to reproduce this problem and unfortunately there's
no lkcd patch for the 2.6.9 kernel yet. Also it's not feasible to
attach a serial console to each and every one of the 15 Workstations
and I'll never know which one crashes the next time. (So I'm basically
hoping for the lkcd release for 2.6.9.)

[3.] Keywords (i.e., modules, networking, kernel):

Dell, kernel, crash, NULL pointer

[4.] Kernel version (from /proc/version):

Linux version 2.6.9-1-smp (geeko@buildhost) (gcc-Version 3.3.3 (SuSE Linux)) #1 SMP Tue Nov 9 15:06:41 CET 2004

(I built the kernel on one of the workstations with a modified
specfile for the SuSE 9.1 kernel. I removed all the SuSE patches,
except the rpm-related ones.)

[5.] Output of Oops.. message:

(I could not capture the full oops, see above, this is what was
visible at the console when the crash occured the last time. I hope
that this will suffice. I typed it in, printed it out and re-checked
the printout with the output on the console, so the information below
*should* be correct.)

 snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device
 snd soundcore af_packet usbhid ipv6 intel_agp agpgart ehci_hcd tg3
 uhci_hcd evdev nnpfs usbcore binfmt_misc subfs dm_mod ide_cd cdrom
 ext3 jbd ata_piix libata sd_mod scsi_mod
CPU:    1
EIP:    0060:[<c0171af7>]    Tainted: GF VLI
EFLAGS: 00010246   (2.6.9-1-smp 20041109140641)
EIP is at __d_path+087/1x170
eax: 00000000   ebx: dd9aefff   ecx: deb4d290   edx: dd9aeffe
esi: d86ce320   edi: 00000f07   ebp: 00000f07   esp: d744decc
ds: 007b   es: 007b   ss: 0068
Process fuser (pid: 16550, threadinfo=d744c000 task=deced350)
Stack: dd9aeffe deb4d290 00000000 df518100 deb4d290 dd9ae0f8 00000000 c0171c63
       df518100 dd9ae0f8 00000f07 d86ce320 dd9ae0f8 d86ce320 c0aa8180 c035ab84
       c017752e 00000f08 df096f00 00000005 0000002c c0aa8180 df096f00 c0186703
Call Trace:
 [<c0171c63>] d_path+0x83/0xe0
 [<c017752e>] seq_path+0x2e/0xf0
 [<c0186703>] show_map+0xd3/0x100
 [<c01770c2>] seq_read+0x232/0x290
 [<c0176e90>] seq_read+0x0/0x290
 [<c015aaae>] vfs_read+0xae/0xf0
 [<c015ad0c>] sys_read+0xec/0x70
 [<c0106dc9>] sysenter_past_esp+0x52/0x79
Code: 00 00 8d 43 ff 89 04 24 c6 43 ff 2f 8b 44 24 20 3b 74 24 04 0f 94 c2 39 44
 24 08 0f 94 c0 21 d0 8b 14 24 a8 01 75 63 8b 44 24 08 <3b> 70 10 74 64 8b 6e 10
 39 ee 74 5d 0f 18 45 00 8b 56 1c 8b 44
 Nov 30 14:16:50 count kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000010


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

SuSE Linux 9.1, with all recent patches, custom 2.6.9 kernel, arla AFS
client 0.36.2.

Linux roscoe 2.6.9-1-smp #1 SMP Tue Nov 9 15:06:41 CET 2004 i686 i686 i386 GNU/Linux

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
quota-tools            3.11.
PPP                    2.4.2
isdn4k-utils           3.4
nfs-utils              1.0.6
Linux C Library        x  1 root root 1349081 Apr  5  2004 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nvram edd joydev st sr_mod snd_pcm_oss snd_mixer_oss thermal processor fan button battery snd_intel8x0 snd_ac97_codec snd_pcm ac snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore af_packet sg usbhid usb_storage ipv6 intel_agp agpgart tg3 ehci_hcd hw_random uhci_hcd evdev nnpfs usbcore binfmt_misc subfs dm_mod ide_cd cdrom ext3 jbd ata_piix libata sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 4
cpu MHz         : 2797.038
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid xtpr
bogomips        : 5521.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 4
cpu MHz         : 2797.038
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid xtpr
bogomips        : 5586.94


[7.3.] Module information (from /proc/modules):

edd 13980 0 - Live 0xe04f4000
joydev 13632 0 - Live 0xe03fb000
sg 40480 0 - Live 0xe051e000
st 41756 0 - Live 0xe0512000
sr_mod 20516 0 - Live 0xe04ed000
nvram 13448 0 - Live 0xe0373000
snd_pcm_oss 62888 0 - Live 0xe0501000
snd_mixer_oss 23552 1 snd_pcm_oss, Live 0xe04e6000
thermal 22152 0 - Live 0xe03f4000
processor 29632 1 thermal, Live 0xe04dd000
fan 9348 0 - Live 0xe03d5000
button 12432 0 - Live 0xe0378000
battery 15364 0 - Live 0xe033a000
ac 10244 0 - Live 0xe035c000
snd_intel8x0 38092 1 - Live 0xe03ca000
snd_ac97_codec 70736 1 snd_intel8x0, Live 0xe03e1000
snd_pcm 104964 2 snd_pcm_oss,snd_intel8x0, Live 0xe04c2000
snd_timer 30212 1 snd_pcm, Live 0xe03c1000
snd_page_alloc 14216 2 snd_intel8x0,snd_pcm, Live 0xe0335000
gameport 8832 1 snd_intel8x0, Live 0xe0331000
snd_mpu401_uart 12160 1 snd_intel8x0, Live 0xe031a000
snd_rawmidi 29604 1 snd_mpu401_uart, Live 0xe0353000
snd_seq_device 12040 1 snd_rawmidi, Live 0xe02f7000
af_packet 25864 2 - Live 0xe034b000
snd 67076 11 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe0361000
soundcore 13408 1 snd, Live 0xe0289000
usbhid 44864 0 - Live 0xe033f000
ipv6 259968 19 - Live 0xe0481000
intel_agp 25120 1 - Live 0xe0312000
agpgart 36652 1 intel_agp, Live 0xe02ed000
hw_random 9620 0 - Live 0xe01cd000
ehci_hcd 34052 0 - Live 0xe02e3000
tg3 84996 0 - Live 0xe02fc000
uhci_hcd 34960 0 - Live 0xe027f000
evdev 12928 0 - Live 0xe026e000
nnpfs 213484 1 - Live 0xe02ad000
usbcore 113636 5 usbhid,ehci_hcd,uhci_hcd, Live 0xe0290000
binfmt_misc 16008 1 - Live 0xe01c8000
subfs 12288 1 - Live 0xe01c4000
dm_mod 59776 0 - Live 0xe002e000
ide_cd 42528 0 - Live 0xe01b8000
cdrom 40860 2 sr_mod,ide_cd, Live 0xe01ad000
ext3 122216 6 - Live 0xe01d1000
jbd 71716 1 ext3, Live 0xe006a000
ata_piix 12804 9 - Live 0xe0029000
libata 46468 1 ata_piix, Live 0xe005d000
sd_mod 21120 10 - Live 0xe0022000
scsi_mod 117188 5 sg,st,sr_mod,libata,sd_mod, Live 0xe003f000

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

/proc/ioports:

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
01f0-01f7 : ide0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0828-082f : GPE0_BLK
2000-20fe : motherboard
2100-21fe : motherboard
2200-22fe : motherboard
2300-23fe : motherboard
2400-24fe : motherboard
2500-25fe : motherboard
2600-26fe : motherboard
2700-27fe : motherboard
2800-28fe : motherboard
2900-29fe : motherboard
2a00-2afe : motherboard
2b00-2bfe : motherboard
2c00-2cfe : motherboard
2d00-2dfe : motherboard
2e00-2efe : motherboard
2f00-2ffe : motherboard
5000-50fe : motherboard
5100-51fe : motherboard
5200-52fe : motherboard
5300-53fe : motherboard
5400-54fe : motherboard
5500-55fe : motherboard
5600-56fe : motherboard
5700-57fe : motherboard
5800-58fe : motherboard
5900-59fe : motherboard
5a00-5afe : motherboard
5b00-5bfe : motherboard
5c00-5cfe : motherboard
5d00-5dfe : motherboard
5e00-5efe : motherboard
5f00-5ffe : motherboard
6000-60fe : motherboard
6100-61fe : motherboard
6200-62fe : motherboard
6300-63fe : motherboard
6400-64fe : motherboard
6500-65fe : motherboard
6600-66fe : motherboard
6700-67fe : motherboard
6800-68fe : motherboard
6900-69fe : motherboard
6a00-6afe : motherboard
6b00-6bfe : motherboard
6c00-6cfe : motherboard
6d00-6dfe : motherboard
6e00-6efe : motherboard
6f00-6ffe : motherboard
a000-a0fe : motherboard
a100-a1fe : motherboard
a200-a2fe : motherboard
a300-a3fe : motherboard
a400-a4fe : motherboard
a500-a5fe : motherboard
a600-a6fe : motherboard
a700-a7fe : motherboard
a800-a8fe : motherboard
a900-a9fe : motherboard
aa00-aafe : motherboard
ab00-abfe : motherboard
ac00-acfe : motherboard
ad00-adfe : motherboard
ae00-aefe : motherboard
af00-affe : motherboard
e898-e89f : 0000:00:02.0
e8a0-e8bf : 0000:00:1f.3
e8c0-e8ff : 0000:00:1e.2
  e8c0-e8ff : Intel ICH
ec00-ecff : 0000:00:1e.2
  ec00-ecff : Intel ICH
fe00-fe07 : 0000:00:1f.2
  fe00-fe07 : libata
fe10-fe13 : 0000:00:1f.2
  fe10-fe13 : libata
fe20-fe27 : 0000:00:1f.2
  fe20-fe27 : libata
fe30-fe33 : 0000:00:1f.2
  fe30-fe33 : libata
fea0-feaf : 0000:00:1f.2
  fea0-feaf : libata
ff20-ff3f : 0000:00:1d.3
  ff20-ff3f : uhci_hcd
ff40-ff5f : 0000:00:1d.2
  ff40-ff5f : uhci_hcd
ff60-ff7f : 0000:00:1d.1
  ff60-ff7f : uhci_hcd
ff80-ff9f : 0000:00:1d.0
  ff80-ff9f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0


/proc/iomem:

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1f686bff : System RAM
  00100000-00317cf4 : Kernel code
  00317cf5-003e4eff : Kernel data
1f686c00-1f688bff : ACPI Non-volatile Storage
1f688c00-1f68abff : ACPI Tables
1f68ac00-1fffffff : reserved
c0000000-cfffffff : 0000:00:02.0
  c0000000-c012bfff : vesafb
dfc00000-dfcfffff : PCI Bus #02
  dfcf0000-dfcfffff : 0000:02:00.0
    dfcf0000-dfcfffff : tg3
dfd00000-dfdfffff : PCI Bus #01
dfebfd00-dfebfdff : 0000:00:1e.2
  dfebfd00-dfebfdff : Intel ICH
dfebfe00-dfebffff : 0000:00:1e.2
  dfebfe00-dfebffff : Intel ICH
dfec0000-dfefffff : 0000:00:02.0
dff00000-dff7ffff : 0000:00:02.0
dff80000-dfffffff : 0000:00:02.1
e0000000-efffffff : reserved
fec00000-fed003ff : reserved
fed20000-fed9ffff : reserved
fee00000-feefffff : reserved
ffa80800-ffa80bff : 0000:00:1d.7
  ffa80800-ffa80bff : ehci_hcd
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Intel Corp.: Unknown device 2580 (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 2581 (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dfd00000-dfdfffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [a0] #10 [0041]

0000:00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2582 (rev 04) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at dff00000 (32-bit, non-prefetchable)
        Region 1: I/O ports at e898 [size=8]
        Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at dfec0000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corp.: Unknown device 2782 (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at dff80000 (32-bit, non-prefetchable)
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.0 PCI bridge: Intel Corp.: Unknown device 2660 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dfc00000-dfcfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corp.: Unknown device 2658 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 4: I/O ports at ff80 [size=32]

0000:00:1d.1 USB Controller: Intel Corp.: Unknown device 2659 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 185
        Region 4: I/O ports at ff60 [size=32]

0000:00:1d.2 USB Controller: Intel Corp.: Unknown device 265a (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 193
        Region 4: I/O ports at ff40 [size=32]

0000:00:1d.3 USB Controller: Intel Corp.: Unknown device 265b (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 201
        Region 4: I/O ports at ff20 [size=32]

0000:00:1d.7 USB Controller: Intel Corp.: Unknown device 265c (rev 03) (prog-if 20 [EHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at ffa80800 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

0000:00:1e.2 Multimedia audio controller: Intel Corp.: Unknown device 266e (rev 03)
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at ec00
        Region 1: I/O ports at e8c0 [size=64]
        Region 2: Memory at dfebfe00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at dfebfd00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 2640 (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp.: Unknown device 266f (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]

0000:00:1f.2 IDE interface: Intel Corp.: Unknown device 2651 (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 209
        Region 0: I/O ports at fe00
        Region 1: I/O ports at fe10 [size=4]
        Region 2: I/O ports at fe20 [size=8]
        Region 3: I/O ports at fe30 [size=4]
        Region 4: I/O ports at fea0 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corp.: Unknown device 266a (rev 03)
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 217
        Region 4: I/O ports at e8a0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation: Unknown device 1677 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 0179
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at dfcf0000 (64-bit, non-prefetchable)
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: c4e8006105c096ac  Data: 0602
        Capabilities: [d0] #10 [0001]


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD400JD-75HK Rev: 14.0
  Type:   Direct-Access                    ANSI SCSI revision: 05

This is a Serial ATA drive.

[7.7.] Other information that might be relevant to the problem:

We're using the nnpfs module from arla 0.36.2. This appears to have
some problems of its own:

Nov 18 13:57:55 kermit kernel: NNPFS SoftAssert: nnpfs_message_installdata: got data w/o token!

I intend to report these to the arla mailing list later.

Also, one of the workstations has crashed after an external usb DVD
burner was removed, but that was with an unofficial 2.6.8 kernel from
SuSE.

I also recorded 3 oopses, apparently memory manager related (acrobat
reader crashed took down the X Server and caused 3 oopses), also with
the unofficial 2.6.8 kernel. These seem unrelated, but if you think it
might help, I'll post them here as well.

I also see lines like these quite often:

Nov 30 14:12:07 kermit kernel: mtrr: no more MTRRs available
Nov 30 14:12:07 kermit kernel: mtrr: 0xc0000000,0x400000 overlaps existing 0xc0000000,0x100000

Kind regards and thanks in advance
--
Friedrich Delgado Friedrichs (IT-Services), DFN-CERT Services GmbH
https://www.dfn-cert.de, +49 40 808077-555 (Hotline)
12. DFN-CERT Workshop und Tutorien, CCH Hamburg, 2-3. Maerz 2005

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQayatPqefzmUpgR/AQHfgAgArlYizFwxOWa8Ux61fKO7jn/L/+sQzvZv
aLxXrQv2jVHBKc6wjr1qFCbYbImkJmcW7sl3GUKCEv0/TSaEwyUmeArijbMoM9be
L5ToEKNpYSeH9RnT6eMA0SIiEhpjbMoHCnMcv+Qq0Vs0oejgmhQ8T2IHDEdQy3xm
ofAfm0Vr/DpGQzy/Zwtd7pZJy2iKFivjmO7QPs5X9kDwB7hPrSPSAV8etI0Pxymq
L2aABrjx4OlqInZxGbmilFJ3XNKwXauoujvWnk2uXm/iiKsw/ld8HgpRVne0nQEu
7UaT/l3Q+/7XBHFoXDvqJxG/xd8D0LvbpG1OpdtadtVMOgau4TYDBw==
=6Vdz
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
