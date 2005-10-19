Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVJSRyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVJSRyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVJSRyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:54:11 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:40673 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751190AbVJSRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:54:10 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Date: Wed, 19 Oct 2005 10:54:04 -0700
User-Agent: KMail/1.8.91
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rob@janerob.com
References: <20051015185502.GA9940@plato.virtuousgeek.org> <200510170930.33530.jbarnes@virtuousgeek.org> <4353F290.10009@s5r6.in-berlin.de>
In-Reply-To: <4353F290.10009@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191054.04852.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 17, 2005 11:50 am, Stefan Richter wrote:
> Jesse Barnes wrote:
> >>Jesse, what DMI_PRODUCT_NAME matches your laptop?
> >
> > I'll have to check when I get home, is the relevant info from the
> > "System Information" section of the dmidecode output?
>
> AFAICT yes. Although I wonder if there is a better suited part of the
> DMI table to look at. From what Rob posted, we could simply match
> {DMI_SYS_VENDOR, "TOSHIBA"} && {DMI_PRODUCT_VERSION, "PS5"} which
> probably catches all Satellite 5xxx's. I hope this isn't too general.
>
> I also wonder how 1394 CardBus cards would react on this patch in
> affected Toshibas...

It should be harmless, right?  I don't have any way of testing since I 
don't have such a card myself.  Here's the dmidecode output from my 
machine.

Thanks,
Jesse

# dmidecode 2.7
SMBIOS 2.3 present.
45 structures occupying 1419 bytes.
Table at 0x000EB160.

Handle 0x0000, DMI type 0, 20 bytes.
BIOS Information
        Vendor: TOSHIBA
        Version: Version 1.20
        Release Date: 01/24/2005
        Address: 0xEB000
        Runtime Size: 84 kB
        ROM Size: 512 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PC Card (PCMCIA) is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                BIOS ROM is socketed
                EDD is supported
                Japanese floppy for NEC 9800 1.2 MB is supported (int 
13h)
                3.5"/720 KB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                Smart battery is supported
                Function key-initiated network boot is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
        Manufacturer: TOSHIBA
        Product Name: Satellite M45
        Version: PSM40U-01X001
        Serial Number: 15106102Q
        UUID: 60178840-7169-11D9-A70E-00A0D1BB8852
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 17 bytes.
Base Board Information
        Manufacturer: TOSHIBA
        Product Name: Portable PC
        Version: Version A0
        Serial Number: 0000000000
        Asset Tag: Not Specified
        Features: None
        Location In Chassis: Not Specified
        Chassis Handle: 0x0000
        Type: Other
        Contained Object Handles: 0

Handle 0x0003, DMI type 3, 17 bytes.
Chassis Information
        Manufacturer: TOSHIBA
        Type: Portable
        Lock: Not Present
        Version: Version 1.0
        Serial Number: 00000000
        Asset Tag: 0000000000
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 32 bytes.
Processor Information
        Socket Designation: mFCPGA
        Type: Central Processor
        Family: Pentium M
        Manufacturer: GenuineIntelation
        ID: FF F9 E9 AF 00 00 00 00
        Signature: Type 3, Family 4073, Model 159, Stepping 15
        Flags: None
        Version: Pentium(R) M
        Voltage: 2.9 V
        External Clock: 133 MHz
        Max Speed: 1733 MHz
        Current Speed: 1733 MHz
        Status: Populated, Enabled
        Upgrade: None
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: Not Provided

Handle 0x0005, DMI type 7, 19 bytes.
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

Handle 0x0006, DMI type 7, 19 bytes.
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

Handle 0x0007, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: Serial Port
        Internal Connector Type: None
        External Reference Designator: J16
        External Connector Type: DB-9 male
        Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: Parallel Port
        Internal Connector Type: None
        External Reference Designator: J20
        External Connector Type: DB-25 male
        Port Type: Parallel Port ECP/EPP

