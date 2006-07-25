Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWGYFoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWGYFoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGYFoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:44:38 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:30153 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932465AbWGYFoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:44:38 -0400
Message-ID: <44C5AFC3.4020405@bigpond.net.au>
Date: Tue, 25 Jul 2006 15:44:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
References: <200607241857.52389.a1426z@gawab.com> <200607250757.10722.a1426z@gawab.com>
In-Reply-To: <200607250757.10722.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Jul 2006 05:44:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> Peter Williams wrote:
>>>> This version removes the hard/soft CPU rate caps from the SPA
>>>> schedulers.
>>>>
>>>> A patch for 2.6.18-rc2 is available at:
>>>>
>>>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.18-rc2.
>>>> pat ch?download>
>>>>
>>>> Very Brief Documentation:
>>>>
>>>> You can select a default scheduler at kernel build time.  If you wish
>>>> to boot with a scheduler other than the default it can be selected at
>>>> boot time by adding:
>>>>
>>>> cpusched=<scheduler>
>>> Any reason dynsched couldn't be merged with plugsched?
>> None that I know of (but I'm not familiar with dynsched).  Patches to
>> add it to the mix would be accepted and once in I would try to keep it
>> in step with kernel changes.
> 
> I thought dynsched patches against plugsched, what else is needed?
>

Hopefully, nothing but it may be necessary to modify the plugsched 
interface if dynsched can't be implemented against it "as is".  E.g. 
both staircase and nicksched needed changes to what was required for 
ingosched and the SPA schedulers.

>>>> to the boot command line where <scheduler> is one of: ingosched,
>>>> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
>>>> or zaphod.  If you don't change the default when you build the kernel
>>>> the default scheduler will be ingosched (which is the normal
>>>> scheduler).
>>>>
>>>> The scheduler in force on a running system can be determined by the
>>>> contents of:
>>>>
>>>> /proc/scheduler
>>> It may be really great, to allow schedulers perPid parent, thus allowing
>>> the stacking of different scheduler semantics.  This could aid
>>> flexibility a lot.
>> I'm don't understand what you mean here.  Could you elaborate?
> 
> i.e:  Boot the kernel with spa_no_frills, then start X with spa_ws.

It's probably not a good idea to have different schedulers managing the 
same resource.  The way to do different scheduling per process is to use 
the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc. 
(possibly extended) within each scheduler.  On the other hand, on an SMP 
system, having a different scheduler on each run queue (or sub set of 
queues) might be interesting :-).  The schedulers would probably have to 
have a common idea of how the run queue works though and this would 
restrict the choice of schedulers.

I have no intentions (at the moment) of going down this path myself.

However, I am thinking about making it possible to switch between the 
various SPA schedulers on a running system.  A extension to this could 
be to attempt automatic selection of which scheduler to use possibly 
based on which users are logged in.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
