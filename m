Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUE1JZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUE1JZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUE1JZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:25:24 -0400
Received: from CPE-203-45-91-93.nsw.bigpond.net.au ([203.45.91.93]:22262 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S262406AbUE1JYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:24:40 -0400
Message-ID: <40B70542.2060006@aurema.com>
Date: Fri, 28 May 2004 19:24:18 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
References: <40B6C571.3000103@aurema.com> <20040528090536.GA12933@elte.hu>
In-Reply-To: <20040528090536.GA12933@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <peterw@aurema.com> wrote:
> 
> 
>>-- at the end of each time slice (or when waking up) each task is
>>given a complete new time slice and, if class SCHED_NORMAL, is put in
>>a priority slot given by (static_prio + MAX_BONUS - interactive_bonus)
> 
> 
> this is the Achilles' heel of approaches that try to get rid of the
> active/expired array and/or try to get rid of timeslice tracking. A
> CPU-bound task which schedules away for small amounts of time will get a
> disproportionatly larger share of the CPU than a CPU-bound task that
> doesnt schedule at all.
> 
> just try it - run a task that runs 95% of the time and sleeps 5% of the
> time, and run a (same prio) task that runs 100% of the time. With the
> current scheduler the slightly-sleeping task gets 45% of the CPU, the
> looping one gets 55% of the CPU. With your patch the slightly-sleeping
> process can easily monopolize 90% of the CPU!

If these two tasks have the same nice value they should around robin 
with each other in the same priority slot and this means that the one 
doing the smaller bites of CPU each time will in fact get less CPU than 
the other i.e. the outcome will be the opposite of what you claim.

This does, of course, not take into account the interactive bonus.  If 
the task doing the shorter CPU bursts manages to earn a larger 
interactivity bonus than the other then it will get more CPU but isn't 
that the intention of the interactivity bonus?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

