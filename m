Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319644AbSH3Skt>; Fri, 30 Aug 2002 14:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSH3Skt>; Fri, 30 Aug 2002 14:40:49 -0400
Received: from imo-d10.mx.aol.com ([205.188.157.42]:40383 "EHLO
	imo-d10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S319644AbSH3Sk3>; Fri, 30 Aug 2002 14:40:29 -0400
Message-ID: <3D6F859C.8010302@netscape.net>
Date: Fri, 30 Aug 2002 14:47:56 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 port PnP BIOS to the driver model RESEND #1
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com> <3D6BF1E6.9010701@netscape.net> <20020828051406.GA26263@kroah.com> <3D6E85B1.4040708@netscape.net> <20020830052823.GE6486@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



greg@kroah.com wrote

>
>i386, with PnP BIOS support turned off :)
>
>I haven't tried enabling this before, what kind of devices does it
>enable?
>
It mainly controls system devices that aren't shown by the currently 
supported buses.  These include devices ranging from the pc speaker to 
the monitor.  I encourage you to try it out.  It allows the user to 
change the resources used by these devices and provides information for 
drivers.  It also can be used to enable devices that were disabled by 
the BIOS.  Here's a list of supported devices.  I hope to incorporate 
this list into the pnpbios driver in the future.

ID range    Category
--------        -------------
PNP0xxx     System devices
PNP8xxx            Network adapters
PNPAxxx     SCSI, proprietary CD adapters
PNPBxxx     Sound, video capture, multimedia
PNPCxxx - Dxxx    Modems

The following device ID is provided only for compatibility
with earlier device ID lists:

Device ID    Description
--------        -------------
PNP0802            Microsoft Sound System-compatible device
                (obsolete; use PNPB0xx instead)

---------------------------------------------------------------------------
Device ID       Description
--------        -------------
***** System Devices - PNP0xxx **************************
--Interrupt Controllers--
PNP0000         AT Interrupt Controller
PNP0001         EISA Interrupt Controller
PNP0002         MCA Interrupt Controller
PNP0003         APIC
PNP0004         Cyrix SLiC MP interrupt controller

--Timers--
PNP0100         AT Timer
PNP0101         EISA Timer
PNP0102         MCA Timer

--DMA--
PNP0200         AT DMA Controller
PNP0201         EISA DMA Controller
PNP0202         MCA DMA Controller

--Keyboards--
PNP0300         IBM PC/XT keyboard controller (83-key)
PNP0301         IBM PC/AT keyboard controller (86-key)
PNP0302         IBM PC/XT keyboard controller (84-key)
PNP0303         IBM Enhanced (101/102-key, PS/2 mouse support)
PNP0304         Olivetti Keyboard (83-key)
PNP0305         Olivetti Keyboard (102-key)
PNP0306         Olivetti Keyboard (86-key)
PNP0307         Microsoft Windows(R) Keyboard
PNP0308         General Input Device Emulation Interface (GIDEI) legacy
PNP0309         Olivetti Keyboard (A101/102 key)
PNP030A         AT&T 302 keyboard
PNP030B         Reserved by Microsoft
PNP0320         Japanese 106-key keyboard A01
PNP0321         Japanese 101-key keyboard
PNP0322         Japanese AX keyboard
PNP0323         Japanese 106-key keyboard 002/003
PNP0324         Japanese 106-key keyboard 001
PNP0325         Japanese Toshiba Desktop keyboard
PNP0326         Japanese Toshiba Laptop keyboard
PNP0327         Japanese Toshiba Notebook keyboard
PNP0340         Korean 84-key keyboard
PNP0341         Korean 86-key keyboard
PNP0342         Korean Enhanced keyboard
PNP0343         Korean Enhanced keyboard 101b
PNP0343         Korean Enhanced keyboard 101c
PNP0344         Korean Enhanced keyboard 103

--Parallel Devices--
PNP0400         Standard LPT printer port
PNP0401         ECP printer port

--Serial Devices--
PNP0500         Standard PC COM port
PNP0501         16550A-compatible COM port
PNP0502         Multiport serial device (non-intelligent 16550)
PNP0510         Generic IRDA-compatible device
PNP0511         Generic IRDA-compatible device

