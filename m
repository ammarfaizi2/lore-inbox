Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbULOR2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbULOR2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbULOR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:27:40 -0500
Received: from fmr14.intel.com ([192.55.52.68]:64712 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262403AbULOR0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:26:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 0/3] NUMA boot hash allocation interleaving
Date: Wed, 15 Dec 2004 09:25:55 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02900608@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/3] NUMA boot hash allocation interleaving
Thread-Index: AcTiddqMQZZ6lLCoTb2+CsLH2XLCkQAU5sAg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, "Andi Kleen" <ak@suse.de>,
       "Brent Casavant" <bcasavan@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 15 Dec 2004 17:25:55.0827 (UTC) FILETIME=[22800430:01C4E2CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also at least on IA64 the large page size is usually 1-2GB 
>> and that would seem to be a little too large to me for
>> interleaving purposes. Also it may prevent the purpose 
>> you implemented it - not using too much memory from a single
>> node. 
>
>Yes, that'd bork it. But I thought that they had a large sheaf of
>mapping sizes to chose from on ia64?

Yes, ia64 supports lots of pagesizes (the exact list for each cpu
model can be found in /proc/pal/cpu*/vm_info, but the architecture
requires that 4k, 8k, 16k, 64k, 256k, 1m, 4m, 16m, 64m, 256m be
supported by all implementations).  To make good use of them
for vmalloc() would require that we switch the kernel over to
using long format VHPT ... as well as all the architecture
independent changes that Andi listed.

It would be interesting to see some perfmon data on TLB miss rates
before and after this patch, but I'd personally be amazed if you
could find a macro-level benchmark that could reliably detect the
perfomance effects relating to TLB caused by this change.

-Tony
