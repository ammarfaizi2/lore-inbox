Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUIINzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUIINzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIINzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:55:49 -0400
Received: from smtp1.voila.fr ([193.252.22.174]:43846 "EHLO mwinf4005.voila.fr")
	by vger.kernel.org with ESMTP id S264113AbUIINyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:54:10 -0400
Message-ID: <31554465.1094737987945.JavaMail.www@wwinf4005>
From: "rom.132" <rom.132@voila.fr>
Reply-To: rom.132@voila.fr
To: linux-kernel@vger.kernel.org
Subject: floppy problem 2.6.9
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.249.118.104]
Date: Thu,  9 Sep 2004 15:53:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] floppy and USB key: modules mounted, devices work but error message

[2] Hi,
I had compiled a 2.6.8.1 kernel patched with patch-2.6.9-rc1. I'm using patch because I had the same problem with 2.6.8.1 but none with 2.6.6.
I could mount a CDROM but not floppy or USB key and the STDERR is the same:
_____________________________________________________________
# mount -t vfat /dev/df0 /media/floppy
floppy reader turn but call return this:
mount: wrong fs type, bad option, bad superblock on /dev/fd0,
       or too many mounted file systems
-------------------------------------------------------------       
I test my modules:
_____________________________________________________________
# modinfo floppy

vemagic:	2.6.8.1 K7 gcc-3.3
depend:

# modinfo vfat
...
vemagic		2.6.8.1 K7 gcc-3.3
depend:		fat
-------------------------------------------------------------

I tried patching floppy.c only last day and booting after with floppy=noacpi. Awful, same result but my floppy reader turn everytime.

[7] My computer is a Presario 1211EA under Debian Sarge.
_____________________________________________________________________
# lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Expansion ROM at 00009000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1820 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 10
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
	Subsystem: Compaq Computer Corporation Soundmax integrated digital audio
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at 1000
	Region 1: I/O ports at 1834 [size=4]
	Region 2: I/O ports at 1830 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: Conexant HCF 56k Modem (rev 08)
	Subsystem: Compaq Computer Corporation 623-LAN Grizzly
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at 1400
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.1 Communication controller: Conexant HCF 56k Modem (rev 05)
	Subsystem: Compaq Computer Corporation Yogi
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at 1838
	Region 1: Memory at f4004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 14000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 005f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f5000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
--------------------------------------------------------------------------------------------------------------
# scripts/ver_linux
 
Linux ares 2.6.8.1 #1 Thu Sep 9 14:28:09 CEST 2004 i686 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
quota-tools            3.11.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         sd_mod usb_storage scsi_mod floppy tulip crc32 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss mousedev usbmouse snd_pcm snd_timer snd_page_alloc usbhid snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd usbcore via_agp agpgart evdev ide_cd cdrom genrtc reiserfs vfat fat isofs ext2 ide_disk ide_generic via82cxxx generic ide_core unix
---------------------------------------------------------------------------------------------------------------
# cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:07.5
1000-10ff : VIA686A
1400-14ff : 0000:00:09.0
1400-14ff : tulip
1800-181f : 0000:00:07.2
1800-181f : uhci_hcd
1820-182f : 0000:00:07.1
1820-1827 : ide0
1828-182f : ide1
1830-1833 : 0000:00:07.5
1830-1831 : VIA82xx MPU401
1834-1837 : 0000:00:07.5
1838-183f : 0000:00:09.1
8000-80ff : 0000:00:07.4
8000-808f : motherboard
8000-8003 : PM1a_EVT_BLK
8004-8005 : PM1a_CNT_BLK
8008-800b : PM_TMR
8020-8023 : GPE0_BLK
8100-810f : 0000:00:07.4
9000-9fff : PCI Bus #01
9000-90ff : 0000:01:00.0
  --------------------------------------------------------------------------------------------------------
cat /proc/iomem

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000dc000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-13feffff : System RAM
00100000-0022a372 : Kernel code
0022a373-00281bff : Kernel data
13ff0000-13fffbff : ACPI Tables
13fffc00-13ffffff : ACPI Non-volatile Storage
14000000-14000fff : 0000:00:0a.0
f4000000-f4003fff : 0000:00:09.0
f4000000-f4003fff : tulip
f4004000-f4007fff : 0000:00:09.1
f4100000-f5ffffff : PCI Bus #01
f4100000-f4100fff : 0000:01:00.0
f5000000-f5ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fffe0000-ffffffff : reserved
----------------------------------------------------------------------------------------------------------
Actually, I don't know kernel to debug it myself but I'm working for. If Robert Love read this: thanks Robert your 'Linux Kernel Development' is wonderful!


------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr 


