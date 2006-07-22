Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWGVXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWGVXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWGVXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 19:38:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:61566 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750706AbWGVXi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 19:38:26 -0400
X-IronPort-AV: i="4.07,171,1151910000"; 
   d="scan'208"; a="69171313:sNHT15371629"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for non-atomic allocation
Date: Sat, 22 Jul 2006 19:38:03 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6010912DB@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for non-atomic allocation
Thread-Index: AcatqmprWrGSXgUDTqi/sz71obI17AAPWL2A
From: "Brown, Len" <len.brown@intel.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Cc: "linux-acpi" <linux-acpi@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jul 2006 23:38:25.0147 (UTC) FILETIME=[ECF99CB0:01C6ADE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this would oops on a resume from suspend --
when it is called with interrupts off.

-Len 

>-----Original Message-----
>From: Jiri Kosina [mailto:jikos@jikos.cz] 
>Sent: Saturday, July 22, 2006 12:16 PM
>To: Brown, Len
>Cc: linux-acpi; linux-kernel@vger.kernel.org
>Subject: [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for 
>non-atomic allocation
>
>Hi,
>
>drivers/acpi/pci_link.c::acpi_pci_link_set() sets the GFP_ATOMIC for
>kmalloc() allocation for no first-sight obvious reason; as far as I can
>see this is always called outside the atomic/interrupt context, so
>GFP_KERNEL allocation should be used instead.
>
>If applicable, please apply
>
>Signed-off-by: Jiri Kosina <jikos@jikos.cz>
>
>--- drivers/acpi/pci_link.c.orig	2006-07-15 
>21:00:43.000000000 +0200
>+++ drivers/acpi/pci_link.c	2006-07-22 17:45:11.000000000 +0200
>@@ -318,7 +318,7 @@ static int acpi_pci_link_set(struct acpi
> 	if (!link || !irq)
> 		return_VALUE(-EINVAL);
> 
>-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
>+	resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
> 	if (!resource)
> 		return_VALUE(-ENOMEM);
> 
> 
>
>-- 
>JiKos.
>
