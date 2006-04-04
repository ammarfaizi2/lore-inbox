Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDDSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDDSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDDSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:53:56 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:50409 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbWDDSxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:53:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:content-type:date:message-id:mime-version:x-mailer;
        b=r3+NGp4FMDax8KRWjlZxt6ed9DaEBn+7Ri67YxLPUvTsrjmhbkWmUi+QKHaYZxhRE4bsnM0siBzf1znVvcyG21/ZwrTGcBH3whB0f39EGVnKdyAkBPgRYwKcUTNtwr68T74ba6gSImzmzQOfmXO8ySa8JXdzdvjV4F38pTJbZ88=
Subject: wistron_btns for Fujitsu N3510
From: John Reed Riley <john.reed.riley@gmail.com>
Reply-To: john.reed.riley@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Miloslav Trmac <mitr@volny.cz>
Content-Type: multipart/mixed; boundary="=-w0hBpUeux3HBDI3fO1d7"
Date: Tue, 04 Apr 2006 14:53:41 -0400
Message-Id: <1144176821.29288.10.camel@nox.abyss.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w0hBpUeux3HBDI3fO1d7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

After being pointed in the right direction by one of my friends, I
figured out how to get the multimedia buttons on my laptop working.
I've attached the patch to wistron_btns, along with the output of
dmidecode.

The buttons are labelled as follows:
0x11    A
0x12    B
0x36    WWW
0x31    ( picture of envelope )
0x71    Stop/Eject
0x72    Play/Pause
0x74    Rewind
0x78    Fast-Forward

Thanks for everyone's work on the module,
John Reed Riley


--=-w0hBpUeux3HBDI3fO1d7
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- drivers/input/misc/wistron_btns.c.orig	2006-03-30 21:01:13.000000000 -0500
+++ drivers/input/misc/wistron_btns.c	2006-03-30 21:16:54.000000000 -0500
@@ -273,6 +273,18 @@
 	{ KE_END,  0 }
 };
 
+static struct key_entry keymap_fujitsu_n3510[] = {
+	{ KE_KEY, 0x11, KEY_PROG1 },
+	{ KE_KEY, 0x12, KEY_PROG2 },
+	{ KE_KEY, 0x36, KEY_WWW },
+	{ KE_KEY, 0x31, KEY_MAIL },
+	{ KE_KEY, 0x71, KEY_STOPCD },
+	{ KE_KEY, 0x72, KEY_PLAYPAUSE },
+	{ KE_KEY, 0x74, KEY_REWIND },
+	{ KE_KEY, 0x78, KEY_FORWARD },
+	{ KE_END, 0 }
+};
+
 static struct key_entry keymap_wistron_ms2141[] = {
 	{ KE_KEY,  0x11, KEY_PROG1 },
 	{ KE_KEY,  0x12, KEY_PROG2 },
@@ -313,6 +325,15 @@
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Fujitsu N3510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N3510"),
+		},
+		.driver_data = keymap_fujitsu_n3510
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Acer Aspire 1500",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

--=-w0hBpUeux3HBDI3fO1d7
Content-Disposition: attachment; filename=dmi
Content-Type: text/plain; name=dmi; charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.6
SMBIOS 2.3 present.
27 structures occupying 868 bytes.
Table at 0x000EB960.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: FUJITSU/Insyde
		Version: Version 1.07
		Release Date: 01/29/2005
		Address: 0xEB700
		Runtime Size: 84224 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: FUJITSU
		Product Name: N3510
		Version: A0
		Serial Number: R5209607
		UUID: 809E9755-B28A-A115-88A0-000B5D688B0B
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 17 bytes.
	Base Board Information
		Manufacturer: FUJITSU
		Product Name: TOP01
		Version: 0
		Serial Number: 12345678
		Asset Tag: Not Specified
		Features: None
		Location In Chassis: Not Specified
		Chassis Handle: 0x0000
		Type: <OUT OF SPEC>
		Contained Object Handlers: 0
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information
		Manufacturer: AJR0E1A88E000000
		Type: Portable
		Lock: Not Present
		Version: A0
		Serial Number: 12345678
		Asset Tag: None
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: On Board
		Type: Central Processor
		Family: Pentium M
		Manufacturer: GenuineIntelation
		ID: FF FB E9 AF 00 00 00 00
		Signature: Type 3, Family 4075, Model 159, Stepping 15
		Flags: None
		Version: Pentium M
		Voltage: 2.9 V
		External Clock: 133 MHz
		Max Speed: 1733 MHz
		Current Speed: 1733 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: 0x0000
		Serial Number: Processor Serial Number
		Asset Tag: Asset_TAG
		Part Number: Part Number
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 2048 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: CardBus-1
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Unknown
		Length: Other
		ID: Adapter 0, Socket 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
			Hot-plug devices are supported
