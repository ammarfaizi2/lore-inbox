Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSGCQrk>; Wed, 3 Jul 2002 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSGCQrk>; Wed, 3 Jul 2002 12:47:40 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:49117 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317180AbSGCQri>; Wed, 3 Jul 2002 12:47:38 -0400
Date: Wed, 3 Jul 2002 05:45:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace vs /proc
Message-ID: <20020703034517.GH474@elf.ucw.cz>
References: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu> <1024609747.922.0.camel@sinai> <20020702004706.GB107@elf.ucw.cz> <aft582$mq0$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aft582$mq0$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I believe such proc interface is wrong thing to do. ptrace() is really
> >very *very* special thing, and you don't want it hidden in some kind
> >of /proc magic.
> 
> Five years ago I believed all that mattered was the functionality:
> whether it was exposed via ptrace() and signals or via /proc and ioctls
> was irrelevant.  Since then, having spent a lot of time using both Linux
> ptrace() and Solaris /proc, I've learned that there is a huge difference
> between the two.  The Solaris implementation, via /proc, is very clean.
> The Linux implementation, via ptrace(), is icky.
> 
> For example, ptrace() uses signals as part of its interface; this
> is a gross kludgy hack, and it breaks various things.  For instance,
> overloading the meaning of signals causes wait4() to break in the traced
> process, and you have to do all sorts of workarounds in the tracer
> to make tracing transparent.  Go read the source code to strace(1).
> I think if you spend the time to understand it all, you'll agree with
> me that it is sadly hairy stuff.
> 
> The Solaris /proc implementation, in contrast, was much cleaner,
> in my experience.  I suspect this is partially because the Solaris
> implementation was more carefully thought-through, but also the interface
> helped: by not overloading the meaning of signals, the Solaris /proc
> interface avoids changing the semantics of signal-related functionality
> in the traced process, and this makes for cleaner code.
> 
> Solaris /proc also had other nice features, like the ability to follow
> fork() automatically and so on.  (Check out what strace has to do with
> ptrace(): it actually does binary code-rewriting of the traced process
> on the fly to work around lack of functionality in ptrace().)  Many of
> these features, of course, were orthogonal to whether the process tracing
> was implemented via ptrace() and signals or /proc and ioctls.

Agreed signals should not be overloaded.

I helped with subterfugue (.sf.net), so I know about this
issues. Using signals is ugly. I'm not sure what to do with following
fork; I do not think we want to bloat kernel with that (and I believe
we have helper [CLONE_? flag?] that allows us to do that too). I still
think ptrace() should have its own syscall. Its very special thing.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
