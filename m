Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932837AbWFVIAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWFVIAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWFVIAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:00:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:37496 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932307AbWFVIAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:00:42 -0400
X-IronPort-AV: i="4.06,164,1149490800"; 
   d="scan'208"; a="55025751:sNHT16295958"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Thu, 22 Jun 2006 04:00:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6CF0D04@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] ACPI: reduce code size, clean up, fix validator message
Thread-Index: AcaVzRFeS1rs2RSWTzeVJH49xhx8eAAA6zgA
From: "Brown, Len" <len.brown@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Cc: <michal.k.k.piotrowski@gmail.com>, <arjan@linux.intel.com>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Arjan van de Ven" <arjan@infradead.org>
X-OriginalArrivalTime: 22 Jun 2006 08:00:41.0101 (UTC) FILETIME=[F49903D0:01C695D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
Thanks for the quick reply.

An Andrew's advice a while back, Bob already got rid
of the allocate part -- it just isn't upstream yet.

Re: changing ACPICA code (sub-directories of drivers/acpi/) like this:

>-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
>+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);

I can't do that without either
1. diverging between Linux and ACPICA
or
2. getting a license back from you to Intel such that Intel can
   re-distrubute such a change under the Intel license on the file
   and
   inventing spin_lock_irqsave() on about 9 other operating systems.

#1 is all pain and no gain, unless the 244 net fewer bytes counts as
gain.
#2 wouldn't make sense either.

If this code were performance or size critical, I would still delete
acpi_os_acquire_lock from osl.c, but would inline it in aclinux.h.

thanks,
-Len
