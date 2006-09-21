Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWIUHTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWIUHTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWIUHTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:19:25 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:15041
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750888AbWIUHTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:19:24 -0400
Date: Thu, 21 Sep 2006 00:18:40 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921071838.GA10337@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921065402.GA22089@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 08:54:02AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> 
> > On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
> > > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > > from the usual place:
> > ... 
> > > as usual, bugreports, fixes and suggestions are welcome,
> > 
> > Speaking of which...
> > 
> > This patch moves put_task_struct() reaping into a thread instead of an 
> > RCU callback function [...]
> 
> had some time to think about it since yesterday: RCU reaping is done in 
> softirqs (check out the softirq-rcu threads on your -rt box), that's why 
> i removed the delayed-task-drop code to begin with. Now i dont doubt 

It's correct from the standpoint of it being reaped in another thread,
so it fixed those crashes. But I pushed it down into another thread at the
request of Esben and his private discussion with Paul McKenney, since
a summary from Esben felt that call_rcu() was somehow less than ideal to
do that.

> that you saw crashes under 2.6.17 - but did you manage to figure out 
> what the reason is for those crashes, and do those reasons really 
> necessiate the pushing of task-reapdown into yet another set of kernel 
> threads?

Unfortunately no. I even used Robert's .config on my machine. I added a
disk controller and networking device driver just to boot into his
configuration and I still couldn't replicated any of his kjournald problems
at all. If I had his hardware I'd have a better way of replicating those
problems and pound it out.

bill

