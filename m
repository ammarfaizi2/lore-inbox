Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVCXARR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVCXARR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVCXARR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:17:17 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:44188 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262103AbVCXARM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:17:12 -0500
Message-ID: <42420704.9080701@yahoo.com.au>
Date: Thu, 24 Mar 2005 11:17:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arun Srinivas <getarunsri@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related
 questions?
References: <BAY10-F42DB434C4A842D9EB1D3AAD94F0@phx.gbl>
In-Reply-To: <BAY10-F42DB434C4A842D9EB1D3AAD94F0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Srinivas wrote:
> few more trivial Q's (bear with me  I'm a newbie to kernel world):
> 
> 1) As I said I have a process that spawns 2 threads(thread A and B).I am 
> trying to measure the exact time @ which they are being scheduled.For 
> this I am using the rdtsc() (when threads A and B come)  in 
> enqueue_task()..where they are being inserted into the priority array.
> Is this a correct way of measuring?
> 

Not exactly. They can be enqueued "onto" the runqueue without being
scheduled if there is another process running at the time.

You should look in schedule(). And use sched_clock instead of rdtsc.
I think you'll find schedule() already calls sched_clock, so you should
be able to do this with minimal overhead.

Note also, that schedule() may be called multiple times without
switching your task off the CPU - so keep that in mind if you are looking
for the time at which it is first scheduled on.

> 2) also in task_struct.....is "tgid" the id of my process and each of 
> threads hav a unique pid??
> 

Something like that.

> 3) I saw frm the kernel docs tht realtime tasks hav priority 0 to 99. So 
> using setscheduler means do I have to enforce a priority in one of these 
> ranges to make my threads as soft/hard realtime task.
> 

Well, if you have nothing else running with a realtime scheduling policy,
then your process that is will always be scheduled first.

The priority only distinguishes between two realtime processes.

Oh, and Linux is not hard realtime. Meaning you don't have a deterministic
scheduling latency. But these days it is pretty good - probably not something
you'd have to worry about.

Nick

