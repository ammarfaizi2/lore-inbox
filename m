Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317558AbSFRTLQ>; Tue, 18 Jun 2002 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317557AbSFRTLP>; Tue, 18 Jun 2002 15:11:15 -0400
Received: from mail.webmaster.com ([216.152.64.131]:42127 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317556AbSFRTLO> convert rfc822-to-8bit; Tue, 18 Jun 2002 15:11:14 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <root@chaos.analogic.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>
CC: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 12:11:12 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBCEEICBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618191114.AAA27826@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jun 2002 11:05:36 -0700, mgix@mgix.com wrote:

>>    Your assumptions are just plain wrong. The yielder is being nice, so it
>>should get preferential treatment, not worse treatment. All threads are
>>ready-to-run all the time. Yielding is not the same as blocking or lowering
>>your priority.

>In other words, the more you yield, the nicer you
>are and the more CPU you get, and those nasty processes
>that are trying to actually use the CPU to do something
>with it and wear it down should get it as little as possible.
>I get it.
>
>    - Mgix

	I'm sorry, but you are being entirely unreasonable. The kernel has no way to 
know which processes are doing something useful and which ones are just 
wasting CPU. It knows is that they are all ready-to-run and they all have the 
same priority and none of them are blocking. The yielding threads are playing 
nice and shouldn't be penalized for it.

	The following code:

while(1) sched_yield();

	Is the problem, not the kernel. You can't expect the kernel's ESP to figure 
out that you really meant something else or that your process isn't really 
doing anything useful.

	If you didn't mean to burn the CPU in an endless loop, WHY DID YOU?

	You should never call sched_yield in a loop like this unless your intent is 
to burn the CPU until some other thread/process does something. Since you 
rarely want to do this, you should seldom if ever call sched_yield in a loop. 

	What sched_yield is good for is if you encounter a situation where you 
need/want some resource and another thread/process has it. You call 
sched_yield once, and maybe when you run again, the other thread/process will 
have released it. You can also use it as the spin function in spinlocks.

	But your expectation that it will reduce CPU usage is just plain wrong. If 
you have one thread spinning on sched_yield, on a single CPU machine it will 
definitely get 100% of the CPU. If you have two, they will each definitely 
get 50% of the CPU. There are blocking functions and scheduler priority 
functions for this purpose.

	DS


