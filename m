Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUHCAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUHCAcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHCA3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:29:53 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:199 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S264660AbUHCA1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:27:38 -0400
Message-ID: <410EDBF5.40205@bigpond.net.au>
Date: Tue, 03 Aug 2004 10:27:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <2oEEn-197-9@gated-at.bofh.it> <m3isc1smag.fsf@averell.firstfloor.org>
In-Reply-To: <m3isc1smag.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Peter Williams <pwil3058@bigpond.net.au> writes:
> 
> 
>>Version 3 of the various single priority array scheduler patches for
>>2.6.7, 2.6.8-rc2 and 2.6.8-rc2-mm1 kernels are now available for
>>download and evaluation:
> 
> 
> [...] So many schedulers. It is hard to chose one for testing.
> 
> Do you have one you prefer and would like to be tested especially? 

I think that ZAPHOD in "pb" mode is probably the best but I'm hoping for 
input from a wider audience.  That's why I built HYDRA.  So that various 
options can be tried without having to rebuild and reboot.

The questions I'm trying to answer are:

1.  Are "priority" based ("pb") semantics for "nice" better than 
"entitlement" based ("eb") semantics?  Does it depend on what the 
system's being used for?

2. What are the appropriate values for controlling interactive bonuses 
for "pb" and "eb"?

3. Are interactive bonuses even necessary for "eb"?

4. What's the best time slice size for interactive use?

5. What's the best time slice size for a server?

6. Does the throughput bonus help?  In particular, does it reduce the 
amount of queuing when the system is not fully loaded.

7. Should any (or all) of the scheduling knobs in 
/proc/sys/kernel/cpusched/ be retained for a production scheduler.

> 
> Perhaps a few standard benchmark numbers for the different ones 
> (e.g. volanomark or hackbench or the OSDL SDL tests) would make it 
> easier to preselect.

OK, I'll do that. But some of the questions for which I am seeking 
answers are more subjective.  In particular, interactive responsiveness 
is hard to test automatically.

Also, these tests are no good for evaluating the throughput bonus 
because when the system is heavily loaded there's going to be queuing 
anyway.  Where this bonus is expected to be most helpful is at 
intermediate system loads where there is still significant queuing (due 
to lack of serendipity i.e. they're all sleeping at the same time and 
trying to run at the same time instead of slotting in nicely between 
each other) even though there are (theoretically) enough CPU resources 
to handle the load without any queuing.  Tests with an earlier scheduler 
showed that (where such queuing was occurring) the techniques used in 
the throughput bonus could significantly reduce it.  These tests were 
conducted with artificial loads and confirmation from the real world 
would be helpful.  (Of import here is whether there are significant 
queuing problems at intermediate loads in the real world because if 
there isn't then there is nothing for the throughput bonus to fix.  This 
is possible because the higher the randomness of a system's load then 
the better the serendipity will be.)

The scheduling statistics that are included in my patches measure time 
spent on the run queue so that measurements of improvements due to the 
throughput bonus are possible.  Another way that such improvements would 
be increased responsiveness from servers.

> 
> Have you considered submitting one to -mm* for wider testing?

I've made patches available for 2.6.8-rc2-mm1 and I'll provide them for 
mm2 as soon as possible.  Is there something else I should be doing?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

