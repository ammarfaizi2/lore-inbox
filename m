Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVDPBP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVDPBP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVDPBP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:15:29 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:12210 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262504AbVDPBPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:15:19 -0400
Subject: Re: FUSYN and RT
From: Steven Rostedt <rostedt@goodmis.org>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <16992.20513.551920.826472@sodium.jf.intel.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
	 <1113407200.4294.25.camel@localhost.localdomain>
	 <20050415225137.GA23222@nietzsche.lynx.com>
	 <16992.20513.551920.826472@sodium.jf.intel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 15 Apr 2005 21:14:22 -0400
Message-Id: <1113614062.4294.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 16:37 -0700, Inaky Perez-Gonzalez wrote:
> >>>>> Bill Huey (hui) <bhuey@lnxw.com> writes:
> 
> > Ok, I've been thinking about these issues and I believe there are a
> > number of misunderstandings here. The user and kernel space mutexes
> > need to be completely different implementations. I'll have more on
> > this later.
> 
> > First of all, priority transitivity should be discontinuous at the
> > user/kernel space boundary, but be propagated by the scheduler, via
> > an API or hook, upon a general priority boost to the thread in
> > question.
> 
> This is not necessarily true. My temperature-regulating thread should
> be able to promote a task so it works around priority invertion, no
> matter if they are sharing a kernel or user space lock. 
> 
> By following your method, the pi engine becomes unnecesarily complex;
> you have actually two engines following two different propagation
> chains (one kernel, one user). If your mutexes/locks/whatever are the
> same with a different cover, then you can simplify the whole
> implementation by leaps.
> 

I have to agree with Inaky too.  Fundamentally, PI is the same for the
system regardless of if the locks are user or kernel. I still don't see
the difference here.  But for other reasons, I feel that the user lock
should be a different structure from the kernel lock. That's why I
mentioned that it would be a good idea if Ingo modulized the PI portion.
So that part would be the same for both. If he doesn't have the time to
do it, I'll do it :-)  (Ingo, all you need to do is ask.)

[...]

> > There will be problems trying to implement a Posix read/write lock
> 
> As long as the concept of rwlock allows for it to have multiple owners
> (read locks need to have them), the procedure is mostly the
> same. However, this not being POSIX, nobody (yet) has asked for it.
> 

I don't think rwlocks work well with PI.  You can implement it, but it's
like implementing multiple inheritance for Object Oriented languages.
Java didn't implement it because they say keeping it out makes the code
cleaner (probably true), but the real reason I bet, was that
implementing it makes everything much more complex.  The same goes with
rwlocks with multiple readers and PI. Without it makes for a cleaner
solution (for users as well as developers), and with it, it just makes
everything more complex.

-- Steve


