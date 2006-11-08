Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754452AbWKHIg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbWKHIg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbWKHIg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:36:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2056 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1754449AbWKHIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:36:27 -0500
Date: Wed, 8 Nov 2006 09:36:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ernst Herzberg <earny@net4u.de>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, mingo@redhat.com
Subject: Re: [linux-pm] 2.6.19-rc4: known unfixed regressions (v3)
Message-ID: <20061108083628.GS4729@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611070317.42230.earny@net4u.de> <200611070041.28008.len.brown@intel.com> <200611072105.50178.earny@net4u.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611072105.50178.earny@net4u.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 09:05:36PM +0100, Ernst Herzberg wrote:
> On Tuesday 07 November 2006 06:41, Len Brown wrote:
> > On Monday 06 November 2006 21:17, Ernst Herzberg wrote:
> > > On Sunday 05 November 2006 07:48, Adrian Bunk wrote:
> > > > ...
> > > > Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
> > > > References : http://lkml.org/lkml/2006/10/31/333
> > > > Submitter  : Ernst Herzberg <earny@net4u.de>
> > > > Status     : problem is being debugged
> 
> First i made shure again that 2.6.18.2 works..... damn shure.
> 
> >
> > Please test if booting with "processor.max_cstate=1" makes any
> > difference
> 
> --> NO.
> 
> > Please test if building with CONFIG_CPU_FREQ=n makes any difference.
> 
> --> NO.
> 
> > Also, please make sure that booting with "apm=off" makes no difference
> > -- there is a bug where the APM code is not currently disabled in ACPI
> > mode, and who knows what effect that may have...
> 
> Ahem. All previous tests was done with CONFIG_APM=n. So i tested with 
> CONFIG_APM=y. Does not help. It makes no difference booting with "apm=off" 
> or not.
> 
> Another check:
> 
> The laptop muste be powered on on_battery to trigger the problem. If i 
> disconnect AC at the grub-prompt the problem does _not_ occur.
> 
> The laptop has two batteries. The utraybay battery is nearly dead now, but 
> it makes no difference if removed.
> 
> This problem is not very important for me, i just wondering why is only 
> occurs if running on battery. I would be happy, if someone can explain 
> this;-) 
> 
> The laptop itself is rock stable (if he boots), never seen any glitch or 
> instability (with lapic). I don't know exactly when i started using lapic. 
> Its a long time ago (last year?), i have read the message that i can 
> enable this so i did. No problems until 2.6.19-rc1....
> 
> If nobody can reproduce this, i don't care about the problem. There is also 
> a life without lapic:) But maybe it shows a problem anywhere else, timing 
> or whatever, so i'm willing to test everything against.


There's exactly the important point:
It's interesting to work out (e.g. by a successfull bisecting) _what_ 
broke it.

"OK, we understand what's going on, and it's a surprise that lapic ever 
worked for you." is a possible result.

But it's also possible that it's only one symptom of some serious 
problem - a buggy part of Andi's APIC cleanups has just been fixed, and 
Martin seems to run from one problem into the next on his ThinkPad, 
so getting your problem debugged might also help other people.