--Disk Controllers--
PNP0600         Generic ESDI/IDE/ATA compatible hard disk controller
PNP0601         Plus Hardcard II
PNP0602         Plus Hardcard IIXL/EZ
PNP0603         Generic IDE supporting Microsoft Device Bay Specification
PNP0700         PC standard floppy disk controller
PNP0701         Standard floppy controller supporting MS Device Bay Spec

--Compatibility with early device ID list--
PNP0802         Microsoft Sound System compatible device (obsolete, use
        PNPB0xx instead)
--Display Adapters--
PNP0900         VGA Compatible
PNP0901         Video Seven VRAM/VRAM II/1024i
PNP0902         8514/A Compatible
PNP0903         Trident VGA
PNP0904         Cirrus Logic Laptop VGA
PNP0905         Cirrus Logic VGA
PNP0906         Tseng ET4000
PNP0907         Western Digital VGA
PNP0908         Western Digital Laptop VGA
PNP0909         S3 Inc. 911/924
PNP090A         ATI Ultra Pro/Plus (Mach 32)
PNP090B         ATI Ultra (Mach 8)
PNP090C         XGA Compatible
PNP090D         ATI VGA Wonder
PNP090E         Weitek P9000 Graphics Adapter
PNP090F         Oak Technology VGA
PNP0910         Compaq QVision
PNP0911         XGA/2
PNP0912         Tseng Labs W32/W32i/W32p
PNP0913         S3 Inc. 801/928/964
PNP0914         Cirrus Logic 5429/5434 (memory mapped)
PNP0915         Compaq Advanced VGA (AVGA)
PNP0916         ATI Ultra Pro Turbo (Mach64)
PNP0917         Reserved by Microsoft
PNP0918         Matrox MGA
PNP0919         Compaq QVision 2000
PNP091A         Tseng W128
PNP0930         Chips & Technologies Super VGA
PNP0931         Chips & Technologies Accelerator
PNP0940         NCR 77c22e Super VGA
PNP0941         NCR 77c32blt
PNP09FF         Plug and Play Monitors (VESA DDC)

--Peripheral Buses--
PNP0A00         ISA Bus
PNP0A01         EISA Bus
PNP0A02         MCA Bus
PNP0A03         PCI Bus
PNP0A04         VESA/VL Bus
PNP0A05         Generic ACPI Bus
PNP0A06         Generic ACPI Extended-IO Bus (EIO bus)


-- Real Time Clock, BIOS, System board devices--
PNP0800         AT-style speaker sound
PNP0B00         AT Real-Time Clock
PNP0C00         Plug and Play BIOS (only created by the root enumerator)
PNP0C01         System Board
PNP0C02         General ID for reserving resources required by Plug and Play
        motherboard registers. (Not specific to a particular device.)
PNP0C03         Plug and Play BIOS Event Notification Interrupt
PNP0C04         Math Coprocessor
PNP0C05         APM BIOS (Version independent)
PNP0C06         Reserved for identification of early Plug and Play
                BIOS implementation.
PNP0C07         Reserved for identification of early Plug and Play
                BIOS implementation.
PNP0C08         ACPI system board hardware
PNP0C09         ACPI Embedded Controller
PNP0C0A         ACPI Control Method Battery
PNP0C0B         ACPI Fan
PNP0C0C         ACPI power button device
PNP0C0D         ACPI lid device
PNP0C0E         ACPI sleep button device
PNP0C0F         PCI interrupt link device
PNP0C10        ACPI system indicator device
PNP0C11         ACPI thermal zone
PNP0C12         Device Bay Controller
PNP0C13         Plug and Play BIOS (used when ACPI mode cannot be used)

--PCMCIA Controller Chipsets--
PNP0E00         Intel 82365-Compatible PCMCIA Controller
PNP0E01         Cirrus Logic CL-PD6720 PCMCIA Controller
PNP0E02         VLSI VL82C146 PCMCIA Controller
PNP0E03         Intel 82365-compatible CardBus controller

