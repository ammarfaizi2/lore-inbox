Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbSKJLn0>; Sun, 10 Nov 2002 06:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKJLmi>; Sun, 10 Nov 2002 06:42:38 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4868 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264816AbSKJLmA>;
	Sun, 10 Nov 2002 06:42:00 -0500
Date: Sat, 9 Nov 2002 22:21:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Werner Almesberger <wa@almesberger.net>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021109212103.GA239@elf.ucw.cz>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105150048.H1408@almesberger.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, we are putting [MCORE] in as one of the alternative dump targets
> > available.
> 
> Great !
> 
> > Its not quite ready yet and we need something like kexec to be
> > available which we can use on Intel systems to achieve the softboot
> > (the acceptance status of that still doesn't seem to be clear),
> 
> Yes, I've just checked with Eric, and he hasn't received any
> indication from Linus so far. I posted a reminder to linux-kernel.
> I'd really hate to see kexec miss 2.6.
> 
> > Why do we even consider the other options when we are doing 
> > this already ? Well, as we discussed earlier there's non-disruptive
> > dumps for one, where this wouldn't work.
> 
> But they're very different anyway, aren't they ? I mean, you could
> even implement them (well, almost) from user space, with today's
> kernels.
> 
> > The other is that before overwriting 
> > memory we need to be able to stop all activity in the system for certain
> > (system may appear hung/locked up) and I'm not fully certain about
> > how to do this for all environments. Maybe an answer lies in 
> > rethinking some parts of the algorithm a bit.
> 
> This is certainly the hairiest part, yes. I think we have about
> four types of devices/elements to worry about:
> 
>  - those that just sit there, and never talk unless spoken to
>  - those that may generate interrupts
>  - those that DMA if you ask them nicely
>  - those that DMA when they feel like it (e.g. copy an incoming
>    network packet to the next buffer in the free list)
> 
> The latter are the real problem. I see the following possibilities
> for dealing with them:
> 
>  - faith-based computing: pray that nothing bad will befall your
>    system :-)
>  - de-activate them individually. There should be a lot of work
>    that can be shared with power management. And that's one of
>    the reasons why I think the memory target should be available
>    early, or convergence will take forever.

I have very similar problem in swsusp (need to deactivate DMA
devices), and driverfs^H^H^H^H^Hsysfs framework seems to be suitable
for that.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
