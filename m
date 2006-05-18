Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWERAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWERAgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWERAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:36:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:51865 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751117AbWERAge convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:36:34 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="38894888:sNHT16630824168"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFT] major libata update
Date: Wed, 17 May 2006 20:36:12 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB679C28F@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFT] major libata update
Thread-Index: AcZ6DITV2vvp3U/jS0e592rCAWCyZwABNpgg
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jeff@garzik.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
       "Avuton Olrich" <avuton@gmail.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 18 May 2006 00:36:13.0781 (UTC) FILETIME=[112DA850:01C67A13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Many BIOS ACPI tables from years ago simply _assumed_ that you have 
>hardcoded irq 14/15, even...  Their irq descriptors for 14/15 would be 
>absent or completely non-functional.
>
>Or maybe its the $pirq table I'm recalling.  One of the two, anyway.

For x86, the ACPI interrupt configuration process is to identity-map
the IOAPIC entries below 16 1:1 PIC:IOAPIC,
unless there are interrupt source overrides
(such as commonly done to swizzle IRQ0 from a different pin)

This makes legacy-mode ATA happy.  Hard code ATA to 14/15 and
off you go.

But there is a gray area where the ATA controller registers
as a PCI device, but Linux goes off and looks in the ACPI PRT
for that PCI-dev and finds no entry.  So if you didn't
have the hard-coded 14/15, you'd be dead.

Then there are cases where the PRT specifies something
_other_ than 14/15 for ATA, and in that cases the hard-coded
default is the wrong thing to do; and the workaround is
to use BIOS SETUP options to be sure that ATA is set up
in legacy mode.

I suspect Linux could be smarter here.  The 14/15 should be
the backup default for when the tables
don't give us anything else; not the only option.

-Len
