Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbTHUJ4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTHUJ4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:56:02 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:18620 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262537AbTHUJzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:55:02 -0400
Message-ID: <3F44977A.6050705@sbcglobal.net>
Date: Thu, 21 Aug 2003 04:57:14 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp (2.6.0-test3-mm3 <sigh>)
References: <3F440387.5090902@sbcglobal.net> <20030820223344.GA10163@neo.rr.com>
In-Reply-To: <20030820223344.GA10163@neo.rr.com>
Content-Type: multipart/mixed;
 boundary="------------030208000201090003030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208000201090003030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi again!

OK, finally managed to boot, though I had to disable USB and ISAPNP to 
do that.  I couldn't get it to work until I disabled ISA PNP in the 
build menu. 

Even without ISAPNP I had trouble.  I tried nousb on its own, which did 
not work.  I had to use both pci=noacpi, nolapic, noapic and nousb.  Now 
I don't know if I HAD to use the apic ones, but it probably doesn't 
matter since my box isn't capable anyway.  I just wanted it to boot 
because it takes a while for those Promise cards to detect the drives. 

Finally it would boot, but then I lose a lot without usb.  Oddly, IRQ 5 
is freed with both nousb AND pci=noacpi.  That was not the case with 
just pci=noacpi or just nousb.  But then maybe that isn't so odd since 
the USB card sucks up 3 irqs.  With just pci=noacpi I made it several 
lines farther.  Instead of "mice: PS/2 mouse device...", I got to see 
"hub 1-0:0: new USB device on port2, assigned address 2", which was 
proceeded by some ACPI message that also said something (IIRC) about 
states S4 and S5.  Usually it only says something about C1 and C2.

Anyway, for what it's worth, here's cat /proc/interrupts:
           CPU0      
  0:     199807          XT-PIC  timer
  1:        822          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:          7          XT-PIC  acpi, eth0
 11:       7631          XT-PIC  ide2, ide3
 12:         70          XT-PIC  ide4, ide5
 14:          1          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

I've attached lspic -vv and boot.msg this time rather than include them in.

Sure would be nice to get mm3 working with those reiserfs fixes...I 
guess I'll just hand patch for now.  Sure beats the rebuild-tree I have 
to do every 5 days or so ;-)

Thanks,

Wes



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
>
>>Unfortunately for me, it looks like 2.6.0-test3-mm3 is like 2.4.18 and
>>    
>>
>
>In what kernel version did you first see this problem?
>
>  
>
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
>Also, are you using acpi?  If so, try the kernel parameter pci=noacpi and
>also try disabling acpi completely.
>
>Thanks,
>Adam
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