--Mice--
PNP0F00         Microsoft Bus Mouse
PNP0F01         Microsoft Serial Mouse
PNP0F02         Microsoft InPort Mouse
PNP0F03         Microsoft PS/2-style Mouse
PNP0F04         Mouse Systems Mouse
PNP0F05         Mouse Systems 3-Button Mouse (COM2)
PNP0F06         Genius Mouse (COM1)
PNP0F07         Genius Mouse (COM2)
PNP0F08         Logitech Serial Mouse
PNP0F09         Microsoft BallPoint Serial Mouse
PNP0F0A         Microsoft Plug and Play Mouse
PNP0F0B         Microsoft Plug and Play BallPoint Mouse
PNP0F0C         Microsoft-compatible Serial Mouse
PNP0F0D         Microsoft-compatible InPort-compatible Mouse
PNP0F0E         Microsoft-compatible PS/2-style Mouse
PNP0F0F         Microsoft-compatible Serial BallPoint-compatible Mouse
PNP0F10         Texas Instruments QuickPort Mouse
PNP0F11         Microsoft-compatible Bus Mouse
PNP0F12         Logitech PS/2-style Mouse
PNP0F13         PS/2 Port for PS/2-style Mice
PNP0F14         Microsoft Kids Mouse
PNP0F15         Logitech bus mouse
PNP0F16         Logitech SWIFT device
PNP0F17         Logitech-compatible serial mouse
PNP0F18         Logitech-compatible bus mouse
PNP0F19         Logitech-compatible PS/2-style Mouse
PNP0F1A         Logitech-compatible SWIFT Device
PNP0F1B         HP Omnibook Mouse
PNP0F1C         Compaq LTE Trackball PS/2-style Mouse
PNP0F1D         Compaq LTE Trackball Serial Mouse
PNP0F1E         Microsoft Kids Trackball Mouse
PNP0F1F         Reserved by Microsoft Input Device Group
PNP0F20         Reserved by Microsoft Input Device Group
PNP0F21         Reserved by Microsoft Input Device Group
PNP0F22         Reserved by Microsoft Input Device Group
PNP0F23         Reserved by Microsoft Input Device Group
PNP0FFF         Reserved by Microsoft Systems

