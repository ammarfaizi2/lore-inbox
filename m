Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTKWTQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTKWTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:16:12 -0500
Received: from fmr99.intel.com ([192.55.52.32]:65215 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263415AbTKWTQI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:16:08 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Date: Sun, 23 Nov 2003 14:16:04 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC886D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Thread-Index: AcOx4JjQ3Xs7gZc9TKCWzOQLNtC0ngAELTpA
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Marco d'Itri" <md@Linux.IT>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Andi Kleen" <ak@muc.de>
X-OriginalArrivalTime: 23 Nov 2003 19:16:05.0821 (UTC) FILETIME=[3E160ED0:01C3B1F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So something in the ACPI code made IRQ15 active, or caused 
> there to be a 
> pending interrupt. I'd guess that ACPI incorrectly turns the 
> legacy IDE 
> interrupts to be PCI interrupts (level-triggered, active low) 
> instead of 
> legacy interrupts (edge-triggered, active high).

I think so too.

> Len - does ACPI ever change the polarity of an interrupt? 
> Just turning the 
> irq level-triggered shouldn't matter that much, but if some 
> part of ACPI 
> switches polarities around (and gets the wrong one) that 
> would be deadly 
> and would cause screaming interrupts when no event is pending.

I think that PCI Interrupt Link Devices were originally intended to map
PIRQs down into PIC IRQs with standard PCI semantics -- obsoleting the
bogus chip-set specific PIRQ router "standard".  But the BIOS can ask us
to do just about anything, and I'm finding that some system designers
and BIOS writers have become much more creative in their use;-)

Marco,
Please file a bug per below and attach the output of acpidmp and lspci
-v with full dmesg so I can decode what the BIOS is really asking us to
do.

Perhaps you can also add the dmesg and /proc/interrupts from the version
of 2.4 that worked.  I'm puzzled at what 2.6-specific change provoked
this failure.

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts, lspci -v and the dmesg output showing
the failure, if possible.
