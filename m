Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTGPOTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270866AbTGPOTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:19:47 -0400
Received: from hal-5.inet.it ([213.92.5.24]:47012 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S270865AbTGPOTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:19:32 -0400
Date: Wed, 16 Jul 2003 16:35:23 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oops when killing a kon launched from an xterm
Message-ID: <20030716143523.GA632@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] 
Oops when killing a kon launched from an xterm

[2.] 
the same happens in 2.4.2[01] and 2.5.75. I tried adding some debug
printk to check_tty_count but this makes the oops trigger at shutdown
time (without being able to write it down - this laptop has no serial
port).

[3.] 
tty, console, X

[5.] 
ksymoops 2.4.8 on i686 2.6.0-test1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test1/ (default)
     -m /boot/System.map-2.6.0-test1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
WARNING: USB Mass Storage data integrity not assured
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Unable to handle kernel paging request at virtual address 00100100
c02016eb
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02016eb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c7b6c000   ebx: 00000000   ecx: cda1d180   edx: 00100100
esi: c9fbf000   edi: c9fbf000   ebp: c7b89980   esp: c7b6df2c
ds: 007b   es: 007b   ss: 0068
Stack: cda1d180 cf192980 cda1d180 c7b6c000 cf192980 c7b6c000 cf192980 c0201f12 
       c9fbf000 c02cd6b3 cbaec480 00000000 00000000 c9fbf000 000009b0 00000001 
       c7b89980 c020240d c9fbf000 00000000 c7b6c000 cff7ea80 00000000 00000001 
Call Trace:
 [<c0201f12>] do_tty_hangup+0x82/0x4f0
 [<c020240d>] disassociate_ctty+0x4d/0x1c0
 [<c0120ca0>] do_exit+0x2c0/0x430
 [<c0120efb>] do_group_exit+0x7b/0xc0
 [<c01093ab>] syscall_call+0x7/0xb
Code: 8b 02 0f 18 00 90 8d 8e 6c 09 00 00 39 ca 74 12 90 8d 74 26 


>>EIP; c02016eb <check_tty_count+1b/c0>   <=====

>>eax; c7b6c000 <_end+77d6650/3fc68650>
>>ecx; cda1d180 <_end+d6877d0/3fc68650>
>>esi; c9fbf000 <_end+9c29650/3fc68650>
>>edi; c9fbf000 <_end+9c29650/3fc68650>
>>ebp; c7b89980 <_end+77f3fd0/3fc68650>
>>esp; c7b6df2c <_end+77d857c/3fc68650>

Trace; c0201f12 <do_tty_hangup+82/4f0>
Trace; c020240d <disassociate_ctty+4d/1c0>
Trace; c0120ca0 <do_exit+2c0/430>
Trace; c0120efb <do_group_exit+7b/c0>
Trace; c01093ab <syscall_call+7/b>

Code;  c02016eb <check_tty_count+1b/c0>
00000000 <_EIP>:
Code;  c02016eb <check_tty_count+1b/c0>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c02016ed <check_tty_count+1d/c0>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c02016f0 <check_tty_count+20/c0>
   5:   90                        nop    
Code;  c02016f1 <check_tty_count+21/c0>
   6:   8d 8e 6c 09 00 00         lea    0x96c(%esi),%ecx
Code;  c02016f7 <check_tty_count+27/c0>
   c:   39 ca                     cmp    %ecx,%edx
Code;  c02016f9 <check_tty_count+29/c0>
   e:   74 12                     je     22 <_EIP+0x22>
Code;  c02016fb <check_tty_count+2b/c0>
  10:   90                        nop    
Code;  c02016fc <check_tty_count+2c/c0>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi


1 warning and 1 error issued.  Results may not be reliable.

[6.] kon ; sleep 3 ; kill `pidof kon`

[7.] debian testing on a sony vaio gr7/k a japanese model

[7.1.]
Linux inferi 2.6.0-test1 #1 Tue Jul 15 13:16:17 CEST 2003 i686 GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         speedstep_ich speedstep_lib parport_pc lp parport ds yenta_socket pcmcia_core e100 ipt_state ip_conntrack sd_mod iptable_filter ip_tables hid usb_storage scsi_mod snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd usbcore rtc

[7.2.]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Pentium(R) III Mobile CPU      1000MHz
stepping	: 1
cpu MHz		: 729.129
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1441.79

