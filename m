Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTKHTFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKHTFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:05:46 -0500
Received: from scanmail1.cableone.net ([24.116.0.121]:55814 "EHLO
	scanmail1.cableone.net") by vger.kernel.org with ESMTP
	id S262041AbTKHTEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:04:54 -0500
Message-ID: <3FAD3E45.3040003@cableone.net>
Date: Sat, 08 Nov 2003 12:04:37 -0700
From: Gary Wolfe <gpwolfe@cableone.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [crash/panic] Linux-2.6.0-test9
References: <3FA5FFF7.2020006@cableone.net> <Pine.LNX.4.44.0311030834230.20373-100000@home.osdl.org> <20031103232526.GC16854@neo.rr.com>
In-Reply-To: <20031103232526.GC16854@neo.rr.com>
Content-Type: multipart/mixed;
 boundary="------------090701030905020508030806"
X-SMTP-HELO: cableone.net
X-SMTP-MAIL-FROM: gpwolfe@cableone.net
X-SMTP-PEER-INFO: 24-116-194-85.cpe.cableone.net [24.116.194.85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090701030905020508030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adam Belay wrote:

>On Mon, Nov 03, 2003 at 08:37:30AM -0800, Linus Torvalds wrote:
>  
>
>>On Mon, 3 Nov 2003, Gary Wolfe wrote:
>>    
>>
>>>Tried test8 and, now, test9 and both exhibit same problem.
>>>
>>>The issue seems to be related to the PnPBIOS support under the Plug and
>>>Play Kconfig category.  When enabled I get a crash of the form:
>>>      
>>>
>>Yes. The crash happens inside the BIOS itself, and the kernel doesn't
>>really have any control over it. The most Adam could possibly do is to
>>avoid calling the BIOS (or at least avoid _certain_ calls), but that would
>>require knowing what it is that triggers it.
>>    
>>
>
>One of the most common triggers is requesting for the dynamic (currently
>assigned) resource information.  This tends to happen with particular device
>nodes, from what I've seen typically the mouse controller, but I don't have a
>large enough sample space to make a generalization.  I've made some
>modifications to the PnPBIOS call function in the past and they seem to solve
>this problem for many of the buggy systems.
>
>  
>
>>Has PnP support ever worked for you on this board? Sometimes the solution
>>is to just say "it's dead, Jim", and just not enable it. There are few
>>enough systems that actually want PnP.
>>
>>Adam, any ideas?
>>
>>		Linus
>>    
>>
>
>I've included a patch that encourages the PnPBIOS to make more conservative
>calls and it should help with situations such as this one.  I'd like to see a
>dmi_scan for this system, if it is possible, so I can blacklist certain PnPBIOS
>features on it.  I've also attached a patch that makes the pnpbios proc
>interface an optional feature. The proc interface allows users to make PnPBIOS
>calls without restrictions and as a result can cause problems on some buggy
>systems. (one example is the recent ESCD problems posted on lkml)  Finally, the
>Kconfig help has been updated to better reflect this viewpoint.
>
>Please let me know if any of this helps.  I'd predict it will boot properly with
>the first patch applied.
>
>Thanks,
>Adam
>
>  
>
Sorry it took me so long to get back but work is taking up most of my 
free time as of late.  In any event, I applied the patch to a clean 
test9, enabled the PNP support and the PNPBios sub option.  I did not 
check the sub option, the creation of the /proc interface.   It still 
crashes by the way.  Here's the output.

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5350
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5f3a, dseg 0xf0000
general protection fault: 0000 [#1]
CPU: 0
EIP: 0098:[<00002b60>]  Not tainted
EFLAGS: 00010087
EIP is at 0x2b60
eax: 000033d8 ebx: 0000007b ecx: 00020000 edx: 00000002
esi: dfed244e edi: 0000004d ebp: dfed0000 esp: dfed9ee6
ds: 00b0 es: 00b0 ss:0068
Process swapper (pid: 1, threadinfo=dfed8000 task=c151b900)
Stack: 000003d8 33d829d2 00000000 815d004d 0004cf3a 00020002 9f2c80fc 
cfeacff2
           61f90909 01090109 007b6054 0000007b 00a08000 601000b0 
00a85fd6 00000082
           000b0000 00010090 00b00000 00a00002 90590000 0060c01b 00020000
Call Trace:

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!

I don't know if you need all of that again but I figured it couldn't 
hurt.  Some of the stuff looks different from before.  As far as the 
dmi_dump goes, I'm not certain what you want or how to get that.  The 
best I could find out that sounds reasonable is the dmidecode app.  I've 
attached the output of that command.  If this is not what you wanted 
please let me know how to get what you want and I'll strive to get it to 
you.

Thanks for looking into this,

Gary




--------------090701030905020508030806
Content-Type: text/plain;
 name="p4c800_dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p4c800_dmidecode.txt"

PNP BIOS present.
RSD PTR found at 0xF9E60
checksum failed.
OEM ACPIAM
SMBIOS 2.3 present.
DMI 2.3 present.
68 structures occupying 2057 bytes.
DMI table at 0x000F04B0.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: American Megatrends Inc.
		Version: 080009  
		Release: 09/02/2003
		BIOS base: 0xF0000
		ROM size: 448K
		Capabilities:
			Flags: 0x000000017F8BDE90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: To Be Filled By O.E.M.
		Product: To Be Filled By O.E.M.
		Version: To Be Filled By O.E.M.
		Serial Number: To Be Filled By O.E.M.
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: ASUSTeK Computer Inc.
		Product: P4C800
		Version: Rev 1.xx
		Serial Number: MB-1234567890
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: Chassis Manufacture
		Chassis Type: Desktop
		Version: Chassis Version
		Serial Number: Chassis Serial Number
		Asset Tag: Asset-1234567890
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor
		Socket Designation: CPU 1
		Processor Type: Central Processor
		Processor Family: 
		Processor Manufacturer: Intel            
		Processor Version: Intel(R) Pentium(R) 4 CPU 2.40GHz                   
		Serial Number: To Be Filled By O.E.M.
		Asset Tag: To Be Filled By O.E.M.
		Vendor Part Number: To Be Filled By O.E.M.
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache
		Socket: L1-Cache
		L1 Internal Cache: 
		L1 Cache Size: 8K
		L1 Cache Maximum: 8K
		L1 Cache Type: Pipeline burst 
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache
		Socket: L2-Cache
		L2 Internal Cache: 
		L2 Cache Size: 512K
		L2 Cache Maximum: 512K
		L2 Cache Type: Pipeline burst 
Handle 0x0007
	DMI type 7, 19 bytes.
	Cache
		Socket: L3-Cache
		L3 Internal Cache: disabled
		L3 Cache Size: 0K
		L3 Cache Maximum: 0K
		L3 Cache Type: Unknown 
Handle 0x0008
	DMI type 5, 24 bytes.
	Memory Controller
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM A1
		Banks: 1 0
		Type: DIMM SDRAM 
		Installed Size: 512Mbyte (Double sided)
		Enabled Size: 512Mbyte (Double sided)
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM A2
		Banks: 3 2
		Type: UNKNOWN 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM B1
		Banks: 5 4
		Type: UNKNOWN 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000C
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM B2
		Banks: 7 6
		Type: UNKNOWN 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: PS2Mouse
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: Keyboard
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB3
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB4
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB5
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB6
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB7
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: USB8
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: LPT 1
		External Connector Type: DB-25 pin male
		Port Type: Parallel Port ECP/EPP
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: COM 1
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x0019
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: COM 2
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x001A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: Audio Mic In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x001B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: Audio Line In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x001C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: Audio Line Out
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: LAN
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x001E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: FireWire 1
		External Connector Type: 1394
		Port Type: FireWire (IEEE P1394)
Handle 0x001F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: FireWire 2
		External Connector Type: 1394
		Port Type: FireWire (IEEE P1394)
Handle 0x0020
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: MIDI
		External Connector Type: DB-15 pin female
		Port Type: MIDI Port
Handle 0x0021
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: 
		Internal Connector Type: None
		External Designator: Joy Stick
		External Connector Type: DB-15 pin female
		Port Type: Joy Stick Port
Handle 0x0022
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: AUX
		Internal Connector Type: On Board Sound Input from CD-ROM
		External Designator: 
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0023
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CD
		Internal Connector Type: On Board Sound Input from CD-ROM
		External Designator: 
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0024
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PRI_IDE
		Internal Connector Type: On Board IDE
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0025
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SEC_IDE
		Internal Connector Type: On Board IDE
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0026
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FLOPPY
		Internal Connector Type: On Board Floppy
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0027
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CHA_FAN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0028
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CPU_FAN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x0029
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PWR_FAN
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: ATXPWR
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CHASSIS
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FP_AUDIO
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SATA1
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SATA2
		Internal Connector Type: Other
		External Designator: 
		External Connector Type: None
		Port Type: Other
Handle 0x002F
	DMI type 9, 13 bytes.
	Card Slot
		Slot: AGP
		Type: 32bit Long 
		Status: Available.
		Slot Features: 3.3v 
Handle 0x0030
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI1
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0031
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI2
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0032
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI3
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0033
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI4
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0034
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI5
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0035
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description:  3COM 3C940 : Enabled
		Type: 
Handle 0x0036
	DMI type 11, 5 bytes.
	OEM Data
		To Be Filled By O.E.M.
		To Be Filled By O.E.M.
		To Be Filled By O.E.M.
		To Be Filled By O.E.M.
Handle 0x0037
	DMI type 13, 22 bytes.
	BIOS Language Information
Handle 0x0038
	DMI type 16, 15 bytes.
	Physical Memory Array
Handle 0x0039
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x003A
	DMI type 17, 27 bytes.
	Memory Device
Handle 0x003B
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x003C
	DMI type 17, 27 bytes.
	Memory Device
Handle 0x003D
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x003E
	DMI type 17, 27 bytes.
	Memory Device
Handle 0x003F
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0040
	DMI type 17, 27 bytes.
	Memory Device
Handle 0x0041
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0042
	DMI type 32, 20 bytes.
	System Boot Information
Handle 0x0043
	DMI type 127, 4 bytes.
	End-of-Table

--------------090701030905020508030806--


