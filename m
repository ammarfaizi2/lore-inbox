Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUIHKwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUIHKwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUIHKwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:52:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46521 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269099AbUIHKwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:52:44 -0400
Date: Wed, 8 Sep 2004 12:54:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908105415.GB5523@elte.hu>
References: <20040908100448.GA4994@elte.hu> <20040908101719.GH2258@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908101719.GH2258@suse.de>
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


* Jens Axboe <axboe@suse.de> wrote:

> Wasn't the move of the ide_lock grabbing enough to solve this problem
> by itself?

yes and no. It does solve it for the specific case of the
voluntary-preemption patches: there hardirqs can run in separate kernel
threads which are preemptable (no HARDIRQ_OFFSET). In stock Linux
hardirqs are not preemptable so the earlier dropping of ide_lock doesnt
solve the latency.

so in the upstream kernel the only solution is to reduce the size of IO.
(I'll push the hardirq patches later on too but their acceptance should
not hinder people in achieving good latencies.) It can be useful for
other reasons too to reduce IO, so why not? The patch certainly causes
no overhead anywhere in the block layer and people are happy with it.

	Ingo
