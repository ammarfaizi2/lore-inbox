Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVDMARm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVDMARm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVDMANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:13:55 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:64522 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S263033AbVDMAE3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:04:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework
Date: Tue, 12 Apr 2005 19:04:20 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB8@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework
Thread-Index: AcU/V/zEAgIOCEcxScKewF5TSmpUBwAMG8iAAAbEMOAABfzbYA==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Li Shaohua" <shaohua.li@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "ACPI-DEV" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Apr 2005 00:04:21.0268 (UTC) FILETIME=[57FF5540:01C53FBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I forgot to mention that while working on the patch,
> I found a problem with ACPI driver while counting number of records 
> in acpi_table_parse_madt_family() (drivers/acpi/tables.c). 
> It always returns 0 for the number of records, so this should be 
> fixed for my patch to work properly, since I rely on number of 
> lapic entries found by ACPI. I am going to post a bugzilla on this, 
> for now it worked for me as follows:
>    while (((unsigned long) entry) + sizeof(acpi_table_entry_header) <
madt_end) {
>                if (entry->type == entry_id &&
>	 -            (!max_entries || count++ < max_entries) 
>       +            ((count++ < max_entries) || !max_entries))
> (it wasn't incrementing count if max_entries are >0 ).

Please disregard this: I couldn't reproduce it anymore, looks like it
only happened on one system (I cannot remember on which one) and seems
to work OK without the fix on any machine I'm trying it now...

Thanks,
--Natalie 
