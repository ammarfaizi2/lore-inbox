Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUIPO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUIPO1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUIPO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:27:31 -0400
Received: from mail.tmr.com ([216.238.38.203]:28164 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268090AbUIPO13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:27:29 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Date: Thu, 16 Sep 2004 10:28:08 -0400
Organization: TMR Associates, Inc
Message-ID: <cic7f9$i4m$1@gatekeeper.tmr.com>
References: <2EJTp-7bx-1@gated-at.bofh.it><2EJTp-7bx-1@gated-at.bofh.it> <m3vfefa61l.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1095344426 18582 192.168.12.100 (16 Sep 2004 14:20:26 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <m3vfefa61l.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> 
>>the attached patch is a new approach to get rid of Linux's Big Kernel
>>Lock as we know it today.
> 
> 
> Interesting approach. Did you measure what it does to context
> switch rates? Usually adding semaphores tends to increase them
> a lot.

Is that (necessarily) a bad thing? If it results in less time waiting 
for BKL, and/or more time doing user work, that may drive throughput and 
responsiveness up. It depends if the time for two ctx is greater or less 
than the spin time on BKL.

It would be nice to have the best of both worlds, use the semaphore if 
there is a process on the run queue, and spin if not. That sounds 
complex, and hopefully not worth the effort.

High ctx rates are not necessarily bad, when we implemented O_DIRECT for 
an application the rate went up 30%, the outbound bandwidth went up 
10-15%, and waitio dropped by half at peak load. As long as something 
useful is being done with the time previously wasted in spinning, I 
would expect it to be a win.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
