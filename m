Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265807AbRFXXr6>; Sun, 24 Jun 2001 19:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbRFXXrs>; Sun, 24 Jun 2001 19:47:48 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:14892
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S265802AbRFXXrb>; Sun, 24 Jun 2001 19:47:31 -0400
Date: Sun, 24 Jun 2001 16:47:29 -0700
From: Larry McVoy <lm@bitmover.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Stephen Satchell <satch@fluent-access.com>, Martin Devera <devik@cdi.cz>,
        bert hubert <ahu@ds9a.nl>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Threads are processes that share more
Message-ID: <20010624164729.G8832@work.bitmover.com>
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	Stephen Satchell <satch@fluent-access.com>,
	Martin Devera <devik@cdi.cz>, bert hubert <ahu@ds9a.nl>,
	"linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010620175937.A8159@home.ds9a.nl> <Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz> <4.3.2.7.2.20010620150729.00b60710@mail.fluent-access.com> <20010621011031.B19922@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010621011031.B19922@werewolf.able.es>; from jamagallon@able.es on Thu, Jun 21, 2001 at 01:10:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 01:10:31AM +0200, J . A . Magallon wrote:
> 
> On 20010621 Stephen Satchell wrote:
> >
> >By the way, I'm surprised no one has mentioned that a synonym for "thread" 
> >is "lightweight process".
> >
> 
> In linux. Perhaps this the fault.
> In IRIX, you have sprocs and threads. sprocs have independent pids and you
> can control what you share (mappings, fd table...). Threads group under
> same pid.

I think that's accurate.

> Linux chose the sproc way...

That's not accurate.  The Linux way is an infinitely nicer architecture.
For each thing that is shareable you have code like

	vm_fork(... flags)
	{
		if (flags & VM_SHARE) return;
		do the work to fork the data structure
	}

In other words, it's designed to be shared.  The IRIX stuff is disgusting,
you really don't want anything to do with sproc().    It _sounds_ like they
are the same but they aren't - for example, with sproc you get your very
own TLB miss handler.  Doesn't that sound special?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
