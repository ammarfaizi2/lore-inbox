Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVBPO0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVBPO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVBPO0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:26:16 -0500
Received: from relay1.oslo.kommune.no ([171.23.1.11]:57762 "EHLO
	relay1.oslo.kommune.no") by vger.kernel.org with ESMTP
	id S262018AbVBPOZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:25:56 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <200502151742.55362.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108482083.12031.10.camel@elrond.flymine.org>
	 <42122054.8010408@colitti.com>  <200502151742.55362.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 15:25:26 +0100
Message-Id: <1108563926.4986.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 15,.02.2005 kl. 17.42 +0000, skrev Alistair John Strachan:
> On Tuesday 15 Feb 2005 16:16, Lorenzo Colitti wrote:
> [snip]
> >
> > Ok, here is the output from dmidecode (Debian package) and from lspci. I
> > don't have acpidmp and I don't know where to get it, but if you think
> > it's necessary I can download it if you tell me where to find it.
> 
> Find below a diff of my dmidecode output versus Lorenzo's. Nothing much
> to call home about.
> 
I've attached a diff against Lorenzo's too. Only difference is that my
laptop is a nc4010, and looking here it's clear that this model doesn't
support APM at least. I also have non-working S3. It behaves just like
the entry in the ubuntu wiki for the nc6000 in all three cases with a
full system running at least. I'll try init=/bin/sh later to see if that
helps and if it does experiment with removing modules one by one...

--- dmidecode	2005-02-16 15:17:02.127419209 +0100
+++ dmi.out	2005-02-16 15:16:43.142505944 +0100
@@ -1,21 +1,20 @@
 # dmidecode 2.5
 SMBIOS 2.3 present.
-31 structures occupying 1354 bytes.
-Table at 0x000FF2EB.
+31 structures occupying 1342 bytes.
+Table at 0x000FC06F.
 Handle 0x0000
 	DMI type 0, 20 bytes.
 	BIOS Information
 		Vendor: Hewlett-Packard
-		Version: 68BDD Ver. F.0F
-		Release Date: 07/23/2004
+		Version: 68BAS Ver. F.2F
+		Release Date: 12/10/2004
 		Address: 0xE0000
 		Runtime Size: 128 kB
-		ROM Size: 1024 kB
+		ROM Size: 512 kB
 		Characteristics:
 			PCI is supported
 			PC Card (PCMCIA) is supported
 			PNP is supported
-			APM is supported
 			BIOS is upgradeable
 			BIOS shadowing is allowed
 			Boot from CD is supported
@@ -37,27 +36,27 @@ Handle 0x0001
 	DMI type 1, 25 bytes.
 	System Information
 		Manufacturer: Hewlett-Packard
-		Product Name: HP Compaq nc6000 (DJ254A#ABB)   
-		Version: F.0F
-		Serial Number: XXXXXXXXXX                      
-		UUID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
+		Product Name: HP Compaq nc4010 (DY885AA#ABN)  
+		Version: F.2F                      
+		Serial Number: XXXXXXXXXX
+		UUID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
 		Wake-up Type: Power Switch
 Handle 0x0002
 	DMI type 2, 8 bytes.
 	Base Board Information
 		Manufacturer: Hewlett-Packard
-		Product Name: 0890
-		Version: 8051 Version 1A.19
+		Product Name: 0834
+		Version: KBC Version 20.37
 		Serial Number: Not Specified
 Handle 0x0003
 	DMI type 3, 13 bytes.
 	Chassis Information
-		Manufacturer: Hewlett-Packard
+		Manufacturer: Hewlett-Packard                      
 		Type: Notebook
 		Lock: Not Present
 		Version: Not Specified
-		Serial Number: XXXXXXXXXX                      
-		Asset Tag:                 
+		Serial Number: CNU442FBGX
+		Asset Tag: CNU442FBGX      
 		Boot-up State: Safe
 		Power Supply State: Safe
 		Thermal State: Safe
@@ -69,8 +68,8 @@ Handle 0x0004
 		Type: Central Processor
 		Family: Pentium M
 		Manufacturer: Intel(R)
-		ID: XX XX XX XX XX XX XX XX
-		Signature: Type 0, Family 6, Model 9, Stepping 5
+		ID: D6 06 00 00 BF F9 E9 AF
+		Signature: Type 0, Family 6, Model 13, Stepping 6
 		Flags:
 			FPU (Floating-point unit on-chip)
 			VME (Virtual mode extension)
@@ -93,13 +92,14 @@ Handle 0x0004
 			FXSR (Fast floating-point save and restore)
 			SSE (Streaming SIMD extensions)
 			SSE2 (Streaming SIMD extensions 2)
+			SS (Self-snoop)
 			TM (Thermal monitor supported)
 			SBF (Signal break on FERR)
-		Version: Intel(R) Pentium(R) M processor 1400MHz        
-		Voltage: 1.8 V
+		Version: Intel(R) Pentium(R) M processor 1.80GHz        
+		Voltage: 1.1 V
 		External Clock: 100 MHz
-		Max Speed: 1400 MHz
-		Current Speed: 1400 MHz
+		Max Speed: 1800 MHz
+		Current Speed: 1800 MHz
 		Status: Populated, Enabled
 		Upgrade: None
 		L1 Cache Handle: 0x0005
@@ -121,25 +121,25 @@ Handle 0x0005
 			Burst
 		Installed SRAM Type: Burst
 		Speed: Unknown
-		Error Correction Type: Unknown
+		Error Correction Type: None
 		System Type: Unified
-		Associativity: 4-way Set-associative
+		Associativity: 8-way Set-associative
 Handle 0x0006
 	DMI type 7, 19 bytes.
 	Cache Information
 		Socket Designation: Internal L2 Cache
 		Configuration: Enabled, Not Socketed, Level 2
 		Operational Mode: Write Back
-		Location: External
-		Installed Size: 1024 KB
-		Maximum Size: 1024 KB
+		Location: Internal
+		Installed Size: 2048 KB
+		Maximum Size: 2048 KB
 		Supported SRAM Types:
 			Burst
 		Installed SRAM Type: Burst
 		Speed: Unknown
 		Error Correction Type: None
 		System Type: Unified
-		Associativity: 4-way Set-associative
+		Associativity: 8-way Set-associative
 Handle 0x0007
 	DMI type 9, 13 bytes.
 	System Slot Information
@@ -156,9 +156,11 @@ Handle 0x0007
 			Modem ring resume is supported
 			PME signal is supported
 Handle 0x0008
-	DMI type 11, 5 bytes.
-	OEM Strings
-		String 1: www.compaq.com
+	DMI type 10, 6 bytes.
+	On Board Device Information
+		Type: Video
+		Status: Enabled
+		Description: 64
 Handle 0x0009
 	DMI type 13, 22 bytes.
 	BIOS Language Information
@@ -180,7 +182,7 @@ Handle 0x000B
 		Location: System Board Or Motherboard
 		Use: Flash Memory
 		Error Correction Type: None
-		Maximum Capacity: 1 MB
+		Maximum Capacity: 512 kB
 		Error Information Handle: Not Provided
 		Number Of Devices: 1
 Handle 0x000C
@@ -190,18 +192,18 @@ Handle 0x000C
 		Error Information Handle: No Error
 		Total Width: 64 bits
 		Data Width: 64 bits
-		Size: 256 MB
+		Size: 512 MB
 		Form Factor: SODIMM
 		Set: None
 		Locator: DIMM #1
-		Bank Locator: 030B2C25
+		Bank Locator: Not Specified
 		Type: DDR
 		Type Detail: Synchronous
 		Speed: 142 MHz (7.0 ns)
 		Manufacturer: Not Specified
-		Serial Number: Not Specified
+		Serial Number: 770EB63A
 		Asset Tag: Not Specified
-		Part Number: Not Specified
+		Part Number: 16VDDF6464HG-335G2
 Handle 0x000D
 	DMI type 17, 27 bytes.
 	Memory Device
@@ -209,18 +211,18 @@ Handle 0x000D
 		Error Information Handle: No Error
 		Total Width: 64 bits
 		Data Width: 64 bits
-		Size: 256 MB
+		Size: 512 MB
 		Form Factor: SODIMM
 		Set: None
 		Locator: DIMM #2
-		Bank Locator: 051FD180
+		Bank Locator: Not Specified
 		Type: DDR
 		Type Detail: Synchronous
 		Speed: 142 MHz (7.0 ns)
 		Manufacturer: Not Specified
-		Serial Number: XXXXXXXXXXXX-XXXXX
+		Serial Number: A807A11B
 		Asset Tag: Not Specified
-		Part Number: Not Specified
+		Part Number: 16VDDF6464HG-335G2
 Handle 0x000E
 	DMI type 17, 27 bytes.
 	Memory Device
@@ -231,7 +233,7 @@ Handle 0x000E
 		Size: 1024 kB
 		Form Factor: Chip
 		Set: None
-		Locator: SST49F008A
+		Locator: SST49LF040
 		Bank Locator: Not Specified
 		Type: Flash
 		Type Detail: Non-Volatile
@@ -244,8 +246,8 @@ Handle 0x000F
 	DMI type 19, 15 bytes.
 	Memory Array Mapped Address
 		Starting Address: 0x00000000000
-		Ending Address: 0x0001FFFFFFF
-		Range Size: 512 MB
+		Ending Address: 0x0003FFFFFFF
+		Range Size: 1 GB
 		Physical Array Handle: 0x000A
 		Partition Width: 0
 Handle 0x0010
@@ -260,17 +262,17 @@ Handle 0x0011
 	DMI type 20, 19 bytes.
 	Memory Device Mapped Address
 		Starting Address: 0x00000000000
-		Ending Address: 0x0000FFFFFFF
-		Range Size: 256 MB
+		Ending Address: 0x0001FFFFFFF
+		Range Size: 512 MB
 		Physical Device Handle: 0x000C
 		Memory Array Mapped Address Handle: 0x000F
 		Partition Row Position: 1
 Handle 0x0012
 	DMI type 20, 19 bytes.
 	Memory Device Mapped Address
-		Starting Address: 0x00010000000
-		Ending Address: 0x0001FFFFFFF
-		Range Size: 256 MB
+		Starting Address: 0x00020000000
+		Ending Address: 0x0003FFFFFFF
+		Range Size: 512 MB
 		Physical Device Handle: 0x000D
 		Memory Array Mapped Address Handle: 0x000F
 		Partition Row Position: 2
@@ -294,7 +296,7 @@ Handle 0x0015
 	Portable Battery
 		Location: Primary
 		Manufacturer: Hewlett-Packard
-		Manufacture Date: 12/12/2003
+		Manufacture Date: 09/28/2004
 		Serial Number: 00001       
 		Name: Not Specified
 		Chemistry: Lithium Ion
@@ -357,12 +359,12 @@ Handle 0x0085
 	DMI type 133, 34 bytes.
 	OEM-specific Type
 		Header and Data:
-			85 22 85 00 01 30 11 1F 0D CE 0B 02 00 6E 00 15
-			00 24 30 B2 00 5C 2B 02 80 00 00 00 0D 10 13 10
-			05 10
+			85 22 85 00 01 10 0E 86 0B 33 0B 02 00 6A 00 24
+			00 B2 30 00 00 5C 2B 02 E0 00 00 00 37 10 44 10
+			39 10
 		Strings:
-			00001 12/12/2003
-			HP                
+			00001 09/28/2004
+			SIMPLO            
 Handle 0x0086
 	DMI type 126, 34 bytes.
 	Inactive

[root@localhost kmaraas]# lspci
00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M]
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
00:09.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
00:0b.0 CardBus bridge: O2 Micro, Inc. OZ711M1 SmartCardBus MultiMediaBay Controller (rev 20)
00:0b.1 CardBus bridge: O2 Micro, Inc. OZ711M1 SmartCardBus MultiMediaBay Controller (rev 20)
00:0b.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay Accelerator
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:12.0 USB Controller: NEC Corporation USB (rev 43)
00:12.1 USB Controller: NEC Corporation USB (rev 43)
00:12.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
00:13.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M Gigabit Ethernet (rev 03)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 330M/340M/350M

Cheers
Kjartan


