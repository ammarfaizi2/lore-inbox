Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVHWMuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVHWMuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVHWMuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:50:46 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:32395 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932065AbVHWMuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:50:46 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050823123612.GA7924@elte.hu>
References: <20050818060126.GA13152@elte.hu>
	 <1124433586.5186.119.camel@localhost.localdomain>
	 <20050823123612.GA7924@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 23 Aug 2005 08:50:34 -0400
Message-Id: <1124801434.5350.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 14:36 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Ingo, can't you get rt.c to be more confusing. I mean it is too 
> > simple. We need to add a few more underscores here and there :-) 
> > Seriously, that rt.c is mind boggling. It was nice before, now it is 
> > just screaming for a cleanup (come now, do we really need the four 
> > underscores?). Same with latency.c.
> 
> i agree that it's ugly, but some of that ugliness is to achieve the 
> 7-instructions fail-through codepath for the common acquire (and 
> release) codepath:
> 
>  c03a5320 <__down_mutex>:
>  c03a5320:       89 c1                   mov    %eax,%ecx
>  c03a5322:       8b 15 08 76 3a c0       mov    0xc03a7608,%edx
>  c03a5328:       31 c0                   xor    %eax,%eax
>  c03a532a:       0f b1 51 14             cmpxchg %edx,0x14(%ecx)
>  c03a532e:       85 c0                   test   %eax,%eax
>  c03a5330:       75 01                   jne    c03a5333 <__down_mutex+0x13>
>  c03a5332:       c3                      ret
> 

Impressive!

> that's how much it takes to acquire an RT lock, and i worked hard to get 
> there. As long as the fastpath is kept this tight, feel free to do 
> cleanups. But i really want to avoid having to write mutex_down/up in 
> assembly for 24 architectures ...

Warning! I'm hacking hard to get rid of the global pi_lock, and I'm not
worrying now about efficiency.  I figure that if I can get it to work,
then we can speed it up afterwards.  Since it's complex enough keeping
all the locks straight, I just want it to work without deadlocking. 

Once I get it to work, I'll let you figure out how get it back down to
7-instructions :-)

-- Steve


