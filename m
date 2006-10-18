Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWJRSpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWJRSpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWJRSpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:45:32 -0400
Received: from dxa00.wellsfargo.com ([151.151.65.115]:32425 "EHLO
	dxa00.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1161258AbWJRSpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:45:31 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Touchscreen hardware hacking/driver hacking.
Date: Wed, 18 Oct 2006 13:45:17 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C6005@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Touchscreen hardware hacking/driver hacking.
Thread-Index: AcbyZNncqKnC3SUkQDuf91kXATGN/wAgB1ew
From: <Greg.Chandler@wellsfargo.com>
To: <chandleg@constellation.wizardsworks.org>, <dmitry.torokhov@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-input@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 18 Oct 2006 18:45:17.0825 (UTC) FILETIME=[8E773F10:01C6F2E5]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I was wrong about the kernel oops, it was for another driver that I
had not turned off. {which has now been reported seporately}

I was also wrong about it acting as if the button was always pressed.
It's just VERY sensitive.
I need to completely re-install my machine now to test it outside of
gpm.  I hosed the system in a futile bid to have a prototype X driver
work instead.

"Kevin K" has replied back saying that the Panasonic Toughbooks also
should use this driver. I've asked him if he would like to test a kernel
for one or a couple since his fix was in the 2.4 port.  If so I'd like
to throw all the additions into a patch and submit it all in one pass..




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg Chandler
Sent: Tuesday, October 17, 2006 9:31 PM
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org; linux-input@atrey.karlin.mff.cuni.cz
Subject: RE: Touchscreen hardware hacking/driver hacking.


I added the following to drivers/input/mouse/lifebook.c
        {
                .ident = "FLORA-ie 55mi",
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "FLORA-ie 55mi"),
                },
        },

It scrolled oopses for a little while then booted normally.
gpmd using /dev/mouse is taking input from the touchscreen. kind of....

If I move up or down on the screen it moves the cursor like a mouse
would, but it acts like the button is always pressed.


I'm happy that it accepts data at all but concerned about the oops 
scroll...  There is so much that it is pushed out of the dmesg log, and 
the kernel scrollback log.  I have no way of recording it {I can't
soldier 
down a pin header for serial}

Any ideas?


On Tue, 17 Oct 2006, Greg Chandler wrote:

