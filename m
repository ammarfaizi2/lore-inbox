Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWGQLxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWGQLxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWGQLxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:53:06 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:43451 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1750759AbWGQLxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:53:05 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607161254260.9870@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
	 <1152978284.16617.7.camel@mindpipe>
	 <1153009392.6374.77.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
	 <1153044864.6374.135.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161254260.9870@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Mon, 17 Jul 2006 21:53:00 +1000
Message-Id: <1153137181.24228.16.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Who said suid root? What about suid realtime or suid audio?

Still, I don't see what you gain by making them setuid $group vs
allowing member(s) of $group to use rt scheduling.

> My point is not that they can lock up the machine. My point is that you 
> just can't add a rt task to a rt system! A rt-system consists of a fixed 
> set of threads, which in worst case can meet it's deadlines. If you add 
> just one task you might break the whole system. Only someone with overview 
> of the whole system can add those tasks.

This issue can also happen if you start 10 suid rt apps. It's the
responsibility of the user to make sure there's no bad interaction. The
reason we want a limit is to make sure the system remains relatively
responsive (not just up). In the ideal case (not sure it's possible),
the scheduler would make sure that non-root rt apps wouldn't get (on
average) more CPU than they would get running at normal priority. i.e.
if there are 3 tasks competing and you start a rt task, then that task
couldn't get more than 25% CPU. Of course, it may not be possible to do
that perfectly, but anything remotely close would be pretty good. 

In any case, most audio (and probably other) applications tend to only
require a very small amount (<10%) of CPU to run properly. I'd be quite
happy is my system was configured to allow me to run rt tasks as long as
the total doesn't exceed 30% CPU.

> It is very simple if you have only a audio application or only a driver 
> needing low latencies. What if you have both? You have to make sure that 
> the higher priority one leaves enough cpu for the lower priority one. And 
> it is not a question of using a low percentage of cpu. It is a question of 
> how long the cpu is used in one go and how often it can happen within the 
> critical timeframe of the lower priority application.

I understand that, but adding artificial restrictions (to setuid audio
apps) isn't going to help. 

> You can make a system which checks that but it is much harder to do than 
> a moving average. The only thing which makes sense is (a) square filter(s)
> with a width equal to the required latency of the lower priority task(s).

Why not? It could be nice as well if someone wants to implement that.
I'd already be quite happy to just have basic control on the CPU time.

> So the sys-admin should somehow be able to give the right either to 
> specific (audio) applications with specific priorities or a developer whom 
> he trusts (and it does not make sense to give it to both as they would 
> then mess it up for each other!)

How about simply giving rt rights to whomever is logged on the console?
That's the user that really counts since he's (usually) next to the
audio device. 

> We have discussed that total lock-up can be prevented with a simple 
> watchdog. That solution doesn't need anything added into the scheduler.

As I mentioned earlier, it's not about total lock-up, but having things
run relatively smoothly and (if possible?) even fairly.

	Jean-Marc