--------------030208000201090003030504
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Inspecting /boot/System.map-2.6.0-test3-mm3
Loaded 24363 symbols from /boot/System.map-2.6.0-test3-mm3.
Symbols match kernel version 2.6.0.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.0-test3-mm3 (sprchkn@rybBIT) (gcc version 3.3.1) #11 Thu Aug 21 02:23:58 CDT 2003
<4>Video mode to be used for restore is 31b
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
<4> BIOS-e820: 0000000017ff0000 - 0000000017ff0800 (ACPI NVS)
<4> BIOS-e820: 0000000017ff0800 - 0000000018000000 (ACPI data)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<6>user-defined physical RAM map:
<4> user: 0000000000000000 - 00000000000a0000 (usable)
<4> user: 00000000000f0000 - 0000000000100000 (reserved)
<4> user: 0000000000100000 - 0000000017ff0000 (usable)
<4> user: 0000000017ff0000 - 0000000017ff0800 (ACPI NVS)
<4> user: 0000000017ff0800 - 0000000018000000 (ACPI data)
<4> user: 00000000ffff0000 - 0000000100000000 (reserved)
<5>383MB LOWMEM available.
<4>On node 0 totalpages: 98288
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 94192 pages, LIFO batch:16
<4>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI 2.1 present.
<6>ACPI: RSDP (v000 FIC                                       ) @ 0x000f81e0
<6>ACPI: RSDT (v001 FIC    PA2013   0x42302e31 AWRD 0x00000000) @ 0x17ff0800
<6>ACPI: FADT (v001 FIC    PA2013   0x42302e31 AWRD 0x00000000) @ 0x17ff0840
<6>ACPI: DSDT (v001 FIC    AWRDACPI 0x00001000 MSFT 0x01000004) @ 0x00000000
<4>ACPI: MADT not present
<4>Building zonelist for node : 0
<4>Kernel command line: root=/dev/hde1 ide0=autotune ide1=autotune ide2=autotune ide3=autotune ide4=autotune ide5=autotune parport=0x378,7,3 vga=0x31B video=vesafb:ywrap cachesize=1024 pci=noacpi nolapic noapic debug nousb mem=393152K
<6>ide_setup: ide0=autotune
<6>ide_setup: ide1=autotune
<6>ide_setup: ide2=autotune
<6>ide_setup: ide3=autotune
<6>ide_setup: ide4=autotune
<6>ide_setup: ide5=autotune
<4>current: c032d9c0
<4>current->thread_info: c03a8000
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order 11: 16384 bytes)
<4>Detected 400.885 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 790.52 BogoMIPS
<6>Memory: 385360k/393152k available (1936k kernel code, 7040k reserved, 777k data, 156k init, 0k highmem)
<4>zapping low mappings.
<6>Security Scaffold v1.0.0 initialized
<6>Capability LSM initialized
<6>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>-> /dev
<6>-> /dev/console
<6>-> /root
<7>CPU:     After generic identify, caps: 008001bf 808009bf 00000000 00000000
<7>CPU:     After vendor identify, caps: 008001bf 808009bf 00000000 00000000
<6>CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
<7>CPU:     After all inits, caps: 008001bf 808009bf 00000000 00000000
<4>CPU: AMD-K6(tm) 3D processor stepping 00
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<7>PM: Adding info for No Bus:legacy
<4>Initializing RT netlink socket
<6>PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=2
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
<6>ACPI: Subsystem revision 20030813
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>PM: Adding info for No Bus:pci0000:00
<3>PCI: 0000:00:07.3: class 604 doesn't match header type 00. Ignoring class.
<7>PM: Adding info for pci:0000:00:00.0
<7>PM: Adding info for pci:0000:00:01.0
<7>PM: Adding info for pci:0000:00:07.0
<7>PM: Adding info for pci:0000:00:07.1
<7>PM: Adding info for pci:0000:00:07.3
<7>PM: Adding info for pci:0000:00:08.0
<7>PM: Adding info for pci:0000:00:09.0
<7>PM: Adding info for pci:0000:00:0a.0
<7>PM: Adding info for pci:0000:00:0a.1
<7>PM: Adding info for pci:0000:00:0a.2
<7>PM: Adding info for pci:0000:00:0b.0
<7>PM: Adding info for pci:0000:01:00.0
<7>PM: Adding info for pci:0000:01:00.1
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>drivers/usb/core/usb.c: USB support disabled
<4>
<4>PCI: Probing PCI hardware
<6>PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0
<4>PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
<6>PCI: Found IRQ 11 for device 0000:00:0a.0
<4>PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
<4>PCI: IRQ 0 for device 0000:00:0a.2 doesn't match PIRQ mask - try pci=usepirqmask
<6>PCI: Found IRQ 9 for device 0000:00:0a.2
<6>IRQ routing conflict for 0000:00:08.0, have irq 11, want irq 9
<6>vesafb: framebuffer at 0xe8000000, mapped to 0xd8808000, size 16384k
<6>vesafb: mode is 1280x1024x24, linelength=3840, pages=16
<6>vesafb: protected mode interface info at c000:5604
<6>vesafb: pmi: set display start = c00c5698, set palette = c00c56e4
<6>vesafb: pmi: ports = 9010 9016 9054 9038 903c 905c 9000 9004 90b0 90b2 90b4 
<6>vesafb: scrolling: ywrap using protected mode interface, yres_virtual=4369
<6>vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
<6>fb0: VESA VGA frame buffer device
<4>Console: switching to colour frame buffer device 160x64
<4>pty: 256 Unix98 ptys configured
<6>Machine check exception polling timer started.
<6>Initializing Cryptographic API
<6>Activating ISA DMA hang workarounds.
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Processor [CPU0] (supports C1 C2)
<7>PM: Adding info for No Bus:pnp0
<6>isapnp: Scanning for PnP cards...
<7>PM: Adding info for No Bus:00:01
<6>pnp: SB audio device quirk - increasing port range
<7>PM: Adding info for pnp:00:01.00
<7>PM: Adding info for pnp:00:01.01
<7>PM: Adding info for pnp:00:01.02
<7>PM: Adding info for pnp:00:01.03
<6>isapnp: Card 'Creative SB16 PnP'
<6>isapnp: 1 Plug & Play card detected total
<7>request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
<6>lp: driver loaded but no devices found
<6>Real Time Clock Driver v1.11a
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
<6>parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
<7>parport0: cpp_daisy: aa5500ff(18)
<7>parport0: assign_addrs: aa5500ff(18)
<6>parport0: Printer, EPSON Stylus COLOR 1520
<6>lp0: using parport0 (interrupt-driven).
<6>PCI: Assigned IRQ 9 for device 0000:00:0b.0
<6>PCI: Sharing IRQ 9 with 0000:00:0a.1
<4>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
<6>0000:00:0b.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xe000. Vers LK1.1.19
<4>eth0: Dropping NETIF_F_SG since no checksum feature.
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>VP_IDE: IDE controller at PCI slot 0000:00:07.1
<6>VP_IDE: chipset revision 6
<6>VP_IDE: not 100%% native mode: will probe irqs later
<6>VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci0000:00:07.1
<6>    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
<4>hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
<7>PM: Adding info for No Bus:ide0
<4>Using anticipatory scheduling elevator
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<7>PM: Adding info for ide:0.0
<6>PDC20269: IDE controller at PCI slot 0000:00:08.0
<6>PCI: Found IRQ 9 for device 0000:00:08.0
<6>IRQ routing conflict for 0000:00:08.0, have irq 11, want irq 9
<6>PCI: Sharing IRQ 9 with 0000:00:0a.2
<6>PDC20269: chipset revision 2
<6>PDC20269: ROM enabled at 0xf2000000
<6>PDC20269: 100%% native mode on irq 11
<6>    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
<6>    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
<4>hde: Maxtor 6Y060L0, ATA DISK drive
<7>PM: Adding info for No Bus:ide2
<4>ide2 at 0xb800-0xb807,0xbc02 on irq 11
<7>PM: Adding info for ide:2.0
<4>hdg: AOpen Inc. DVD-ROM DVD-1640 PRO 0122, ATAPI CD/DVD-ROM drive
<7>PM: Adding info for No Bus:ide3
<4>ide3 at 0xc000-0xc007,0xc402 on irq 11
<7>PM: Adding info for ide:3.0
<6>PDC20269: IDE controller at PCI slot 0000:00:09.0
<6>PCI: Found IRQ 12 for device 0000:00:09.0
<6>PDC20269: chipset revision 2
<6>PDC20269: ROM enabled at 0xf3000000
<6>PDC20269: 100%% native mode on irq 12
<6>    ide4: BM-DMA at 0xdc00-0xdc07, BIOS settings: hdi:pio, hdj:pio
<6>    ide5: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdk:pio, hdl:pio
<4>hdi: Maxtor 92048D8, ATA DISK drive
<7>PM: Adding info for No Bus:ide4
<4>ide4 at 0xcc00-0xcc07,0xd002 on irq 12
<7>PM: Adding info for ide:4.0
<4>hdk: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
<7>PM: Adding info for No Bus:ide5
<4>ide5 at 0xd400-0xd407,0xd802 on irq 12
<7>PM: Adding info for ide:5.0
<4>hde: max request size: 128KiB
<6>hde: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
<6> hde: hde1 hde2
<4>hdi: max request size: 128KiB
<6>hdi: 40000464 sectors (20480 MB) w/1024KiB Cache, CHS=39683/16/63, UDMA(33)
<6> hdi: hdi1 hdi2
<4>Console: switching to colour frame buffer device 160x64
<7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<6>mice: PS/2 mouse device common for all mice
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Advanced Linux Sound Architecture Driver Version 0.9.6 (Mon Jul 28 11:08:42 2003 UTC).
<7>request_module: failed /sbin/modprobe -- snd-card-0. error = -16
<6>ALSA device list:
<6>  No soundcards found.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>ACPI: (supports S0 S1 S4bios S5)
<4>found reiserfs format "3.6" with standard journal
<4>Reiserfs journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<4>reiserfs: checking transaction log (hde1) for (hde1)
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 156k freed
<6>Adding 1052216k swap on /dev/hdi1.  Priority:42 extents:1
<6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------030208000201090003030504
Content-Type: text/plain;
 name="lspivv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspivv.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f0000000-f1ffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at b400 [size=16]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10) (prog-if 00 [Normal decode])
	!!! Invalid class 0604 for header type 00
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
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
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
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
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1799:0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f500a000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1799:0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at f5008000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.2 USB Controller: NEC Corporation USB Enhanced Host Controller (rev 04) (prog-if 20)
	Subsystem: Unknown device 1799:0002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at f5009000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e000 [size=64]
	Expansion ROM at f4000000 [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4966 (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 4f72
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f1000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at f0000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc: Unknown device 496e (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 4f73
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at ec000000 (32-bit, prefetchable) [disabled] [size=64M]
	Region 1: Memory at f1010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------030208000201090003030504--

