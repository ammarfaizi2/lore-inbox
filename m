Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUIHLHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUIHLHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUIHLHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:07:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18320 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269105AbUIHLGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:06:53 -0400
Date: Wed, 8 Sep 2004 13:05:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908110544.GI2258@suse.de>
References: <20040908100448.GA4994@elte.hu> <20040908101719.GH2258@suse.de> <20040908105415.GB5523@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908105415.GB5523@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > Wasn't the move of the ide_lock grabbing enough to solve this problem
> > by itself?
> 
> yes and no. It does solve it for the specific case of the
> voluntary-preemption patches: there hardirqs can run in separate kernel
> threads which are preemptable (no HARDIRQ_OFFSET). In stock Linux
> hardirqs are not preemptable so the earlier dropping of ide_lock doesnt
> solve the latency.
> 
> so in the upstream kernel the only solution is to reduce the size of IO.
> (I'll push the hardirq patches later on too but their acceptance should
> not hinder people in achieving good latencies.) It can be useful for
> other reasons too to reduce IO, so why not? The patch certainly causes
> no overhead anywhere in the block layer and people are happy with it.

I'm not particularly against it, I was just curious. The splitting of
max_sectors into a max_hw_sectors is something we need to do anyways, so
I'm quite fine with the patch. You can add my signed-off-by too.

-- 
Jens Axboe

