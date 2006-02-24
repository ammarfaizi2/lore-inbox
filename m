Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWBXDFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWBXDFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWBXDFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:05:35 -0500
Received: from fmr22.intel.com ([143.183.121.14]:43492 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751824AbWBXDFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:05:34 -0500
Message-Id: <200602240305.k1O35Ng06352@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] fix ia64 hugetlb_free_pgd_range
Date: Thu, 23 Feb 2006 19:05:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY47MRp5LfDB6lgR92PAZRVPsgfNQAAKflA
In-Reply-To: <20060224024431.GC28368@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, February 23, 2006 6:45 PM
> However... I suspect in fact that the transformations should be
> unconditional.

No, that won't be correct.


> The whole address scaling thing that ia64 does for
> hugepages is extremely confusing, but since floor and ceiling are just
> used for bounds checking on the inner functions, shouldn't they be
> transformed to the same scale as addr and end, even if that's not
> actually a true address (hugepage or otherwise).

Think of multiple page size support, the way we do it on ia64 is
effective have different PAGE_SHIFT for normal page and hugetlb
page.  Normal page has page shift of 14 bits (of 16K page size).
Hugetlb page has page shift of 28 bits (of 256MB page size).
For any address, regardless whether it is normal/hugetlb page,
they all have full 3 level (or 4 level page table).  So for hugetlb
address, pgd/pud/pmd/pte index are off by (28-14) bits compare
to normal page.  We just transform the address so all the generic
code can be applied.  It's sort of selling you a wood looking
vinyl car stick shift.

- Ken