***** Network Adapters - PNP8xxx ***********************
PNP8001         Novell/Anthem NE3200
PNP8004         Compaq NE3200
PNP8006         Intel EtherExpress/32
PNP8008         HP EtherTwist EISA LAN Adapter/32 (HP27248A)
PNP8065         Ungermann-Bass NIUps or NIUps/EOTP
PNP8072         DEC (DE211) EtherWorks MC/TP
PNP8073         DEC (DE212) EtherWorks MC/TP_BNC
PNP8078         DCA 10 Mb MCA
PNP8074         HP MC LAN Adapter/16 TP (PC27246)
PNP80c9         IBM Token Ring
PNP80ca         IBM Token Ring II
PNP80cb         IBM Token Ring II/Short
PNP80cc         IBM Token Ring 4/16Mbs
PNP80d3         Novell/Anthem NE1000
PNP80d4         Novell/Anthem NE2000
PNP80d5         NE1000 Compatible
PNP80d6         NE2000 Compatible
PNP80d7         Novell/Anthem NE1500T
PNP80d8         Novell/Anthem NE2100
PNP80dd         SMC ARCNETPC
PNP80de         SMC ARCNET PC100, PC200
PNP80df         SMC ARCNET PC110, PC210, PC250
PNP80e0         SMC ARCNET PC130/E
PNP80e1         SMC ARCNET PC120, PC220, PC260
PNP80e2         SMC ARCNET PC270/E
PNP80e5         SMC ARCNET PC600W, PC650W
PNP80e7         DEC DEPCA
PNP80e8         DEC (DE100) EtherWorks LC
PNP80e9         DEC (DE200) EtherWorks Turbo
PNP80ea         DEC (DE101) EtherWorks LC/TP
PNP80eb         DEC (DE201) EtherWorks Turbo/TP
PNP80ec         DEC (DE202) EtherWorks Turbo/TP_BNC
PNP80ed         DEC (DE102) EtherWorks LC/TP_BNC
PNP80ee         DEC EE101 (Built-In)
PNP80ef         DECpc 433 WS (Built-In)
PNP80f1         3Com EtherLink Plus
PNP80f3         3Com EtherLink II or IITP (8 or 16-bit)
PNP80f4         3Com TokenLink
PNP80f6         3Com EtherLink 16
PNP80f7         3Com EtherLink III
PNP80f8         3Com Generic Etherlink Plug and Play Device
PNP80fb         Thomas Conrad TC6045
PNP80fc         Thomas Conrad TC6042
PNP80fd         Thomas Conrad TC6142
PNP80fe         Thomas Conrad TC6145
PNP80ff         Thomas Conrad TC6242
PNP8100         Thomas Conrad TC6245
PNP8105         DCA 10 MB
PNP8106         DCA 10 MB Fiber Optic
PNP8107         DCA 10 MB Twisted Pair
PNP8113         Racal NI6510
PNP811C         Ungermann-Bass NIUpc
PNP8120         Ungermann-Bass NIUpc/EOTP
PNP8123         SMC StarCard PLUS (WD/8003S)
PNP8124         SMC StarCard PLUS With On Board Hub (WD/8003SH)
PNP8125         SMC EtherCard PLUS (WD/8003E)
PNP8126         SMC EtherCard PLUS With Boot ROM Socket (WD/8003EBT)
PNP8127         SMC EtherCard PLUS With Boot ROM Socket (WD/8003EB)
PNP8128         SMC EtherCard PLUS TP (WD/8003WT)
PNP812a         SMC EtherCard PLUS 16 With Boot ROM Socket (WD/8013EBT)
PNP812d         Intel EtherExpress 16 or 16TP
PNP812f         Intel TokenExpress 16/4
PNP8130         Intel TokenExpress MCA 16/4
PNP8132         Intel EtherExpress 16 (MCA)
PNP8137         Artisoft AE-1
PNP8138         Artisoft AE-2 or AE-3
PNP8141         Amplicard AC 210/XT
PNP8142         Amplicard AC 210/AT
PNP814b         Everex SpeedLink /PC16 (EV2027)
PNP8155         HP PC LAN Adapter/8 TP (HP27245)
PNP8156         HP PC LAN Adapter/16 TP (HP27247A)
PNP8157         HP PC LAN Adapter/8 TL (HP27250)
PNP8158         HP PC LAN Adapter/16 TP Plus (HP27247B)
PNP8159         HP PC LAN Adapter/16 TL Plus (HP27252)
PNP815f         National Semiconductor Ethernode *16AT
PNP8160         National Semiconductor AT/LANTIC EtherNODE 16-AT3
PNP816a         NCR Token-Ring 4 Mbs ISA
PNP816d         NCR Token-Ring 16/4 Mbs ISA
PNP8191         Olicom 16/4 Token-Ring Adapter
PNP81c3         SMC EtherCard PLUS Elite (WD/8003EP)
PNP81c4         SMC EtherCard PLUS 10T (WD/8003W)
PNP81c5         SMC EtherCard PLUS Elite 16 (WD/8013EP)
PNP81c6         SMC EtherCard PLUS Elite 16T (WD/8013W)
PNP81c7         SMC EtherCard PLUS Elite 16 Combo (WD/8013EW or 8013EWC)
PNP81c8         SMC EtherElite Ultra 16
PNP81e4         Pure Data PDI9025-32 (Token Ring)
PNP81e6         Pure Data PDI508+ (ArcNet)
PNP81e7         Pure Data PDI516+ (ArcNet)
PNP81eb         Proteon Token Ring (P1390)
PNP81ec         Proteon Token Ring (P1392)
PNP81ed         Proteon ISA Token Ring (1340)
PNP81ee         Proteon ISA Token Ring (1342)
PNP81ef         Proteon ISA Token Ring (1346)
PNP81f0         Proteon ISA Token Ring (1347)
PNP81ff         Cabletron E2000 Series DNI
PNP8200         Cabletron E2100 Series DNI
PNP8209         Zenith Data Systems Z-Note
PNP820a         Zenith Data Systems NE2000-Compatible
PNP8213         Xircom Pocket Ethernet II
PNP8214         Xircom Pocket Ethernet I
PNP821d         RadiSys EXM-10
PNP8227         SMC 3000 Series
PNP8228         SMC 91C2 controller
PNP8231         Advanced Micro Devices AM2100/AM1500T
PNP8263         Tulip NCC-16
PNP8277         Exos 105
PNP828A         Intel '595 based Ethernet
PNP828B         TI2000-style Token Ring
PNP828C         AMD PCNet Family cards
PNP828D         AMD PCNet32 (VL version)
PNP8294         IrDA Infrared NDIS driver (Microsoft-supplied)
PNP82bd         IBM PCMCIA-NIC
PNP82C2         Xircom CE10
PNP82C3         Xircom CEM2
PNP8321         DEC Ethernet (All Types)
PNP8323         SMC EtherCard (All Types except 8013/A)
PNP8324         ARCNET Compatible
PNP8326         Thomas Conrad (All Arcnet Types)
PNP8327         IBM Token Ring (All Types)
PNP8385         Remote Network Access Driver
PNP8387         RNA Point-to-point Protocol Driver
PNP8388         Reserved for Microsoft Networking components
PNP8389        Peer IrLAN infrared driver (Microsoft-supplied)
PNP8390         Generic network adapter

