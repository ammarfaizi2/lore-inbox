Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbUABUWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbUABUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:22:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28176 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265627AbUABUWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:22:30 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Fri, 02 Jan 2004 15:05:51 -0500
Organization: TMR Associates, Inc
Message-ID: <bt4j7q$6i2$1@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073074234 6722 192.168.12.10 (2 Jan 2004 20:10:34 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20031226225652.GE197@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>Why do I need hyper-thread aware batch scheduling?
>>
>>If you have a hyperthread (P4HT) processor and run it as two logical cpus you 
>>can have a very low priority task running that can consume 50% of your 
>>physical cpu's capacity no matter how high priority tasks you are running. 
>>For example if you use the distributed computing client setiathome you will 
>>be effectively be running at half your cpu's speed even if you run setiathome 
>>at nice 20. Batch scheduling for normal cpus allows only idle time to be used 
>>for batch tasks, and for HT cpus only allows idle time when both logical cpus 
>>are idle.
> 
> 
> BTW this is going to be an issue even on normal (non-HT)
> systems. Imagine memory-bound scientific task on CPU0 and nice -20
> memory-bound seti&home at CPU1. Even without hyperthreading, your
> scientific task is going to run at 50% of speed and seti&home is going
> to get second half. Oops.

Yes and even worse, if you stop running setiathome the scientific task 
*still* only gets half the available CPU!

The difference is that with HT running a task on one sibling actually 
does (or can) slow the other. That's not true with true SMP, at least 
not directly, since the resourses shared (memory and disk) are much 
farther away from the CPU.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
