Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266151AbTLIIn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbTLIIn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:43:29 -0500
Received: from ns1.netnea.com ([138.189.116.70]:17088 "EHLO james.netnea.com")
	by vger.kernel.org with ESMTP id S266151AbTLIIl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:41:56 -0500
Subject: Re: PROBLEM: (Bug report) USB Mass Storage in 2.6.0-test11 (cannot
	mount flash drive)
From: Charles Bueche <charles@bueche.ch>
To: Pavel Alexeev <al_pavel@rambler.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FD2694D.5090706@rambler.ru>
References: <3FD2694D.5090706@rambler.ru>
Content-Type: text/plain
Message-Id: <1070957548.6531.5.camel@bluez.bueche.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 09:12:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have one of these multi-cards USB2 reader (from PQI I think). I can
only see the CF card if I first plug the CF into the device, then plug
the reader USB cable in the PC.

After this procedure, I see the card under
/dev/scsi/host1/bus0/target0/lun0/part1

In fstab, I have (on 1 line) :

/dev/scsi/host1/bus0/target0/lun0/part1 /mnt/cf    vfat
rw,uid=cbueche,gid=cbueche,noauto,noatime      0 0

Hope this help, 
Charles

On Sun, 2003-12-07 at 00:42, Pavel Alexeev wrote:
> Hi!
> Sorry, i am totally stumped as to whom to send the report :)
> 
> [1.] One line summary of the problem:
> -------------------------------------
> 
> I cannot mount any USB mass storage drive when using kernel 2.6.0-test11
> 
> [2.] Full description of the problem/report:
> --------------------------------------------
> 
> After plugging the HP Photosmart 720 USB cable in my notebook HP Omnibook xe4500 i see
> in /var/log/messages:
> 
> Dec  6 19:28:18 mycomp kernel: hub 1-0:1.0: new USB device on port 2, assigned address 3
> Dec  6 19:28:18 mycomp modprobe: FATAL: Module usb_storage already in kernel. 
> Dec  6 19:28:18 mycomp kernel: scsi1 : SCSI emulation for USB Mass Storage devices
> Dec  6 19:28:18 mycomp scsi.agent[894]: bogus sysfs  DEVPATH=/devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/ho st1/1:0:0:0
> Dec  6 19:28:18 mycomp kernel:   Vendor:           Model:                   Rev:     
> Dec  6 19:28:18 mycomp kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
> Dec  6 19:28:18 mycomp kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
> 
> But I cannot mount the device:
> 
> bash-2.05b# mount /dev/sg0 /mnt/flash
> mount: /dev/sg0 is not a block device
> bash-2.05b# mount /dev/sda1 /mnt/flash
> mount: /dev/sda1 is not a valid block device
> bash-2.05b# mount /dev/sdb1 /mnt/flash
> mount: /dev/sdb1 is not a valid block device
> ...
> 
> When I use the 2.4.22 kernel (compiled with the same options in .config-file), the
> command "mount /dev/sda1 /mnt/flash" works fine!
> I have tried the same with the 128MB USB Flash Drive (noname). The contents of the /var/log/messages:
> 
> 
> Dec 6 14:49:25 mycomp kernel: hub 1-0:1.0: new USB device on port 2, assigned address 2
> Dec 6 14:49:25 mycomp kernel: Initializing USB Mass Storage driver...
> Dec 6 14:49:26 mycomp kernel: scsi0 : SCSI emulation for USB Mass Storage devices
> Dec 6 14:49:26 mycomp scsi.agent[597]: bogus sysfs  DEVPATH=/devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/ho st0/0:0:0:0
> Dec 6 14:49:26 mycomp kernel: Vendor: Model: USB DISK Pro Rev: 1.09
> Dec 6 14:49:26 mycomp kernel: Type: Direct-Access ANSI SCSI revision: 02
> Dec 6 14:49:26 mycomp kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0, type 0
> Dec 6 14:49:26 mycomp kernel: drivers/usb/core/usb.c: registered new driver usb-storage
> Dec 6 14:49:26 mycomp kernel: USB Mass Storage support registered.
> 
> But when I do the same under 2.4.22, it works also fine! The output in /var/log/messages
> when using 2.4.22:
> 
> Dec 6 12:26:05 mycomp kernel: hub.c: new USB device 00:02.0-2, assigned address 2
> Dec 6 12:26:08 mycomp kernel: Initializing USB Mass Storage driver...
> Dec 6 12:26:08 mycomp kernel: usb.c: registered new driver usb-storage
> Dec 6 12:26:08 mycomp kernel: scsi0 : SCSI emulation for USB Mass Storage devices
> Dec 6 12:26:08 mycomp kernel: USB Mass Storage support registered.
> Dec 6 12:29:30 mycomp kernel: sda: sda1
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> --------------------------------------------------
> 
> USB Mass Storage, kernel 2.6.0-test11, mount
> 
> [4.] Kernel version (from /proc/version):
> -----------------------------------------
> 
> Linux version 2.6.0-test11 (gcc version 3.2.3)
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information 
>      resolved (see Documentation/oops-tracing.txt)
> -----------------------------------------------------------------------
> 
> No Oops.. message
> 
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> ---------------------------------------------------------------
> 
> Not possible :)
> 
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
> -------------------------------------------------------------
> 
> Linux Yozhikbook 2.6.0-test11 #9 Sat Dec 6 14:43:41 CET 2003 i686 unknown unknown GNU/Linux
> 
> Gnu C                  3.2.3
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> module-init-tools      0.9.14
> e2fsprogs              1.34
> pcmcia-cs              3.2.5
> PPP                    2.4.1
> nfs-utils              1.0.6
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Linux C++ Library      5.0.3
> Procps                 2.0.16
> Net-tools              1.60
> Kbd                    1.08
> Sh-utils               5.0
> Modules Loaded         usb_storage radeon snd_pcm_oss snd_mixer_oss uhci_hcd ohci_hcd ehci_hcd usbcore
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> --------------------------------------------------
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz
> stepping        : 4
> cpu MHz         : 1699.976
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat p
> se36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 3342.33
> 
> [7.3.] Module information (from /proc/modules):
> -----------------------------------------------
> 
> usb_storage 26368 0 - Live 0xd0914000
> radeon 117400 2 - Live 0xd0937000
> snd_pcm_oss 51844 0 - Live 0xd0906000
> snd_mixer_oss 19072 1 snd_pcm_oss, Live 0xd08b5000
> uhci_hcd 30344 0 - Live 0xd08ed000
> ohci_hcd 17664 0 - Live 0xd08c2000
> ehci_hcd 23552 0 - Live 0xd08bb000
> usbcore 105684 6 usb_storage,uhci_hcd,ohci_hcd,ehci_hcd, Live 0xd08d2000
> 
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> --------------------------------------------------------------------------
> 
> bash-2.05b# cat ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 1000-10ff : 0000:00:06.0
>   1000-10ff : ALI 5451
> 1400-14ff : 0000:00:08.0
> 1800-180f : 0000:00:10.0
>   1800-1807 : ide0
>   1808-180f : ide1
> 1c00-1cff : 0000:00:12.0
>   1c00-1cff : eth0
> 4000-40ff : PCI CardBus #02
> 4400-44ff : PCI CardBus #02
> 4800-48ff : PCI CardBus #06
> 4c00-4cff : PCI CardBus #06
> 8000-803f : 0000:00:11.0
> 8040-805f : 0000:00:11.0
> 9000-9fff : PCI Bus #01
>   9000-90ff : 0000:01:00.0
> 
> bash-2.05b# cat iomem  
> 00000000-0009f7ff : System RAM
> 0009f800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000cf000-000cffff : Extension ROM
> 000e0000-000effff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-0feeffff : System RAM
>   00100000-0039665c : Kernel code
>   0039665d-004be57f : Kernel data
> 0fef0000-0fefefff : ACPI Tables
> 0feff000-0fefffff : ACPI Non-volatile Storage
> 0ff00000-0fffffff : reserved
> 10000000-10000fff : 0000:00:0a.0
>   10000000-10000fff : yenta_socket
> 10001000-10001fff : 0000:00:0a.1
>   10001000-10001fff : yenta_socket
> 10400000-107fffff : PCI CardBus #02
> 10800000-10bfffff : PCI CardBus #02
> 10c00000-10ffffff : PCI CardBus #06
> 11000000-113fffff : PCI CardBus #06
> e0000000-e0000fff : 0000:00:02.0
>   e0000000-e0000fff : ohci_hcd
> e0001000-e0001fff : 0000:00:06.0
> e0002000-e0002fff : 0000:00:08.0
> e0003000-e00037ff : 0000:00:0c.0
>   e0003000-e00037ff : ohci1394
> e0004000-e0007fff : 0000:00:0c.0
> e0008000-e0008fff : 0000:00:12.0
>   e0008000-e0008fff : eth0
> e0100000-e01fffff : PCI Bus #01
>   e0100000-e010ffff : 0000:01:00.0
> e8000000-efffffff : PCI Bus #01
>   e8000000-efffffff : 0000:01:00.0
> f0000000-f7ffffff : 0000:00:00.0
> fffc0000-ffffffff : reserved
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> ---------------------------------------------
> 
> 00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge [AGP4X,PCI and SDR/DDR] (rev 02)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 0
> 	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
> 	Capabilities: [b0] AGP version 2.0
> 		Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
> 	Capabilities: [a4] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 00009000-00009fff
> 	Memory behind bridge: e0100000-e01fffff
> 	Prefetchable memory behind bridge: e8000000-efffffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (20000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
> 	Latency: 64 (500ns min, 6000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at 1000 [size=256]
> 	Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [a0] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 [Generic])
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at e0002000 (32-bit, non-prefetchable) [disabled] [size=4K]
> 	Region 1: I/O ports at 1400 [disabled] [size=256]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0a.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 20
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
> 	Memory window 0: 10400000-107ff000 (prefetchable)
> 	Memory window 1: 10800000-10bff000
> 	I/O window 0: 00004000-000040ff
> 	I/O window 1: 00004400-000044ff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:0a.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 20
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
> 	Memory window 0: 10c00000-10fff000 (prefetchable)
> 	Memory window 1: 11000000-113ff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min, 1000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at e0003000 (32-bit, non-prefetchable) [size=2K]
> 	Region 1: Memory at e0004000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> 
> 00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if b0)
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 1000ns max)
> 	Interrupt: pin A routed to IRQ 0
> 	Region 4: I/O ports at 1800 [size=16]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.0 Bridge: ALi Corporation M7101 PMU
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
> 	Subsystem: Unknown device 3c08:a400
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 90 (2750ns min, 13000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 1c00 [size=256]
> 	Region 1: Memory at e0008000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
> 	Subsystem: Hewlett-Packard Company: Unknown device 0025
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 66 (2000ns min), cache line size 08
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
> 	Region 1: I/O ports at 9000 [size=256]
> 	Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=64K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [58] AGP version 2.0
> 		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
> 		Command: RQ=28 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> ----------------------------------------------
> 
> Attached devices:
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor:          Model: USB DISK Pro     Rev: 1.09
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> 
> Note: USB Flash inserted, HP Photosmart not inserted
> 
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> -----------------------------------------------------------------
> 
> bash-2.05b# ls -lR /proc/scsi
> /proc/scsi:
> total 0
> -r--r--r--    1 root     root            0 2003-12-07 00:27 device_info
> -r--r--r--    1 root     root            0 2003-12-07 00:27 scsi
> dr-xr-xr-x    2 root     root            0 2003-12-07 00:27 sg
> dr-xr-xr-x    2 root     root            0 2003-12-07 00:27 usb-storage
> 
> /proc/scsi/sg:
> total 0
> -rw-r--r--    1 root     root            0 2003-12-07 00:27 allow_dio
> -r--r--r--    1 root     root            0 2003-12-07 00:27 debug
> -rw-r--r--    1 root     root            0 2003-12-07 00:27 def_reserved_size
> -r--r--r--    1 root     root            0 2003-12-07 00:27 device_hdr
> -r--r--r--    1 root     root            0 2003-12-07 00:27 device_strs
> -r--r--r--    1 root     root            0 2003-12-07 00:27 devices
> -r--r--r--    1 root     root            0 2003-12-07 00:27 version
> 
> /proc/scsi/usb-storage:
> total 0
> -rw-r--r--    1 root     root            0 2003-12-07 00:27 2
> 
> 
> bash-2.05b# cat /proc/scsi/usb-storage/2
>    Host scsi2: usb-storage
>        Vendor:         
>       Product: USB DISK Pro
> Serial Number: 073B1C3000A4
>      Protocol: Transparent SCSI
>     Transport: Bulk
>        Quirks:
> 
> [X.] Other notes, patches, fixes, workarounds:
> ----------------------------------------------
> I have no patches applied to the compiled kernel.
> PCMCIA-cards (FAT file system) work fine! I can successfully mount these cards with
> mount -t vfat /dev/hde1 /mnt/pcmcia
> 
> Best regards,
> Pavel Alexeev
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer

