Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLPAQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTLPAQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:16:56 -0500
Received: from qlink.QueensU.CA ([130.15.126.18]:41694 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S264271AbTLPAQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:16:53 -0500
Subject: Re: HT schedulers' performance on single HT processor
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>,
       Adam Kropelin <akropel1@rochester.rr.com>
In-Reply-To: <200312152111.52949.kernel@kolivas.org>
References: <200312130157.36843.kernel@kolivas.org>
	 <1071431363.19011.64.camel@rocky>  <200312152111.52949.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1071533802.24673.35.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Dec 2003 19:16:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 05:11, Con Kolivas wrote:
> On Mon, 15 Dec 2003 06:49, Nathan Fredrickson wrote:
> > I can also run the same on four physical processors if there is
> > interest.
> 
> The specific HT scheduler benefits only start appearing with more physical 
> cpus which is to be expected. Just for demonstration the four processor run 
> would be nice (and obviously take you less time to do ;). I think it will 
> demonstrate it even more. It would be nice to help the most common case of 
> one HT cpu, though, instead of hindering it.

Here are some results on four physical processors.  Unfortunately my
quad systems are a different speed than the dual systems used for the
previous tests so the results are not directly comparable.

Same test as before, a 2.6.0 kernel compile with make -jX vmlinux. 
Results are the best real time out of five runs.
Hardware: Xeon HT 1.4GHz

Test cases:
1phys UP      - UP test11 kernel with HT disabled in the BIOS
4phys SMP     - SMP test11 kernel on 4 physical procs with HT disabled
4phys HT      - SMP test11 kernel on 4 physical procs with HT enabled
4phys HT (w26)- same as above with Nick's w26 sched-rollup patch
4phys HT (C1) - same as above with Ingo's C1 patch

Here are the results normalized to the X=1 UP case to make comparisons
easier.  Lower is better.

          X =  1     2     3     4     5     6     7     8     9    16
1phys UP      1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00
4phys SMP     1.00  0.99  0.51  0.35  0.27  0.27  0.27  0.27  0.27  0.27
4phys HT      1.01  1.00  0.55  0.40  0.33  0.29  0.27  0.26  0.25  0.26
4phys HT(w26) 1.01  1.01  0.54  0.37  0.31  0.27  0.26  0.26  0.26  0.26
4phys HT(C1)  1.01  1.00  0.52  0.36  0.29  0.28  0.27  0.26  0.25  0.26

Interesting that the overhead due to HT in the X=1 column is only 1%
with 4 physical processors.  It was 1-3% before with 1 or 2 physical
processors.

In the partial load columns where there are less compiler processes than
logical CPUs (X=3,4,5,6,7), it appears that both patches are doing a
better job scheduling than the standard scheduler.  At full load (X=>8)
all three HT test cases perform about equally and beat standard SMP by
1-2%.

Hope these results are helpful.  I'd be happy to run more cases and/or
other patches.

Nathan

