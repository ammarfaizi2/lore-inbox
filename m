Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWCVHoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWCVHoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCVHoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:44:19 -0500
Received: from fmr17.intel.com ([134.134.136.16]:23731 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751078AbWCVHoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:44:18 -0500
Message-Id: <200603220744.k2M7iBg05206@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: [PATCH] less tlb flush in unmap_vmas
Date: Tue, 21 Mar 2006 23:44:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZNgnTX7nFh028AToaVyRsZ0ueY6gAAUB7w
In-Reply-To: <4420FCFD.3060401@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 21, 2006 11:30 PM
> > Chen, Kenneth W wrote:
> > Interesting. In the old day, since mm->page_table_lock is held for the
> > entire unmap_vmas function, it was beneficial to introduce periodic
> > reschedule point and to drop the spin lock under pressure. Now that the
> > page table lock is fine-grained and is pushed into zap_pte_range(), I
> > would think scheduling latency would improve from lock contention
> > avoidance point of view.  It is not the case?
> > 
> 
> Well mmu_gather uses a per-cpu data structure and is non preemptible,
> which I guess is one of the main reasons why we have this preemption
> here.
> 
> You're right that another good reason would be ptl lock contention,
> however I don't think that alleviating that problem alone would allow
> longer mmu_gather scheduling latencies, because the longest latency
> is still the mmu_gather <--> mmu_finish span.

OK, I think it would be beneficial to take a latency measurement again,
just to see how it perform now a day.  The dynamics might changed.

- Ken

