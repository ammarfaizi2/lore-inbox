Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWBXBOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWBXBOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBXBOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:14:21 -0500
Received: from fmr22.intel.com ([143.183.121.14]:6620 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932343AbWBXBOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:14:20 -0500
Message-Id: <200602240114.k1O1E4g05231@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Hugh Dickins" <hugh@veritas.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IA64 non-contiguous memory space bugs
Date: Thu, 23 Feb 2006 17:14:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY41y6fwRCNtdgVQDm9X59Q/+P3CAAAQTiw
In-Reply-To: <20060224001146.GC25101@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, February 23, 2006 4:12 PM
> It doesn't really mean different things - "touches a hugepage
> exclusive area" is the correct semantic, the ia64 implementation
> doesn't quite encode that, but is equivalent for valid address
> ranges.  (though I wonder if that's another bug associated with by
> task-region-max patch, without that patch invalid address ranges can
> slip through, so maybe it's possible on ia64 to create a normalpage VM
> with its start in the address space gap and its end in the hugepage
> region, ouch).

This is getting complicated that my little brain hurts.  There has been
so many iterations that the semantic is ambiguous.  If the semantic is
decided to be "overlap", then 

It will break arch/ia64/mm/hugetlbpage.c:hugetlb_free_pgd_range():

        if (is_hugepage_only_range(tlb->mm, floor, HPAGE_SIZE))
                floor = htlbpage_to_page(floor);
        if (is_hugepage_only_range(tlb->mm, ceiling, HPAGE_SIZE))
                ceiling = htlbpage_to_page(ceiling);

And it will break horribly bad because hugetlbpage_to_page does
"magic" address transformation.

- Ken