Handle 0x0009, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: Kbd Connector
        Internal Connector Type: None
        External Reference Designator: J8
        External Connector Type: PS/2
        Port Type: Keyboard Port

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: Mouse Conn.
        Internal Connector Type: None
        External Reference Designator: J9
        External Connector Type: PS/2
        Port Type: Mouse Port

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: USB Conn.
        Internal Connector Type: None
        External Reference Designator: J12
        External Connector Type: Other
        Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: Dock Conn.
        Internal Connector Type: None
        External Reference Designator: J6
        External Connector Type: Other
        Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: VGA Conn.
        Internal Connector Type: None
        External Reference Designator: J7
        External Connector Type: Other
        Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: DC Input
        Internal Connector Type: None
        External Reference Designator: J35
        External Connector Type: Other
        Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: IrDA Port
        Internal Connector Type: None
        External Reference Designator: U1
        External Connector Type: Infrared
        Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: CardBus Conn.
        Internal Connector Type: None
        External Reference Designator: J26
        External Connector Type: Other
        Port Type: Cardbus

Handle 0x0011, DMI type 9, 13 bytes.
System Slot Information
        Designation: ISA Slot
        Type: 16-bit ISA
        Current Usage: Available
        Length: Long
        Characteristics: Unknown

Handle 0x0012, DMI type 9, 13 bytes.
System Slot Information
        Designation: PCI Slot
        Type: 32-bit PCI
        Current Usage: Available
        Length: Long
        ID: 4
        Characteristics: Unknown

Handle 0x0013, DMI type 10, 16 bytes.
On Board Device 1 Information
        Type: Other
        Status: Disabled
        Description: ECP Port
On Board Device 2 Information
        Type: Other
        Status: Disabled
        Description: 16550 UART
On Board Device 3 Information
        Type: Other
        Status: Disabled
        Description: IrDA Port
On Board Device 4 Information
        Type: Other
        Status: Enabled
        Description: CardBus Bridge
On Board Device 5 Information
        Type: Other
        Status: Enabled
        Description: IDE Controller
On Board Device 6 Information
        Type: Video
        Status: Enabled
        Description: Itl

Handle 0x0014, DMI type 11, 5 bytes.
OEM Strings
        String 1: PSM40U-01X001,SQ003520,11V

Handle 0x0015, DMI type 12, 5 bytes.
System Configuration Options
        Option 1: TOSHIBA

Handle 0x0016, DMI type 13, 22 bytes.
BIOS Language Information
        Installable Languages: 1
                en|US|iso8859-1
        Currently Installed Language: en|US|iso8859-1

Handle 0x0017, DMI type 16, 15 bytes.
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 2 GB
        Error Information Handle: 0x001D
        Number Of Devices: 2

Handle 0x0018, DMI type 16, 15 bytes.
Physical Memory Array
        Location: System Board Or Motherboard
        Use: Video Memory
        Error Correction Type: None
        Maximum Capacity: 64 MB
        Error Information Handle: Not Provided
        Number Of Devices: 1

Handle 0x0019, DMI type 16, 15 bytes.
Physical Memory Array
        Location: System Board Or Motherboard
        Use: Flash Memory
        Error Correction Type: None
        Maximum Capacity: 512 kB
        Error Information Handle: Not Provided
        Number Of Devices: 1

Handle 0x001A, DMI type 16, 15 bytes.
Physical Memory Array
        Location: System Board Or Motherboard
        Use: Cache Memory
        Error Correction Type: None
        Maximum Capacity: 2 MB
        Error Information Handle: Not Provided
        Number Of Devices: 1

Handle 0x001B, DMI type 17, 23 bytes.
Memory Device
        Array Handle: 0x0017
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: Unknown
        Locator: DRAM Slot 0
        Bank Locator: Banks 0/1
        Type: DDR
        Type Detail: EDO
        Speed: 333 MHz (3.0 ns)

