Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUGAVk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUGAVk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266300AbUGAVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:40:58 -0400
Received: from mail.tmr.com ([216.238.38.203]:57615 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266293AbUGAVkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:40:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux scheduler (scheduling) questions vs threads
Date: Thu, 01 Jul 2004 17:41:54 -0400
Organization: TMR Associates, Inc
Message-ID: <cc2030$se5$1@gatekeeper.tmr.com>
References: <313680C9A886D511A06000204840E1CF08F42FBC@whq-msgusr-02.pit.comms.marconi.com><313680C9A886D511A06000204840E1CF08F42FBC@whq-msgusr-02.pit.comms.marconi.com> <20040701120624.GA24295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1088717728 29125 192.168.12.100 (1 Jul 2004 21:35:28 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040701120624.GA24295@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Povolotsky, Alexander <Alexander.Povolotsky@marconi.com> wrote:
> 
> 
>>Sorry for bothering and annoying everyone on this list again with additional
>>questions ...
>>
>>Let assume there is one (and only one) application (user space ) process
>>running on the Linux 2.6 - with multiple threads within it, created via
>>"clone" (this happens, I presume, for example, if one uses Monta Vista
>>library for porting PSOS to Linux).
>>
>>What scheduling policies those threads (within the same process) will be
>>governed by (if any )?
> 
> 
> in Linux there's no difference between the scheduling of 'threads' and
> 'processes'. Both are internally a 'task'. If two tasks share the same
> MM (this is possible via the use of clone()) then they are called
> threads. If a task has its own MM (normally created via fork()) then
> it's called a process - but the scheduler doesnt care.
> 
> so the normal Linux scheduling policy applies to 'threads' too. Fully
> preemptable, SCHED_NORMAL by default, or SCHED_FIFO/SCHED_RR if you set
> it. The priority (or rt_priority) can be set per-task as well. Newly
> created threads/processes may inherit (or not) the policy of the parent,
> this largely depends on the library implementation.

On a multi-user machine this may result in undesirable behaviour, since 
each thread seems to compete for resources and the machine may get VERY 
slow if someone deos something anti-social. There is a Mandelbrot 
drawing program which allows use of threads, it will do very bad things 
to system performance to have 8 CPU bound threads generating graphics so 
X is doing a lot of work as well. Student claimed it was part of his 
math homework...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
