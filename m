Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbTHUEYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbTHUEYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:24:55 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:17260 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262396AbTHUEYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:24:40 -0400
Message-ID: <3F444A07.40009@sbcglobal.net>
Date: Wed, 20 Aug 2003 23:26:47 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp
References: <3F440387.5090902@sbcglobal.net> <20030820223344.GA10163@neo.rr.com>
In-Reply-To: <20030820223344.GA10163@neo.rr.com>
Content-Type: multipart/mixed;
 boundary="------------060204010007060909080408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204010007060909080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adam Belay wrote:

>On Wed, Aug 20, 2003 at 06:25:59PM -0500, Wes Janzen wrote:
>  
>
>>So sad...  Ever since I started with kernel 2.5.69, the kernel has been
>>properly reserving IRQ 5 for ISA, as set in my BIOS.
>>    
>>
>
>The reserve IRQ feature in your BIOS should not effect the linux kernel.
>It is strictly internal to your BIOS.  Therefore if linux assigns
>resources it probably won't reserve irq 5.  This problem may be the
>result of a change in the way linux assigns resources.
>  
>
Well, as odd as this may be, for versions 2.5.69 thru 2.6.0-test3-mm2, 
adjusting my BIOS changed how the IRQs were allocated.  Apparently 
something was using that information, whether that is supposed to happen 
or not.  In the BIOS I used the "set resources manually" to reserve 7 
and 5 for ISA...and it made a difference with 2.5.69 thru 
2.6.0-test3-mm2.  I haven't tried setting it back to auto, but I suspect 
it has no effect anymore as you state.

i.e., with my BIOS set to auto configure resources, 2.5.69 thru 
2.6.0-test3-mm2 would allocate IRQ's in much the same way 
2.6.0-test3-mm3 is right now even with my BIOS settings set manually ;-)
Well, I can't say that for sure, because I can only tell how the IRQ's 
are allocated for my two PDC20269 cards, the PCI USB 2.0 card, and the 1 
onboard IDE I have enabled on my MVP3...  The screen scrolled too fast 
to figure out what the NIC is using and it's clearly locked since I 
can't scroll up.  Seems odd it doesn't complain about the conflict and 
tries to share an interrupt with an ISA device...  I know it complained 
at least with 2.5.69 when I tried loading the module before changing my 
BIOS settings.

So, I'll give you those I know until I'm able to re-compile:

IRQ                 DEVICE
___________________________
  5                    PDC20269#1
  7                    Parport
  9                    OHCI HCD
 10                   EHCI HCD & PDC20269#2
 14                   VIA IDE#1 

>  
>
>>Unfortunately for me, it looks like 2.6.0-test3-mm3 is like 2.4.18 and
>>    
>>
>
>In what kernel version did you first see this problem?
>
Well ;-)  I thought I inferred 2.6.0-test3-mm3 well enough...
I guess I left out the part about 2.5.69 thru 2.6.0-test3-mm2 working.  
I must have removed that part, sorry!

>>ignores my BIOS settings, so it locks up trying to ativate my SB16 on
>>boot (since IRQ 5 is used for IDE).  Oddly it doesn't spit out any
>>warnings, just locks up after "pnp: Device 00:01.03 activated".
>>    
>>
>
>I'd imagine this is the result of the resource conflict, presumably with
>your ide controller.  More information would be needed.  I'd like to see
>/proc/interrupts, dmesg, and lspci -vv (when the sb driver is not loaded).
>
I tend to agree, that's always been the conflict before.  The PCI 
devices use up all the IRQ's and then I can't get the SB16 on one it 
likes.  I think it uses 10 or 12 in WinXP, but I'm not interested enough 
to confirm which.  I know that the ALSA driver doesn't support those 
IRQs though. 

