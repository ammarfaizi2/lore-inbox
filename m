Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271521AbTGQR2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271516AbTGQR2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:28:40 -0400
Received: from fmr03.intel.com ([143.183.121.5]:4859 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S271509AbTGQR2i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:28:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] remove pa->va->pa conversion for efi.acpi
Date: Thu, 17 Jul 2003 10:43:19 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE548@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] remove pa->va->pa conversion for efi.acpi
Thread-Index: AcNKaT+wrzLNpHy8QAOG9qPIJOlqXwCHy9ow
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: <davidm@hpl.hp.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2003 17:43:20.0343 (UTC) FILETIME=[E983C270:01C34C8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> I'm OK with the change in principle, but the patch as sent is
> unacceptable because it leaves "acpi" and "acpi20" declared 
> as "void *"
> (in struct efi").  If you want them to by physical addresses, this
> should be changed to "unsigned long" (or perhaps u32 for acpi and u64
> for acpi20?).  It would be good to rename the members as well (e.g.,
> acpi_phys_addr/acpi20_phys_addr) to make sure that old code will
> break at compile-time, not at run-time.

Sounds good.  I've changed these to unsigned long and added the phys_addr to the names...

> Does ACPI really guarantee that the table is never stored at physical
> address 0?  If not, then leaving it as a virtual address might be
> safer.  (Yes, I know it's very unlikely for today's system, but at
> least on ia64, pfn 0 is normal RAM so it seems at least in principle
> possible to store the ACPI table there).
> 

No guarantee that I could find...I suppose this is technically possible. :)  However, considering the ACPI routines expect a physical address and thus immediately map it to get the descriptor (either directly with virt_to_phys or via ioremap), this seems redundant.  Given the mapping scheme employed, is this still risky?  I'd like to reuse the same code path for ia32, but don't want to break ia64.     

thanks,
matt   
