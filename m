Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946136AbWJSPwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946136AbWJSPwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946137AbWJSPwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:52:24 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:12058 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1946136AbWJSPwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:52:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Thu, 19 Oct 2006 08:52:11 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0195D13E6@hqemmail02.nvidia.com>
In-Reply-To: <4536C9DA.4060704@shaw.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Thread-Index: AcbzF8sLSjII8eB8SGGqsaf3H+QCJAAfP5wg
From: "Allen Martin" <AMartin@nvidia.com>
To: "Robert Hancock" <hancockr@shaw.ca>, "Len Brown" <lenb@kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Daniel Mierswa" <impulze@impulze.org>, "Andi Kleen" <ak@suse.de>,
       "Andy Currid" <ACurrid@nvidia.com>
X-OriginalArrivalTime: 19 Oct 2006 15:51:56.0099 (UTC) FILETIME=[80F79130:01C6F396]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I recall quite clearly that Nvidia told us that that 
> > acpi_skip_timer_override was necessary in NFORCE2 days.  I don't 
> > remember the HPET qualification to that statement -- I 
> guess that came later.
> > Unfortunately, my NFORCE2 board is dead, so I can't really 
> test this out directly.
> > 
> > Perhaps checking for PCI_VENDOR_ID_NVIDIA is too broad and the 
> > workaround is counter-productive on their newer NVIDIA chip-sets?
> > 
> > -Len
> > 
> > ps.
> > One (other) problem with this code is that it checks for an HPET 
> > table, but doesn't check that the kernel has HPET support enabled.
> 
> I think the intent of the HPET check was that the quirk 
> wasn't needed on chipsets new enough to have an HPET. 
> Unfortunately, even if the chipset has an HPET it isn't 
> always enabled by the BIOS.
> 
> Clearly this quirk is too broad, it should likely be only 
> triggering on known chipset revisions with the bad timer 
> overrides and not on all NVIDIA chipsets. What I am wondering 
> is how these boards manage to work fine in Windows, 
> (presumably) without any such chipset-specific tweaks..

The problem is this workaround doesn't fix a chipset issue, it fixes
incorrect entries in the BIOS ACPI tables.  This bug existed in the
NVIDIA reference BIOS for nForce2 and got copied to all customer BIOSes
for nForce2.  Even though our reference BIOSes and documentation for all
chipsets since then have the correct interrupt overrides in the ACPI
tables we still see customer BIOSes that get shipped with incorrect
entries that were probably copied from their nForce2 BIOS code.

I believe the HPET check was because the workaround was causing problems
when enabling HPET on systems that support it.  Andy probably has more
details on that.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
