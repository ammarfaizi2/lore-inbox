Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWBQDOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWBQDOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 22:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWBQDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 22:14:47 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:15171 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932180AbWBQDOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 22:14:47 -0500
Message-ID: <43F53FA4.3090005@bigpond.net.au>
Date: Fri, 17 Feb 2006 14:14:44 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       npiggin@suse.de, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com> <43F53553.50904@bigpond.net.au> <20060216185403.B27025@unix-os.sc.intel.com>
In-Reply-To: <20060216185403.B27025@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 17 Feb 2006 03:14:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Feb 17, 2006 at 01:30:43PM +1100, Peter Williams wrote:
> 
>>On a normal system, would either of them be moved anyway?
> 
> 
> Possible. Because when the migration thread runs it moves the current running
> task out of the processor and the checks in can_migrate_task() like
> "sd->nr_balance_failed > sd->cache_nice_tries" can result in cache hot task
> move to the idle package.. This is a round about way and we should not depend
> on this behavior..

So why does it need to be retained?

> 
> 
>>>To fix my reported problem, we need to make sure that find_busiest_group()
>>>doesn't find an imbalance..
>>
>>I disagree.  If this causes a problem with your "optimizations" then I 
>>think that you need to fix the "optimizations".
>>
>>There's a rational argument (IMHO) that this patch should be applied 
>>even in the absence of the smpnice patches as it prevents 
>>active_load_balance() doing unnecessary work.  If this isn't good for 
>>hypo threading then hypo threading is a special case and needs to handle 
>>it as such.
> 
> 
> active load balance is designed only with HT optimizations in mind. And now
> multi-core optimizations also use this active load balance. No one else uses
> active load balance.

I can see nothing in the source code that will cause 
active_load_balance() to be only run on hypo threaded systems.  Could 
you please provide some pointers to the mechanism that does this.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
