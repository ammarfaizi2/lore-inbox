Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUIOGSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUIOGSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUIOGSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:18:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40064 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266245AbUIOGR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:17:59 -0400
Date: Wed, 15 Sep 2004 08:19:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915061922.GA11683@elte.hu>
References: <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414776CE.5030302@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> No, but I mean putting them right down into fastpaths like the vmscan
> one, for example.

it is a very simple no-parameters call to a function that reads a
likely-cached word and returns. The cost is in the 2-3 cycles range - a
_single_ cachemiss can be 10-100 times more expensive, and cachemisses
happen very frequently in every iteration of the VM _scanning_ path
since it (naturally and inevitably) deals with lots of sparsely
scattered data structures that havent been referenced for quite some
time.

The function (cond_resched()) triggers scheduling only very rarely, you
should not be worried about that aspect either.

> And if I remember correctly, you resorted to putting them into
> might_sleep as well (but I haven't read the code for a while, maybe
> you're now getting decent results without doing that).

i'm not arguing that now at all, that preemption model clearly has to be
an optional thing - at least initially.

	Ingo