Handle 0x001C, DMI type 17, 23 bytes.
Memory Device
        Array Handle: 0x0017
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: No Module Installed
        Form Factor: SODIMM
        Set: Unknown
        Locator: DRAM Slot 1
        Bank Locator: Banks 2/3
        Type: DDR
        Type Detail: EDO
        Speed: 333 MHz (3.0 ns)

Handle 0x001D, DMI type 18, 23 bytes.
32-bit Memory Error Information
        Type: Unknown
        Granularity: Memory Partition Level
        Operation: Unknown
        Vendor Syndrome: Unknown
        Memory Array Address: Unknown
        Device Address: Unknown
        Resolution: Unknown

Handle 0x001E, DMI type 19, 15 bytes.
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Array Handle: 0x0017
        Partition Width: 0

Handle 0x001F, DMI type 20, 19 bytes.
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x00003FFFFFF
        Range Size: 64 MB
        Physical Device Handle: 0x001B
        Memory Array Mapped Address Handle: 0x0003
        Partition Row Position: <OUT OF SPEC>

Handle 0x0020, DMI type 20, 19 bytes.
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x00003FFFFFF
        Range Size: 64 MB
        Physical Device Handle: 0x001C
        Memory Array Mapped Address Handle: 0x0003
        Partition Row Position: <OUT OF SPEC>

Handle 0x0021, DMI type 21, 7 bytes.
Built-in Pointing Device
        Type: Mouse
        Interface: PS/2
        Buttons: 2

Handle 0x0022, DMI type 22, 26 bytes.
Portable Battery
        Location: Smart Battery Conn J37
        Manufacturer: Duracell
        Manufacture Date: 01/06/97
        Serial Number: 0042
        Name: DR36
        Design Capacity: Unknown
        Design Voltage: 12 mV
        SBDS Version: V1.0
        Maximum Error: Unknown
        SBDS Chemistry: Not Specified
        OEM-specific Information: 0x00000000

Handle 0x0023, DMI type 23, 13 bytes.
System Reset
        Status: Disabled
        Watchdog Timer: Not Present

Handle 0x0024, DMI type 24, 5 bytes.
Hardware Security
        Power-On Password Status: Disabled
        Keyboard Password Status: Not Implemented
        Administrator Password Status: Disabled
        Front Panel Reset Status: Not Implemented

Handle 0x0025, DMI type 25, 9 bytes.
        System Power Controls
        Next Scheduled Power-on: *-* 00:00:00

Handle 0x0026, DMI type 26, 22 bytes.
Voltage Probe
        Description: Voltage Probe Description
        Location: Unknown
        Status: Unknown
        Maximum Value: Unknown
        Minimum Value: Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000
        Nominal Value: 0.000 V

Handle 0x0027, DMI type 27, 14 bytes.
Cooling Device
        Temperature Probe Handle: 0x0028
        Type: Unknown
        Status: Unknown
        OEM-specific Information: 0x00000000
        Nominal Speed: 0 rpm

Handle 0x0028, DMI type 28, 22 bytes.
Temperature Probe
        Description: Temperature Probe Description
        Location: Unknown
        Status: Unknown
        Maximum Value: Unknown
        Minimum Value Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000
        Nominal Value: 0.0 deg C

Handle 0x0029, DMI type 29, 22 bytes.
Electrical Current Probe
        Description: Electrical Probe Description
        Location: Unknown
        Status: Unknown
        Maximum Value: Unknown
        Minimum Value: Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000
        Nominal Value: 0.000 A

Handle 0x002A, DMI type 30, 6 bytes.
Out-of-band Remote Access
        Manufacturer Name: Manufacturer Name
        Inbound Connection: Disabled
        Outbound Connection: Disabled

Handle 0x002B, DMI type 32, 11 bytes.
System Boot Information
        Status: No errors detected

Handle 0x002C, DMI type 127, 4 bytes.
End Of Table

