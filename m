Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWCVHPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWCVHPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWCVHPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:15:12 -0500
Received: from fmr20.intel.com ([134.134.136.19]:58513 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750972AbWCVHPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:15:11 -0500
Message-Id: <200603220715.k2M7F1g04936@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Li, Shaohua" <shaohua.li@intel.com>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: [PATCH] less tlb flush in unmap_vmas
Date: Tue, 21 Mar 2006 23:15:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZNbLkagc2f+RjATrGi5s3lL62s1AAEcTNw
In-Reply-To: <4420D82B.6080504@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 21, 2006 8:53 PM
> Shaohua Li wrote:
> >In unmaping region, if current task doesn't need reschedule, don't do a
> >tlb_finish_mmu. This can reduce some tlb flushes.
> >
> >In the lmbench tests, this patch gives 2.1% improvement on exec proc
> >item and 4.2% on sh proc item.
> 
> The problem with this is that by the time we _do_ determine that a
> reschedule is needed, we might have built up a huge amount of work
> to do (which can probably be as much if not more exensive per-page
> as the unmapping), so scheduling latency can still be unacceptable
> so I'm afraid I don't think we can include this patch.

Interesting. In the old day, since mm->page_table_lock is held for the
entire unmap_vmas function, it was beneficial to introduce periodic
reschedule point and to drop the spin lock under pressure. Now that the
page table lock is fine-grained and is pushed into zap_pte_range(), I
would think scheduling latency would improve from lock contention
avoidance point of view.  It is not the case?

- Ken

