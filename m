Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWBAOZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWBAOZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWBAOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:25:24 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:59306 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161062AbWBAOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:25:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tC+lYErUHxIU1I+XIHHP92uaLidWN2nL/YQnIzvyR5+ZL6+nh2xBT0qLT/eb/wbbdpdLRWzUI5bj66+TikqDC4O1OUhNc+Ji3/fGpovyO9LxGVnDltkH+mijX4TuVsDPq12HvzJSedqWG6/zE312FPjBWxr5isHkxLgrjBFguPw=  ;
Message-ID: <43E0C4CF.8090501@yahoo.com.au>
Date: Thu, 02 Feb 2006 01:25:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au> <20060201141248.GA6277@elte.hu>
In-Reply-To: <20060201141248.GA6277@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 

>>However, as an RT-tree thing obviously I have no problems with it, but 
>>unless your interrupt thread is preemptible, then there isn't much 
>>point because it can cause a similar latency (that your tools won't 
>>detect) simply by running multiple times.
> 
> 
> we can (and do) detect any type of latency. E.g. there's the 
> CONFIG_LPPTEST feature in the -rt kernel, which allows me to inject 
> 50,000 hardirqs per second from another box, over a parallel port, and 
> allows me to validate the worst-case IRQ response time from that 
> external box. The 'external' component of LPPTEST injects the interrupt 
> with interrupts disabled, and polls for the response, and does all 
> measurements on that other box. I can use that in conjunction with the 
> latency tracer running on the measured box, to get an easy snapshot of 
> the longest hardirq latency path.
> 

What I am talking about is when you want a task to have the highest
possible scheduling priority and you'd like to guarantee that it is
not interrupted for more than Xus, including scheduling latency.

Presumably this is your classic RT control type application.

Now in your kernel you can measure a single long interrupt time, but
if you "break" that latency by splitting it into two interrupts, the
end result will be the same if not worse due to decreased efficiency.

This is what I was talking about. But that's going off topic...

>>You really want isolcpus on SMP machines to really ensure load 
>>balancing doesn't harm RT behaviour, yeah?
> 
> 
> not really - isolcpus is useful for certain problems, but it is not 
> generic as it puts heavy constraints on usability and resource 
> utilization. We have really, really good latencies on SMP too in the -rt 
> kernel, with _arbitrary_ SCHED_OTHER workloads. Rwsems and rwlocks are 
> not an issue, pretty much the only issue is the scheduler's 
> load-balancing.
> 

Then it is a fine hack for the RT kernel (or at least an improved,
batched version of the patch). No arguments from me.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
