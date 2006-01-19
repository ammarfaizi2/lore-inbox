Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWASBti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWASBti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWASBti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:49:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:35237 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030418AbWASBth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:49:37 -0500
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 20:42:39 -0500
Message-Id: <1137634961.626.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 22:59 +0000, Hugh Dickins wrote:
> I'm to blame for that - sorry.  It didn't occur to me that I was
> moving any signficant amount of work (on mms with many vmas) into the
> section with preemption disabled.  Actually, the mm->page_table_lock
> is _not_ held there any more; but preemption is still disabled while
> using the per-cpu mmu_gathers.
> 
> I wish you'd found it at -rc1 time.  It's not something that can
> be properly corrected in a hurry.  The proper fix is to rework the
> tlb_gather_mmu stuff, so it can be done without preemption disabled.
> It's already a serious limitation in unmap_vmas, with CONFIG_PREEMPT's
> ZAP_BLOCK_SIZE spoiling throughput with far too many TLB flushes.
> 
> On my list to work on; but the TLB always needs great care, and this
> goes down into architectural divergences, with truncation of a mapped
> file adding further awkward constraints.  I imagine 2.6.16-rc1 is only
> a couple of weeks away, so it's unlikely to be fixed in 2.6.16 either.
> 

Hugh,

Is this believed to be fixed in 2.6.16-rc1?

Lee

