Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSCXOF5>; Sun, 24 Mar 2002 09:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSCXOFu>; Sun, 24 Mar 2002 09:05:50 -0500
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:24194 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S293277AbSCXOFi>; Sun, 24 Mar 2002 09:05:38 -0500
Date: Sun, 24 Mar 2002 15:05:14 +0100
To: Banai Zoltan <bazooka@enclavenet.hu>
Cc: Steffen Persvold <sp@scali.com>, Janos Farkas <chexum@shadow.banki.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: io-apic not working on i850mv(p4)
Message-ID: <20020324150514.A1789@bazooka.saturnus.vein.hu>
In-Reply-To: <priv$1016911429.lord@lk8rp.mail.xeon.eu.org> <Pine.LNX.4.30.0203232232240.11080-100000@elin.scali.no> <20020324000115.C9229@bazooka.saturnus.vein.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@enclavenet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have discussed the problem with Janos Farkas:

He said that CONFIG_X86_UP_IOAPIC=y means that if
IO-APIC _is_ present on the motherboard then it will be used.

But i pointed out that acording to intel's 
i850MV board specification update:
ftp://download.intel.com/design/motherbd/mv/A7258705.pdf (8-9 page)
this motherboard supports 16 irq in PIC mode and 24 in APIC mode.

So it seems to me that the problem is with kernel-bios communication.
Maybe the kernel needs the bios to supply the SMP layout?
Or ther is need to relocate the DMI scan to early boot stage?

I supply my DMI decode output:

SMBIOS 2.3 present.
DMI 2.3 present.
64 structures occupying 2207 bytes.
DMI table at 0x000F0FD0.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: Intel Corp.
		Version: MV85010A.86A.0011.P05.0111141737
		Release: 11/14/2001
		BIOS base: 0xF0000
		ROM size: 448K
		Capabilities:
			Flags: 0x000000017FF9DE80
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor:                                
		Product:                                
		Version:                        
		Serial Number:                                
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: Intel Corporation              
		Product: D850MV                         
		Version: AAA56423-301           
		Serial Number: IUMV20609870                   
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor:                                
		Chassis Type: Unknown
		Version:                        
		Serial Number:                                
		Asset Tag:                                
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: J4K2
		Processor Type: Central Processor
		Processor Family: 
		Processor Manufacturer: Intel Corporation
		Processor Version: Pentium(R) 4                 
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache
		Socket: None
		L1 Internal Cache: write-back
		L1 Cache Size: 8K
		L1 Cache Maximum: 8K
		L1 Cache Type: Pipeline burst Synchronous 
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache
		Socket: None
		L2 Internal Cache: write-back
		L2 Cache Size: 256K
		L2 Cache Maximum: 256K
		L2 Cache Type: Synchronous 
Handle 0x0007
	DMI type 5, 24 bytes.
	Memory Controller
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J7J1
		Banks: 0 0
		Type: OTHER ECC 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J7J2
		Banks: 0 0
		Type: OTHER ECC 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J8J1
		Banks: 0 
		Type: OTHER 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J8J2
		Banks: 0 
		Type: OTHER 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000C
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4E1
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v 
Handle 0x000D
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4D1
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 3.3v 
Handle 0x000E
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4C1
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v 
Handle 0x000F
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4C1
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v 
Handle 0x0010
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4C1
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 3.3v 
Handle 0x0011
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J4C1
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v 
Handle 0x0012
	DMI type 9, 13 bytes.
	Card Slot
		Slot: J5E1
		Type: 32bit PC98/C20
		Status: In use.
		Slot Features: 5v 
Handle 0x0013
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Intel ICH2 Audio Device : Enabled
		Type: 
Handle 0x0014
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Intel 82559 Ethernet Device : Enabled
		Type: 
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1L1
		Internal Connector Type: None
		External Designator: USB1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1L1
		Internal Connector Type: None
		External Designator: USB2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1K1
		Internal Connector Type: None
		External Designator: COM A
		External Connector Type: DB-9 pin female
		Port Type: Serial Port 16650A Compatible
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1J2
		Internal Connector Type: None
		External Designator: LPT1
		External Connector Type: DB-25 pin male
		Port Type: Parallel Port ECP/EPP
Handle 0x0019
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1M1
		Internal Connector Type: None
		External Designator: Keyboard
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x001A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1M1
		Internal Connector Type: None
		External Designator: PS2Mouse
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x001B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: JA1H1
		Internal Connector Type: None
		External Designator: LAN
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x001C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1F3 - VIDEO INTERFACE PORT
		Internal Connector Type: Other
		External Designator: None
		External Connector Type: None
		Port Type: Video Port
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1G1
		Internal Connector Type: None
		External Designator: Audio Mic In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x001E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1G1
		Internal Connector Type: None
		External Designator: Audio Line In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x001F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1G1
		Internal Connector Type: None
		External Designator: Audio Line Out
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x0020
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J10C1
		Internal Connector Type: Other
		External Designator: USB Front Panel
		External Connector Type: None
		Port Type: Other
Handle 0x0021
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J10G1 - Floppy
		Internal Connector Type: On Board Floppy
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0022
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J9G2 - PRI IDE
		Internal Connector Type: On Board IDE
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0023
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J9G1 - SEC IDE
		Internal Connector Type: On Board IDE
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0024
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J2D1 - CDIN
		Internal Connector Type: On Board Sound Input from CD-ROM
		External Designator: 
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0025
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J2C2 - Telephony IN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0026
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J2C1 - AUX IN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0027
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J8C1 - Wake On Ring
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0028
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J7C1 - Wake On LAN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0029
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J7A2 - SCSI LED
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J9D2 - Control Panel
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J7M2 - Power Supply Fan
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J6M1 - CPU Fan
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J8C2 - Configuration Jumper
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002E
	DMI type 12, 5 bytes.
	Configuration Information
		J8C2 Jumper Pins 1-2 Normal Mode
		J8C2 Jumper Pins 2-3 Configuration Mode
		J8C2 No Jumper Recovery Mode
Handle 0x002F
	DMI type 13, 22 bytes.
	BIOS Language Information
Handle 0x0030
	DMI type 15, 33 bytes.
	Event Log
		Log Area: 4096 bytes.
		Log Header At: 0.
		Log Data At: 16.
		Log Type: 3.
		Log Valid: Yes.
Handle 0x0031
	DMI type 31, 28 bytes.
2e 00 00 00 13 71 00 f0 04 df 0f 00 00 00 00 00 	.....q..........
00 00 00 00 00 00 00 00                         	........        
Handle 0x0032
	DMI type 18, 23 bytes.
	32-bit Memory Error Information
Handle 0x0033
	DMI type 16, 15 bytes.
	Physical Memory Array
Handle 0x0034
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x0035
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x0036
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0037
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x0038
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0039
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x003A
	DMI type 126, 19 bytes.
	Inactive
Handle 0x003B
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x003C
	DMI type 126, 19 bytes.
	Inactive
Handle 0x003D
	DMI type 32, 20 bytes.
	System Boot Information
Handle 0x003E
	DMI type 130, 12 bytes.
01 01 02 01 00 01 08 01                         	........        
Handle 0x003F
	DMI type 127, 4 bytes.
	End-of-Table

Regards, Banai
