Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVCHG3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVCHG3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVCHG3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:29:12 -0500
Received: from gizmo12bw.bigpond.com ([144.140.70.43]:28068 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S261796AbVCHG3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:29:03 -0500
Message-ID: <422D4628.8060203@bigpond.net.au>
Date: Tue, 08 Mar 2005 17:28:56 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au> <20050308054931.GA20200@elte.hu>
In-Reply-To: <20050308054931.GA20200@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>I don't object to rlimits per se and I think that they are useful but
>>not as a sole solution to this problem.  Being able to give a task
>>preferential treatment is a permissions issue and should be solved as
>>one.
>>
>>Having RT cpu usage limits on tasks is a useful tool to have when
>>granting normal users the privilege of running tasks as RT tasks so
>>that you can limit the damage that they can do BUT the presence of a
>>limit on a task is not a very good criterion for granting that
>>privilege.
> 
> 
> i think you are talking about my rlimit patch (the 'RT CPU limit' patch)
> - but that one is not in discussion here.
> 
> what is being discussed currently is the other rlimit patch (from Chris
> Wright and Matt Mackall) which implements a simple rlimit ceiling for
> the RT (and nice) priorities a task can set. The rlimit defaults to 0,
> meaning no change in behavior by default. A value of 50 means RT
> priority levels 1-50 are allowed. A value of 100 means all 99 privilege
> levels from 1 to 99 are allowed. CAP_SYS_NICE is blanket permission.
> It's all pretty finegrained and and it's a quite straightforward
> extension of what we have today.

OK.  My misunderstanding.

But the patch you describe still seems a little loose to me in that it 
doesn't control both which users AND which programs they can run. 
Although I suppose that can be managed by suitable setting of file 
permissions?

Also I presume that root privileges are needed to set the rlimits which 
means that the program has to be setuid root or run from a setuid root 
wrapper.  In the first of these cases the program will be running for a 
(hopefully) short while with way more privilege than it needs.  This is 
why I'm attracted to mechanisms that allow programs to be given a subset 
of root's privileges and only for specified users.

I would be nice to have a solution to this particular problem that fits 
in with such a generalized "granular" privilege mechanism (when/if such 
a mechanism becomes available in the future) rather than a quirky fix 
that is specific to this problem and doesn't generalize well to similar 
problems when they arise in the future.  However, I agree with your 
opinion that granting CAP_SYS_NICE is dangerous without some limit on 
the priority levels is dangerous and think that a generalized "granular" 
privilege mechanism would need to include such restrictions.

> The patch does not attempt to do any
> "damage control" of abuse caused by RT tasks, and is hence much simpler
> than my patch or Con's SCHED_ISO patch. ("damage control" could be done
> from userspace anyway)

Yes.  In kernel "damage control" is an optional extra not a necessity 
with this solution.  Not so sure about with the RT LSB solution though.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
