Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVFVUHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVFVUHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVFVUHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:07:31 -0400
Received: from opersys.com ([64.40.108.71]:40463 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262014AbVFVUHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:07:01 -0400
Message-ID: <42B9C777.8040202@opersys.com>
Date: Wed, 22 Jun 2005 16:17:59 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu>
In-Reply-To: <20050622190422.GA6572@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> with lpptest (PREEMPT_RT's built-in parallel-port latency driver) that's 
> possible, as it polls the target with interrupts disabled, eliminating 
> much of the logger-side latencies. The main effect is that it's now only 
> a single worst-case latency that is measured, instead of having to have 
> two worst-cases meet.
> 
> Here's a rough calculation to show what the stakes are: if there's a 
> 1:100000 chance to trigger a worst-case irq handling latency, and you 
> have 600000 samples, then with lpptest you'll see an average of 6 events 
> during the measurement. With lrtfb (the one Karim used) the chance to 
> see both of these worst-case latencies on both sides of the measurement 
> is 1:10000000000, and you'd see 0.00006 of them during the measurement.  
> I.e. the chances of seeing the true max latency are pretty slim.

If indeed there are 6 events on a single-side which are worst-case,
then you would have to also factor in the probability of obtaining
an average or below average result on the other side. So again, if
all runs were measuring average on each side, one would expect that
at least one of the runs would have a bump over the 55us mark. Yet,
they all have the same maximum.

Here's an overview of the results spread in the case of IRQ latency
measurements in the HD case (this is just a view of one case, a
true study would require drawing graphs showing the spread for all
tests):
Of 833,000 results for PREEMPT_RT:
	-  36 values are above 50us (0.0045% or 4.5/100,000)
	- 860 values are 19us and above
Of 781,000 results for IPIPE:
	- 213 values are above 50us (0.0273% or 27/100,000)
	- 311 values are 19us and above

Contrary to the illustration you make above, it would seem that the
fact that both machines are running the same mechanism, the
blue-moon effect multiplies upward instead of downward. This,
though, is but a preliminary analysis.

Notes:
- Below 19us, the number of measurement points increases for both
setups as we get closer to the 14us average mark.
- There are more data points for PREEMPT_RT than ipipe because
LMbench takes much more time to complete on the former.

> So if you want to reliably measure worst-case latencies in your expected 
> lifetime, you truly never want to serially couple the probabilities of 
> worst-case latencies on the target and the logger side.

Like I said, we're going to settle this one to avoid any further
doubts.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
