Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWEKGgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWEKGgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWEKGgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:36:42 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24034 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965154AbWEKGgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:36:42 -0400
Date: Thu, 11 May 2006 02:36:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Al Viro <viro@ftp.linux.org.uk>
cc: Daniel Walker <dwalker@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <20060510212058.GE27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0605110223540.925@gandalf.stny.rr.com>
References: <1147257266.17886.3.camel@localhost.localdomain>
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de>
 <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com>
 <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com>
 <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <20060510212058.GE27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Al Viro wrote:

> On Wed, May 10, 2006 at 02:11:54PM -0700, Daniel Walker wrote:
> > > I really don't see why it couldn't be added.  What's the problem with it?
> > >
> > > I mean, I see lots of advantages, and really no disadvantages.
>
> Your vision is quite selective, then.

And maybe so is yours.

>
> > We are in complete agreement .. The only disadvantage is maybe we cover
> > up and real error

I disagree here that it covers up any bug. See below.

>
> ... which is more than enough to veto it.  However, that is not all.
> Consider the following scenario:
>
> 1) gcc gives false positive
> 2) tosser on a rampage "fixes" it
> 3) code is chaged a month later
> 4) a real bug is introduced - one that would be _really_ visible to gcc,
> with "is used" in a warning
> 5) thanks to aforementioned tosser, that bug remains hidden.

What's the difference in seeing a warning in a compile, and noticing that
there's a wrapper around a variable?  In fact, that wrapper is more
of a flag that something might be broken than a warning that everyone is
use to seeing.  In step 3, the code that is changed, should either remove
the wrapper on the variable, or recompile with the wrapper defaulted to
warn.  The bug is never hidden due to the fact that you can keep the
warnings on.

So if you like to look for real warnings, you can compile it with the
false positives turned off, and if you don't trust the hidden warnings,
use a compile where the false positives stay on.  So it's now a choice to
which you perfer.  Not everyone likes to see a bunch of false positives,
and have to fight to find the real bugs.

As stated before, gcc (and any other program) is not perfect, and can't be
right all the time.  So it takes the side of aggressive warnings. But with
the help of the programmer, it only needs to warn on actual bugs.

This solution does _not_ hide the bug in step 5.  It only surpresses it to
those who don't care.

>
> And that's besides making code uglier for no good reason, etc.

The ugliness of the code, only helps to point out that there might be a
problem.  So instead of constantly weeding through warnings in search of
real bugs, you can look through the code once in a while to see if
something was missed.

>
> Consider that preemptively NAKed.
>

Preemptive strikes are usually never a good thing.

-- Steve

