Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJVU3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJVU3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWJVU3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:29:24 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44884 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751422AbWJVU3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:29:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type;
	b=fHMWvTTepyao72WF+N77IkERGeiyKD3C75Ap7dG39cZAaxw/Vkb9umCJGGgGkkcZb
	Gm4nPIyI9c4u7Ecoqgjuw==
Message-ID: <453BD41B.4010007@google.com>
Date: Sun, 22 Oct 2006 13:27:07 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Strange errors from e1000 driver (2.6.18)
References: <453BBC9E.4040300@google.com> <453BC0E7.1060308@mbligh.org> <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>
In-Reply-To: <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040706060208020709020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706060208020709020104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Brandeburg wrote:
> On 10/22/06, Martin J. Bligh <mbligh@mbligh.org> wrote:
>> Martin J. Bligh wrote:
>> > I'm getting a lot of these type of errors if I run 2.6.18. If
>> > I run the standard Ubuntu Dapper kernel, I don't get them.
>> > What do they indicate?
> 
> Hi Martin, they indicate that you're getting transmit hangs.  Means
> your hardware is having issues with some of the buffers it is being
> handed.  Because the TDH and TDT noted below are not equal, it means
> the hardware is hung processing buffers that the driver gave to it.
> 
> We need the standard bug report particulars,

Sure.

> lspci -vv, 

0000:00:0a.0 Ethernet controller: Intel Corporation 82546EB Gigabit 
Ethernet Con
troller (Copper) (rev 01)
         Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at ef020000 (64-bit, non-prefetchable) [size=128K]
         Region 4: I/O ports at a000 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot
+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4]      Capabilities: [f0] Message Signalled 
Interrupts:
  64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

0000:00:0a.1 Ethernet controller: Intel Corporation 82546EB Gigabit 
Ethernet Con
troller (Copper) (rev 01)
         Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at ef000000 (64-bit, non-prefetchable) [size=128K]
         Region 4: I/O ports at a400 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot
+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4]      Capabilities: [f0] Message Signalled 
Interrupts:
  64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

> cat /proc/interrupts, 

            CPU0
   0:  146271373          XT-PIC  timer
   1:     179459          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:    1975991          XT-PIC  ehci_hcd:usb2, VIA8237, eth0
   6:          2          XT-PIC  floppy
  10:          0          XT-PIC  uhci_hcd:usb4, uhci_hcd:usb5, 
uhci_hcd:usb6
  11:          0          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb3, 
uhci_hcd:usb7, uhci_hcd:usb8
  12:    2758142          XT-PIC  i8042
  14:    6344745          XT-PIC  ide0
  15:   20014468          XT-PIC  ide1
NMI:          0
LOC:  146264664
ERR:      52805

> dmesg

Did that bit already.

> ethtool -e eth0,

root@titus:/usr/local/autotest/bin # ethtool -e eth0
Offset          Values
------          ------
0x0000          00 07 e9 09 0b 08 30 05 ff ff ff ff ff ff ff ff
0x0010          44 a9 03 98 0b 46 11 10 86 80 10 10 86 80 68 34
0x0020          0c 00 10 10 00 00 02 21 c8 18 ff ff ff ff ff ff
0x0030          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0040          0c c3 61 78 04 50 02 21 c8 08 ff ff ff ff ff ff
0x0050          ff ff ff ff ff ff ff ff ff ff ff ff ff ff 02 06
0x0060          2c 00 00 40 07 11 00 00 2c 00 00 40 ff ff ff ff
0x0070          ff ff ff ff ff ff ff ff ff ff ff ff ff ff 4f 29
0x0080          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0090          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00a0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00b0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00c0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00d0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00e0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x00f0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0100          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0110          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0120          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0130          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0140          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0150          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0160          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0170          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0180          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0190          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01a0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01b0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01c0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01d0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01e0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x01f0          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

> and maybe output of
> dmidecode, etc. 

Attached.

> only a little.  There are so many different pieces of e1000 hardware
> and so few specifics in this report that I'll be able to tell you lots
> more when you get us the info requested.

Thanks. Not sure if the bug wasn't there in earlier kernels, or if we
just weren't printing anything.

M.

--------------040706060208020709020104
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.7
SMBIOS 2.2 present.
37 structures occupying 959 bytes.
Table at 0x000F0800.

Handle 0x0000, DMI type 0, 19 bytes.
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 09/13/2004
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 256 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
	Manufacturer: VIA Technologies, Inc.
	Product Name: KT600-8237
	Version:  
	Serial Number:  
	UUID: Not Present
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer:  
	Product Name: KT600-8237
	Version:  
	Serial Number:  

Handle 0x0003, DMI type 3, 13 bytes.
Chassis Information
	Manufacturer:  
	Type: Desktop
	Lock: Not Present
	Version:  
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown

Handle 0x0004, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: Socket A
	Type: Central Processor
	Family: Athlon XP
	Manufacturer: AMD
	ID: A0 06 00 00 FF FB 83 03
	Signature: Family 6, Model A, Stepping 0
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
	Version: AMD Athlon(tm) XP
	Voltage: 1.5 V
	External Clock: 100 MHz
	Max Speed: 3000 MHz
	Current Speed: 1100 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0009
	L2 Cache Handle: 0x000A
	L3 Cache Handle: No L3 Cache

Handle 0x0005, DMI type 5, 22 bytes.
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: Four-way Interleave
	Maximum Memory Module Size: 32 MB
	Maximum Total Memory Size: 96 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		Standard
		EDO
	Memory Module Voltage: 5.0 V
	Associated Memory Slots: 3
		0x0006
		0x0007
		0x0008
	Enabled Error Correcting Capabilities: None

Handle 0x0006, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A0
	Bank Connections: 0 1
	Current Speed: 60 ns
	Type: Other SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A1
	Bank Connections: 2 3
	Current Speed: 60 ns
	Type: Other SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A2
	Bank Connections: None
	Current Speed: 60 ns
	Type: Unknown
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0009, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000A, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Other
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: AUDIO
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0015, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0016, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0017, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0018, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI3
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0019, DMI type 9, 13 bytes.
System Slot Information
	Designation: AGP
	Type: 32-bit AGP
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided

Handle 0x001A, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x001B, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 3 GB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x001C, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None

Handle 0x001D, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: A1
	Bank Locator: Bank2/3
	Type: Unknown
	Type Detail: None

Handle 0x001E, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None

Handle 0x001F, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x001B
	Partition Width: 0

Handle 0x0020, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001C
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0021, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001D
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0022, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x001E
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0023, DMI type 32, 11 bytes.
System Boot Information
	Status: No errors detected

Handle 0x0024, DMI type 127, 4 bytes.
End Of Table


--------------040706060208020709020104--