These are from 2.6.0-test3-mm2, I have to recompile because snd-sb16 
isn't compiled as a module.  With a K6-2 and GCC 3.3, that's going to 
take a little bit.  Besides, once I attach my boot.msg log, this is 
going to be big.  Concerning my boot log, because I have USB verbose 
enabled, the first part of the boot mesg has been deleted.  You're 
probably more interested in those ACPI messages at the top... which are 
not there, but I've included it anyway.

 >cat /proc/interrupts:
           CPU0
  0:   12297914          XT-PIC  timer
  1:       1773          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      11072          XT-PIC  SoundBlaster
  7:          2          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:      29564          XT-PIC  acpi, ohci-hcd, eth0
 10:         72          XT-PIC  ohci-hcd
 11:    1495725          XT-PIC  ide2, ide3, ehci_hcd, radeon@PCI:1:0:0
 12:       1068          XT-PIC  ide4, ide5
 14:         13          XT-PIC  ide0
NMI:          0
ERR:          0

 >lspci -vv:

rybBIT:/home/sprchkn # lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at b400 [size=16]
 
00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10) 
(prog-if 00 [Normal decode])
        !!! Invalid class 0604 for header type 00
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
 
00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 2: I/O ports at c000 [size=8]
        Region 3: I/O ports at c400 [size=4]
        Region 4: I/O ports at c800 [size=16]
        Region 5: Memory at f5000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at f2000000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at dc00 [size=16]
        Region 5: Memory at f5004000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at f3000000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1799:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f500a000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1799:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at f5008000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.2 USB Controller: NEC Corporation USB Enhanced Host Controller 
(rev 04) (prog-if 20)
        Subsystem: Unknown device 1799:0002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 08
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at f5009000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e000 [size=64]
        Expansion ROM at f4000000 [disabled] [size=64K]
 
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 
4966 (rev 01) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4f72
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at f1000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at f0000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=7 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.1 Display controller: ATI Technologies Inc: Unknown device 496e 
(rev 01)
        Subsystem: ATI Technologies Inc: Unknown device 4f73
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at ec000000 (32-bit, prefetchable) [disabled] 
[size=64M]
        Region 1: Memory at f1010000 (32-bit, non-prefetchable) 
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


>Also, are you using acpi?  If so, try the kernel parameter pci=noacpi and
>also try disabling acpi completely.
>
Already tried pci=noacpi, I'll go first with the ALSA driver as a module 
and then pci=noacpi, then I'll disable ACPI, re-compile and post that too.

>
>Thanks,
>Adam
>

Thanks, I'll send more when I have it.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

