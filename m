Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271741AbTHHSqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHHSqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:46:07 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:30126 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271741AbTHHSpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:45:54 -0400
Subject: IDE-SCSI bug
From: Ryan Fitch-Davis <sithriel@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1060368392.2212.2.camel@morrigan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Aug 2003 11:46:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Timeouts and oops when ripping audio.


[2.] Full description of the problem/report:
When attempting to rip audio data from a CD using CDparanoia, the process
runs for several seconds, then locks up. System logs show timeouts in SCSI
and lost IRQ from IDE. The kernel eventually oopsed and restarted the ATAPI
device and a subsequent attempt to read from the CD failed mysteriously.

[3.] Keywords (i.e., modules, networking, kernel):
IDE-SCSI timing kernel CD-ROM

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test2 (root@morrigan) (gcc version 3.3.1 20030728 (Debian prerelease)) #9 Fri Aug 8 00:20:13 PDT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Aug  8 01:19:38 morrigan kernel: hdc: lost interrupt
Aug  8 01:19:38 morrigan kernel: Call Trace:
Aug  8 01:19:38 morrigan kernel:  [schedule+942/947] schedule+0x3ae/0x3b3
Aug  8 01:19:38 morrigan kernel:  [schedule_timeout+90/171] schedule_timeout+0x5a/0xab
Aug  8 01:19:38 morrigan kernel:  [printk+299/380] printk+0x12b/0x17c
Aug  8 01:19:38 morrigan kernel:  [process_timeout+0/12] process_timeout+0x0/0xcAug  8 01:19:38 morrigan kernel:  [idescsi_abort+143/232] idescsi_abort+0x8f/0xe8
Aug  8 01:19:38 morrigan kernel:  [scsi_try_to_abort_cmd+94/127] scsi_try_to_abort_cmd+0x5e/0x7f
Aug  8 01:19:38 morrigan kernel:  [scsi_eh_abort_cmds+87/222] scsi_eh_abort_cmds+0x57/0xde
Aug  8 01:19:38 morrigan kernel:  [scsi_unjam_host+336/511] scsi_unjam_host+0x150/0x1ff
Aug  8 01:19:38 morrigan kernel:  [scsi_error_handler+260/443] scsi_error_handler+0x104/0x1bb
Aug  8 01:19:38 morrigan kernel:  [scsi_error_handler+0/443] scsi_error_handler+0x0/0x1bb
Aug  8 01:19:38 morrigan kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Aug  8 01:19:38 morrigan kernel:
[[The above trace repeated 16 more times]]
Aug  8 01:19:46 morrigan kernel: --[ cut here ]--
Aug  8 01:19:46 morrigan kernel: kernel BUG at kernel/timer.c:166!
Aug  8 01:19:46 morrigan kernel: invalid operand: 0000 [#1]
Aug  8 01:19:46 morrigan kernel: CPU:    0
Aug  8 01:19:46 morrigan kernel: EIP:    0060:[add_timer+153/163]    Not taintedAug  8 01:19:46 morrigan kernel: EFLAGS: 00010002
Aug  8 01:19:46 morrigan kernel: EIP is at add_timer+0x99/0xa3
Aug  8 01:19:46 morrigan kernel: eax: 00000001   ebx: dfce6000   ecx: c046cfa0
 edx: c0478fbc
Aug  8 01:19:46 morrigan kernel: esi: 00000000   edi: dfd06ca4   ebp: dfce7ea0
 esp: dfce7e8c
Aug  8 01:19:46 morrigan kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 01:19:46 morrigan kernel: Process scsi_eh_0 (pid: 10, threadinfo=dfce6000 task=dfd30100)
Aug  8 01:19:46 morrigan kernel: Stack: 00000046 00000032 dfce6000 00000000 c0478fbc dfce7ed0 c0266c65 dfd06ca4
Aug  8 01:19:46 morrigan kernel:        c026664f 00000032 00000000 dfd06c80 c0478f10 00000092 00000000 c0478fbc
Aug  8 01:19:46 morrigan kernel:        c0478fcc dfce7ee0 c0266ca2 c0478fbc 00000000 dfce7f00 c02822d1 c0478fbc
Aug  8 01:19:46 morrigan kernel: Call Trace:
Aug  8 01:19:46 morrigan kernel:  [do_reset1+570/606] do_reset1+0x23a/0x25e
Aug  8 01:19:46 morrigan kernel:  [atapi_reset_pollfunc+0/292] atapi_reset_pollfunc+0x0/0x124
Aug  8 01:19:46 morrigan kernel:  [ide_do_reset+25/29] ide_do_reset+0x19/0x1d
Aug  8 01:19:46 morrigan kernel:  [idescsi_reset+224/285] idescsi_reset+0xe0/0x11d
Aug  8 01:19:46 morrigan kernel:  [scsi_try_bus_device_reset+87/146] scsi_try_bus_device_reset+0x57/0x92
Aug  8 01:19:46 morrigan kernel:  [scsi_eh_bus_device_reset+127/360] scsi_eh_bus_device_reset+0x7f/0x168
Aug  8 01:19:46 morrigan kernel:  [scsi_eh_ready_devs+40/116] scsi_eh_ready_devs+0x28/0x74
Aug  8 01:19:46 morrigan kernel:  [scsi_unjam_host+362/511] scsi_unjam_host+0x16a/0x1ff
Aug  8 01:19:46 morrigan kernel:  [scsi_error_handler+260/443] scsi_error_handler+0x104/0x1bb
Aug  8 01:19:46 morrigan kernel:  [scsi_error_handler+0/443] scsi_error_handler+0x0/0x1bb
Aug  8 01:19:46 morrigan kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Aug  8 01:19:46 morrigan kernel:
Aug  8 01:19:46 morrigan kernel: Code: 0f 0b a6 00 33 bb 35 c0 eb 8d 55 31 c0 89 e5 83 ec 14 89 7d
Aug  8 01:19:46 morrigan kernel:  <6>note: scsi_eh_0[10] exited with preempt_count 3
Aug  8 01:19:48 morrigan kernel: hdc: ATAPI reset complete

[6.] A small shell script or example program which triggers the
     problem (if possible)

#!/bin/sh
abcde 2

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux morrigan 2.6.0-test2 #9 Fri Aug 8 00:20:13 PDT 2003 i686 GNU/Linux
  
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.2
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.11
Net-tools              1.60
Kbd                    command
Sh-utils               5.0
Modules Loaded         slip slhc binfmt_misc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd nls_iso8859_1 ntfs smbfs usb_storage


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping        : 7
cpu MHz         : 1989.519
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3923.96
 

[7.3.] Module information (from /proc/modules):
slip 11232 1 - Live 0xe284c000
slhc 6144 1 slip, Live 0xe2991000
binfmt_misc 8200 1 - Live 0xe294f000
snd_seq_oss 33280 0 - Live 0xe29b2000
snd_seq_midi_event 5888 1 snd_seq_oss, Live 0xe294c000
snd_seq 55696 4 snd_seq_oss,snd_seq_midi_event, Live 0xe29a3000
snd_pcm_oss 56484 1 - Live 0xe2959000
snd_mixer_oss 18688 2 snd_pcm_oss, Live 0xe2953000
snd_intel8x0 29956 2 - Live 0xe292b000
snd_ac97_codec 50436 1 snd_intel8x0, Live 0xe2983000
snd_pcm 95908 2 snd_pcm_oss,snd_intel8x0, Live 0xe296a000
snd_timer 23940 2 snd_seq,snd_pcm, Live 0xe2934000
snd_page_alloc 8452 2 snd_intel8x0,snd_pcm, Live 0xe2853000
snd_mpu401_uart 7040 1 snd_intel8x0, Live 0xe2850000
snd_rawmidi 22048 1 snd_mpu401_uart, Live 0xe28eb000
snd_seq_device 7176 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe2847000
snd 53636 12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe293d000
nls_iso8859_1 3968 1 - Live 0xe284a000
ntfs 84940 1 - Live 0xe28f4000
smbfs 61176 0 - Live 0xe28ca000
usb_storage 60736 0 - Live 0xe2859000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
 /proc/ioports
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
03f8-03ff : serial
0cf8-0cff : PCI conf1
1080-109f : Sony Programable I/O Device
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
2800-28ff : PCI CardBus #03
2c00-2cff : PCI CardBus #07
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M7 L
4000-403f : Intel Corp. 82801CAM (ICH3) PRO/
  4000-403f : eepro100
4400-44ff : PCI CardBus #07

/proc/iomem
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-00346b14 : Kernel code
  00346b15-00439e7f : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
20000000-20000fff : Ricoh Co Ltd RL5c476 II
20001000-20001fff : Ricoh Co Ltd RL5c476 II (#2)
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
e8000000-e80003ff : Intel Corp. 82801CAM IDE U100
e8100000-e81fffff : PCI Bus #01
  e8100000-e810ffff : ATI Technologies Inc Radeon Mobility M7 L
    e8100000-e810ffff : radeonfb
e8200000-e8200fff : Intel Corp. 82801CAM (ICH3) PRO/
  e8200000-e8200fff : eepro100
e8201000-e82017ff : Ricoh Co Ltd R5C552 IEEE 1394 Con
  e8201000-e82017ff : ohci1394
ec000000-efffffff : Intel Corp. 82845 845 (Brookdale
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M7 L
    f0000000-f7ffffff : radeonfb
ff800000-ffbfffff : reserved
fff80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4 
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1800 [size=32]
 
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1820 [size=32]
 
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 9
        Region 4: I/O ports at 1840 [size=32]
 
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: e8200000-e82fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 255
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=1K]
 
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1880 [size=32]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
 
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
 
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00002800-000028ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
 
02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00002c00-00002cff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
 
02:05.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 9
        Region 0: Memory at e8201000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+
 
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-R6012 Rev: 1S31
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Sony     Model: MSC-U03          Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
Rebuilding with kernel pre-empt turned off produces same error.

-- 
Run down by the drunken taxicabs of Absolute Reality.

sithriel@earthlink.net

