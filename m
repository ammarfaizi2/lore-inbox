Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbRFVRqj>; Fri, 22 Jun 2001 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbRFVRq3>; Fri, 22 Jun 2001 13:46:29 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:27870 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S265484AbRFVRqR>; Fri, 22 Jun 2001 13:46:17 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE38E@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: For comment: draft BIOS use document for the kernel
Date: Fri, 22 Jun 2001 10:44:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks somewhat familiar.  8;)
(compare http://rddunlap.home.att.net/linit/lin240_init_x86.html) (blatant
plug)

Some comments below.


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]

> Linux 2.4 BIOS usage reference
> 
> 
> Boot Sequence
> -------------
> 
...
> 
> int 0x10 service 3 is used during the boot loading sequence 
> to obtain the
> cursor position. int 0x10 service 13 is used to display 
s/13/0x13/                         0x13

> loading messages
> as the loading procedure continues. int 0x10 AH=0xE is used 
> to display a
> progress bar of '=' characters during the bootstrap
s/=/./            '.'


> Memory Sizing
> -------------
> 
> Firstly a call is made to BIOS INT 15  AX=0xE820 in order to read the
s/15/0x15/

> E820 map. A maximum of 32 blocks are supported by current kernels. The
> 'SMAP' signature is required and tested. In addition the SMAP 
> signature
> is restored each call, although not required by the 
> specification in order to handle some know BIOS bugs.
> 
> If the E820 call fails then the INT 15 AX=0xE801 service is 
s/15/0x15/

> called and the
> results are sanity checked. In particular the code zeroes the 
> CX/DX return 
> values in order to detect BIOS implementations that do not set them 
> usable memory data. It also handles older BIOSes that return 
> AX/BX but not AX/BX data.
???             CX/DX instead?


> Peripherals
> -----------
> 
...
> 
> Having completed video set up the hard disk data for hda and 
> hdb is copied
> from the low memory BIOS area into the kernel tables. INT 
> 0x13 AH-0x15 is
s/-/=/


> 32bit Bootstrap
> ---------------
> 
...
> 
> In the majority of systems the kernel will directly invoke 
> type 1 or type 2
> configuration. In this situation the kernel will search for a $PIR PCI
> IRQ routing table in the BIOS area (0xF0000->0xFFFFF) with a 
> revision of 0x100 (1.0). 

However, the $PIR table is a Windows 98 requirement.  Hence it
is not required for newer versions of Windows and also does not
apply to MP systems (unless the MP BIOS table is not being used).
(http://www.microsoft.com/HWDEV/busbios/PCIIRQ.htm)

$PIR *is* still used in Windows 2000 if available:
http://www.microsoft.com/HWDEV/cardbus/Spir.htm


> Power Management and BIOS Bugs
> ------------------------------
> 
...

> Finally the battery status querying can be disabled to work 
> around a small
> number of BIOSes which crash when this function is used from 
> 32bit space.
> These options can be keyed from the DMI table scanner, so 
> that, if we are
> made aware of BIOSes requiring options set specific ways we can
> automatically set the options correctly for that BIOS without user
> intervention.

Didn't you disable DMI scan recently, in favor of userspace
DMI tools?


> Future Paths
> ------------
> 
> Intel are currently working on ACPI support for Linux. While 
> much of this is
> functional it is not yet stable enough that vendors enable 
> it. Linux does
> not require APM services to do minimal power management, nor 
> does it require
> PnPBIOS services to function happily. It does however need to 
> know about 
> interrupt routing. For minimal Linux compatibility a 'legacy 
> free' BIOS
> should probably provide the $PIR table, even if it does not 
> provide non ACPI versions of other services.

Sorry, legacy-free => ACPI, certainly not a $PIR table IMO.

Personally I'd like to explore adding support to Linux for
the Simple Boot Flag spec.
(http://www.microsoft.com/HWDEV/desinit/simp_bios.htm

~Randy
(not speaking for Intel)

