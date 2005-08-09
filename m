Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVHIU0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVHIU0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVHIU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:26:40 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:13017 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964931AbVHIU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:26:39 -0400
Subject: Re: my kernel sometimes did a crash, but no panic
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>,
       "klasyk99@poczta.onet.pl" <klasyk99@poczta.onet.pl>
In-Reply-To: <1123618340.2484.9.camel@KKK>
References: <200508091804050500.042A58AE@friko2.onet.pl>
	 <1123615130.4849.81.camel@localhost>  <1123618340.2484.9.camel@KKK>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Aug 2005 17:26:15 -0300
Message-Id: <1123619175.4849.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klasyk,

	It might be related to bttv, but not just listening radio. There are
some bugs on some VIA and SIS chipsets related to PCI to PCI (or PCI to
AGP) data transfers. bttv, on video overlay mode, does this.
	Since you were not using BTTV for video on that time, it doesn't seen
to be your case.
	It may also be related with some other PCI-PCI transfer, like some from
firewire to video or from webcam to video.
	
Mauro.

Em Ter, 2005-08-09 às 22:12 +0200, klasyk99@poczta.onet.pl escreveu:
> Dnia 09-08-2005, wto o godzinie 16:18 -0300, Mauro Carvalho Chehab
> napisał(a): 
> > Klasyk,
> > 
> > 	Were you using bttv at the time you had this oops? It doesn't look to
> > be related. 
> 
> my modprobe.conf:
> 
> alias char-major-89 i2c-dev
> snd-cmipci && { /sbin/modprobe snd-pcm-oss; /bin/true; }
> alias ieee1394-controller ohci1394
> alias eth1 8139too
> alias eth0 8139too
> options bttv card=72 pll=1 tuner=28 radio=1 video_nr=2
> options lirc_gpio gpio_mask=0x1f00 gpio_lock_mask=0x8000 gpio_xor_mask=0
> soft_gap=500 sample_rate=12
> 
> options pwc dev_hint=740:5,740:9 power_save=0 compression=1 size=vga
> fps=5
> alias net-pf-10 ipv6
> alias /dev/nvidia*   nvidia
> alias eth2 eth1394
> options snd  device_mode=0666
> alias snd-card-0 snd-emu10k1
> alias sound-slot-0 snd-emu10k1
> install usb-interface /sbin/modprobe uhci-hcd; /sbin/modprobe
> ehci-hcd; /bin/true
> 
> I don't use tv on bttv, only radio.
> I'm not sure, but maybe the crash was, when i disable
> the /usr/bin/radio. But not sure. Maybe the "q" key in radio
> was the last one what i did.
> 
> 
> 
> > Maybe you can also send us some logs about your system init
> > and some description about your configuration. What's your Motherboard?
> > What PCI chipset does it use?
> 
> It is asus a7v333 on via 333. Duron 1300 without overcloking.
> 2x philips webcam pcvc740k, dsl eagle usb, bttv with radio,
> sb live, 2xeth, 1xeth1394
> 
> 
> lspci -vvv
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
> KT266/A/333]
>         Subsystem: ASUSTeK Computer Inc. A7V333 Mainboard
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
> Rate=x4
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
> KT266/A/333 AGP] (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000e000-0000dfff
>         Memory behind bridge: eb000000-ec6fffff
>         Prefetchable memory behind bridge: edf00000-efffffff
>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
> IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 808d
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 35 (500ns min, 1000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at ea800000 (32-bit, non-prefetchable)
> [size=2K]
>         Region 1: Memory at ea000000 (32-bit, non-prefetchable)
> [size=16K]
>         Capabilities: [44] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
> +,D2+,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> 
> 00:09.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 50) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin A routed to IRQ 19
>         Region 4: I/O ports at d800 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
> +,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 50) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin B routed to IRQ 16
>         Region 4: I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
> +,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if
> 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 10
>         Interrupt: pin C routed to IRQ 17
>         Region 0: Memory at e9800000 (32-bit, non-prefetchable)
> [size=256]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
> +,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video
> Capture (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (4000ns min, 10000ns max)
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at ed000000 (32-bit, prefetchable) [size=4K]
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
> (rev 11)
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at ec800000 (32-bit, prefetchable) [size=4K]
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at d000 [size=256]
>         Region 1: Memory at e9000000 (32-bit, non-prefetchable)
> [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1
> +,D2+,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 04)
>         Subsystem: Creative Labs CT4850 SBLive! Value
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (500ns min, 5000ns max)
>         Interrupt: pin A routed to IRQ 18
>         Region 0: I/O ports at b800 [size=32]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
> (rev 01)
>         Subsystem: Creative Labs Gameport Joystick
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 0: I/O ports at b400 [size=8]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at b000 [size=256]
>         Region 1: Memory at e8800000 (32-bit, non-prefetchable)
> [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1
> +,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 808c
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 0
>         Region 4: I/O ports at a800 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 23) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 21
>         Region 4: I/O ports at a400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 23) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 21
>         Region 4: I/O ports at a000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA
> TNT2/TNT2 Pro] (rev 15) (prog-if 00 [VGA])
>         Subsystem: nVidia Corporation RIVA TNT2 Pro
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (1250ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at eb000000 (32-bit, non-prefetchable)
> [size=16M]
>         Region 1: Memory at ee000000 (32-bit, prefetchable) [size=32M]
>         Expansion ROM at edff0000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-
> FW- Rate=x4
> 
> 
> 
> 
> 
> 
> Log when the system started:
> (I mixed a little in scripts with the usb drivers when linux is loading)
> 
> Aug  8 23:56:55 o syslogd 1.4.1: restart.
> Aug  8 23:56:56 o dhclient: eth2: unknown hardware address type 24
> Aug  8 23:56:56 o kernel: klogd 1.4.1, log source = /proc/kmsg started.
> Aug  8 23:56:56 o kernel: Inspecting /boot/System.map
> Aug  8 23:56:56 o kernel: Loaded 20310 symbols from /boot/System.map.
> Aug  8 23:56:56 o kernel: Symbols match kernel version 2.6.11.
> Aug  8 23:56:56 o kernel: No module symbols loaded - kernel modules not
> enabled.
> Aug  8 23:56:56 o kernel: Linux version 2.6.11-12mdkcustom (root@o) (gcc
> version 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #
> 2 Sat Aug 6 11:02:20 CEST 2005
> Aug  8 23:56:56 o kernel: BIOS-provided physical RAM map:
> Aug  8 23:56:56 o kernel:  BIOS-e820: 0000000000000000 -
> 000000000009fc00 (usable)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 000000000009fc00 -
> 00000000000a0000 (reserved)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 00000000000f0000 -
> 0000000000100000 (reserved)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 0000000000100000 -
> 000000004fffc000 (usable)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 000000004fffc000 -
> 000000004ffff000 (ACPI data)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 000000004ffff000 -
> 0000000050000000 (ACPI NVS)
> Aug  8 23:56:56 o partmon: Sprawdzanie czy na partycjach jest
> wystarczająca ilość miejsca:
> Aug  8 23:56:56 o kernel:  BIOS-e820: 00000000fec00000 -
> 00000000fec01000 (reserved)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 00000000fee00000 -
> 00000000fee01000 (reserved)
> Aug  8 23:56:56 o kernel:  BIOS-e820: 00000000ffff0000 -
> 0000000100000000 (reserved)
> Aug  8 23:56:56 o kernel: 383MB HIGHMEM available.
> Aug  8 23:56:57 o kernel: 896MB LOWMEM available.
> Aug  8 23:56:57 o kernel: On node 0 totalpages: 327676
> Aug  8 23:56:57 o kernel:   DMA zone: 4096 pages, LIFO batch:1
> Aug  8 23:56:57 o kernel:   Normal zone: 225280 pages, LIFO batch:16
> Aug  8 23:56:57 o kernel:   HighMem zone: 98300 pages, LIFO batch:16
> Aug  8 23:56:57 o kernel: DMI 2.3 present.
> Aug  8 23:56:57 o kernel: ACPI: RSDP (v000
> ASUS                                  ) @ 0x000f5c30
> Aug  8 23:56:57 o kernel: ACPI: RSDT (v001 ASUS   A7V333   0x42302e31
> MSFT 0x31313031) @ 0x4fffc000
> Aug  8 23:56:57 o partmon: ^[[65G
> Aug  8 23:56:57 o kernel: ACPI: FADT (v001 ASUS   A7V333   0x42302e31
> MSFT 0x31313031) @ 0x4fffc0b2
> Aug  8 23:56:57 o partmon:
> Aug  8 23:56:57 o kernel: ACPI: BOOT (v001 ASUS   A7V333   0x42302e31
> MSFT 0x31313031) @ 0x4fffc030
> Aug  8 23:56:57 o rc: Uruchamianie partmon: succeeded
> Aug  8 23:56:57 o kernel: ACPI: MADT (v001 ASUS   A7V333   0x42302e31
> MSFT 0x31313031) @ 0x4fffc058
> Aug  8 23:56:57 o kernel: ACPI: DSDT (v001   ASUS A7V333   0x00001000
> MSFT 0x0100000b) @ 0x00000000
> Aug  8 23:56:57 o kernel: ACPI: PM-Timer IO Port: 0xe408
> Aug  8 23:56:57 o kernel: ACPI: Local APIC address 0xfee00000
> Aug  8 23:56:58 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 6
> Aug  8 23:56:58 o kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00]
> enabled)
> Aug  8 23:56:58 o xfs: Uruchamianie xfs succeeded
> Aug  8 23:55:25 o rc.sysinit: Setting default font (lat2-sun16):
> succeeded
> Aug  8 23:56:58 o xfs[5533]: ignoring font path
> element /usr/X11R6/lib/X11/fonts/drakfont/Type1 (unreadable)
> Aug  8 23:56:58 o kernel: Processor #0 6:7 APIC version 16
> Aug  8 23:55:25 o rc.sysinit: Montowanie systemu plików proc succeeded
> Aug  8 23:56:58 o xfs[5533]: ignoring font path
> element /usr/X11R6/lib/X11/fonts/drakfont/ttf (unreadable)
> Aug  8 23:56:58 o kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge
> lint[0x1])
> Aug  8 23:55:25 o rc.sysinit: Montowanie sysfs na /sys succeeded
> Aug  8 23:56:58 o numlock: Uruchamianie klawiatury numerycznej:
> Aug  8 23:56:58 o xfs[5533]: ignoring font path
> element /usr/X11R6/lib/X11/fonts/100dpi:unscaled (unreadable)
> Aug  8 23:56:58 o kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000]
> gsi_base[0])
> Aug  8 23:55:25 o devfsd: Started device management daemon v1.3.25
> for /dev
> Aug  8 23:56:58 o numlock:
> Aug  8 23:56:59 o kernel: IOAPIC[0]: apic_id 2, version 2, address
> 0xfec00000, GSI 0-23
> Aug  8 23:55:26 o devfsd: error
> execing: /etc/dynamic/scripts/part.script^INo such file or directory
> Aug  8 23:56:59 o kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq
> 2 dfl edge)
> Aug  8 23:56:59 o rc: Uruchamianie numlock: succeeded
> Aug  8 23:55:26 o devfsd: error
> execing: /etc/dynamic/scripts/part.script^INo such file or directory
> Aug  8 23:56:59 o kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq
> 9 low level)
> Aug  8 23:55:26 o devfsd: error
> execing: /etc/dynamic/scripts/part.script^INo such file or directory
> Aug  8 23:56:59 o kernel: ACPI: IRQ0 used by override.
> Aug  8 23:55:26 o devfsd: error
> execing: /etc/dynamic/scripts/part.script^INo such file or directory
> Aug  8 23:57:00 o kernel: ACPI: IRQ2 used by override.
> Aug  8 23:55:28 o rc.sysinit: Uruchamianie demona DevFs succeeded
> Aug  8 23:57:00 o kernel: ACPI: IRQ9 used by override.
> Aug  8 23:55:28 o rc.sysinit: Konfiguracja parametrów jądra:  succeeded
> Aug  8 23:57:00 o kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Aug  8 23:55:28 o pam_console.dev[1046]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:00 o kernel: Using ACPI (MADT) for SMP configuration
> information
> Aug  8 23:55:28 o pam_console.dev[1047]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:00 o su(pam_unix)[5660]: session opened for user nobody by
> (uid=0)
> Aug  8 23:57:00 o kernel: Allocating PCI resources starting at 50000000
> (gap: 50000000:aec00000)
> Aug  8 23:55:28 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:00 o kernel: Built 1 zonelists
> Aug  8 23:55:28 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:00 o kernel: mapped APIC to ffffd000 (fee00000)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:00 o kernel: mapped IOAPIC to ffffc000 (fec00000)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:01 o kernel: Initializing CPU#0
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:01 o kernel: Kernel command line:
> BOOT_IMAGE=MOJ_2_6_11____12 ro root=301 resume=/dev/hda5 devfs=mount
> Aug  8 23:55:28 o pam_console.dev[1090]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:01 o su(pam_unix)[5660]: session closed for user nobody
> Aug  8 23:57:01 o kernel: PID hash table entries: 4096 (order: 12, 65536
> bytes)
> Aug  8 23:55:29 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:01 o mDNSResponder: Uruchamianie  succeeded
> Aug  8 23:57:01 o kernel: Detected 1303.663 MHz processor.
> Aug  8 23:55:29 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:01 o kernel: Using pmtmr for high-res timesource
> Aug  8 23:55:29 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:01 o kernel: Console: colour VGA+ 80x25
> Aug  8 23:55:29 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:01 o kernel: Dentry cache hash table entries: 131072
> (order: 7, 524288 bytes)
> Aug  8 23:55:29 o pam_console.dev[1106]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:02 o kernel: Inode-cache hash table entries: 65536 (order:
> 6, 262144 bytes)
> Aug  8 23:57:02 o atd: Uruchamianie atd succeeded
> Aug  8 23:55:27 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:02 o kernel: Memory: 1294696k/1310704k available (2635k
> kernel code, 15188k reserved, 765k data, 268k init, 39
> 3200k highmem, 0k BadRAM)
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:02 o kernel: Checking if this processor honours the WP bit
> even in supervisor mode... Ok.
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:02 o kernel: Calibrating delay loop... 2580.48 BogoMIPS
> (lpj=1290240)
> Aug  8 23:57:02 o smartd[5715]: smartd version 5.33
> [i586-mandrake-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:02 o kernel: Mount-cache hash table entries: 512 (order: 0,
> 4096 bytes)
> Aug  8 23:57:02 o smartd[5715]: Home page is
> http://smartmontools.sourceforge.net/
> Aug  8 23:55:27 o date: Mon Aug  8 23:55:27 CEST 2005
> Aug  8 23:57:02 o kernel: CPU: After generic identify, caps: 0383fbff
> c1c3fbff 00000000 00000000 00000000 00000000 00000000
> Aug  8 23:57:02 o smartd[5715]: Opened configuration
> file /etc/smartd.conf
> Aug  8 23:55:27 o rc.sysinit: Ustawianie zegara  (utc): Mon Aug  8
> 23:55:27 CEST 2005 succeeded
> Aug  8 23:57:02 o kernel: CPU: After vendor identify, caps: 0383fbff
> c1c3fbff 00000000 00000000 00000000 00000000 00000000
> Aug  8 23:57:02 o smartd[5715]: Configuration file /etc/smartd.conf was
> parsed, found DEVICESCAN, scanning devices
> Aug  8 23:55:27 o pam_console.dev[1137]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:02 o kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
> 64K (64 bytes/line)
> Aug  8 23:57:02 o smartd[5715]: Device: /dev/hda, opened
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:02 o kernel: CPU: L2 Cache: 64K (64 bytes/line)
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:02 o smartd[5715]: Device: /dev/hda, found in smartd
> database.
> Aug  8 23:57:02 o kernel: CPU: After all inits, caps: 0383fbff c1c3fbff
> 00000000 00000020 00000000 00000000 00000000
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:02 o smartd[5715]: Device: /dev/hda, enabled SMART
> Attribute Autosave.
> Aug  8 23:57:02 o kernel: Intel machine check architecture supported.
> Aug  8 23:55:27 o rc.sysinit: Ładowanie domyślnej mapy klawiatury
> succeeded
> Aug  8 23:57:03 o kernel: Intel machine check reporting enabled on
> CPU#0.
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hda, enabled SMART
> Automatic Offline Testing.
> Aug  8 23:55:27 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:03 o kernel: CPU: AMD Duron(TM) stepping 01
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hda, appears to lack SMART
> Self-Test log; disabling -l selftest (override with
> -T permissive Directive)
> Aug  8 23:55:27 o pam_console.dev[1160]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:03 o kernel: Enabling fast FPU save and restore... done.
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hda, appears to lack SMART
> Error log; disabling -l error (override with -T per
> missive Directive)
> Aug  8 23:55:27 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:03 o kernel: Enabling unmasked SIMD FPU exception
> support... done.
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hda, is SMART capable.
> Adding to "monitor" list.
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:03 o kernel: Checking 'hlt' instruction... OK.
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hdb, opened
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:03 o kernel: ENABLING IO-APIC IRQs
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hdb, found in smartd
> database.
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:03 o kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
> Aug  8 23:57:03 o smartd[5715]: Device: /dev/hdb, enabled SMART
> Attribute Autosave.
> Aug  8 23:55:27 o rc.sysinit: Ustawianie nazwy hosta o: succeeded
> Aug  8 23:57:03 o kernel: NET: Registered protocol family 16
> Aug  8 23:57:04 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 8
> Aug  8 23:55:27 o pam_console.dev[1185]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:04 o smartd[5715]: Device: /dev/hdb, is SMART capable.
> Adding to "monitor" list.
> Aug  8 23:57:04 o kernel: PCI: Using configuration type 1
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:04 o smartd[5715]: Monitoring 2 ATA and 0 SCSI devices
> Aug  8 23:57:04 o kernel: mtrr: v2.0 (20020519)
> Aug  8 23:55:27 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:04 o kernel: ACPI: Subsystem revision 20050211
> Aug  8 23:57:05 o smartd[5715]: Device: /dev/hdb, SMART Usage Attribute:
> 194 Temperature_Celsius changed from 76 to 75
> Aug  8 23:55:27 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:05 o kernel: ACPI: Interpreter enabled
> Aug  8 23:57:05 o smartd[5717]: smartd has fork()ed into background
> mode. New PID=5717.
> Aug  8 23:55:27 o pam_console.dev[1213]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:05 o smartd: Uruchamianie smartd succeeded
> Aug  8 23:57:05 o kernel: ACPI: Using IOAPIC for interrupt routing
> Aug  8 23:55:28 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:05 o kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6
> 7 10 *11 12 14 15)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:05 o kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6
> 7 10 11 12 14 15) *9
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:05 o kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6
> 7 10 11 12 14 15)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:06 o kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6
> 7 10 11 12 14 15) *9
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6
> 7 *10 11 12 14)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o kernel: PCI: Probing PCI hardware (bus 00)
> Aug  8 23:55:28 o pam_console.dev[1255]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:06 o kernel: PCI: Via IRQ fixup
> Aug  8 23:55:28 o pam_console.dev[1273]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:06 o net.agent[5766]: how do I bring interfaces up on this
> distro?
> Aug  8 23:57:06 o kernel: ACPI: PCI Interrupt Routing Table
> [\_SB_.PCI0._PRT]
> Aug  8 23:55:28 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:06 o net.agent[5766]: add event not handled
> Aug  8 23:57:06 o kernel: ACPI: PCI Interrupt Routing Table
> [\_SB_.PCI0.PCI1._PRT]
> Aug  8 23:55:28 o devfsd[1032]: error calling: "unlink" in "GLOBAL"
> Aug  8 23:57:06 o kernel: Linux Plug and Play Support v0.97 (c) Adam
> Belay
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:06 o kernel: pnp: PnP ACPI init
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:06 o kernel: pnp: PnP ACPI: found 14 devices
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcsa1" to
> "/lib/dev-state/vcsa1"
> Aug  8 23:57:06 o kernel: PnPBIOS: Disabled
> Aug  8 23:55:28 o pam_console.dev[1341]: Restoring console permissions
> for /dev/vcsa1
> Aug  8 23:57:06 o kernel: PCI: Using ACPI for IRQ routing
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o sshd: uruchamianie succeeded
> Aug  8 23:57:06 o kernel: ** PCI interrupts are no longer routed
> automatically.  If this
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o kernel: ** causes a device to stop working, it is
> probably because the
> Aug  8 23:57:06 o sshd[5795]: Server listening on :: port 443.
> Aug  8 23:55:28 o devfsd[1032]: error copying: "/dev/vcs1" to
> "/lib/dev-state/vcs1"
> Aug  8 23:57:06 o kernel: ** driver failed to call pci_enable_device().
> As a temporary
> Aug  8 23:57:06 o sshd[5795]: error: Bind to port 443 on 0.0.0.0 failed:
> Address already in use.
> Aug  8 23:55:28 o pam_console.dev[1357]: Restoring console permissions
> for /dev/vcs1
> Aug  8 23:57:06 o kernel: ** workaround, the "pci=routeirq" argument
> restores the old
> Aug  8 23:56:05 o modprobe: WARNING: Error inserting snd
> (/lib/modules/2.6.11-12mdkcustom/kernel/sound/core/snd.ko): Unknow
> n symbol in module, or unknown parameter (see dmesg)  <29>Aug  8
> 23:56:05 modprobe: WARNING: Error inserting snd-seq-device (
> /lib/modules/2.6.11-12mdkcustom/kernel/sound/core/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see
> dmesg)
> Aug  8 23:57:06 o kernel: ** behavior.  If this argument makes the
> device work again,
> Aug  8 23:56:05 o usb.agent[1795]: ... can't load module snd-usb-audio
> Aug  8 23:57:06 o kernel: ** please email the output of "lspci" to
> bjorn.helgaas@hp.com
> Aug  8 23:56:05 o usb.agent[1795]: missing kernel or user mode driver
> snd-usb-audio
> Aug  8 23:57:07 o kernel: ** so I can fix the driver.
> Aug  8 23:57:07 o xinetd: Uruchamianie xinetd succeeded
> Aug  8 23:56:06 o usb: Inicjalizacja kontrolera USB (uhci-hcd):
> succeeded
> Aug  8 23:57:07 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/cups-lpd [file=/etc/xinetd.conf] [line=1
> 5]
> Aug  8 23:57:07 o kernel: pnp: 00:01: ioport range 0xe400-0xe47f could
> not be reserved
> Aug  8 23:56:06 o usb: Inicjalizacja kontrolera USB (ehci-hcd):
> succeeded
> Aug  8 23:57:09 o vsftpd: vsftpd vsftpd succeeded
> Aug  8 23:57:09 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/cvs [file=/etc/xinetd.d/cvs] [line=15]
> Aug  8 23:57:09 o kernel: pnp: 00:01: ioport range 0xe800-0xe81f has
> been reserved
> Aug  8 23:56:06 o usb: Montowanie systemu plików USB succeeded
> Aug  8 23:57:09 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/imap [file=/etc/xinetd.d/imap] [line=12]
> Aug  8 23:57:09 o dhcpd: Not searching LDAP since ldap-server, ldap-port
> and ldap-base-dn were not specified in the config
> file
> Aug  8 23:57:09 o kernel: pnp: 00:0d: ioport range 0x290-0x291 has been
> reserved
> Aug  8 23:56:07 o modprobe: cupsd: no process killed
> Aug  8 23:57:09 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/imaps [file=/etc/xinetd.d/imaps] [line=1
> 4]
> Aug  8 23:57:09 o dhcpd: Wrote 0 deleted host decls to leases file.
> Aug  8 23:57:09 o kernel: pnp: 00:0d: ioport range 0x370-0x372 has been
> reserved
> Aug  8 23:56:07 o usb: Ładowanie modułu kernela dla drukarki USB
> succeeded
> Aug  8 23:57:10 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/ipop2 [file=/etc/xinetd.d/ipop2] [line=1
> 4]
> Aug  8 23:57:10 o dhcpd: Wrote 0 new dynamic host decls to leases file.
> Aug  8 23:57:10 o kernel: Simple Boot Flag at 0x3a set to 0x1
> Aug  8 23:56:12 o fsck: /dev/hda1: clean, 393053/3499328 files,
> 4493127/6986259 blocks
> Aug  8 23:57:10 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/ipop3 [file=/etc/xinetd.d/ipop3] [line=1
> 5]
> Aug  8 23:57:10 o dhcpd: Wrote 0 leases to leases file.
> Aug  8 23:57:10 o kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
> version 1.16ac)
> Aug  8 23:56:12 o rc.sysinit: Ponowne montowanie gł. systemu plików w
> trybie do odczytu i zapisu:  succeeded
> Aug  8 23:57:10 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/pop3s [file=/etc/xinetd.d/pop3s] [line=1
> 3]
> Aug  8 23:57:10 o kernel: apm: overridden by ACPI.
> Aug  8 23:57:10 o dhcpd:
> Aug  8 23:56:15 o rc.sysinit: Aktywacja partycji wymiany: succeeded
> Aug  8 23:57:10 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/rsync [file=/etc/xinetd.d/rsync] [line=1
> 3]
> Aug  8 23:57:10 o kernel: audit: initializing netlink socket (disabled)
> Aug  8 23:57:10 o dhcpd: No subnet declaration for eth0 (192.168.1.232).
> Aug  8 23:56:16 o : Loading module: nvidia
> Aug  8 23:57:10 o xinetd[5813]: Reading included configuration
> file: /etc/xinetd.d/sshd-xinetd [file=/etc/xinetd.d/sshd-xin
> etd] [line=13]
> Aug  8 23:57:10 o kernel: audit(1123538119.408:0): initialized
> Aug  8 23:57:10 o dhcpd: ** Ignoring requests on eth0.  If this is not
> what
> Aug  8 23:56:17 o : Loading module: bttv
> Aug  8 23:57:10 o xinetd[5813]: removing printer
> Aug  8 23:57:10 o kernel: highmem bounce pool size: 64 pages
> Aug  8 23:57:10 o dhcpd:    you want, please write a subnet declaration
> Aug  8 23:56:18 o : Loading module: bt878
> Aug  8 23:57:10 o xinetd[5813]: removing cvspserver
> Aug  8 23:57:10 o kernel: Total HugeTLB memory allocated, 0
> Aug  8 23:57:10 o dhcpd:    in your dhcpd.conf file for the network
> segment
> Aug  8 23:56:18 o : Loading module: via-agp
> Aug  8 23:57:10 o xinetd[5813]: removing imap
> Aug  8 23:57:10 o kernel: inotify device minor=63
> Aug  8 23:57:10 o dhcpd:    to which interface eth0 is attached. **
> Aug  8 23:56:19 o fsck: /dev/hdb1: recovering journal
> Aug  8 23:57:10 o xinetd[5813]: removing imaps
> Aug  8 23:57:10 o kernel: VFS: Disk quotas dquot_6.5.1
> Aug  8 23:57:10 o dhcpd:
> Aug  8 23:56:21 o fsck: /dev/hdb1: clean, 124308/7340032 files,
> 7477522/14657296 blocks
> Aug  8 23:57:11 o xinetd[5813]: removing pop2
> Aug  8 23:57:11 o kernel: Dquot-cache hash table entries: 1024 (order 0,
> 4096 bytes)
> Aug  8 23:56:22 o rc.sysinit: Montowanie lokalnych systemów plików:
> succeeded
> Aug  8 23:57:11 o xinetd[5813]: removing rsync
> Aug  8 23:57:11 o dhcpd: Uruchamianie dhcpd succeeded
> Aug  8 23:57:11 o kernel: devfs: 2004-01-31 Richard Gooch
> (rgooch@atnf.csiro.au)
> Aug  8 23:56:22 o rc.sysinit: Montowanie plikopartycji:  succeeded
> Aug  8 23:57:11 o xinetd[5813]: removing ssh
> Aug  8 23:57:11 o kernel: devfs: boot_options: 0x1
> Aug  8 23:56:23 o loadkeys:
> Loading /usr/lib/kbd/keymaps/i386/qwerty/pl.kmap.gz
> Aug  8 23:57:11 o xinetd[5813]: xinetd Version 2.3.13 started with
> libwrap options compiled in.
> Aug  8 23:57:11 o kernel: Supermount version 2.0.4 for kernel 2.6
> Aug  8 23:57:11 o loadkeys:
> Loading /usr/lib/kbd/keymaps/i386/qwerty/pl.kmap.gz
> Aug  8 23:56:24 o pam_console.dev[3126]: Restoring console permissions
> for /dev/dsp
> Aug  8 23:57:11 o xinetd[5813]: Started working: 2 available services
> Aug  8 23:57:11 o kernel: Initializing Cryptographic API
> Aug  8 23:57:11 o keytable: Ładowanie mapy klawiatury: pl succeeded
> Aug  8 23:56:24 o pam_console.dev[3124]: Restoring console permissions
> for /dev/snd/pcmC2D1c
> Aug  8 23:57:11 o kernel: isapnp: Scanning for PnP cards...
> Aug  8 23:56:24 o pam_console.dev[3114]: Restoring console permissions
> for /dev/dsp1
> Aug  8 23:57:11 o kernel: isapnp: No Plug & Play device found
> Aug  8 23:57:11 o loadkeys:
> Loading /usr/lib/kbd/keymaps/include/compose.latin2.inc.gz
> Aug  8 23:56:24 o pam_console.dev[3110]: Restoring console permissions
> for /dev/audio2
> Aug  8 23:57:11 o kernel: Real Time Clock Driver v1.12
> Aug  8 23:56:24 o pam_console.dev[3100]: Restoring console permissions
> for /dev/mixer2
> ug  8 23:57:11 o kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Aug  8 23:56:24 o pam_console.dev[3096]: Restoring console permissions
> for /dev/mixer1
> Aug  8 23:57:11 o keytable: Ładowanie klawiszy kompozycji:
> compose.latin2.inc succeeded
> Aug  8 23:57:11 o kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Aug  8 23:56:24 o pam_console.dev[3052]: Restoring console permissions
> for /dev/nvidiactl
> Aug  8 23:57:11 o kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8
> ports, IRQ sharing enabled
> Aug  8 23:56:24 o pam_console.dev[3037]: Restoring console permissions
> for /dev/snd/pcmC2D0p
> Aug  8 23:57:11 o kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Aug  8 23:56:24 o pam_console.dev[3092]: Restoring console permissions
> for /dev/mixer
> Aug  8 23:57:11 o kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Aug  8 23:56:24 o pam_console.dev[3027]: Restoring console permissions
> for /dev/snd/pcmC2D2p
> Aug  8 23:57:11 o kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Aug  8 23:56:24 o pam_console.dev[3023]: Restoring console permissions
> for /dev/snd/pcmC2D3p
> Aug  8 23:57:11 o kernel: io scheduler noop registered
> Aug  8 23:56:24 o pam_console.dev[3076]: Restoring console permissions
> for /dev/dsp2
> Aug  8 23:57:11 o kernel: io scheduler anticipatory registered
> Aug  8 23:57:11 o keytable:  succeeded
> Aug  8 23:56:24 o pam_console.dev[3072]: Restoring console permissions
> for /dev/snd/controlC2
> Aug  8 23:57:11 o kernel: io scheduler deadline registered
> Aug  8 23:56:24 o pam_console.dev[3015]: Restoring console permissions
> for /dev/snd/pcmC1D0c
> Aug  8 23:57:11 o kernel: io scheduler cfq registered
> Aug  8 23:56:24 o pam_console.dev[3011]: Restoring console permissions
> for /dev/snd/controlC0
> Aug  8 23:57:11 o kernel: RAMDISK driver initialized: 16 RAM disks of
> 32000K size 1024 blocksize
> Aug  8 23:56:24 o pam_console.dev[3068]: Restoring console permissions
> for /dev/snd/pcmC2D0c
> Aug  8 23:57:11 o kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe
> (axboe@suse.de) and petero2@telia.com
> Aug  8 23:56:24 o pam_console.dev[3064]: Restoring console permissions
> for /dev/snd/midiC2D0
> Aug  8 23:57:11 o kernel: Uniform Multi-Platform E-IDE driver Revision:
> 7.00alpha2
> Aug  8 23:56:24 o pam_console.dev[3007]: Restoring console permissions
> for /dev/snd/pcmC0D0c
> Aug  8 23:57:12 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 7
> Aug  8 23:57:12 o kernel: ide: Assuming 33MHz system bus speed for PIO
> modes; override with idebus=xx
> Aug  8 23:56:24 o pam_console.dev[3031]: Restoring console permissions
> for /dev/snd/pcmC2D2c
> Aug  8 23:57:12 o kernel: VP_IDE: IDE controller at PCI slot
> 0000:00:11.1
> Aug  8 23:56:24 o pam_console.dev[3019]: Restoring console permissions
> for /dev/snd/controlC1
> Aug  8 23:57:12 o kernel: ACPI: PCI interrupt 0000:00:11.1[A]: no GSI -
> using IRQ 0
> Aug  8 23:56:24 o pam_console.dev[3001]: Restoring console permissions
> for /dev/nvidia0
> Aug  8 23:57:12 o kernel: VP_IDE: chipset revision 6
> Aug  8 23:56:24 o pam_console.dev[3057]: Restoring console permissions
> for /dev/snd/timer
> Aug  8 23:57:12 o kernel: VP_IDE: not 100%% native mode: will probe irqs
> later
> ug  8 23:56:24 o pam_console.dev[3049]: Restoring console permissions
> for /dev/agpgart
> Aug  8 23:57:12 o kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133
> controller on pci0000:00:11.1
> Aug  8 23:56:24 o pam_console.dev[3118]: Restoring console permissions
> for /dev/audio1
> Aug  8 23:57:12 o kernel:     ide0: BM-DMA at 0xa800-0xa807, BIOS
> settings: hda:DMA, hdb:DMA
> Aug  8 23:56:24 o pam_console.dev[3106]: Restoring console permissions
> for /dev/audio
> Aug  8 23:57:12 o kernel:     ide1: BM-DMA at 0xa808-0xa80f, BIOS
> settings: hdc:DMA, hdd:pio
> Aug  8 23:56:24 o pam_console.dev[3088]: Restoring console permissions
> for /dev/midi2
> Aug  8 23:57:12 o kernel: Probing IDE interface ide0...
> Aug  8 23:56:24 o pam_console.dev[3084]: Restoring console permissions
> for /dev/dmmidi2
> Aug  8 23:57:12 o kernel: hda: Maxtor 33073U4, ATA DISK drive
> Aug  8 23:56:24 o pam_console.dev[3080]: Restoring console permissions
> for /dev/adsp2
> Aug  8 23:57:12 o kernel: hdb: MAXTOR 6L060J3, ATA DISK drive
> Aug  8 23:56:24 o pam_console.dev[3060]: Restoring console permissions
> for /dev/snd/hwC2D0
> Aug  8 23:57:12 o kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Aug  8 23:56:24 o keytable: Ładowanie mapy klawiatury: pl succeeded
> Aug  8 23:57:12 o kernel: Probing IDE interface ide1...
> Aug  8 23:57:12 o oidentd: Uruchamianie oidentd succeeded
> Aug  8 23:56:25 o loadkeys:
> Loading /usr/lib/kbd/keymaps/include/compose.latin2.inc.gz
> Aug  8 23:57:12 o kernel: hdc: CD-RW BCE4816IM, ATAPI CD/DVD-ROM drive
> Aug  8 23:56:25 o keytable: Ładowanie klawiszy kompozycji:
> compose.latin2.inc succeeded
> Aug  8 23:57:12 o kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Aug  8 23:56:26 o keytable:  succeeded
> Aug  8 23:57:12 o kernel: hda: max request size: 128KiB
> Aug  8 23:56:28 o rc.sysinit: Uaktywnianie przestrzeni wymiany:
> succeeded
> Aug  8 23:57:12 o kernel: hda: 60030432 sectors (30735 MB) w/512KiB
> Cache, CHS=59554/16/63, UDMA(100)
> Aug  8 23:56:29 o rc.sysinit: Inicjalizacja kontrolera firewire
> (ohci1394):  succeeded
> Aug  8 23:57:12 o kernel: hda: cache flushes not supported
> Aug  8 23:56:29 o ieee1394.agent[3794]: ... no drivers for IEEE1394
> product 0x/0x/0x
> Aug  8 23:57:12 o kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5
> >
> Aug  8 23:56:30 o ieee1394.agent[3958]: ... no drivers for IEEE1394
> product 0x/0x/0x
> Aug  8 23:57:13 o kernel: hdb: max request size: 128KiB
> Aug  8 23:56:30 o ieee1394.agent[3972]: ... no drivers for IEEE1394
> product 0x/0x/0x
> Aug  8 23:57:13 o kernel: hdb: 117266688 sectors (60040 MB) w/1819KiB
> Cache, CHS=65535/16/63, UDMA(133)
> Aug  8 23:56:31 o mandrake_everytime: Uruchamianie netprofile: succeeded
> Aug  8 23:57:13 o kernel: hdb: cache flushes supported
> Aug  8 23:56:31 o init: Entering runlevel: 3
> Aug  8 23:57:13 o kernel:  /dev/ide/host0/bus0/target1/lun0: p1
> Aug  8 23:56:34 o INIT: Loading ACPI module ac: successfull
> Aug  8 23:57:13 o kernel: mice: PS/2 mouse device common for all mice
> Aug  8 23:56:34 o INIT: Loading ACPI module battery: successfull
> Aug  8 23:57:13 o kernel: input: AT Translated Set 2 keyboard on
> isa0060/serio0
> Aug  8 23:56:34 o INIT: Loading ACPI module button: successfull
> Aug  8 23:57:13 o kernel: input: PS/2 Generic Mouse on isa0060/serio1
> Aug  8 23:56:35 o INIT: Loading ACPI module container: successfull
> Aug  8 23:57:13 o kernel: md: md driver 0.90.1 MAX_MD_DEVS=256,
> MD_SB_DISKS=27
> Aug  8 23:56:35 o INIT: Loading ACPI module fan: successfull
> Aug  8 23:57:13 o kernel: NET: Registered protocol family 2
> Aug  8 23:56:35 o INIT: Loading ACPI module processor: successfull
> Aug  8 23:57:13 o kernel: IP: routing cache hash table of 16384 buckets,
> 128Kbytes
> Aug  8 23:56:35 o INIT: Loading ACPI module tc1100-wmi: successfull
> Aug  8 23:57:13 o kernel: TCP established hash table entries: 262144
> (order: 9, 2097152 bytes)
> Aug  8 23:56:35 o INIT: Loading ACPI module thermal: successfull
> Aug  8 23:57:13 o kernel: TCP bind hash table entries: 65536 (order: 6,
> 262144 bytes)
> Aug  8 23:56:35 o INIT: Loading ACPI module video: successfull
> Aug  8 23:57:13 o kernel: TCP: Hash tables configured (established
> 262144 bind 65536)
> Aug  8 23:56:40 o rc: Uruchamianie dkms: succeeded
> Aug  8 23:57:13 o kernel: NET: Registered protocol family 1
> Aug  8 23:56:46 o sensord: sensord started
> Aug  8 23:57:13 o kernel: ACPI wakeup devices:
> Aug  8 23:56:46 o sensord: Chip: asb100-i2c-1-2d
> Aug  8 23:57:13 o kernel: PCI0 PCI1 UAR1 USB0 USB1
> Aug  8 23:56:46 o sensord: Adapter: SMBus Via Pro adapter at e800
> Aug  8 23:57:13 o kernel: ACPI: (supports S0 S1 S4 S5)
> Aug  8 23:56:46 o sensord: Algorithm: Unavailable from sysfs
> Aug  8 23:57:13 o kernel: BIOS EDD facility v0.16 2004-Jun-25, 2 devices
> found
> Aug  8 23:56:46 o lm_sensors: Uruchamianie sensord succeeded
> Aug  8 23:57:13 o kernel: devfs_mk_dev: could not append to parent for
> md/0
> Aug  8 23:56:46 o sensord:   VCore 1: +1.84 V (min = +1.71 V, max =
> +1.89 V)
> Aug  8 23:57:13 o kernel: md: Autodetecting RAID arrays.
> Aug  8 23:56:46 o sensord:   +3.3V: +3.33 V (min = +3.14 V, max = +3.47
> V)
> Aug  8 23:57:13 o kernel: md: autorun ...
> Aug  8 23:56:46 o sensord:   +5V: +5.00 V (min = +4.76 V, max = +5.24 V)
> Aug  8 23:57:14 o kernel: md: ... autorun DONE.
> Aug  8 23:56:46 o sensord:   +12V: +12.65 V (min = +10.82 V, max =
> +13.19 V)
> Aug  8 23:57:14 o kernel: EXT3-fs: INFO: recovery required on readonly
> filesystem.
> Aug  8 23:56:46 o sensord:   -12V (reserved): -13.15 V (min = -0.00 V,
> max = -0.00 V)
> Aug  8 23:57:14 o kernel: EXT3-fs: write access will be enabled during
> recovery.
> Aug  8 23:56:46 o sensord:   -5V (reserved): -5.52 V (min = -0.00 V, max
> = -0.00 V)
> Aug  8 23:57:14 o kernel: kjournald starting.  Commit interval 5 seconds
> Aug  8 23:56:46 o sensord:   CPU Fan: 2033 RPM (min = 664 RPM, div = -0)
> Aug  8 23:57:14 o kernel: EXT3-fs: hda1: orphan cleanup on readonly fs
> Aug  8 23:56:46 o sensord:   Power Fan: 1288 RPM (min = 664 RPM, div =
> -0)
> Aug  8 23:57:14 o kernel: ext3_orphan_cleanup: deleting unreferenced
> inode 3467492
> Aug  8 23:56:46 o sensord:   Chassic Fan: 1562 RPM (min = 664 RPM, div =
> -0)
> Aug  8 23:57:14 o kernel: ext3_orphan_cleanup: deleting unreferenced
> inode 2142121
> Aug  8 23:56:46 o sensord:   M/B Temp: 44.0 C (limit = 40 C, hysteresis
> = 45 C)
> Aug  8 23:57:14 o kernel: EXT3-fs: hda1: 2 orphan inodes deleted
> Aug  8 23:56:46 o sensord:   CPU Temp (Intel): 69.5 C (limit = 50 C,
> hysteresis = 60 C)
> Aug  8 23:57:14 o kernel: EXT3-fs: recovery complete.
> Aug  8 23:56:46 o sensord:   Power Temp: 38.0 C (limit = 40 C,
> hysteresis = 45 C)
> Aug  8 23:57:14 o kernel: EXT3-fs: mounted filesystem with ordered data
> mode.
> Aug  8 23:56:46 o sensord:   CPU Temp (AMD): 60.0 C (limit = 50 C,
> hysteresis = 60 C)
> Aug  8 23:57:14 o kernel: VFS: Mounted root (ext3 filesystem) readonly.
> Aug  8 23:56:46 o sensord: Chip: LG PAL_BG-i2c-0-61
> Aug  8 23:57:14 o kernel: Mounted devfs on /dev
> Aug  8 23:56:46 o sensord: Adapter: bt878 #0 [sw]
> Aug  8 23:57:14 o kernel: Freeing unused kernel memory: 268k freed
> Aug  8 23:56:46 o sensord: Algorithm: Unavailable from sysfs
> Aug  8 23:57:14 o kernel: ACPI: Power Button (FF) [PWRF]
> Aug  8 23:56:48 o network: Konfiguracja parametrów sieciowych:
> succeeded
> Aug  8 23:57:15 o kernel: ibm_acpi: ec object not found
> Aug  8 23:56:49 o postfix/postfix-script: fatal: the Postfix mail system
> is not running
> Aug  8 23:57:15 o postfix/postfix-script: starting the Postfix mail
> system
> Aug  8 23:57:15 o kernel: usbcore: registered new driver usbfs
> Aug  8 23:56:49 o network: Podnoszenie interfejsu lokalnego: succeeded
> Aug  8 23:57:15 o postfix:  succeeded
> Aug  8 23:57:15 o postfix/master[6062]: daemon started -- version 2.1.5
> Aug  8 23:57:15 o kernel: usbcore: registered new driver hub
> Aug  8 23:56:52 o postfix/postfix-script: fatal: the Postfix mail system
> is not running
> Aug  8 23:57:15 o kernel: [eagle-usb] driver V2.2.0 loaded
> Aug  8 23:56:52 o network: Inicjowanie interfejsu eth0: succeeded
> Aug  8 23:57:16 o kernel: usbcore: registered new driver eagle-usb
> Aug  8 23:56:54 o postfix/postfix-script: fatal: the Postfix mail system
> is not running
> Aug  8 23:57:16 o kernel: Linux video capture interface: v1.00
> Aug  8 23:56:54 o network: Inicjowanie interfejsu eth1: succeeded
> Aug  8 23:57:16 o kernel: pwc Philips webcam module version
> 10.0.6-unofficial loaded.
> Aug  8 23:56:54 o ifplugd(eth2)[5369]: ifplugd 0.26 initializing.
> Aug  8 23:57:16 o kernel: pwc Supports Philips PCA645/646,
> PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
> Aug  8 23:56:54 o ifplugd(eth2)[5369]: Using interface
> eth2/00:E0:18:00:00:04 with driver <eth1394> (version: $Rev: 1224 $)
> 
> Aug  8 23:57:16 o kernel: pwc Also supports the Askey VC010, various
> Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
> Aug  8 23:56:54 o ifplugd(eth2)[5369]: Using detection mode: IFF_RUNNING
> Aug  8 23:57:16 o kernel: pwc the Creative WebCam 5 & Pro Ex, SOTEC
> Afina Eye and Visionite VCS-UC300 and VCS-UM100.
> Aug  8 23:56:54 o ifplugd(eth2)[5369]: Initialization complete, link
> beat detected.
> Aug  8 23:57:16 o kernel: pwc Default framerate set to 5.
> Aug  8 23:56:54 o ifplugd(eth2)[5369]: Executing
> '/etc/ifplugd/ifplugd.action eth2 up'.
> Aug  8 23:57:16 o kernel: pwc Default image size set to vga [640x480].
> Aug  8 23:56:54 o dhclient: eth2: unknown hardware address type 24
> Aug  8 23:57:17 o kernel: pwc Trace options: 0x00a1
> Aug  8 23:56:55 o network: Inicjowanie interfejsu eth2: succeeded
> Aug  8 23:57:17 o kernel: pwc Preferred compression set to 1.
> Aug  8 23:57:17 o httpd: Uruchamianie httpd succeeded
> Aug  8 23:57:17 o kernel: usbcore: registered new driver Philips webcam
> Aug  8 23:57:18 o rc: Uruchamianie kheader: succeeded
> Aug  8 23:57:18 o kernel: USB Universal Host Controller Interface driver
> v2.2
> Aug  8 23:57:19 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 11
> Aug  8 23:57:19 o kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Aug  8 23:57:19 o devfsd[1032]: Caught SIGHUP
> Aug  8 23:57:19 o devfsd: Uruchamianie czynności devfsd: succeeded
> Aug  8 23:57:19 o kernel: uhci_hcd 0000:00:09.0: UHCI Host Controller
> Aug  8 23:57:19 o devfsd[1032]: read config file:
> "/etc/devfs/conf.d//mouse.conf"
> Aug  8 23:57:21 o kernel: uhci_hcd 0000:00:09.0: irq 19, io base 0xd800
> Aug  8 23:57:22 o devfsd[1032]: read config file:
> "/etc/devfs/conf.d//dynamic.conf"
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:09.0: new USB bus registered,
> assigned bus number 1
> Aug  8 23:57:22 o devfsd[1032]: read config file:
> "/etc/devfs/conf.d//rfcomm.conf"
> Aug  8 23:57:22 o kernel: hub 1-0:1.0: USB hub found
> Aug  8 23:57:22 o devfsd[1032]: read config file:
> "/etc/devfs/conf.d//mk712.conf"
> Aug  8 23:57:22 o kernel: hub 1-0:1.0: 2 ports detected
> Aug  8 23:57:22 o devfsd[1032]: read config file: "/etc/devfsd.conf"
> Aug  8 23:57:22 o kernel: ACPI: PCI interrupt 0000:00:09.1[B] -> GSI 16
> (level, low) -> IRQ 16
> Aug  8 23:57:22 o devfsd[6285]: error execing:
> "/etc/dynamic/scripts/part.script"^INo such file or directory
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:09.1: UHCI Host Controller
> Aug  8 23:57:22 o devfsd[6286]: error execing:
> "/etc/dynamic/scripts/part.script"^INo such file or directory
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:09.1: irq 16, io base 0xd400
> Aug  8 23:57:22 o devfsd[6287]: error execing:
> "/etc/dynamic/scripts/part.script"^INo such file or directory
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:09.1: new USB bus registered,
> assigned bus number 2
> Aug  8 23:57:22 o devfsd[6289]: error execing:
> "/etc/dynamic/scripts/part.script"^INo such file or directory
> Aug  8 23:57:22 o kernel: hub 2-0:1.0: USB hub found
> Aug  8 23:57:22 o kernel: hub 2-0:1.0: 2 ports detected
> Aug  8 23:57:22 o kernel: ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 21
> (level, low) -> IRQ 21
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.2: UHCI Host Controller
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.2: irq 21, io base 0xa400
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.2: new USB bus registered,
> assigned bus number 3
> Aug  8 23:57:22 o kernel: hub 3-0:1.0: USB hub found
> Aug  8 23:57:22 o kernel: hub 3-0:1.0: 2 ports detected
> Aug  8 23:57:22 o kernel: ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 21
> (level, low) -> IRQ 21
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.3: UHCI Host Controller
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.3: irq 21, io base 0xa000
> Aug  8 23:57:22 o kernel: uhci_hcd 0000:00:11.3: new USB bus registered,
> assigned bus number 4
> Aug  8 23:57:22 o kernel: hub 4-0:1.0: USB hub found
> Aug  8 23:57:23 o kernel: hub 4-0:1.0: 2 ports detected
> Aug  8 23:57:23 o kernel: usb 4-1: new full speed USB device using
> uhci_hcd and address 2
> Aug  8 23:57:23 o kernel: [eagle-usb] New USB ADSL device detected,
> waiting for DSP code...
> Aug  8 23:57:23 o kernel: [eagle-usb] Interface 0 accepted.
> Aug  8 23:57:23 o kernel: [eagle-usb] created proc entry
> at : /proc/driver/eagle-usb/004-002
> Aug  8 23:57:23 o kernel: ACPI: PCI interrupt 0000:00:09.2[C] -> GSI 17
> (level, low) -> IRQ 17
> Aug  8 23:57:23 o kernel: ehci_hcd 0000:00:09.2: EHCI Host Controller
> Aug  8 23:57:23 o kernel: ehci_hcd 0000:00:09.2: irq 17, pci mem
> 0xe9800000
> Aug  8 23:57:23 o kernel: ehci_hcd 0000:00:09.2: new USB bus registered,
> assigned bus number 5
> Aug  8 23:57:23 o kernel: ehci_hcd 0000:00:09.2: USB 2.0 initialized,
> EHCI 0.95, driver 10 Dec 2004
> Aug  8 23:57:23 o kernel: hub 5-0:1.0: USB hub found
> Aug  8 23:57:23 o kernel: hub 5-0:1.0: 4 ports detected
> Aug  8 23:57:23 o kernel: usb 1-1: new full speed USB device using
> uhci_hcd and address 2
> Aug  8 23:57:23 o kernel: pwc Philips PCVC740K (ToUCam Pro)/PCVC840
> (ToUCam II) USB webcam detected.
> Aug  8 23:57:23 o kernel: pwc Registered as /dev/video5.
> Aug  8 23:57:23 o kernel: usb 1-2: new full speed USB device using
> uhci_hcd and address 3
> Aug  8 23:57:23 o kernel: hub 1-2:1.0: USB hub found
> Aug  8 23:57:23 o kernel: hub 1-2:1.0: 4 ports detected
> Aug  8 23:57:23 o kernel: usb 1-2.3: new full speed USB device using
> uhci_hcd and address 4
> Aug  8 23:57:23 o kernel: pwc Philips PCVC740K (ToUCam Pro)/PCVC840
> (ToUCam II) USB webcam detected.
> Aug  8 23:57:23 o kernel: pwc Registered as /dev/video9.
> Aug  8 23:57:23 o kernel: usb 1-2.3: 400mA over 100mA budget!
> Aug  8 23:57:23 o kernel: hub 1-2:1.0: 100mA over power budget!
> Aug  8 23:57:23 o kernel: usbcore: deregistering driver eagle-usb
> Aug  8 23:57:23 o kernel: [eagle-usb] ADSL device removed
> Aug  8 23:57:23 o kernel: [eagle-usb] driver unloaded
> Aug  8 23:57:23 o kernel: snd: Unknown symbol unregister_sound_special
> Aug  8 23:57:23 o kernel: snd: Unknown symbol register_sound_special
> Aug  8 23:57:23 o kernel: snd: Unknown symbol sound_class
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol
> snd_info_register
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol
> snd_info_create_module_entry
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol
> snd_info_free_entry
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol snd_seq_root
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol snd_iprintf
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol snd_device_new
> Aug  8 23:57:23 o kernel: snd-seq-device: Unknown symbol
> snd_info_unregister
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_info_register
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_seq_device_new
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_info_free_entry
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_unregister_oss_device
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_register_oss_device
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_ctl_register_ioctl
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_card_file_add
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_iprintf
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_oss_info_register
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_unregister_device
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_device_new
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_ctl_unregister_ioctl
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_info_create_card_entry
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol snd_device_free
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_card_file_remove
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_info_unregister
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_device_register
> Aug  8 23:57:23 o kernel: snd-rawmidi: Unknown symbol
> snd_register_device
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_receive
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_transmit_empty
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_transmit
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_transmit_ack
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_transmit_peek
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol snd_rawmidi_new
> Aug  8 23:57:23 o kernel: snd-usb-lib: Unknown symbol
> snd_rawmidi_set_ops
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol snd_info_register
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol
> snd_info_create_module_entry
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol snd_info_free_entry
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol snd_iprintf
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol snd_ecards_limit
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol
> snd_oss_info_register
> Aug  8 23:57:23 o kernel: snd-timer: Unknown symbol
> snd_unregister_device
> Aug  8 23:57:24 o kernel: snd-timer: Unknown symbol snd_device_new
> Aug  8 23:57:24 o kernel: snd-timer: Unknown symbol snd_kmalloc_strdup
> Aug  8 23:57:24 o kernel: snd-timer: Unknown symbol snd_info_unregister
> Aug  8 23:57:24 o kernel: snd-timer: Unknown symbol snd_register_device
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_info_register
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol
> snd_info_create_module_entry
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_timer_notify
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_timer_interrupt
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_info_free_entry
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_info_get_str
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_ctl_register_ioctl
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_card_file_add
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_iprintf
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_major
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_unregister_device
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_timer_new
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_device_new
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol
> snd_ctl_unregister_ioctl
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol
> snd_info_create_card_entry
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_power_wait
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_device_free
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_card_file_remove
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_info_unregister
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_device_register
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_register_device
> Aug  8 23:57:24 o kernel: snd-pcm: Unknown symbol snd_info_get_line
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_ctl_add
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_pcm_new
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_card_register
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_card_free
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_card_proc_new
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_usb_create_midi_interface
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_pcm_stop
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_hw_constraint_minmax
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_format_physical_width
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_ctl_free_one
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_ctl_find_id
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_ctl_new1
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_component_add
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_hw_rule_add
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_card_new
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_iprintf
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_lib_malloc_pages
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_lib_ioctl
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_lib_free_pages
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_new_stream
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_pcm_set_ops
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol snd_device_new
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_card_disconnect
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_lib_preallocate_pages
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_card_free_in_thread
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_lib_preallocate_free_for_all
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_period_elapsed
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_pcm_format_name
> Aug  8 23:57:24 o kernel: snd-usb-audio: Unknown symbol
> snd_usbmidi_disconnect
> Aug  8 23:57:24 o kernel: usbcore: registered new driver snd-usb-audio
> Aug  8 23:57:24 o kernel: usbcore: registered new driver usblp
> Aug  8 23:57:24 o kernel: drivers/usb/class/usblp.c: v0.13: USB Printer
> Device Class driver
> Aug  8 23:57:24 o kernel: EXT3 FS on hda1, internal journal
> Aug  8 23:57:24 o kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 18
> (level, low) -> IRQ 18
> Aug  8 23:57:24 o kernel: Adding 2064312k swap on /dev/hda5.
> Priority:-1 extents:1
> Aug  8 23:57:24 o kernel: Linux agpgart interface v0.100 (c) Dave Jones
> Aug  8 23:57:24 o kernel: nvidia: module license 'NVIDIA' taints kernel.
> Aug  8 23:57:24 o kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16
> (level, low) -> IRQ 16
> Aug  8 23:57:24 o kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel
> Module  1.0-7174  Tue Mar 22 06:44:39 PST 2005
> Aug  8 23:57:24 o kernel: bttv: driver version 0.9.15 loaded
> Aug  8 23:57:24 o kernel: bttv: using 8 buffers with 2080k (520 pages)
> each for capture
> Aug  8 23:57:24 o kernel: bttv: Bt8xx card found (0).
> Aug  8 23:57:24 o kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 16
> (level, low) -> IRQ 16
> Aug  8 23:57:24 o kernel: bttv0: Bt878 (rev 17) at 0000:00:0d.0, irq:
> 16, latency: 32, mmio: 0xed000000
> Aug  8 23:57:24 o kernel: bttv0: using: Prolink Pixelview PV-BT878P+9B
> (PlayTV Pro rev.9B FM+NICAM) [card=72,insmod option]
> Aug  8 23:57:24 o kernel: bttv0: gpio: en=00000000, out=00000000
> in=00ffc0ff [init]
> Aug  8 23:57:24 o kernel: bttv0: using tuner=28
> Aug  8 23:57:24 o kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not
> found
> Aug  8 23:57:24 o kernel: tvaudio: TV audio decoder + audio/video mux
> driver
> Aug  8 23:57:24 o kernel: tvaudio: known chips:
> tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425
> ,pic16c54 (PV951),ta8874z
> Aug  8 23:57:24 o kernel: bttv0: i2c: checking for TDA9887 @ 0x86... not
> found
> Aug  8 23:57:25 o kernel: tuner 0-0061: chip found @ 0xc2 (bt878 #0
> [sw])
> Aug  8 23:57:25 o kernel: tuner 0-0061: type set to 28 (LG PAL_BG+FM
> (TPI8PSB01D))
> Aug  8 23:57:25 o kernel: bttv0: registered device video2
> Aug  8 23:57:25 o kernel: bttv0: registered device vbi0
> Aug  8 23:57:25 o kernel: bttv0: registered device radio0
> Aug  8 23:57:25 o kernel: bttv0: PLL: 28636363 => 35468950 .. ok
> Aug  8 23:57:25 o kernel: bttv0: add subdevice "remote0"
> Aug  8 23:57:25 o kernel: bt878: AUDIO driver version 0.0.0 loaded
> Aug  8 23:57:25 o kernel: bt878: Bt878 AUDIO function found (0).
> Aug  8 23:57:25 o kernel: ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 16
> (level, low) -> IRQ 16
> Aug  8 23:57:25 o kernel: bt878(0): Bt878 (rev 17) at 00:0d.1, irq: 16,
> latency: 32, memory: 0xec800000
> Aug  8 23:57:25 o kernel: agpgart: Detected VIA KT266/KY266x/KT333
> chipset
> Aug  8 23:57:25 o kernel: agpgart: Maximum main memory to use for agp
> memory: 1185M
> Aug  8 23:57:25 o kernel: agpgart: AGP aperture is 128M @ 0xf0000000
> Aug  8 23:57:25 o kernel: kjournald starting.  Commit interval 5 seconds
> Aug  8 23:57:25 o kernel: EXT3 FS on hdb1, internal journal
> Aug  8 23:57:25 o kernel: EXT3-fs: mounted filesystem with ordered data
> mode.
> Aug  8 23:57:25 o kernel: loop: loaded (max 8 devices)
> Aug  8 23:57:25 o kernel: SCSI subsystem initialized
> Aug  8 23:57:25 o kernel: st: Version 20041025, fixed bufsize 32768, s/g
> segs 256
> Aug  8 23:57:25 o kernel: ieee1394: Initialized config rom entry
> `ip1394'
> Aug  8 23:57:25 o kernel: ohci1394: $Rev: 1223 $ Ben Collins
> <bcollins@debian.org>
> Aug  8 23:57:25 o kernel: ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 17
> (level, low) -> IRQ 17
> Aug  8 23:57:25 o kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
> IRQ=[17]  MMIO=[ea800000-ea8007ff]  Max Packet=[2048]
> Aug  8 23:57:25 o kernel: hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB
> Cache, UDMA(33)
> Aug  8 23:57:25 o kernel: Uniform CD-ROM driver Revision: 3.20
> Aug  8 23:57:26 o kernel: 8139too Fast Ethernet driver 0.9.27
> Aug  8 23:57:26 o kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 17
> (level, low) -> IRQ 17
> Aug  8 23:57:26 o kernel: eth0: RealTek RTL8139 at 0xf8c40000,
> 00:e0:4c:08:ae:17, IRQ 17
> Aug  8 23:57:26 o kernel: eth0:  Identified 8139 chip type
> 'RTL-8100B/8139D'
> Aug  8 23:57:26 o kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 19
> (level, low) -> IRQ 19
> Aug  8 23:57:26 o kernel: eth1: RealTek RTL8139 at 0xf8c42000,
> 00:50:fc:c7:eb:2b, IRQ 19
> Aug  8 23:57:26 o kernel: eth1:  Identified 8139 chip type
> 'RTL-8100B/8139D'
> Aug  8 23:57:26 o kernel: ide-floppy driver 0.99.newide
> Aug  8 23:57:26 o kernel: eth1394: $Rev: 1224 $ Ben Collins
> <bcollins@debian.org>
> Aug  8 23:57:26 o kernel: eth1394: eth2: IEEE-1394 IPv4 over 1394
> Ethernet (fw-host0)
> Aug  8 23:57:26 o kernel: ieee1394: Host added: ID:BUS[0-00:1023]
> GUID[00e018000004199b]
> Aug  8 23:57:26 o kernel: ip_conntrack version 2.1 (8192 buckets, 65536
> max) - 248 bytes per conntrack
> Aug  8 23:57:26 o kernel: ip_tables: (C) 2000-2002 Netfilter core team
> Aug  8 23:57:26 o kernel: Floppy drive(s): fd0 is 1.44M
> Aug  8 23:57:26 o kernel: FDC 0 is a post-1991 82077
> Aug  8 23:57:26 o kernel: NET: Registered protocol family 23
> Aug  8 23:57:26 o kernel: IrCOMM protocol (Dag Brattli)
> Aug  8 23:57:26 o kernel: [eagle-usb] driver V2.2.0 loaded
> Aug  8 23:57:26 o kernel: [eagle-usb] New USB ADSL device detected,
> waiting for DSP code...
> Aug  8 23:57:26 o kernel: [eagle-usb] Interface 0 accepted.
> Aug  8 23:57:26 o kernel: [eagle-usb] created proc entry
> at : /proc/driver/eagle-usb/004-002
> Aug  8 23:57:26 o kernel: usbcore: registered new driver eagle-usb
> Aug  8 23:57:26 o kernel: eth0: link down
> Aug  8 23:57:26 o kernel: eth0: link down
> Aug  8 23:57:26 o kernel: NET: Registered protocol family 17
> Aug  8 23:57:26 o kernel: eth0: link down
> Aug  8 23:57:26 o kernel: eth1: link up, 100Mbps, full-duplex, lpa
> 0x41E1
> Aug  8 23:57:26 o kernel: CSLIP: code copyright 1989 Regents of the
> University of California
> Aug  8 23:57:26 o kernel: PPP generic driver version 2.4.2
> Aug  8 23:57:26 o kernel: NET: Registered protocol family 10
> Aug  8 23:57:26 o kernel: Disabled Privacy Extensions on device
> c0416140(lo)
> Aug  8 23:57:26 o kernel: IPv6 over IPv4 tunneling driver
> Aug  8 23:57:26 o kernel: eth1: no IPv6 routers present
> Aug  8 23:57:26 o kernel: eth0: no IPv6 routers present
> Aug  8 23:57:26 o kernel: ip_tables: (C) 2000-2002 Netfilter core team
> Aug  8 23:57:26 o kernel: ip_conntrack version 2.1 (8192 buckets, 65536
> max) - 248 bytes per conntrack
> Aug  8 23:57:27 o kernel: ip6_tables: (C) 2000-2002 Netfilter core team
> Aug  8 23:57:27 o hal.hotplug[6694]: DEVPATH is not set
> 
> Aug  8 23:57:27 o kernel: input: PC Speaker
> Aug  8 23:57:28 o kernel: cpu5wdt: init success
> Aug  8 23:57:29 o kernel: usbcore: deregistering driver snd-usb-audio
> Aug  8 23:57:30 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 12
> Aug  8 23:57:31 o devfsd[1032]: error copying: "/lib/dev-state/vcc/2" to
> "/dev/vcc/2"
> Aug  8 23:57:31 o devfsd[1032]: error copying: "/lib/dev-state/vcc/3" to
> "/dev/vcc/3"
> Aug  8 23:57:31 o devfsd[1032]: error copying: "/lib/dev-state/vcc/2" to
> "/dev/vcc/2"
> Aug  8 23:57:31 o devfsd[1032]: error copying: "/lib/dev-state/vcc/3" to
> "/dev/vcc/3"
> Aug  8 23:57:34 o kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 18
> (level, low) -> IRQ 18
> Aug  8 23:57:34 o alsa:  succeeded
> Aug  8 23:57:35 o login(pam_unix)[6928]: session opened for user root by
> (uid=0)
> Aug  8 23:57:35 o  -- root[6928]: ROOT LOGIN ON vc/1
> Aug  8 23:57:39 o kernel: usbcore: registered new driver snd-usb-audio
> Aug  8 23:57:40 o login(pam_unix)[6933]: session opened for user
> michalkr by (uid=0)
> Aug  8 23:57:41 o pam_console.dev[8235]: Restoring console permissions
> for /dev/mixer2
> Aug  8 23:57:42 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 15
> Aug  8 23:57:46 o pam_console.dev[8441]: Restoring console permissions
> for /dev/mixer
> Aug  8 23:57:46 o  -- michalkr[6933]: LOGIN ON vc/6 BY michalkr
> Aug  8 23:57:46 o motion: Processing thread 0 - config
> file /usr/local/etc/motion.conf
> Aug  8 23:57:46 o motion: Unknown config option: "mpeg_encode"
> Aug  8 23:57:46 o motion: Unknown config option: "mpeg_encode_bin"
> Aug  8 23:57:46 o motion: Unknown config option: "adjust_rate"
> Aug  8 23:57:46 o motion: Unknown config option: "jpg_cleanup"
> Aug  8 23:57:46 o motion: Unknown config option:
> "berkeley_single_directory"
> Aug  8 23:57:46 o motion: Unknown config option: "predict_filename"
> Aug  8 23:57:46 o motion: Unknown config option: "sql_log_image"
> Aug  8 23:57:46 o motion: Unknown config option: "sql_log_snapshot"
> Aug  8 23:57:46 o motion: Unknown config option: "sql_log_mpeg"
> Aug  8 23:57:46 o motion: Unknown config option: "sql_log_timelapse"
> Aug  8 23:57:46 o motion: Unknown config option: "sql_log_prediction"
> Aug  8 23:57:46 o motion: Unknown config option: "pgsql_port"
> Aug  8 23:57:46 o motion: Unknown config option: "predict_enable"
> Aug  8 23:57:47 o motion: Unknown config option: "predict_threshold"
> Aug  8 23:57:47 o motion: motion running as daemon process
> Aug  8 23:57:47 o motion: waiting for threads to finish, pid: 8508
> Aug  8 23:57:47 o motion: Thread 0 PID: 8508
> Aug  8 23:57:47 o kernel: pwc Failed to set LED on/off time.
> Aug  8 23:57:47 o kernel: pwc set_video_mode(640x480 @ 5, palette 15).
> Aug  8 23:57:47 o kernel: pwc decode_size = 5.
> Aug  8 23:57:47 o kernel: pwc Using alternate setting 6.
> Aug  8 23:57:47 o kernel: [eagle-usb] ioctl EU_IO_CMVS received and
> treated.
> Aug  8 23:57:47 o kernel: [eagle-usb] ioctl EU_IO_OPTIONS received
> Aug  8 23:57:47 o kernel: [eagle-usb] ioctl EU_IO_DSP received
> Aug  8 23:57:47 o kernel: [eagle-usb] Loading DSP code to device...
> Aug  8 23:57:47 o kernel: [eagle-usb] DSP code successfully loaded to
> device
> Aug  8 23:57:48 o pam_console.dev[8541]: Restoring console permissions
> for /dev/vcs10
> Aug  8 23:57:48 o pam_console.dev[8547]: Restoring console permissions
> for /dev/vcsa10
> Aug  8 23:57:50 o kernel: pwc Dumping frame 6.
> Aug  8 23:57:50 o kernel: agpgart: Found an AGP 2.0 compliant device at
> 0000:00:00.0.
> Aug  8 23:57:50 o kernel: agpgart: Putting AGP V2 device at 0000:00:00.0
> into 4x mode
> Aug  8 23:57:50 o kernel: agpgart: Putting AGP V2 device at 0000:01:00.0
> into 4x mode
> Aug  8 23:57:50 o kernel: pwc Dumping frame 7.
> Aug  8 23:57:50 o kernel: pwc Dumping frame 9.
> Aug  8 23:57:50 o kernel: agpgart: Found an AGP 2.0 compliant device at
> 0000:00:00.0.
> Aug  8 23:57:50 o kernel: agpgart: Putting AGP V2 device at 0000:00:00.0
> into 4x mode
> Aug  8 23:57:50 o kernel: agpgart: Putting AGP V2 device at 0000:01:00.0
> into 4x mode
> Aug  8 23:57:51 o kernel: pwc Dumping frame 11.
> Aug  8 23:57:51 o kernel: pwc Dumping frame 13.
> Aug  8 23:57:52 o kernel: pwc Dumping frame 16.
> Aug  8 23:57:52 o kernel: pwc Dumping frame 18.
> Aug  8 23:57:53 o kernel: pwc Dumping frame 21.
> Aug  8 23:57:53 o kernel: pwc Dumping frame 23.
> Aug  8 23:57:54 o kernel: pwc Dumping frame 26.
> Aug  8 23:57:54 o kernel: pwc Dumping frame 28.
> Aug  8 23:57:54 o kernel: pwc Dumping frame 30.
> Aug  8 23:57:55 o kernel: pwc Dumping frame 33.
> Aug  8 23:57:55 o kernel: pwc Dumping frame 35.
> Aug  8 23:57:56 o kernel: pwc Dumping frame 38.
> Aug  8 23:57:56 o kernel: pwc Dumping frame 40.
> Aug  8 23:57:57 o dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port
> 67 interval 2
> Aug  8 23:57:57 o kernel: pwc Dumping frame 42.
> Aug  8 23:57:57 o kernel: pwc Dumping frame 43.
> Aug  8 23:57:57 o kernel: pwc Dumping frame 44.
> Aug  8 23:57:58 o kernel: pwc Dumping frame 46 (last message).
> Aug  8 23:57:59 o dhclient: No DHCPOFFERS received.
> Aug  8 23:58:00 o kernel: zcip uses obsolete (PF_INET,SOCK_PACKET)
> Aug  8 23:58:00 o zcip[8577]: libnet_open_link_interface("eth2"):
> unknown physical layer type 0x18
> Aug  8 23:58:00 o ifplugd(eth2)[5369]: client: Determining IP
> information for eth2... failed.
> Aug  8 23:58:00 o ifplugd(eth2)[5369]: Program execution failed, return
> value is 1.
> Aug  8 23:58:00 o ifplugd(eth2)[5369]: Exiting.
> Aug  8 23:58:04 o kernel: [eagle-usb] Modem operational !!
> Aug  8 23:58:04 o kernel: [eagle-usb]  Ethernet device eth3 created.
> Aug  8 23:58:06 o postfix/postfix-script: refreshing the Postfix mail
> system
> Aug  8 23:58:06 o postfix/master[6062]: reload configuration
> Aug  8 23:58:14 o kernel: eth3: no IPv6 routers present
> Aug  8 23:58:22 o pppd[8679]: pppd 2.4.3 started by root, uid 0
> Aug  8 23:58:22 o pppd[8679]: using channel 1
> Aug  8 23:58:22 o pppd[8679]: Using interface ppp0
> Aug  8 23:58:22 o pppd[8679]: Connect: ppp0 <--> /dev/pts/0
> Aug  8 23:58:23 o pppd[8679]: sent [LCP ConfReq id=0x1 <mru 1492> <magic
> 0xbd1ae510>]
> Aug  8 23:58:25 o pppd[8679]: rcvd [LCP ConfReq id=0x3e <auth chap MD5>
> <magic 0x6d4ee261>]
> Aug  8 23:58:25 o pppd[8679]: sent [LCP ConfAck id=0x3e <auth chap MD5>
> <magic 0x6d4ee261>]
> Aug  8 23:58:26 o pppd[8679]: sent [LCP ConfReq id=0x1 <mru 1492> <magic
> 0xbd1ae510>]
> Aug  8 23:58:26 o pppd[8679]: rcvd [LCP ConfAck id=0x1 <mru 1492> <magic
> 0xbd1ae510>]
> Aug  8 23:58:26 o pppd[8679]: rcvd [CHAP Challenge id=0x8d
> <74092edeac109ef714f8f867905772a515274f12be>, name = "kat_ru1"]
> Aug  8 23:58:26 o pppd[8679]: sent [CHAP Response id=0x8d
> <0a44b75013fc6d851d1f081a27942425>, name = "CENZO@RED"
> ]
> Aug  8 23:58:27 o pppd[8679]: rcvd [CHAP Success id=0x8d ""]
> Aug  8 23:58:27 o pppd[8679]: CHAP authentication succeeded
> Aug  8 23:58:27 o pppd[8679]: sent [IPCP ConfReq id=0x1 <addr 0.0.0.0>
> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
> Aug  8 23:58:27 o pppd[8679]: rcvd [IPCP ConfNak id=0x1 <addr
> 83.30.51.80> <ms-dns1 194.204.152.34> <ms-dns3 217.98.63.164>
> ]
> Aug  8 23:58:27 o pppd[8679]: sent [IPCP ConfReq id=0x2 <addr
> 83.30.51.80> <ms-dns1 194.204.152.34> <ms-dns3 217.98.63.164>
> ]
> Aug  8 23:58:27 o pppd[8679]: rcvd [IPCP ConfReq id=0x2 <addr
> 213.25.2.205>]
> Aug  8 23:58:27 o pppd[8679]: sent [IPCP ConfAck id=0x2 <addr
> 213.25.2.205>]
> Aug  8 23:58:27 o pppd[8679]: rcvd [IPCP ConfAck id=0x2 <addr
> 83.30.51.80> <ms-dns1 194.204.152.34> <ms-dns3 217.98.63.164>
> ]
> Aug  8 23:58:27 o pppd[8679]: local  IP address 83.30.51.80
> Aug  8 23:58:27 o pppd[8679]: remote IP address 213.25.2.205
> Aug  8 23:58:27 o pppd[8679]: primary   DNS address 194.204.152.34
> Aug  8 23:58:27 o pppd[8679]: secondary DNS address 217.98.63.164
> Aug  8 23:58:27 o pppd[8747]: Script /etc/ppp/ip-up started (pid 8749)
> Aug  8 23:58:27 o postfix/postfix-script: refreshing the Postfix mail
> system
> Aug  8 23:58:28 o postfix/master[6062]: reload configuration
> Aug  8 23:58:28 o crond[8796]: (CRON) STARTUP (fork ok)
> Aug  8 23:58:28 o crond: Uruchamianie crond succeeded
> Aug  8 23:58:28 o postfix/postfix-script: refreshing the Postfix mail
> system
> Aug  8 23:58:28 o postfix/master[6062]: reload configuration
> Aug  8 23:58:28 o pppd[8747]: Script /etc/ppp/ip-up finished (pid 8749),
> status = 0x0
> Aug  8 23:58:39 o kernel: tuner 0-0061: radio freq (0.00) out of range
> (65-108)
> 
> Aug  8 23:59:00 o CROND[9091]:.................... that's all i think
> 
> 
> 
> It is a kernel-source-2.6-2.6.11-12mdk.i586.rpm compiled by myself
> for "athlon/duron/k7" and NVIDIA-Linux-x86-1.0-7174-pkg1 compiled too
> by myself.
> 
> Linux o 2.6.11-12mdkcustom #2 Sat Aug 6 11:02:20 CEST 2005 i686 AMD
> Duron(TM)unknown GNU/Linux
> 
> 
> Ps. i should compile 2.6.13-rc6, but ATM i have no time, so, i did quick
> fix
> #> rmmod bt878
> #> rmmod bttv
> #> rmmod btcx-risc
> and i'm waiting for crash.
> 
> 
> 
> 
> 
> 
> 
> 
Cheers, Mauro.