***** SCSI, Proprietary CD Adapters - PNPAxxx **********
PNPA002         Future Domain 16-700 compatible controller
PNPA003         Panasonic proprietary CD-ROM adapter (SBPro/SB16)
PNPA01B         Trantor 128 SCSI Controller
PNPA01D         Trantor T160 SCSI Controller
PNPA01E         Trantor T338 Parallel SCSI controller
PNPA01F         Trantor T348 Parallel SCSI controller
PNPA020         Trantor Media Vision SCSI controller
PNPA022         Always IN-2000 SCSI controller
PNPA02B         Sony proprietary CD-ROM controller
PNPA02D         Trantor T13b 8-bit SCSI controller
PNPA02F         Trantor T358 Parallel SCSI controller
PNPA030         Mitsumi LU-005 Single Speed CD-ROM controller + drive
PNPA031         Mitsumi FX-001 Single Speed CD-ROM controller + drive
PNPA032         Mitsumi FX-001 Double Speed CD-ROM controller + drive

***** Sound/Video-capture, multimedia - PNPBxxx ********
PNPB000         Sound Blaster 1.5 sound device
PNPB001         Sound Blaster 2.0 sound device
PNPB002         Sound Blaster Pro sound device
PNPB003         Sound Blaster 16 sound device
PNPB004         Thunderboard-compatible sound device
PNPB005         Adlib-compatible FM synthesizer device
PNPB006         MPU401 compatible
PNPB007         Microsoft Windows Sound System-compatible sound device
PNPB008         Compaq Business Audio
PNPB009         Plug and Play Microsoft Windows Sound System Device
PNPB00A         MediaVision Pro Audio Spectrum
        (Trantor SCSI enabled, Thunder Chip Disabled)
PNPB00B         MediaVision Pro Audio 3D
PNPB00C         MusicQuest MQX-32M
PNPB00D         MediaVision Pro Audio Spectrum Basic
        (No Trantor SCSI, Thunder Chip Enabled)
PNPB00E         MediaVision Pro Audio Spectrum
        (Trantor SCSI enabled, Thunder Chip Enabled)
PNPB00F         MediaVision Jazz-16 chipset (OEM Versions)
PNPB010         Auravision VxP500 chipset - Orchid Videola
PNPB018         MediaVision Pro Audio Spectrum 8-bit
PNPB019         MediaVision Pro Audio Spectrum Basic
        (no Trantor SCSI, Thunder chip Disabled)
PNPB020         Yamaha OPL3-compatible FM synthesizer device
PNPB02F         Joystick/Game port

***** Modems - PNPCxxx-Dxxx****************************
PNPC000         Compaq 14400 Modem (TBD)
PNPC001         Compaq 2400/9600 Modem (TBD)

>
>
>
>But what are these devices?  Can you run 'tree' on this so as to
>visualize the structure better?
>
Sure.  Here's a copy of my tree.