[7.3.]
speedstep_ich 3720 0 - Live 0xd0af1000
speedstep_lib 2688 1 speedstep_ich, Live 0xd0bd0000
parport_pc 21636 1 - Live 0xd0c10000
lp 8288 0 - Live 0xd0beb000
parport 23104 2 parport_pc,lp, Live 0xd0c18000
ds 11392 4 - Live 0xd0be1000
yenta_socket 11008 0 - Live 0xd0bdd000
pcmcia_core 59776 2 ds,yenta_socket, Live 0xd0c00000
e100 60548 0 - Live 0xd0bf0000
ipt_state 1536 1 - Live 0xd0bcc000
ip_conntrack 26004 1 ipt_state, Live 0xd0bd5000
sd_mod 12192 0 - Live 0xd0bc8000
iptable_filter 2304 1 - Live 0xd0baf000
ip_tables 16512 2 ipt_state,iptable_filter, Live 0xd0bc2000
hid 23680 0 - Live 0xd0b47000
usb_storage 27648 0 - Live 0xd0bba000
scsi_mod 64788 2 sd_mod,usb_storage, Live 0xd0b87000
snd_seq_oss 32768 0 - Live 0xd0ba6000
snd_seq_midi_event 6144 1 snd_seq_oss, Live 0xd0b09000
snd_seq 53200 4 snd_seq_oss,snd_seq_midi_event, Live 0xd0b98000
snd_pcm_oss 49924 0 - Live 0xd0b54000
snd_mixer_oss 17408 2 snd_pcm_oss, Live 0xd0b4e000
snd_intel8x0 27844 1 - Live 0xd0b2c000
snd_ac97_codec 49284 1 snd_intel8x0, Live 0xd0b79000
snd_pcm 88704 2 snd_pcm_oss,snd_intel8x0, Live 0xd0b62000
snd_timer 22144 2 snd_seq,snd_pcm, Live 0xd0b40000
snd_page_alloc 8196 2 snd_intel8x0,snd_pcm, Live 0xd0b05000
snd_mpu401_uart 6400 1 snd_intel8x0, Live 0xd0b02000
snd_rawmidi 20736 1 snd_mpu401_uart, Live 0xd0b25000
snd_seq_device 6660 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xd0af6000
snd 44292 12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xd0b34000
soundcore 7232 2 snd, Live 0xd0af3000
uhci_hcd 30088 0 - Live 0xd0af9000
usbcore 97748 5 hid,usb_storage,uhci_hcd, Live 0xd0b0c000
rtc 10916 0 - Live 0xd08df000

[7.4.]
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
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
1800-181f : Intel Corp. 82801CA/CAM USB (Hub
  1800-181f : uhci-hcd
1820-183f : Intel Corp. 82801CA/CAM USB (Hub
  1820-183f : uhci-hcd
1840-185f : Intel Corp. 82801CA/CAM USB (Hub
  1840-185f : uhci-hcd
1860-186f : Intel Corp. 82801CAM IDE U100
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : Intel Corp. 82801CA/CAM SMBus
18c0-18ff : Intel Corp. 82801CA/CAM AC'97 Au
  18c0-18ff : Intel 82801CA-ICH3 - Controller
1c00-1cff : Intel Corp. 82801CA/CAM AC'97 Au
  1c00-1cff : Intel 82801CA-ICH3 - AC'97
2000-207f : Intel Corp. 82801CA/CAM AC'97 Mo
2400-24ff : Intel Corp. 82801CA/CAM AC'97 Mo
2800-28ff : PCI CardBus #07
2c00-2cff : PCI CardBus #07
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M6 L
4000-403f : Intel Corp. 82801CAM (ICH3) PRO/
  4000-403f : e100

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-002ac006 : Kernel code
  002ac007-003578ff : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0ff7ffff : System RAM
0ff80000-0fffffff : reserved
10000000-10000fff : Ricoh Co Ltd RL5c476 II
10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
10c00000-10ffffff : PCI CardBus #07
11000000-113fffff : PCI CardBus #07
d0000000-d00003ff : Intel Corp. 82801CAM IDE U100
d0100000-d01fffff : PCI Bus #01
  d0100000-d010ffff : ATI Technologies Inc Radeon Mobility M6 L
d0200000-d0203fff : Texas Instruments TSB43AA22 IEEE-1394 
d0204000-d0204fff : Intel Corp. 82801CAM (ICH3) PRO/
  d0204000-d0204fff : e100
d0205000-d02057ff : Texas Instruments TSB43AA22 IEEE-1394 
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon Mobility M6 L
e0000000-efffffff : Intel Corp. 82830 830 Chipset Ho
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] #09 [0105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at 1840 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d02fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 01)
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01) (prog-if 00 [Generic])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 2400 [disabled] [size=256]
	Region 1: I/O ports at 2000 [disabled] [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0205000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00002800-000028ff
	I/O window 1: 00002c00-00002cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 41)
	Subsystem: Sony Corporation Vaio PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 4000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Sony     Model: MSC-U02          Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

-- 
mattia
:wq!
