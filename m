Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJOHUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJOHUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJOHUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:20:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16065 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266252AbUJOHPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:15:46 -0400
Date: Fri, 15 Oct 2004 09:14:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015071411.GB8373@elte.hu>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <Pine.LNX.4.58.0410141930440.1221@gradall.private.brainfood.com> <Pine.LNX.4.58.0410141941320.1221@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410141941320.1221@gradall.private.brainfood.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Heath <doogie@debian.org> wrote:

> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2
> >
> > kernel/latency.c: In function `add_preempt_count':
> > kernel/latency.c:390: error: structure has no member named `preempt_trace_eip'
> > kernel/latency.c:394: error: structure has no member named `preempt_trace_parent_eip'
> 
> Here's a patch:

please try the patch below instead - it will keep the tracer working
even with !LATENCY_TRACE.

	Ingo

--- linux.old/include/linux/sched.h	
+++ linux.new/include/linux/sched.h	
@@ -706,7 +706,7 @@ struct task_struct {
 
 #define MAX_PREEMPT_TRACE 16
 
-#ifdef CONFIG_LATENCY_TRACE
+#ifdef CONFIG_PREEMPT_TIMING
 	unsigned long preempt_trace_eip[MAX_PREEMPT_TRACE];
 	unsigned long preempt_trace_parent_eip[MAX_PREEMPT_TRACE];
 #endif
--- linux.old/include/linux/highmem.h	
+++ linux.new/include/linux/highmem.h	
@@ -33,6 +33,11 @@ static inline void *kmap(struct page *pa
 #define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
+#define kmap_atomic_rt kmap_atomic
+#define kmap_atomic_pfn_rt kmap_atomic_pfn
+#define kunmap_atomic_rt kunmap_atomic
+#define kmap_atomic_to_page_rt(kvaddr) kmap_atomic_to_page(kvaddr)
+
 #endif /* CONFIG_HIGHMEM */
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */

