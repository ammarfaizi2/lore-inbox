Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLGIdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLGIdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVLGIdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 03:33:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41105 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750703AbVLGIdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 03:33:55 -0500
Date: Wed, 7 Dec 2005 09:33:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [RT] Race condition on bug output.
Message-ID: <20051207083355.GA22190@elte.hu>
References: <1133926493.6724.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133926493.6724.109.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I found a race condition in my kernel which can also be found in 
> yours. When I trigger the printk in check_periodic_interval, 
> interrupts are turned on in release_console_sem.  Unfortunately, this 
> can have an interrupt go off there (since they are turned back on 
> there) and the write_lock system_time_lock will be taken again, thus 
> producing a deadlock.
> 
> I'm not sure if this is the best solution, but this was the easiest.
> 
> Maybe the CONFIG_PARANOID_GENERIC_TIME should be added in the warnings 
> in init/main.c too?
> 
> Since interrupts are kept off in the ktimer (hrtimer, whatever) in 
> printk, this does not affect those patches.  This is a PREEMPT_RT only 
> problem.

thanks, applied.

	Ingo