>
> I'm not sure this will help all too much, but at least I have the
strings...
>
>
> Here is what dmidecode spat out:
>
> # dmidecode 2.8
> SMBIOS 2.3 present.
> 23 structures occupying 646 bytes.
> Table at 0x000DC010.
>
> Handle 0x0000, DMI type 0, 20 bytes
> BIOS Information
> 	Vendor: Phoenix Technologies Ltd.
> 	Version: 1.06VB
> 	Release Date: 03/13/2003
> 	Address: 0xE7A00
> 	Runtime Size: 99840 bytes
> 	ROM Size: 512 kB
> 	Characteristics:
> 		ISA is supported
> 		PCI is supported
> 		PC Card (PCMCIA) is supported
> 		PNP is supported
> 		APM is supported
> 		BIOS is upgradeable
> 		BIOS shadowing is allowed
> 		Selectable boot is supported
> 		EDD is supported
> 		Print screen service is supported (int 5h)
> 		8042 keyboard services are supported (int 9h)
> 		Serial services are supported (int 14h)
> 		Printer services are supported (int 17h)
> 		CGA/mono video services are supported (int 10h)
> 		ACPI is supported
> 		USB legacy is supported
> 		Smart battery is supported
> 		BIOS boot specification is supported
>
> Handle 0x0001, DMI type 1, 25 bytes
> System Information
> 	Manufacturer: HITACHI
> 	Product Name: FLORA-ie 55mi
> 	Version: crusoe/ALi1535
> 	Serial Number: 0
> 	UUID: 00000000-0000-0000-0000-FFFFFFFFFFFF
> 	Wake-up Type: Power Switch
>
> Handle 0x0002, DMI type 3, 17 bytes
> Chassis Information
> 	Manufacturer: HITACHI
> 	Type: Portable
> 	Lock: Not Present
> 	Version: crusoe/ALi1535
> 	Serial Number: XXXXXXXXXXXXXXXX
> 	Asset Tag: 0
> 	Boot-up State: Safe
> 	Power Supply State: Safe
> 	Thermal State: Safe
> 	Security Status: None
> 	OEM Information: 0x00001234
>
> Handle 0x0003, DMI type 4, 32 bytes
> Processor Information
> 	Socket Designation: CPU
> 	Type: Central Processor
> 	Family: K6-3
> 	Manufacturer: Transmeta
> 	ID: 43 05 00 00 3F 89 84 00
> 	Signature: Family 5, Model 4, Stepping 3
> 	Flags:
> 		FPU (Floating-point unit on-chip)
> 		VME (Virtual mode extension)
> 		DE (Debugging extension)
> 		PSE (Page size extension)
> 		TSC (Time stamp counter)
> 		MSR (Model specific registers)
> 		CX8 (CMPXCHG8 instruction supported)
> 		SEP (Fast system call)
> 		CMOV (Conditional move instruction supported)
> 		PSN (Processor serial number present and enabled)
> 		MMX (MMX technology supported)
> 	Version: Crusoe(tm)
> 	Voltage: 1.6 V
> 	External Clock: 66 MHz
> 	Max Speed: 400 MHz
> 	Current Speed: 400 MHz
> 	Status: Populated, Enabled
> 	Upgrade: None
> 	L1 Cache Handle: 0x0004
> 	L2 Cache Handle: 0x0005
> 	L3 Cache Handle: Not Provided
>
> Handle 0x0004, DMI type 7, 19 bytes
> Cache Information
> 	Socket Designation: Cache1
> 	Configuration: Enabled, Not Socketed, Level 1
> 	Operational Mode: Write Back
> 	Location: Internal
> 	Installed Size: 128 KB
> 	Maximum Size: 128 KB
> 	Supported SRAM Types:
> 		Pipeline Burst
> 	Installed SRAM Type: Pipeline Burst
> 	Speed: Unknown
> 	Error Correction Type: None
> 	System Type: Unknown
> 	Associativity: Unknown
>
> Handle 0x0005, DMI type 7, 19 bytes
> Cache Information
> 	Socket Designation: Cache2
> 	Configuration: Enabled, Not Socketed, Level 2
> 	Operational Mode: Write Back
> 	Location: Internal
> 	Installed Size: 256 KB
> 	Maximum Size: 256 KB
> 	Supported SRAM Types:
> 		Pipeline Burst
> 	Installed SRAM Type: None
> 	Speed: Unknown
> 	Error Correction Type: None
> 	System Type: Unknown
> 	Associativity: Unknown
>
> Handle 0x0006, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Specified
> 	Internal Connector Type: None
> 	External Reference Designator: SERIAL
> 	External Connector Type: None
> 	Port Type: Serial Port 16550A Compatible
>
> Handle 0x0007, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Specified
> 	Internal Connector Type: None
> 	External Reference Designator: USB1
> 	External Connector Type: Access Bus (USB)
> 	Port Type: USB
>
> Handle 0x0008, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Specified
> 	Internal Connector Type: None
> 	External Reference Designator: USB2
> 	External Connector Type: Access Bus (USB)
> 	Port Type: USB
>
> Handle 0x0009, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Specified
> 	Internal Connector Type: None
> 	External Reference Designator: MICROPHONE MINI JACK
> 	External Connector Type: Other
> 	Port Type: Other
>
> Handle 0x000A, DMI type 8, 9 bytes
> Port Connector Information
> 	Internal Reference Designator: Not Specified
> 	Internal Connector Type: None
> 	External Reference Designator: AUDIO OUT MINI JACK
> 	External Connector Type: Mini Jack (headphones)
> 	Port Type: Audio Port
>
> Handle 0x000D, DMI type 9, 13 bytes
> System Slot Information
> 	Designation: PCCARD SLOT1
> 	Type: 16-bit PC Card (PCMCIA)
> 	Current Usage: Unknown
> 	Length: Other
> 	ID: Adapter 0, Socket 1
> 	Characteristics:
> 		5.0 V is provided
> 		3.3 V is provided
> 		PC Card-16 is supported
> 		Modem ring resume is supported
>
> Handle 0x000E, DMI type 16, 15 bytes
> Physical Memory Array
> 	Location: System Board Or Motherboard
> 	Use: System Memory
> 	Error Correction Type: None
> 	Maximum Capacity: 128 MB
> 	Error Information Handle: Not Provided
> 	Number Of Devices: 1
>
> Handle 0x000F, DMI type 17, 23 bytes
> Memory Device
> 	Array Handle: 0x000E
> 	Error Information Handle: Not Provided
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 128 MB
> 	Form Factor: DIMM
> 	Set: 1
> 	Locator: Socket
> 	Bank Locator: Bank0
> 	Type: SDRAM
> 	Type Detail: Synchronous
> 	Speed: 100 MHz (10.0 ns)
>
> Handle 0x0010, DMI type 17, 23 bytes
> Memory Device
> 	Array Handle: 0x000E
> 	Error Information Handle: Not Provided
> 	Total Width: 64 bits
> 	Data Width: 64 bits
> 	Size: 112 MB
> 	Form Factor: DIMM
> 	Set: 2
> 	Locator: Base
> 	Bank Locator: Bank1
> 	Type: SDRAM
> 	Type Detail: Synchronous
> 	Speed: 100 MHz (10.0 ns)
>
> Handle 0x0011, DMI type 19, 15 bytes
> Memory Array Mapped Address
> 	Starting Address: 0x00000000000
> 	Ending Address: 0x0000EFFFFFF
> 	Range Size: 240 MB
> 	Physical Array Handle: 0x000E
> 	Partition Width: 0
>
> Handle 0x0012, DMI type 20, 19 bytes
> Memory Device Mapped Address
> 	Starting Address: 0x00000000000
> 	Ending Address: 0x00007FFFFFF
> 	Range Size: 128 MB
> 	Physical Device Handle: 0x000F
> 	Memory Array Mapped Address Handle: 0x0011
> 	Partition Row Position: Unknown
>
> Handle 0x0013, DMI type 20, 19 bytes
> Memory Device Mapped Address
> 	Starting Address: 0x00008000000
> 	Ending Address: 0x0000EFFFFFF
> 	Range Size: 112 MB
> 	Physical Device Handle: 0x0010
> 	Memory Array Mapped Address Handle: 0x0011
> 	Partition Row Position: Unknown
>
> Handle 0x0014, DMI type 21, 7 bytes
> Built-in Pointing Device
> 	Type: Track Ball
> 	Interface: PS/2
> 	Buttons: 0
>
> Handle 0x0015, DMI type 32, 20 bytes
> System Boot Information
> 	Status: <OUT OF SPEC>
>
> Handle 0x0016, DMI type 127, 4 bytes
> End Of Table
>
> Wrong DMI structures count: 23 announced, only 21 decoded.
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


