Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSIOTBM>; Sun, 15 Sep 2002 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSIOTBM>; Sun, 15 Sep 2002 15:01:12 -0400
Received: from crack.them.org ([65.125.64.184]:9486 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318190AbSIOTBI>;
	Sun, 15 Sep 2002 15:01:08 -0400
Date: Sun, 15 Sep 2002 15:04:35 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915190435.GA19821@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Brownell <david-b@pacbell.net>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <E17qRfU-0001qz-00@starship> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 11:06:09AM -0700, Linus Torvalds wrote:
> 
> On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > 
> > Let's try a different show of hands: How many users would be happier if
> > they knew that kernel developers are using modern techniques to improve
> > the quality of the kernel?
> 
> You're all talk and no action.
> 
> The last time I looked, the people who really _do_ improve the quality of
> the kernel don't tend to care too much about debuggers, or are at least
> capable to add a patch on their own.
> 
> In fact, of the people who opened their mouth about the BUG() issue, how 
> many actually ended up personally _debugging_ the BUG() that we were 
> talking about?
> 
> I did. Matt probably did. But I didn't see you fixing it with your
> debugger.
> 
> So next time you bring up the kernel debugger issue, show some code and 
> real improvement first. Until then, don't spout off.

[I haven't read the beginning of this thread.  I don't know which
debugger you're talking about, although I suspect from context it's
KDB.  I'm just going to pretend it's KGDB because that's the one that I
consider most useful.]

Let me offer a different perspective, with example.  Perhaps you
remember the paste-o fix I sent you last week.  A patch had changed:

  list_entry(current->ptrace_children.next,struct task_struct,ptrace_list)
to:
  list_entry(current->ptrace_children.next,struct task_struct,sibling)

I usually develop on 2.4.  More, I usually develop on a tree that
already has i386 kgdb merged, or on non-i386 architecture which has a
kgdb stub as standard - MIPS or PowerPC.  I find it a great deal more
convenient, for a whole lot of reasons.  For instance:

Tracking this bug down took me about six hours.  Someone more familiar
with that particular segment of code could, I assume, have done it more
quickly.  One advantage of a debugger is that it's easier to look at
parts of the code you aren't intimately familiar with, and still find
the problem.  With access to a debugger, my process would have gone
something like this:
  - establish that exit_notify was crashing the first time that an
initial thread exited (half an hour.  because my i386 test machine
reboots very slowly.)
  - step through it (five minutes)
  - see it step into zap_thread, the incorrect line right there on my
screen, the corrupted argument immediately obvious

As it was, there is no 2.5 / i386 port of KGDB as far as I know;
George's patches are only for 2.4.  Porting KGDB to 2.5 would have
taken me more than the hours I wasted with printks and oops traces.

Plus, in my experience the work model that BitKeeper encourages puts a
significant penalty on including unrelated patches in the tree while
you're debugging.  It can be gotten around but it's exceptionally
awkward.  Adding in KGDB means time spent merging it into my tree and
time spend merging it cleanly out when I'm done with it.

I even have ulterior motives in suggesting that KGDB be included - with
a proper and complete KGDB in the kernel, the features that make KGDB
more than just the minimal stubs that other platforms have could move
to common code.  MIPS, for instance, could have a thread-aware KGDB,
for instance.

I've always thought it would be useful.  Sure, everyone debugs
differently; but a number of people seem to agree with me that KGDB is
convenient.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
