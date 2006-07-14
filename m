Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWGNT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWGNT0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWGNT0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:26:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:57254 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422723AbWGNT0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:26:49 -0400
X-IronPort-AV: i="4.06,244,1149490800"; 
   d="scan'208"; a="98207393:sNHT20478857"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Date: Fri, 14 Jul 2006 15:26:45 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6FBB114@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Thread-Index: AcanZamXUTJ+LOG8RVSj6bd2vq0GJQAEMVbw
From: "Brown, Len" <len.brown@intel.com>
To: "Daniel Drake" <dsd@gentoo.org>, "Chris Wedgwood" <cw@f00f.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jeff@garzik.org>,
       <greg@kroah.com>, <harmon@ksu.edu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2006 19:26:47.0498 (UTC) FILETIME=[72C532A0:01C6A77B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying very hard to stay away from VIA quirks,
but there are some things to be aware of.

1. quirks are independent of ACPI on/off

Note that ACPI PCI Interrupt Link Devices
are just a wrapper around the same legacy PIRQ router
seen in legacy mode.

The added twist is that it is possible for VIA
to do quirks in ACPI automatically if they want to --
since all it takes is a few lines of AML where we set the link
to a new state.  (we should go see if they're doing this now --
in the past I don not think they did, and so quirks are probably
still needed in ACPI mode on at least old machines)

2. quirks are independent of PIC/IOAPIC

In both ACPI on and ACPI off modes, we tend to touch PIC
interrupts as _little_ as possible.  So it may be that
our system boots up just fine in PIC mode w/o quirks --
but the reason may be because we didn't try to invoke any irq mappings
--
we found we could live with what the BIOS left us and we
used it untouched.

As the IOAPIC is disabled in the default BIOS mode,
we always have to set that up, and a good part of the time
we have to choose our own mappings, so quirks are more likely
to be noticed to be ncessary in IOAPIC mode.

hope this helps,
-Len
