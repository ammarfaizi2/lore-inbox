Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVFVUbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVFVUbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVFVU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:29:36 -0400
Received: from opersys.com ([64.40.108.71]:55311 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261979AbVFVU27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:28:59 -0400
Message-ID: <42B9CC98.1040402@opersys.com>
Date: Wed, 22 Jun 2005 16:39:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu>
In-Reply-To: <20050622200554.GA16119@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> the UDP-over-localhost latency was a softirq processing bug that is 
> fixed in current PREEMPT_RT patches. (real over-the-network latency was 
> never impacted, that's why it wasnt noticed before.)

That's good to hear, but here are some random stats from the
idle run:

Measurements   |   Vanilla   |  preemp_rt     |   ipipe
---------------+-------------+----------------+-------------
fork           |      95us   |  157us (+65%)  |   97us (+2%)
open/close     |     1.4us   |  2.1us (+50%)  |  1.4us (~)
execve         |     355us   |  452us (+27%)  |  365us (+3%)
select 500fd   |    12.7us   | 27.7us (+118%) | 12.7us (~)
mmap           |     660us   | 2886us (+337%) |  673us (+2%)
...            |      ...    |   ...          |   ...

Here's a under ping flood conditions:

Measurements   |   Vanilla   |  preemp_rt     |   ipipe
---------------+-------------+----------------+-------------
fork           |     112us   |  223us (+99%)  |  121us (+8%)
open/close     |     1.7us   |  3.0us (+76%)  |  1.8us (+6%)
execve         |     421us   |  652us (+55%)  |  467us (+11%)
select 500fd   |    14.6us   | 38.1us (+161%) | 15.5us (+6%)
mmap           |     760us   | 3936us (+418%) |  819us (+8%)
...            |      ...    |   ...          |   ...

etc. it's like this accross the board.

Unless that fix you mention above takes care of these, there's
something seriously wrong going on here.

Are there existing LMbench results posted of PREEMPT_RT which
one can go back to for comparison?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
