Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVE0Npt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVE0Npt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0Npt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:45:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43963 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261355AbVE0Np2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:45:28 -0400
Date: Fri, 27 May 2005 15:44:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527134410.GA16158@elte.hu>
References: <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527133122.GF86087@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> > how would you do that, if even a first step (PREEMPT_VOLUNTARY) was 
> > opposed by some as possibly hurting throughput? I'm really curious, what 
> > would you do to improve PREEMPT_NONE's latencies?
> 
> Mostly in the classical way. Add cond_resched where needed. Break up a 
> few locks. Perhaps convert a few spinlocks that block preemption to 
> long and which are not taken that often to a new kind of 
> sleep/spinlock (TBD).  Then add more reschedule point again.

been there, done that. A couple of years ago i started out with a 
somewhat similar opinion to yours, which could be summed up as: "this 
cannot be that hard, just break up the code, damnit". Wrote tools to see 
where the latencies come from, and started sticking cond_resched()s in.  
A few years down the road and after multiple restarts (lowlatency patch, 
the first preempt prototype patch, -VP patchset, etc.) i ended up with 
the -RT patch and with two new preemption models (PREEMPT_VOLUNTARY and 
PREEMPT_RT) in addition to PREEMPT_NONE and PREEMPT. (With the extra 
twist that when i started then the kernel was only 2 million lines big, 
now it's 6+ million lines of code.)

	Ingo
