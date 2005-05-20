Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVETR1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVETR1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVETR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:27:44 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:57105 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S261488AbVETR1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:27:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Proposed: Let's not waste precious IRQs...
Date: Fri, 20 May 2005 12:27:09 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04BA0@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Proposed: Let's not waste precious IRQs...
Thread-Index: AcVdXWHATt6aBdmST12u/J2FGzB/rgAAP3sA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <akpm@osdl.org>, <ak@suse.de>, <len.brown@intel.com>,
       <bjorn.helgaas@hp.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2005 17:27:10.0165 (UTC) FILETIME=[27401850:01C55D61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi Natalie,
> 
> On Thu, 19 May 2005 Natalie.Protasevich@unisys.com wrote:
> 
> > I suggest to change the way IRQs are handed out to PCI devices. 
> > Currently, each I/O APIC pin gets associated with an IRQ, 
> no matter if 
> > the pin is used or not. It is expected that each pin can 
> potentually 
> > be engaged by a device inserted into the corresponding PCI slot. 
> > However, this imposes severe limitation on systems that 
> have designs 
> > that employ many I/O APICs, only utilizing couple lines of 
> each, such 
> > as P64H2 chipset. It is used in ES7000, and currently, 
> there is no way 
> > to boot the system with more that 9 I/O APICs. The simple 
> change below 
> > allows to boot a system with say 64 (or more) I/O APICs, each 
> > providing 1 slot, which otherwise impossible because of the 
> IRQ gaps 
> > created for unused lines on each I/O APIC. It does not resolve the 
> > problem with number of devices that exceeds number of 
> possible IRQs, 
> > but eases up a tension for IRQs on any large system with 
> potentually 
> > large number of devices. I only implemented this for the ACPI boot, 
> > since if the system is this big and
> 
> Can you determine number of slots in use?

I think it is possible, but then it will probably be back to something
like "pci=routeirq" philosophy.
 
> >   using newer chipsets it is probably (better be!) an ACPI based 
> > system :). The change is completely "mechanical" and does not alter 
> > any internal structures or interrupt model/implementation. 
> The patch 
> > works for both i386 and x86_64 archs. It works with MSIs just fine, 
> > and should not intervene with implementations like shared vectors, 
> > when they get worked out and incorporated.
> 
> Well we ran into similar problems on older MPS systems 
> (NUMAQ) but those don't really matter right now anyway. So i 
> think fixing this for ACPI is fine.

ACPI is well organized and easily manipulated, that's why I stopped
right there. I tried adjusting the MPS case, it is possible, but then I
thought no one would need it anyway. It would take multiple changes and
won't be pretty, but if you insist I can work it out :)  
> But i like your patch =)

:)
 
> Thanks,
> 	Zwane
> 
> 
