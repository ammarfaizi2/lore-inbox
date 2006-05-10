Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWEJCHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWEJCHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWEJCHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:07:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:52338 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751175AbWEJCHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:07:44 -0400
Message-Id: <4t16i2$10ctb8@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="33977704:sNHT15322993"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Brian Twichell" <tbrian@us.ibm.com>
Cc: "Hugh Dickins" <hugh@veritas.com>, "Dave McCracken" <dmccr@us.ibm.com>,
       "Linux Memory Management" <linux-mm@kvack.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2][RFC] New version of shared page tables
Date: Tue, 9 May 2006 19:07:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZzGzqzYNCTkvUYSaCX4LAivs9MEQAuKwLA
In-Reply-To: <44600F9B.1060207@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Monday, May 08, 2006 8:42 PM
> Brian Twichell wrote:
> > In the case of x86-64, if pagetable sharing for small pages was 
> > eliminated, we'd lose more than the 27-33% throughput improvement 
> > observed when the bufferpools are in small pages.  We'd also lose a 
> > significant chunk of the 3% improvement observed when the bufferpools 
> > are in hugepages.  This occurs because there is still small page 
> > pagetable sharing being achieved, minimally for database text, when 
> > the bufferpools are in hugepages.  The performance counters indicated 
> > that ITLB and DTLB page walks were reduced by 28% and 10%, 
> > respectively, in the x86-64/hugepage case.
> 
> 
> Aside, can you just enlighten me as to how TLB misses are improved on 
> x86-64? As far as I knew, it doesn't have ASIDs so I wouldn't have thought
> it could share TLBs anyway...
> But I'm not up to scratch with modern implementations.


Allow me to jump in if I may:  The number of TLB misses did not change that
much (both i-side and d-side and is expected).  What changed is the penalty
of TLB misses are reduced: i.e., number of page table walk performed by the
hardware are reduced. This is due to specialized buffering of information
that reduces the need to perform page walks. With page table sharing, the
overall size of page tables are reduced, in turn, it has a better hit rate
on the buffered items and it helps to mitigate page walks upon a TLB miss.

- Ken
