Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWBQCvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWBQCvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWBQCvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:51:49 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:24269 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751330AbWBQCvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:51:48 -0500
Message-ID: <43F53A42.2090909@bigpond.net.au>
Date: Fri, 17 Feb 2006 13:51:46 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       npiggin@suse.de, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com> <43F53553.50904@bigpond.net.au>
In-Reply-To: <43F53553.50904@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 17 Feb 2006 02:51:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
> 
>> Andrew, Please don't apply this patch. This breaks the existing HT
>> (and multi-core) scheduler optimizations.
>>
>> Peter, on a DP system with HT, if we have only two runnable processes
>> and they end up running on the two threads of the same package, with 
>> your patch, migration thread will never move one of those processes to 
>> the idle package..
> 
> 
> On a normal system, would either of them be moved anyway?
> 
>>
>> To fix my reported problem, we need to make sure that 
>> find_busiest_group()
>> doesn't find an imbalance..
> 
> 
> I disagree.  If this causes a problem with your "optimizations" then I 
> think that you need to fix the "optimizations".
> 
> There's a rational argument (IMHO) that this patch should be applied 
> even in the absence of the smpnice patches as it prevents 
> active_load_balance() doing unnecessary work.  If this isn't good for 
> hypo threading then hypo threading is a special case and needs to handle 
> it as such.

OK.  The good news is that (my testing shows that) the "sched: fix 
smpnice abnormal nice anomalies" fixes the imbalance problem and the 
consequent CPU hopping.

BUT I still think that this patch (modified if necessary to handle any 
HT special cases) should be applied.  On a normal system, it will (as 
I've already said) stop active_load_balance() from doing a lot of 
unnecessary work INCLUDING holding the run queue locks for TWO run 
queues for no good reason.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
