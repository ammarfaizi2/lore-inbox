Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVGSWcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGSWcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVGSWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:32:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60587 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261295AbVGSWcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:32:22 -0400
Date: Wed, 20 Jul 2005 00:32:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Interbench real time benchmark results
Message-ID: <20050719223216.GA4194@elte.hu>
References: <200507200816.11386.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507200816.11386.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Not entirely what some would expect. Very little difference under low 
> loads, but the maximum latencies exhibited are about the same at 
> 300us. However they hare under different workloads. With these 
> worklods, on this hardware, running these real time simulations there 
> is not a convincing argument for CONFIG-PREEMPT. Note that running 
> interbench with the non-real time benchmarks also does not show a 
> convincing reason for preempt.

while i do like the PREEMPT_RT results, i think we need to do two more 
things to have total confidence in the numbers:

 - i think we'll need to increase the number of sample points, by both
   increasing the frequency of samples, and by lengthening the
   test-time - even if just for a single testrun. Some of the worst-case 
   latencies i care about in PREEMPT_RT trigger only once every couple 
   of million interrupts (!). For human interactivity we probably dont 
   care that much though.

 - many of the worst-case latencies relate to some sort of extreme 
   situation within a particular algorithm. E.g. lots of tasks being 
   around. Do this for example:

	hackbench 50

   and Ctrl-Z it after a couple of seconds. You'll see a 1msec (or 
   larger) blip.

   or, fill up swapspace, so that the swap allocation map gets filled
   up.

 - networking is another frequent source of latencies - it might make 
   sense to add a workload doing lots of socket IO. (localhost might be 
   enough, but not for everything)

	Ingo
