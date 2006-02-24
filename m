Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWBXGaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWBXGaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWBXGaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:30:52 -0500
Received: from fmr23.intel.com ([143.183.121.15]:59339 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750887AbWBXGav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:30:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] fix ia64 hugetlb_free_pgd_range
Date: Thu, 23 Feb 2006 22:30:39 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB509C43438@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] fix ia64 hugetlb_free_pgd_range
Thread-Index: AcY4+CdGKPryTO8pQb+SyAjC4nSbzgAEp2yQ
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: "Hugh Dickins" <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Feb 2006 06:30:40.0643 (UTC) FILETIME=[D4EE0530:01C6390B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, February 23, 2006 8:06 PM
> But I don't see how not transforming them sometimes can be correct.
> Suppose 'floor' is only a little way below 'addr' - addr will be
> shifted down, but floor won't, so floor may now be above addr, which
> will cause weird results.
> 
> Afaict the *only* thing floor and ceiling are used for is bounds
> checking the address range we're examining.  How can that ever be
> right if one address has been scaled down, but the other hasn't.

The scale down isn't exactly on every address bits.  Top 3 bits of
virtual address are preserved.

#define htlbpage_to_page(x)    (((unsigned long) REGION_NUMBER(x) << 61)
                                 | (REGION_OFFSET(x) >>
(HPAGE_SHIFT-PAGE_SHIFT)))

So scaled address for a hugetlb address will never be below unscaled
normal page address.  That is adjusted addr will never below unchanged
floor.

- Ken
