Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319336AbSH2Ufn>; Thu, 29 Aug 2002 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319337AbSH2Ufm>; Thu, 29 Aug 2002 16:35:42 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12807
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319336AbSH2Ufi>; Thu, 29 Aug 2002 16:35:38 -0400
Subject: Re: [PATCH] low-latency zap_page_range()
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <3D6E844C.4E756D10@zip.com.au>
References: <1030635100.939.2551.camel@phantasy> 
	<3D6E844C.4E756D10@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 16:40:02 -0400
Message-Id: <1030653602.939.2677.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 16:30, Andrew Morton wrote:

> However with your change, we'll only ever put 256 pages into the
> mmu_gather_t.  Half of that thing's buffer is unused and the
> invalidation rate will be doubled during teardown of large
> address ranges.

Agreed.  Go for it.

Hm, unless, since 507 vs 256 is not the end of the world and latency is
already low, we want to just make it always (FREE_PTE_NR*PAGE_SIZE)...

As long as the "cond_resched_lock()" is a preempt only thing, I also
agree with making ZAP_BLOCK_SIZE ~0 on !CONFIG_PREEMPT - unless we
wanted to unconditionally drop the locks and let preempt just do the
right thing and also reduce SMP lock contention in the SMP case.

	Robert Love

