Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135751AbRAWBxP>; Mon, 22 Jan 2001 20:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135982AbRAWBxG>; Mon, 22 Jan 2001 20:53:06 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:62472 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S135751AbRAWBwy>; Mon, 22 Jan 2001 20:52:54 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF4C@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Duncan Laurie'" <duncan@virtualwire.org>
Cc: Petr Matula <pem@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: RE: int. assignment on SMP + ServerWorks chipset
Date: Mon, 22 Jan 2001 17:52:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Duncan Laurie [mailto:duncan@virtualwire.org]
> 
> On Mon, 22 Jan 2001, Randy.Dunlap wrote:
> 
> Hi Randy,
> 
> Oops, I knew it was an STL2, but somehow couldn't get it right in the
> message..  It looks like they both use ServerWorks LE chipsets, do you
> know if the SBT2 has the same problem?

I don't have an SBT2 to test, but it's likely that they share
this problem.  The only difference in them is supposed to be
SBT2 using bigger/faster processors.

> I did see that your BIOS is build 16 (STL20.86B.0016.P01.0010111108)
> while Petr has build 17 (STL20.86B.0017.P01.0011291152) which also
> appears to be the latest release.  Not that it has any affect on this
> particular problem, but it might explain why the patch worked for you
> and not him.
> 
> I looked at the Technical Product Specification,
> (ftp://download.intel.com/support/motherboards/server/stl2/stl
2_tps.pdf)
> and it appears that they have released BIOS updates to fix Errata 
> regarding Linux boot problems, so chances are good that it may be fixed
> by a future update.  Until then, the 'mpint' parameter patch seems
> pretty harmless, yet flexible enough to handle subtle differences
> in hardware and configuration.

Yes, I tested that one as well and it works for me, using
"mpint=5,0,4,9".
But now I need to upgrade the BIOS and I can't run phlash.exe!!!

...

| Here's my output from dump_pirq.  Is the PCI router info unique
| enough so that you'll need to debug it instead of me doing so?
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| [root@localhost src]# ./dump_pirq
|  
| Interrupt routing table found at address 0xfdf10
|   Version 1.0, 0 bytes
|   Interrupt router is device ff:1f.7
|   PCI exclusive interrupt mask: 0x0000 []
|  
| Interrupt router at ff:1f.7:
| Could not read router info from /proc/bus/pci/ff/1f.7.
| [root@localhost src]#
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|

> Hrm, this certainly doesn't look right.  You mentioned in a previous
> message that changing the OS type from PnP-aware did not have any
> effect, but if disabled the BIOS might not be creating the PIRQ
> tables.  Hopefully it will still take care of the IRQ routing, which
> means you should be able to read the value directly.  (it better or
> USB shouldn't work in UP!)  Try the following program:

USB works in UP mode (smp kernel, with "nosmp noapic").

dump_pirq in UP mode, PNP OS = Yes or No, gives the same
output as above.  I'd still like to get dump_pirq
working if you have something else that I could try.

-----------------------------------------------
USB Interrupt: 9
-----------------------------------------------

Yes, the BIOS assigns interrupt 9 to USB.  9 is the correct
value as far as the BIOS is concerned.

BTW, where is the <irq_routing_table> structure defined, in what
spec?

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
