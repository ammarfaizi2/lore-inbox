Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVDPBjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVDPBjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVDPBjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:39:47 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29856 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262552AbVDPBjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:39:44 -0400
Subject: Re: FUSYN and RT
From: Steven Rostedt <rostedt@goodmis.org>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <16992.26700.512551.833614@sodium.jf.intel.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
	 <1113407200.4294.25.camel@localhost.localdomain>
	 <20050415225137.GA23222@nietzsche.lynx.com>
	 <16992.20513.551920.826472@sodium.jf.intel.com>
	 <1113614062.4294.102.camel@localhost.localdomain>
	 <16992.26700.512551.833614@sodium.jf.intel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 15 Apr 2005 21:38:30 -0400
Message-Id: <1113615510.4294.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 18:20 -0700, Inaky Perez-Gonzalez wrote:
> >>>>> Steven Rostedt <rostedt@goodmis.org> writes:
> >> On Fri, 2005-04-15 at 16:37 -0700, Inaky Perez-Gonzalez wrote:
> 
> > I have to agree with Inaky too.  Fundamentally, PI is the same for
> > the system regardless of if the locks are user or kernel. I still
> > don't see the difference here.  But for other reasons, I feel that
> > the user lock should be a different structure from the kernel
> > lock. That's why I mentioned that it would be a good idea if Ingo
> > modulized the PI portion.  So that part would be the same for
> > both. If he doesn't have the time to do it, I'll do it :-) (Ingo,
> > all you need to do is ask.)
> 
> Can you qualify "different" here? I don't mean that they need to be
> interchangeable, but that they are esentially the same. Obviously the
> user cannot acces the kernel locks, but kernel locks are *used* to
> implement user space locks.
> 
> Back to my example before: in fusyn, a user space lock is a kernel
> space lock with a wrapper, that provides all that is necessary for
> doing the fast path and handling user-space specific issues.

I was actually thinking of just giving more flexibility to the user
locks, in case the application using them needed more information, for
debugging or whatever.  Honestly, I haven't looked at the fusyn code
yet, so I don't really know if there is a difference.  As I said, I
"feel" the user lock should be different. I really don't know if they
should.

So, to answer your question. Looking forward, I kind of see two
different structures for locking.  The rt_mutex and something that is
used by fusyn, then there being some common structure (or ops) that they
both use to implement the PI.  But the implementation of how the locks
work may as well be different. But this may not be the case, and there
still be two structures but the fusyn just contain a rt_mutex lock to do
the actual locking and the rest of the structure be used for showing
information or what not back up to user space. This stuff wouldn't be
necessary for the rt_mutex. We need to keep rt_mutex small since it is
used all over the place.

That's all I meant.


-- Steve


