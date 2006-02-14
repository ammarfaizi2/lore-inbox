Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWBNMt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWBNMt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBNMt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:49:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65227 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161041AbWBNMt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:49:29 -0500
Date: Tue, 14 Feb 2006 13:47:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Message-ID: <20060214124743.GA5586@elte.hu>
References: <B05667366EE6204181EABE9C1B1C0EB509AAE8BD@scsmsx401.amr.corp.intel.com> <20060214000033.7e695978.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214000033.7e695978.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > Here is a respin of the patch with more documentation.
> >
> 
> Thanks.  Can you send me an unwordwrapped version off-list?
> 
> Did I mention "ug"?
> 
> Ingo, what's your plan here?

I really dont like the sysctl hack. Firstly, which precise kernel 
version was tested - do we know that it wasnt e.g. the smpnice 
regression interfering? Secondly, i dont like the sysctl concept itself: 
i really think we should try to find a way for _applications_ to be 
woken up according to their workload.

If we add the sysctl then basically only the benchmarkers will use it - 
99.99% of users will get whatever default we (and distros) provide, and 
the problem wont be solved in any way. In fact, we'll never be able to 
get rid of the knob again i suspect. I'd rather have the wakeup patch 
reverted, and some better method presented. Adding the sysctl just 
removes all the incentive for people to work on solving this problem in 
some real way.

I also refuse to regard this as any sort of emergency that justifies the 
sysctl hack. The test results came clearly late and i suggested to the 
benchmarking guys a long time ago that if they want us to care about 
their workload, and if it's complex to reproduce the benchmark, they 
should distill some simpler test-app for us to so that we can reproduce 
those cases. I'd much rather like to do the simplest thing: revert the 
wakeup patch (we were fine without it for 15 kernel releases), than to 
paper over [permanently!] this particular incarnation of a wider 
problem.

	Ingo
