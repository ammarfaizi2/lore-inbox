Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVC3SYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVC3SYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVC3SYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:24:45 -0500
Received: from fmr14.intel.com ([192.55.52.68]:4549 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262366AbVC3SYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:24:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/6] freepgt: free_pgtables use vma list
Date: Wed, 30 Mar 2005 10:23:54 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F032BF15B@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/6] freepgt: free_pgtables use vma list
Thread-Index: AcU0oQ2lHqTBeU4fQa6kE2SebRGWqQAs8veg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>, "David S. Miller" <davem@davemloft.net>
Cc: <nickpiggin@yahoo.com.au>, <akpm@osdl.org>, <benh@kernel.crashing.org>,
       <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Mar 2005 18:23:55.0498 (UTC) FILETIME=[A1EB6CA0:01C53555]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Though my knowledge of out-of-tree patches is very limited,
>I believe "end == 0" is not possible on any arch - when "end"
>originates from vma->vm_end (or vm_struct->addr + size).  There
>are plenty of "BUG_ON(addr >= end)"s dotted around to support that,
>and other places that would be confused by vm_start > vm_end.
>
>(And when Linus first proposed the sysenter page at 0xfffff000,
>I protested, and he brought it down to 0xffffe000: I think we'll
>do well ever to keep that last virtual page invalid.)

IS_ERR(ptr) and PTR_ERR(ptr) would also yield some interesting bizarre
errors if the last page (last 1000 bytes in the current implementation
of IS_ERR) were valid!

>But certainly "ceiling == 0" is possible and common, and "rounded-up
>end" may well be 0 with out-of-tree patches.  When I did those
>free_pgtables tests, it seemed simpler to treat "end" in the same
>way as "ceiling", implicitly allowing it the 0 case.  Perhaps
>that's not so in Nick's version, I've yet to think through it.

Yes ... rounding 'end' up to pmd/pud/pgd boundaries can certainly
wrap around to zero ... giving up the last page of address space
seems reasonable.  Giving up the last PGD_SIZE just to make some
math a bit easier sounds like overkill.

-Tony