--------------060204010007060909080408
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Inspecting /boot/System.map-2.6.0-test3-mm2
Loaded 28002 symbols from /boot/System.map-2.6.0-test3-mm2.
Symbols match kernel version 2.6.0.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
<4>hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>PDC20269: IDE controller at PCI slot 0000:00:08.0
<6>PDC20269: chipset revision 2
<6>PDC20269: ROM enabled at 0xf2000000
<6>PDC20269: 100%% native mode on irq 11
<6>    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
<6>    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
<4>hde: Maxtor 6Y060L0, ATA DISK drive
<4>ide2 at 0xb800-0xb807,0xbc02 on irq 11
<4>hdg: AOpen Inc. DVD-ROM DVD-1640 PRO 0122, ATAPI CD/DVD-ROM drive
<4>ide3 at 0xc000-0xc007,0xc402 on irq 11
<6>PDC20269: IDE controller at PCI slot 0000:00:09.0
<6>PDC20269: chipset revision 2
<6>PDC20269: ROM enabled at 0xf3000000
<6>PDC20269: 100%% native mode on irq 12
<6>    ide4: BM-DMA at 0xdc00-0xdc07, BIOS settings: hdi:pio, hdj:pio
<6>    ide5: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdk:pio, hdl:pio
<4>hdi: Maxtor 92048D8, ATA DISK drive
<4>ide4 at 0xcc00-0xcc07,0xd002 on irq 12
<4>hdk: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
<4>ide5 at 0xd400-0xd407,0xd802 on irq 12
<4>hde: max request size: 128KiB
<6>hde: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
<6> hde: hde1 hde2
<4>hdi: max request size: 128KiB
<6>hdi: 40000464 sectors (20480 MB) w/1024KiB Cache, CHS=39683/16/63, UDMA(33)
<6> hdi: hdi1 hdi2
<4>end_request: I/O error, dev hdg, sector 0
<4>hdg: ATAPI 40X DVD-ROM drive, 512kB Cache
<6>Uniform CD-ROM driver Revision: 3.12
<4>hdk: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache
<4>ide-floppy driver 0.99.newide
<3>hda: No disk in drive
<6>hda: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
<4>Console: switching to colour frame buffer device 160x64
<7>ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
<6>ehci_hcd 0000:00:0a.2: EHCI Host Controller
<7>ehci_hcd 0000:00:0a.2: reset hcs_params 0x2293 dbg=0 cc=2 pcc=2 ports=3
<7>ehci_hcd 0000:00:0a.2: reset portroute 1 0 1 
<7>ehci_hcd 0000:00:0a.2: reset hcc_params e806 thresh 0 uframes 256/512/1024 park
<7>ehci_hcd 0000:00:0a.2: capability 0001 at e8
<6>ehci_hcd 0000:00:0a.2: irq 11, pci mem d982f000
<6>ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
<7>ehci_hcd 0000:00:0a.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset HALT
<7>ehci_hcd 0000:00:0a.2: init command 010b09 park=3 ithresh=1 period=256 RUN
<6>ehci_hcd 0000:00:0a.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
<7>ehci_hcd 0000:00:0a.2: root hub device address 1
<7>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb1: Product: EHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.0-test3-mm2 ehci_hcd
<6>usb usb1: SerialNumber: 0000:00:0a.2
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb1: usb_new_device - registering interface 1-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-0:0: usb_probe_interface
<7>hub 1-0:0: usb_probe_interface - got id
<6>hub 1-0:0: USB hub found
<6>hub 1-0:0: 3 ports detected
<7>hub 1-0:0: standalone hub
<7>hub 1-0:0: individual port power switching
<7>hub 1-0:0: individual port over-current protection
<7>hub 1-0:0: Single TT
<7>hub 1-0:0: TT requires at most 8 FS bit times
<7>hub 1-0:0: Port indicators are not supported
<7>hub 1-0:0: power on to power good time: 0ms
<7>hub 1-0:0: hub controller current requirement: 0mA
<7>hub 1-0:0: local power source is good
<7>hub 1-0:0: no over-current condition exists
<7>hub 1-0:0: enabling power on all ports
<7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<7>ohci-hcd: block sizes: ed 64 td 64
<6>ohci-hcd 0000:00:0a.0: OHCI Host Controller
<6>ohci-hcd 0000:00:0a.0: irq 10, pci mem d9831000
<6>ohci-hcd 0000:00:0a.0: new USB bus registered, assigned bus number 2
<7>ohci-hcd 0000:00:0a.0: reset, control = 0x0
<7>ohci-hcd 0000:00:0a.0: root hub device address 1
<7>usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb2: Product: OHCI Host Controller
<6>usb usb2: Manufacturer: Linux 2.6.0-test3-mm2 ohci-hcd
<6>usb usb2: SerialNumber: 0000:00:0a.0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb2: usb_new_device - registering interface 2-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 2-0:0: usb_probe_interface
<7>hub 2-0:0: usb_probe_interface - got id
<6>hub 2-0:0: USB hub found
<6>hub 2-0:0: 2 ports detected
<7>hub 2-0:0: standalone hub
<7>hub 2-0:0: ganged power switching
<7>hub 2-0:0: global over-current protection
<7>hub 2-0:0: Port indicators are not supported
<7>hub 2-0:0: power on to power good time: 30ms
<7>hub 2-0:0: hub controller current requirement: 0mA
<7>hub 2-0:0: local power source is good
<7>hub 2-0:0: no over-current condition exists
<7>hub 2-0:0: enabling power on all ports
<7>ehci_hcd 0000:00:0a.2: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
<7>hub 1-0:0: port 1, status 501, change 1, 480 Mb/s
<7>ohci-hcd 0000:00:0a.0: created debug files
<7>ohci-hcd 0000:00:0a.0: OHCI controller state
<7>ohci-hcd 0000:00:0a.0: OHCI 1.0, with legacy support registers
<7>ohci-hcd 0000:00:0a.0: control 0x08f HCFS=operational IE PLE CBSR=3
<7>ohci-hcd 0000:00:0a.0: cmdstatus 0x00000 SOC=0
<7>ohci-hcd 0000:00:0a.0: intrstatus 0x00000004 SF
<7>ohci-hcd 0000:00:0a.0: intrenable 0x80000012 MIE UE WDH
<7>ohci-hcd 0000:00:0a.0: hcca frame #00fe
<7>ohci-hcd 0000:00:0a.0: roothub.a 0f000202 POTPGT=15 NPS NDP=2
<7>ohci-hcd 0000:00:0a.0: roothub.b 00000000 PPCM=0000 DR=0000
<7>ohci-hcd 0000:00:0a.0: roothub.status 00000000
<7>ohci-hcd 0000:00:0a.0: roothub.portstatus [0] 0x00000100 PPS
<7>ohci-hcd 0000:00:0a.0: roothub.portstatus [1] 0x00000100 PPS
<6>ohci-hcd 0000:00:0a.1: OHCI Host Controller
<6>ohci-hcd 0000:00:0a.1: irq 9, pci mem d9833000
<6>ohci-hcd 0000:00:0a.1: new USB bus registered, assigned bus number 3
<7>ohci-hcd 0000:00:0a.1: reset, control = 0x0
<7>ohci-hcd 0000:00:0a.1: root hub device address 1
<7>usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb3: Product: OHCI Host Controller
<6>usb usb3: Manufacturer: Linux 2.6.0-test3-mm2 ohci-hcd
<6>usb usb3: SerialNumber: 0000:00:0a.1
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb3: usb_new_device - registering interface 3-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 3-0:0: usb_probe_interface
<7>hub 3-0:0: usb_probe_interface - got id
<6>hub 3-0:0: USB hub found
<6>hub 3-0:0: 1 port detected
<7>hub 3-0:0: standalone hub
<7>hub 3-0:0: ganged power switching
<7>hub 3-0:0: global over-current protection
<7>hub 3-0:0: Port indicators are not supported
<7>hub 3-0:0: power on to power good time: 30ms
<7>hub 3-0:0: hub controller current requirement: 0mA
<7>hub 3-0:0: local power source is good
<7>hub 3-0:0: no over-current condition exists
<7>hub 3-0:0: enabling power on all ports
<6>hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
<7>ehci_hcd 0000:00:0a.2: port 1 low speed --> companion
<7>ohci-hcd 0000:00:0a.1: created debug files
<7>ohci-hcd 0000:00:0a.1: OHCI controller state
<7>ohci-hcd 0000:00:0a.1: OHCI 1.0, with legacy support registers
<7>ohci-hcd 0000:00:0a.1: control 0x08f HCFS=operational IE PLE CBSR=3
<7>ohci-hcd 0000:00:0a.1: cmdstatus 0x00000 SOC=0
<7>ohci-hcd 0000:00:0a.1: intrstatus 0x00000004 SF
<7>ohci-hcd 0000:00:0a.1: intrenable 0x80000012 MIE UE WDH
<7>ohci-hcd 0000:00:0a.1: hcca frame #00f7
<7>ohci-hcd 0000:00:0a.1: roothub.a 0f000201 POTPGT=15 NPS NDP=1
<7>ohci-hcd 0000:00:0a.1: roothub.b 00000000 PPCM=0000 DR=0000
<7>ohci-hcd 0000:00:0a.1: roothub.status 00000000
<7>ohci-hcd 0000:00:0a.1: roothub.portstatus [0] 0x00000100 PPS
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
<6>drivers/usb/core/usb.c: registered new driver hiddev
<6>drivers/usb/core/usb.c: registered new driver hid
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>I2O Core - (C) Copyright 1999 Red Hat Software
<6>I2O: Event thread created as pid 12
<6>i2o: Checking for PCI I2O controllers...
<6>I2O configuration manager v 0.04.
<6>  (C) Copyright 1999 Red Hat Software
<6>I2O Block Storage OSM v0.9
<6>   (c) Copyright 1999-2001 Red Hat Software.
<6>i2o_block: Checking for Boot device...
<6>i2o_block: Checking for I2O Block devices...
<6>Advanced Linux Sound Architecture Driver Version 0.9.6 (Mon Jul 28 11:08:42 2003 UTC).
<7>request_module: failed /sbin/modprobe -- snd-card-0. error = -16
<6>pnp: Device 00:01.00 activated.
<3>sb16: no OPL device at 0x388-0x38a
<6>ALSA device list:
<6>  #0: Sound Blaster 16 at 0x220, irq 5, dma 1&5
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<7>ehci_hcd 0000:00:0a.2: GetStatus port 1 status 003402 POWER OWNER sig=k  CSC
<7>ehci_hcd 0000:00:0a.2: GetStatus port 2 status 001803 POWER sig=j  CSC CONNECT
<7>hub 1-0:0: port 2, status 501, change 1, 480 Mb/s
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<4>ip_conntrack version 2.1 (3071 buckets, 24568 max) - 300 bytes per conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<6>ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
<4>arp_tables: (C) 2002 David S. Miller
<6>hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>IPv6 v0.8 for NET4.0
<6>IPv6 over IPv4 tunneling driver
<4>ip6_tables: (C) 2000-2002 Netfilter core team
<7>ehci_hcd 0000:00:0a.2: port 2 high speed
<7>ehci_hcd 0000:00:0a.2: GetStatus port 2 status 001005 POWER sig=se0  PE CONNECT
<6>hub 1-0:0: new USB device on port 2, assigned address 2
<7>usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
<7>drivers/usb/core/message.c: USB device number 2 default language ID 0x409
<6>usb 1-2: Product: USB2.0 Hub Controller
<6>usb 1-2: Manufacturer: NEC Corporation
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-2: usb_new_device - registering interface 1-2:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-2:0: usb_probe_interface
<7>hub 1-2:0: usb_probe_interface - got id
<6>hub 1-2:0: USB hub found
<6>hub 1-2:0: 4 ports detected
<7>hub 1-2:0: standalone hub
<7>hub 1-2:0: individual port power switching
<7>hub 1-2:0: global over-current protection
<7>hub 1-2:0: Single TT
<7>hub 1-2:0: TT requires at most 16 FS bit times
<7>hub 1-2:0: Port indicators are  supported
<7>hub 1-2:0: power on to power good time: 0ms
<7>hub 1-2:0: hub controller current requirement: 100mA
<7>hub 1-2:0: local power source is good
<7>hub 1-2:0: no over-current condition exists
<7>drivers/usb/host/ehci-sched.c: scheduled qh d7cd8100 usecs 7/0 period 256.0 starting 255.0 (gap 0)
<7>hub 1-2:0: enabling power on all ports
<7>ehci_hcd 0000:00:0a.2: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
<7>hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
<7>registering ipv6 mark target
<6>BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
<4>found reiserfs format "3.6" with standard journal
<6>hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
<7>ehci_hcd 0000:00:0a.2: port 3 full speed --> companion
<7>ehci_hcd 0000:00:0a.2: GetStatus port 3 status 003801 POWER OWNER sig=j  CONNECT
<7>hub 1-2:0: port 1, status 301, change 1, 1.5 Mb/s
<6>hub 1-2:0: debounce: port 1: delay 100ms stable 4 status 0x301
<6>hub 1-2:0: new USB device on port 1, assigned address 3
<7>usb 1-2.1: new device strings: Mfr=1, Product=2, SerialNumber=0
<7>drivers/usb/core/message.c: USB device number 3 default language ID 0x409
<6>usb 1-2.1: Product: USB Receiver
<6>usb 1-2.1: Manufacturer: Logitech
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-2.1: usb_new_device - registering interface 1-2.1:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hid 1-2.1:0: usb_probe_interface
<7>hid 1-2.1:0: usb_probe_interface - got id
<6>input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:0a.2-2.1
<7>hub 1-2:0: port 2, status 101, change 1, 12 Mb/s
<6>hub 1-2:0: debounce: port 2: delay 100ms stable 4 status 0x101
<7>hub 1-2:0: port 2 not reset yet, waiting 10ms
<6>hub 1-2:0: new USB device on port 2, assigned address 4
<4>drivers/usb/core/message.c: usb_control/bulk_msg: timeout
<7>usb 1-2.2: new device strings: Mfr=0, Product=0, SerialNumber=0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-2.2: usb_new_device - registering interface 1-2.2:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-2:0: port 3, status 301, change 1, 1.5 Mb/s
<6>hub 1-2:0: debounce: port 3: delay 100ms stable 4 status 0x301
<4>Reiserfs journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<4>reiserfs: checking transaction log (hde1) for (hde1)
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 168k freed
<6>hub 1-2:0: new USB device on port 3, assigned address 5
<7>usb 1-2.3: new device strings: Mfr=3, Product=1, SerialNumber=2
<7>drivers/usb/core/message.c: USB device number 5 default language ID 0x409
<6>usb 1-2.3: Product: Back-UPS ES 350 FW:800.e3.D USB FW:e3
<6>usb 1-2.3: Manufacturer: APC
<6>usb 1-2.3: SerialNumber: AB0233345257  
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-2.3: usb_new_device - registering interface 1-2.3:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hid 1-2.3:0: usb_probe_interface
<7>hid 1-2.3:0: usb_probe_interface - got id
<7>drivers/usb/core/file.c: looking for a minor, starting at 0
<6>hiddev0: USB HID v1.10 Device [APC Back-UPS ES 350 FW:800.e3.D USB FW:e3] on usb-0000:00:0a.2-2.3
<7>hub 1-2:0: port 4, status 101, change 1, 12 Mb/s
<6>hub 1-2:0: debounce: port 4: delay 100ms stable 4 status 0x101
<7>hub 1-2:0: port 4 not reset yet, waiting 10ms
<6>hub 1-2:0: new USB device on port 4, assigned address 6
<7>usb 1-2.4: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>Adding 1052216k swap on /dev/hdi1.  Priority:42 extents:1
<7>drivers/usb/core/message.c: USB device number 6 default language ID 0x409
<6>usb 1-2.4: Product: Perfection636
<6>usb 1-2.4: Manufacturer: EPSON
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-2.4: usb_new_device - registering interface 1-2.4:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>ohci-hcd 0000:00:0a.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
<7>hub 2-0:0: port 1, status 301, change 1, 1.5 Mb/s
<6>hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
<7>ohci-hcd 0000:00:0a.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
<6>hub 2-0:0: new USB device on port 1, assigned address 2
<7>usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
<3>drivers/usb/core/message.c: string descriptor 0 too short
<3>drivers/usb/core/message.c: string descriptor 0 too short
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 2-1: usb_new_device - registering interface 2-1:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>ohci-hcd 0000:00:0a.0: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
<7>hub 2-0:0: port 2, status 101, change 1, 12 Mb/s
<6>hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
<7>ohci-hcd 0000:00:0a.0: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
<6>hub 2-0:0: new USB device on port 2, assigned address 3
<7>usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=3
<7>drivers/usb/core/message.c: USB device number 3 default language ID 0x409
<6>usb 2-2: SerialNumber: BROC3J288841
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 2-2: usb_new_device - registering interface 2-2:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 2-2: usb_new_device - registering interface 2-2:1
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 2-2: usb_new_device - registering interface 2-2:2
<7>drivers/usb/core/usb.c: usb_hotplug
<7>ehci_hcd 0000:00:0a.2: GetStatus port 1 status 003402 POWER OWNER sig=k  CSC
<7>hub 1-0:0: port 1, status 0, change 1, 12 Mb/s
<7>ehci_hcd 0000:00:0a.2: GetStatus port 3 status 003802 POWER OWNER sig=j  CSC
<7>hub 1-0:0: port 3, status 0, change 1, 12 Mb/s
<6>Disabled Privacy Extensions on device c0418580(lo)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------060204010007060909080408--