> So if someone is interesting to reproduce the problem, i repeat the 
> conditions that must be met:
> 
> 1.: Laptop must be powered on with AC removed (on battery)
> 
> 2.: BIOS-Setting must be
>   power --> Intel Speedstep --> Mode on Battery --> "Max Battery"
> 
> 3.: Kernel command line must have "lapci"
> 
> 4.: Kernel must be >= 2.6.19-rc1
> 
> dmidecode: (maybe that helps?)
> 
> # dmidecode 2.8
> SMBIOS 2.33 present.
> 61 structures occupying 2127 bytes.
> Table at 0x000E0010.
> 
> Handle 0x0000, DMI type 0, 20 bytes
> BIOS Information
> 	Vendor: IBM
> 	Version: 1RETDPWW (3.21 )
> 	Release Date: 06/02/2006
> 	Address: 0xDC000
> 	Runtime Size: 144 kB
> 	ROM Size: 1024 kB
> 	Characteristics:
> 		PCI is supported
> 		PC Card (PCMCIA) is supported
> 		PNP is supported
> 		APM is supported
> 		BIOS is upgradeable
> 		BIOS shadowing is allowed
> 		ESCD support is available
> 		Boot from CD is supported
> 		Selectable boot is supported
> 		EDD is supported
> 		3.5"/720 KB floppy services are supported (int 13h)
> 		Print screen service is supported (int 5h)
> 		8042 keyboard services are supported (int 9h)
> 		Serial services are supported (int 14h)
> 		Printer services are supported (int 17h)
> 		CGA/mono video services are supported (int 10h)
> 		ACPI is supported
> 		USB legacy is supported
> 		AGP is supported
> 		BIOS boot specification is supported
> 
> Handle 0x0001, DMI type 1, 25 bytes
> System Information
> 	Manufacturer: IBM
> 	Product Name: 183222G
> 	Version: ThinkPad R50p
> 	Serial Number: 99DR993
> 	UUID: 5532DC80-466C-11CB-B373-95CD80E5548B
> 	Wake-up Type: Power Switch
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> 	Manufacturer: IBM
> 	Product Name: 183222G
> 	Version: Not Available
> 	Serial Number: J1V9545B13X
> 
> Handle 0x0003, DMI type 3, 17 bytes
> Chassis Information
> 	Manufacturer: IBM
> 	Type: Notebook
> 	Lock: Not Present
> 	Version: Not Available
> 	Serial Number: Not Available
> 	Asset Tag: No Asset Information
> 	Boot-up State: Unknown
> 	Power Supply State: Unknown
> 	Thermal State: Unknown
> 	Security Status: Unknown
> 	OEM Information: 0x00000000
> 
> Handle 0x0004, DMI type 126, 17 bytes
> Inactive
> 
> Handle 0x0005, DMI type 126, 17 bytes
> Inactive
> 
> Handle 0x0006, DMI type 4, 35 bytes
> Processor Information
> 	Socket Designation: None
> 	Type: Central Processor
> 	Family: Pentium M
> 	Manufacturer: GenuineIntel
> 	ID: 95 06 00 00 BF F9 E9 A7
> 	Signature: Type 0, Family 6, Model 9, Stepping 5
> 	Flags:
> 		FPU (Floating-point unit on-chip)
> 		VME (Virtual mode extension)
> 		DE (Debugging extension)
> 		PSE (Page size extension)
> 		TSC (Time stamp counter)
> 		MSR (Model specific registers)
> 		MCE (Machine check exception)
> 		CX8 (CMPXCHG8 instruction supported)
> 		SEP (Fast system call)
> 		MTRR (Memory type range registers)
> 		PGE (Page global enable)
> 		MCA (Machine check architecture)
> 		CMOV (Conditional move instruction supported)
> 		PAT (Page attribute table)
> 		CLFSH (CLFLUSH instruction supported)
> 		DS (Debug store)
> 		ACPI (ACPI supported)
> 		MMX (MMX technology supported)
> 		FXSR (Fast floating-point save and restore)
> 		SSE (Streaming SIMD extensions)
> 		SSE2 (Streaming SIMD extensions 2)
> 		TM (Thermal monitor supported)
> 		PBE (Pending break enabled)
> 	Version: Intel(R) Pentium(R) M processor
> 	Voltage: 1.5 V
> 	External Clock: 400 MHz
> 	Max Speed: 1700 MHz
> 	Current Speed: 1700 MHz
> 	Status: Populated, Enabled
> 	Upgrade: None
> 	L1 Cache Handle: 0x000A
> 	L2 Cache Handle: 0x000B
> 	L3 Cache Handle: Not Provided
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified
> 
> Handle 0x0007, DMI type 5, 20 bytes
> Memory Controller Information
> 	Error Detecting Method: None
> 	Error Correcting Capabilities:
> 		None
> 	Supported Interleave: One-way Interleave
> 	Current Interleave: One-way Interleave
> 	Maximum Memory Module Size: 1024 MB
> 	Maximum Total Memory Size: 2048 MB
> 	Supported Speeds:
> 		Other
> 	Supported Memory Types:
> 		DIMM
> 		SDRAM
> 	Memory Module Voltage: 2.9 V
> 	Associated Memory Slots: 2
> 		0x0008
> 		0x0009
> 	Enabled Error Correcting Capabilities:
> 		None
> 
> Handle 0x0008, DMI type 6, 12 bytes
> Memory Module Information
> 	Socket Designation: DIMM Slot 1
> 	Bank Connections: 0 1
> 	Current Speed: Unknown
> 	Type: DIMM SDRAM
> 	Installed Size: 512 MB (Double-bank Connection)
> 	Enabled Size: 512 MB (Double-bank Connection)
> 	Error Status: OK
> 
> Handle 0x0009, DMI type 6, 12 bytes
> Memory Module Information
> 	Socket Designation: DIMM Slot 2
> 	Bank Connections: 2 3
> 	Current Speed: Unknown
> 	Type: DIMM SDRAM
> 	Installed Size: 512 MB (Double-bank Connection)
> 	Enabled Size: 512 MB (Double-bank Connection)
> 	Error Status: OK
> 
> Handle 0x000A, DMI type 7, 19 bytes
> Cache Information
> 	Socket Designation: Internal L1 Cache
> 	Configuration: Enabled, Socketed, Level 1
> 	Operational Mode: Write Back
> 	Location: Internal
> 	Installed Size: 32 KB
> 	Maximum Size: 32 KB
> 	Supported SRAM Types:
> 		Synchronous
> 	Installed SRAM Type: Synchronous
> 	Speed: Unknown
> 	Error Correction Type: Unknown
> 	System Type: Other
> 	Associativity: 8-way Set-associative
> 
> Handle 0x000B, DMI type 7, 19 bytes
> Cache Information
> 	Socket Designation: Internal L2 Cache
> 	Configuration: Enabled, Socketed, Level 2
> 	Operational Mode: Write Back
> 	Location: Internal
> 	Installed Size: 1024 KB
> 	Maximum Size: 1024 KB
> 	Supported SRAM Types:
> 		Burst
> 	Installed SRAM Type: Burst
> 	Speed: Unknown
> 	Error Correction Type: Multi-bit ECC
> 	System Type: Unified
> 	Associativity: 8-way Set-associative
> 
> Handle 0x000C, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x000D, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Infrared
> 	External Connector Type: Infrared
> 	Port Type: Other
> 
> Handle 0x000E, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Parallel
> 	External Connector Type: DB-25 female
> 	Port Type: Parallel Port ECP/EPP
> 
> Handle 0x000F, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: External Monitor
> 	External Connector Type: DB-15 female
> 	Port Type: Video Port
> 
> Handle 0x0010, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0011, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0012, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0013, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0014, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0015, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Microphone Jack
> 	External Connector Type: Mini Jack (headphones)
> 	Port Type: Audio Port
> 
> Handle 0x0016, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Headphone Jack
> 	External Connector Type: Mini Jack (headphones)
> 	Port Type: Audio Port
> 
> Handle 0x0017, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: S-Video-Out
> 	External Connector Type: Other
> 	Port Type: Video Port
> 
> Handle 0x0018, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0019, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Modem
> 	External Connector Type: RJ-11
> 	Port Type: Modem Port
> 
> Handle 0x001A, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: Ethernet
> 	External Connector Type: RJ-45
> 	Port Type: Network Port
> 
> Handle 0x001B, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: USB 1
> 	External Connector Type: Access Bus (USB)
> 	Port Type: USB
> 
> Handle 0x001C, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Available
> 	Internal Connector Type: None
> 	External Reference Designator: USB 2
> 	External Connector Type: Access Bus (USB)
> 	Port Type: USB
> 
> Handle 0x001D, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x001E, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x001F, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0020, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0021, DMI type 126, 9 bytes
> Inactive
> 
> Handle 0x0022, DMI type 9, 13 bytes
> System Slot Information
> 	Designation: CardBus Slot 1
> 	Type: 32-bit PC Card (PCMCIA)
> 	Current Usage: Available
> 	Length: Other
> 	ID: Adapter 0, Socket 0
> 	Characteristics:
> 		5.0 V is provided
> 		3.3 V is provided
> 		PC Card-16 is supported
> 		Cardbus is supported
> 		Zoom Video is supported
> 		Modem ring resume is supported
> 		PME signal is supported
> 		Hot-plug devices are supported
> 
> Handle 0x0023, DMI type 9, 13 bytes
> System Slot Information
> 	Designation: CardBus Slot 2
> 	Type: 32-bit PC Card (PCMCIA)
> 	Current Usage: Available
> 	Length: Other
> 	ID: Adapter 1, Socket 0
> 	Characteristics:
> 		5.0 V is provided
> 		3.3 V is provided
> 		PC Card-16 is supported
> 		Cardbus is supported
> 		Zoom Video is supported
> 		Modem ring resume is supported
> 		PME signal is supported
> 		Hot-plug devices are supported
> 
> Handle 0x0024, DMI type 126, 13 bytes
> Inactive
> 
> Handle 0x0025, DMI type 126, 13 bytes
> Inactive
> 
> Handle 0x0026, DMI type 9, 13 bytes
> System Slot Information
> 	Designation: Mini-PCI Slot 1
> 	Type: 32-bit PCI
> 	Current Usage: Available
> 	Length: Other
> 	ID: 1
> 	Characteristics:
> 		5.0 V is provided
> 		3.3 V is provided
> 		PME signal is supported
> 		SMBus signal is supported
> 
> Handle 0x0027, DMI type 126, 13 bytes
> Inactive
> 
> Handle 0x0028, DMI type 10, 6 bytes
> On Board Device Information
> 	Type: Other
> 	Status: Enabled
> 	Description: IBM Embedded Security hardware
> 
> Handle 0x0029, DMI type 11, 5 bytes
> OEM Strings
> 	String 1: IBM ThinkPad Embedded Controller -[1RHT71WW-3.04    ]-
> 
> Handle 0x002A, DMI type 13, 22 bytes
> BIOS Language Information
> 	Installable Languages: 1
> 		enUS
> 	Currently Installed Language: enUS
> 
> Handle 0x002B, DMI type 15, 25 bytes
> System Event Log
> 	Area Length: 0 bytes
> 	Header Start Offset: 0x0000
> 	Header Length: 16 bytes
> 	Data Start Offset: 0x0010
> 	Access Method: General-purpose non-volatile data functions
> 	Access Address: 0x0000
> 	Status: Invalid, Not Full
> 	Change Token: 0x00000004
> 	Header Format: Type 1
> 	Supported Log Type Descriptors: 1
> 	Descriptor 1: POST error
> 	Data Format 1: POST results bitmap
> 
> Handle 0x002C, DMI type 16, 15 bytes
> Physical Memory Array
> 	Location: System Board Or Motherboard
> 	Use: System Memory
> 	Error Correction Type: None
> 	Maximum Capacity: 1 GB
> 	Error Information Handle: Not Provided
> 	Number Of Devices: 2
> 
> Handle 0x002D, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x002C
> 	Error Information Handle: No Error
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 512 MB
> 	Form Factor: SODIMM
> 	Set: None
> 	Locator: DIMM 1
> 	Bank Locator: Bank 0/1
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: Unknown
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified
> 
> Handle 0x002E, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x002C
> 	Error Information Handle: No Error
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 512 MB
> 	Form Factor: SODIMM
> 	Set: None
> 	Locator: DIMM 2
> 	Bank Locator: Bank 2/3
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: Unknown
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified
> 
> Handle 0x002F, DMI type 18, 23 bytes
> 32-bit Memory Error Information
> 	Type: OK
> 	Granularity: Unknown
> 	Operation: Unknown
> 	Vendor Syndrome: Unknown
> 	Memory Array Address: Unknown
> 	Device Address: Unknown
> 	Resolution: Unknown
> 
> Handle 0x0030, DMI type 19, 15 bytes
> Memory Array Mapped Address
> 	Starting Address: 0x00000000000
> 	Ending Address: 0x0003FFFFFFF
> 	Range Size: 1 GB
> 	Physical Array Handle: 0x002C
> 	Partition Width: 0
> 
> Handle 0x0031, DMI type 20, 19 bytes
> Memory Device Mapped Address
> 	Starting Address: 0x00000000000
> 	Ending Address: 0x0001FFFFFFF
> 	Range Size: 512 MB
> 	Physical Device Handle: 0x002D
> 	Memory Array Mapped Address Handle: 0x0030
> 	Partition Row Position: 1
> 
> Handle 0x0032, DMI type 20, 19 bytes
> Memory Device Mapped Address
> 	Starting Address: 0x00020000000
> 	Ending Address: 0x0003FFFFFFF
> 	Range Size: 512 MB
> 	Physical Device Handle: 0x002E
> 	Memory Array Mapped Address Handle: 0x0030
> 	Partition Row Position: 1
> 
> Handle 0x0033, DMI type 21, 7 bytes
> Built-in Pointing Device
> 	Type: Track Point
> 	Interface: PS/2
> 	Buttons: 3
> 
> Handle 0x0034, DMI type 21, 7 bytes
> Built-in Pointing Device
> 	Type: Touch Pad
> 	Interface: PS/2
> 	Buttons: 0
> 
> Handle 0x0035, DMI type 24, 5 bytes
> Hardware Security
> 	Power-On Password Status: Disabled
> 	Keyboard Password Status: Disabled
> 	Administrator Password Status: Disabled
> 	Front Panel Reset Status: Unknown
> 
> Handle 0x0036, DMI type 32, 11 bytes
> System Boot Information
> 	Status: No errors detected
> 
> Handle 0x0037, DMI type 131, 102 bytes
> OEM-specific Type
> 	Header and Data:
> 		83 66 37 00 01 00 00 00 00 01 72 03 40 00 AE 80
> 		00 02 00 00 00 00 00 2A 00 40 2A 00 00 00 00 00
> 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 		00 00 00 00 00 00 00 00 00 00 16 00 80 16 00 00
> 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 		00 00 00 00 00 00
> 	Strings:
> 		IBMCFGDATA
> 
> Handle 0x0038, DMI type 131, 17 bytes
> OEM-specific Type
> 	Header and Data:
> 		83 11 38 00 01 02 03 FF FF 1F 00 00 00 00 00 02
> 		00
> 	Strings:
> 		BOOTINF 20h
> 		BOOTDEV 21h
> 		KEYPTRS 23h
> 
> Handle 0x0039, DMI type 132, 7 bytes
> OEM-specific Type
> 	Header and Data:
> 		84 07 39 00 01 D8 36
> 
> Handle 0x003A, DMI type 133, 5 bytes
> OEM-specific Type
> 	Header and Data:
> 		85 05 3A 00 01
> 	Strings:
> 		KHOIHGIUCCHHII
> 
> Handle 0x003B, DMI type 126, 13 bytes
> Inactive
> 
> Handle 0x003C, DMI type 127, 4 bytes
> End Of Table
> 
> ------
> 
> Thx,
> 
> <earny>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

