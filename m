Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVBPR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVBPR7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVBPR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:59:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56061 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262022AbVBPR7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:59:32 -0500
Message-ID: <421389F5.3060007@mvista.com>
Date: Wed, 16 Feb 2005 09:59:17 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Ingo Molnar <mingo@elte.hu>, mgross@linux.intel.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
References: <200502141240.14355.mgross@linux.intel.com>	<200502141429.11587.mgross@linux.intel.com>	<20050215104153.GB19866@elte.hu>	<200502151006.44809.mgross@linux.intel.com>	<20050216051645.GB15197@elte.hu> <20050216081143.50d0a9d6.davem@davemloft.net>
In-Reply-To: <20050216081143.50d0a9d6.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 16 Feb 2005 06:16:45 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
> 
>>Maybe the networking
>>stack would break if we allowed the TIMER softirq (thread) to preempt
>>the NET softirq (threads) (and vice versa)?
> 
> 
> The major assumption is that softirq's run indivisibly per-cpu.
> Otherwise the per-cpu queues of RX and TX packet work would
> get corrupted.

For what its worth, I, a short while ago, put together a workqueue package to a) 
allow easy priority setting for work queues and b) change either softirq, 
tasklet or bh code to use workqueues.  This was done mostly with CPP macros and 
a few conversion routines.  I then converted the network code to use this 
package simply by adding a key include to a couple of files.  The result worked 
on UP but ended up hanging the network code on SMP.  Everything else still 
worked, but not the net stuff.  I never ran down the problem as the "boss" was 
not interested in SMP...

George

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

