Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUHXQCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUHXQCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUHXQCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:02:54 -0400
Received: from fmr12.intel.com ([134.134.136.15]:10888 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268064AbUHXQCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:02:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [broken?] Add MSI support to e1000
Date: Tue, 24 Aug 2004 09:01:04 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024061F9A4A@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [broken?] Add MSI support to e1000
Thread-Index: AcSJ5fOn/FdXqYfBRhel//U7RTwX6AAC5+Qg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>, "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 24 Aug 2004 16:01:06.0695 (UTC) FILETIME=[90765970:01C489F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24 Roland Dreier wrote: 
>    Andi> Yes, the flag word is 0x8b after the call. And
>    Andi> pci_enable_msi returns 0.
>
>Actually I bet the problem is that the driver is doing request_irq()
>on the wrong IRQ.  In s2io.c, s2io_init_nic() does
>
>	sp->irq = pdev->irq;
>
>and then sometime later s2io_open() does
>
>	err =
>	    request_irq((int) sp->irq, s2io_isr, SA_SHIRQ, sp->name,
dev);
>
>If you put the call to pci_enable_msi() after sp->irq is assigned, the
>driver will request the original irq (which will still be in INTx
>mode, of course), rather than the new vector assigned by the MSI core.

My guess is the same as Roland's bet. I've not tested MSI support in 
2.6.8.1 kernel. I'll provide an update later if MSI support
in x86-64 has any issue.

Thanks,
Long
