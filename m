Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267531AbUHEBHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267531AbUHEBHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267530AbUHEBHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:07:12 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:32190 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S267531AbUHEBGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:06:55 -0400
Message-ID: <4111882B.9090504@bigpond.net.au>
Date: Thu, 05 Aug 2004 11:06:51 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com> <41104C8F.9080603@bigpond.net.au> <20040804074440.GL2334@holomorphy.com>
In-Reply-To: <20040804074440.GL2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> On Wed, Aug 04, 2004 at 12:40:15PM +1000, Peter Williams wrote:
> 
>>The timer would be deactivated whenever the number of runnable tasks for 
>>the runqueue goes below 2.  The whole thing could be managed from the 
>>enqueue and dequeue functions i.e.
>>dequeue - if the number running is now less than two cancel the timer 
>>and otherwise decrease the expiry time to maintain the linear 
>>relationship of the interval with the number of runnable tasks
>>enqueue - if the number of runnable tasks is now 2 then start the time 
>>with a single interval setting and if the number is greater than two 
>>then increase the timer interval to maintain the linear relationship.
>>I'm assuming here that add_timer(), del_timer() and (especially) 
>>mod_timer() are relatively cheap.  If mod_timer() is too expensive some 
>>alternative method could be devised to maintain the linear relationship.
> 
> 
> Naive schemes reprogram the timer device too frequently.

I had a look at mod_timer() and I agree that it's too expensive to call 
every time a task gets queued or dequeued.

> Software
> constructs are less of a concern. This also presumes that taking timer
> interrupts when cpu-intensive workloads voluntarily yield often enough
> is necessary or desirable.

Voluntary yielding can't be relied upon.  Writing a program that never 
gives up the CPU voluntarily is trivial.  Some have been known to do it 
without even trying :-)

> This is not so in virtualized environments,
> and unnecessary interruption of userspace also degrades performance.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

