Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269607AbUICJcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269607AbUICJcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269605AbUICJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:23:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60845 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269432AbUICJU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:20:29 -0400
Date: Fri, 3 Sep 2004 11:09:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040903090947.GA18227@elte.hu>
References: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com> <20040902224347.GA28775@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902224347.GA28775@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > 00000002 0.002ms (+0.000ms): dummy_go_idle (schedule)
> > 00000002 0.002ms (+0.060ms): schedule (io_schedule)
> > 00000002 0.063ms (+0.069ms): load_balance_newidle (schedule)
> > 00000002 0.133ms (+0.074ms): find_busiest_group (load_balance_newidle)
> > 00000002 0.207ms (+0.034ms): find_next_bit (find_busiest_group)
> > 00000002 0.242ms (+0.039ms): find_next_bit (find_busiest_group)
> > 00000002 0.281ms (+0.070ms): find_busiest_queue (load_balance_newidle)
> > 00000002 0.351ms (+0.071ms): find_next_bit (find_busiest_queue)
> > 00000002 0.422ms (+0.069ms): double_lock_balance (load_balance_newidle)
> > 00000003 0.492ms (+0.070ms): move_tasks (load_balance_newidle)
> 
> this is as if the CPU executed everything in 'slow motion'. E.g. the
> cache being disabled could be one such reason - or some severe DMA or
> other bus traffic.

another thing: could you try maxcpus=1 again and see whether 1 CPU
produces similar 'slow motion' traces? If it's DMA or PCI bus traffic
somehow interfering then i'd expect the same phenomenon to pop up with a
single CPU too. IIRC you tested an UP kernel once before, but i believe
that was prior fixing all the latency measurement errors. Would be nice
to re-test again, with maxcpus=1, and see whether any of these
slow-motion traces trigger. On a 1-CPU test i'd suggest to lower the
tracing threshold to half of the 2-CPU value.

	Ingo