.
|-- bus
|   |-- pci
|   |   |-- devices
|   |   |   |-- 00:00.0 -> ../../../root/pci0/00:00.0
|   |   |   |-- 00:01.0 -> ../../../root/pci0/00:01.0
|   |   |   |-- 00:1e.0 -> ../../../root/pci0/00:1e.0
|   |   |   |-- 00:1f.0 -> ../../../root/pci0/00:1f.0
|   |   |   |-- 00:1f.1 -> ../../../root/pci0/00:1f.1
|   |   |   |-- 00:1f.2 -> ../../../root/pci0/00:1f.2
|   |   |   |-- 00:1f.3 -> ../../../root/pci0/00:1f.3
|   |   |   |-- 01:09.0 -> ../../../root/pci0/00:1e.0/01:09.0
|   |   |   |-- 01:09.1 -> ../../../root/pci0/00:1e.0/01:09.1
|   |   |   |-- 01:0a.0 -> ../../../root/pci0/00:1e.0/01:0a.0
|   |   |   `-- 01:0b.0 -> ../../../root/pci0/00:1e.0/01:0b.0
|   |   `-- drivers
|   |       |-- Ensoniq AudioPCI
|   |       |-- agpgart
|   |       |-- cardbus
|   |       |-- e100
|   |       |-- parport_pc
|   |       `-- uhci-hcd
|   |-- pnp
|   |   |-- devices
|   |   |   |-- 00 -> ../../../root/pnp/00
|   |   |   |-- 01 -> ../../../root/pnp/01
|   |   |   |-- 02 -> ../../../root/pnp/02
|   |   |   |-- 03 -> ../../../root/pnp/03
|   |   |   |-- 04 -> ../../../root/pnp/04
|   |   |   |-- 05 -> ../../../root/pnp/05
|   |   |   |-- 06 -> ../../../root/pnp/06
|   |   |   |-- 07 -> ../../../root/pnp/07
|   |   |   |-- 08 -> ../../../root/pnp/08
|   |   |   |-- 09 -> ../../../root/pnp/09
|   |   |   |-- 0b -> ../../../root/pnp/0b
|   |   |   |-- 0c -> ../../../root/pnp/0c
|   |   |   |-- 0d -> ../../../root/pnp/0d
|   |   |   |-- 0e -> ../../../root/pnp/0e
|   |   |   |-- 0f -> ../../../root/pnp/0f
|   |   |   |-- 10 -> ../../../root/pnp/10
|   |   |   |-- 11 -> ../../../root/pnp/11
|   |   |   |-- 12 -> ../../../root/pnp/12
|   |   |   `-- 13 -> ../../../root/pnp/13
|   |   `-- drivers
|   |-- scsi
|   |   |-- devices
|   |   `-- drivers
|   |       |-- sd
|   |       |-- sg
|   |       `-- sr
|   `-- usb
|       |-- devices
|       |   |-- 00:1f.2-0:0 -> 
../../../root/pci0/00:1f.2/usb_bus/00:1f.2-0:0
|       |   `-- 00:1f.2-1:0 -> 
../../../root/pci0/00:1f.2/usb_bus/1/00:1f.2-1:0
|       `-- drivers
|-- class
|   `-- input
|       |-- devices
|       |-- drivers
|       `-- mouse
`-- root
    |-- pci0
    |   |-- 00:00.0
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:01.0
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:1e.0
    |   |   |-- 01:09.0
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- power
    |   |   |   `-- resource
    |   |   |-- 01:09.1
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- power
    |   |   |   `-- resource
    |   |   |-- 01:0a.0
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- power
    |   |   |   `-- resource
    |   |   |-- 01:0b.0
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- power
    |   |   |   `-- resource
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:1f.0
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:1f.1
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:1f.2
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   |-- resource
    |   |   `-- usb_bus
    |   |       |-- 00:1f.2-0:0
    |   |       |   |-- altsetting
    |   |       |   |-- name
    |   |       |   `-- power
    |   |       |-- 1
    |   |       |   |-- 00:1f.2-1:0
    |   |       |   |   |-- altsetting
    |   |       |   |   |-- name
    |   |       |   |   `-- power
    |   |       |   |-- configuration
    |   |       |   |-- manufacturer
    |   |       |   |-- name
    |   |       |   |-- power
    |   |       |   `-- product
    |   |       |-- configuration
    |   |       |-- manufacturer
    |   |       |-- name
    |   |       |-- power
    |   |       |-- product
    |   |       `-- serial
    |   |-- 00:1f.3
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- name
    |   `-- power
    |-- pnp
    |   |-- 00
    |   |   |-- name
    |   |   `-- power
    |   |-- 01
    |   |   |-- name
    |   |   `-- power
    |   |-- 02
    |   |   |-- name
    |   |   `-- power
    |   |-- 03
    |   |   |-- name
    |   |   `-- power
    |   |-- 04
    |   |   |-- name
    |   |   `-- power
    |   |-- 05
    |   |   |-- name
    |   |   `-- power
    |   |-- 06
    |   |   |-- name
    |   |   `-- power
    |   |-- 07
    |   |   |-- name
    |   |   `-- power
    |   |-- 08
    |   |   |-- name
    |   |   `-- power
    |   |-- 09
    |   |   |-- name
    |   |   `-- power
    |   |-- 0b
    |   |   |-- name
    |   |   `-- power
    |   |-- 0c
    |   |   |-- name
    |   |   `-- power
    |   |-- 0d
    |   |   |-- name
    |   |   `-- power
    |   |-- 0e
    |   |   |-- name
    |   |   `-- power
    |   |-- 0f
    |   |   |-- name
    |   |   `-- power
    |   |-- 10
    |   |   |-- name
    |   |   `-- power
    |   |-- 11
    |   |   |-- name
    |   |   `-- power
    |   |-- 12
    |   |   |-- name
    |   |   `-- power
    |   |-- 13
    |   |   |-- name
    |   |   `-- power
    |   |-- name
    |   `-- power
    |-- scsi0
    |   |-- name
    |   `-- power
    `-- sys
        |-- 0020
        |   |-- name
        |   `-- power
        |-- 0040
        |   |-- name
        |   `-- power
        |-- 03?0
        |   |-- name
        |   `-- power
        |-- name
        `-- power

101 directories, 113 files


>
>
>>>Also a few minor comments on the patch:
>>>  - pnpbios_bus_type should probably be made static, along with
>>>    alloc_pnpbios_root().
>>>
>>alloc_pnpbios_root is now static.  I'm going to leave bus_type as it is 
>>because I want it open to other files at least for now.
>>
>
>Why?  I don't think there's a need for any other code to need to point
>to it.  If in the future it's needed, you can always export it :)
>
Ok, I'll make it static too.

>
>
>>>  - in pnpbios_bus_match(), don't you have to check the value of
>>>    the call to match_device() to make sure you have a match?
>>>    That would keep pnpbios_device_probe() from being called for
>>>    every device like it looks your patch causes.
>>>
>>I did some serious restructuring here and in pnpbios_device_probe.  Also 
>>I made it a bit more like the one used by pci.  Hopefully it's all right 
>>now.
>>
>
>Wrong placement of your {} in the while statement :)
>You also might want to not hard code the "7" in the memcmp, but use the
>size of the smaller field there, incase things change in the future.
>
I fixed the {}. :-)   The pnpbios driver only supports dev ids with the 
length of 7.  Any shorter or longer would be considered invalid by the 
PNPBIOS Specifications.  Therefore it makes sence to force it to use a 
length of 7.  Look at the devid list I included.

>
>
>>>  - the pnpbios_device_probe() call should return a negative error
>>>    number if the device does not match, or some error happens.
>>>    Returning 1 does not mean success.  You also need to save off
>>>    the device specific info somehow in your structure, so that
>>>    the pnpbios_device_remove() can remove it.  Or am I just
>>>    missing something here?
>>>
>>pnpbios_device_probe now returns a negative number on failure.  I'm 
>>creating a more flexible pnpbios specific device data structure that can 
>>be used instead of pci_dev in my next patch.  I should be able to clean 
>>some of this up once I do that.  I'll take care of the device specific 
>>info then.
>>
>
>But it still looks like you aren't saving off the needed information in
>the dev.driver_data structure.  Or am I missing something?
>
Ok, I'll store the info to dev.driver_data for now.

>
>
>thanks,
>
>greg k-h
>
Thanks,
Adam


