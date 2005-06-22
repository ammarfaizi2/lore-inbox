Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFVPvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFVPvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFVPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:51:21 -0400
Received: from opersys.com ([64.40.108.71]:7949 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261569AbVFVPte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:49:34 -0400
Message-ID: <42B98B20.7020304@opersys.com>
Date: Wed, 22 Jun 2005 12:00:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com>
In-Reply-To: <20050620183115.GA27028@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> You might what to try the overall times numbers with the voluntary
> preemption instead. That option doesn't convert spinlocks and still
> uses interrupt threads. I'd be surprised that the spinlocks would
> contribute to that much overhead. Nevertheless, I'll be curious
> about those results.

To tell you the truth, we've spent a considerable amount of time as
it is on this and we need to move on to other things. So while we
may do a repeat, we think the latest results are good enough to
feed the discussion for some time. Also, we've finally release the
LRTBF, so we hope you'll try it out yourself and share what you find.
We'll continue making LRTBF releases with the contributions we get.

In regards to the performance, of PREEMPT_RT, we've also made
available the comparative output of LMbench for the various runs
as part of the LRTBF release. Have a look at the bottom of this
section:
http://www.opersys.com/lrtbf/#latest-results

I don't know what part of PREEMPT_RT causes this, but looking at
some of the numbers from this output one is tempted to conclude that
PREEMPT_RT causes a very significant impact on system load. And I
don't say this lightly. Have a look for example at the local
communication latencies between vanilla and PREEMPT_RT when the
target is subject to the HD test. For a pipe, this goes from 9.4us
to 21.6. For UDP this goes from 22us to 1070us !!! Even on a
system without any load, the numbers are similar. Ouch.

I have no envy of starting a flamefest, but to be fair I must
mention that the output for the same runs for I-pipe is much more
reasonable. In fact it's much closer to vanilla performance. Again,
please no flames ... just read the numbers.

Notice that that part of the test (LMbench) does not require a
repeat of our complete setup. A simple LMbench comparison even
on an isolated machine should yield similar results.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
