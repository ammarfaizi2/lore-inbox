Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264657AbUFHFmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbUFHFmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbUFHFmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:42:05 -0400
Received: from web51803.mail.yahoo.com ([206.190.38.234]:27016 "HELO
	web51803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264657AbUFHFmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:42:00 -0400
Message-ID: <20040608054200.66080.qmail@web51803.mail.yahoo.com>
Date: Mon, 7 Jun 2004 22:42:00 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
To: Andrew Morton <akpm@osdl.org>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       wli@holomorphy.com
In-Reply-To: <20040607195011.34f8e84e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The test case is a build system that links headers (ln
-s) and runs bison and flex on a couple of files. 
strace shows no difference between running on 2.4.23
compared to running on 2.6.7-rc2bk8s63.

Unfortuneately, I can not send this out, but I am
trying to get a tet case that will demostrate this.

In the mean time, what can I do to try understand this
slowdown?

Thank you for your time.
Phy

--- Andrew Morton <akpm@osdl.org> wrote:
> Phy Prabab <phyprabab@yahoo.com> wrote:
> >
> > Also please note the degredation between
> >  2.6.7-rc2-bk8-s63:
> > 
> >  A:  35.57user 38.18system 1:20.28elapsed 91%CPU
> >  B:  35.54user 38.40system 1:19.48elapsed 93%CPU
> >  C:  35.48user 38.28system 1:20.94elapsed 91%CPU
> > 
> >  Interesting how much more time is spent in both
> user
> >  and kernel space between the two kernels.  Also
> note
> >  that 2.4.x exhibits even greater delta:
> > 
> >  A:  28.32user 29.51system 1:01.17elapsed 93%CPU
> >  B:  28.54user 29.40system 1:01.48elapsed 92%CPU
> >  B:  28.23user 28.80system 1:00.21elapsed 94%CPU
> > 
> >  Could anyone suggest a way to understand why the
> >  difference between the 2.6 kernels and the 2.4
> >  kernels?
> 
> This is very very bad.
> 
> It's a uniprocessor machine, yes?
> 
> Could you describe the workload a bit more?  Is it
> something which others
> can get their hands on?
> 
> It spends a lot of time in the kernel for a build
> system.  I wonder why.
> 
> At a guess I'd say either a) you're hitting some
> path in the kernel which
> is going for a giant and bogus romp through memory,
> trashing CPU caches or
> b) your workload really dislikes
> run-child-first-after-fork or c) the page
> allocator is serving up pages which your access
> pattern dislikes or d)
> something else.
> 
> It's certainly interesting.


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