Handle 0x0008
	DMI type 11, 5 bytes.
	OEM Strings
		String 1:  
Handle 0x0009
	DMI type 15, 41 bytes.
	System Event Log
		Area Length: 1024 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Invalid, Not Full
		Change Token: 0x00000000
		Header Format: OEM-specific
		Supported Log Type Descriptors: 9
		Descriptor 1: POST memory resize
		Data Format 1: None
		Descriptor 2: POST error
		Data Format 2: POST results bitmap
		Descriptor 3: System reconfigured
		Data Format 3: None
		Descriptor 4: Log area reset/cleared
		Data Format 4: None
		Descriptor 5: System boot
		Data Format 5: None
		Descriptor 6: OEM-specific
		Data Format 6: None
		Descriptor 7: OEM-specific
		Data Format 7: None
		Descriptor 8: OEM-specific
		Data Format 8: None
		Descriptor 9: OEM-specific
		Data Format 9: None
Handle 0x000A
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 2 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x000B
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000A
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: Unknown
		Locator: DIMM1
		Bank Locator: Bank 0/1
		Type: Other
		Type Detail: Synchronous
		Speed: 400 MHz (2.5 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000C
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000A
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: Unknown
		Locator: DIMM2
		Bank Locator: Banks 2/3
		Type: Other
		Type Detail: Synchronous
		Speed: 400 MHz (2.5 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000D
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x000A
		Partition Width: 0
Handle 0x000E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000B
		Memory Array Mapped Address Handle: 0x0004
		Partition Row Position: <OUT OF SPEC>
Handle 0x000F
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000C
		Memory Array Mapped Address Handle: 0x0004
		Partition Row Position: <OUT OF SPEC>
Handle 0x0010
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Mouse
		Interface: PS/2
		Buttons: 2
Handle 0x0011
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Internal Battery
		Manufacturer: Fujitsu
		Manufacture Date: 08/10/04
		Serial Number: Not Support
		Name: Li-ion(6cell);CP212456-XX,Li-ion(9cell);CP212456-XX
		Design Capacity: Unknown
		Design Voltage: 12 mV
		SBDS Version: V1.0
		Maximum Error: Unknown
		SBDS Chemistry: Not Specified
		OEM-specific Information: 0x00000000
Handle 0x0012
	DMI type 32, 20 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0013
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0014
	DMI type 143, 16 bytes.
	OEM-specific Type
		Header and Data:
			8F 10 14 00 00 5F 46 4A 5F 4F 45 4D 5F 12 00 00
Handle 0x0015
	DMI type 143, 8 bytes.
	OEM-specific Type
		Header and Data:
			8F 08 15 00 01 03 00 00
Handle 0x0016
	DMI type 143, 11 bytes.
	OEM-specific Type
		Header and Data:
			8F 0B 16 00 02 00 01 20 03 00 05
Handle 0x0017
	DMI type 143, 7 bytes.
	OEM-specific Type
		Header and Data:
			8F 07 17 00 02 01 01
Handle 0x0018
	DMI type 143, 7 bytes.
	OEM-specific Type
		Header and Data:
			8F 07 18 00 02 02 01
Handle 0x0019
	DMI type 143, 16 bytes.
	OEM-specific Type
		Header and Data:
			8F 10 19 00 03 01 00 00 00 00 00 00 00 00 00 00
Handle 0x001A
	DMI type 127, 4 bytes.
	End Of Table

--=-w0hBpUeux3HBDI3fO1d7--

