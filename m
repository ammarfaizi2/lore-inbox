Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRHDICg>; Sat, 4 Aug 2001 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269831AbRHDIC1>; Sat, 4 Aug 2001 04:02:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33606 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269829AbRHDICP>; Sat, 4 Aug 2001 04:02:15 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>
	<Pine.LNX.4.33.0108030051070.1703-100000@fogarty.jakma.org>
	<20010803021642.B9845@emma1.emma.line.org>
	<m1puady69t.fsf@frodo.biederman.org>
	<20010803103954.A11584@emma1.emma.line.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2001 01:55:50 -0600
In-Reply-To: <20010803103954.A11584@emma1.emma.line.org>
Message-ID: <m1puacw96h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> On Fri, 03 Aug 2001, Eric W. Biederman wrote:
> 
> > Actually given that this thread keeps coming up, but no one does anything
> > about it.  I'm tempted to suggest we remove chatrr +S support from ext2.
> > Then there will be enough pain that someone will fix the MTA instead of
> > moaning that kernel is slow...
> 
> They'd just drop Linux from the list of supported OS's, Linux will
> disappoint people who trusted it, nothing is gained. Deliberate breakage
> will not happen, because it would not help anyone except people with
> twisted minds.

There are some other uses for a fully synchronous disk accesses so I'm
not going to run out and do it.  The point is that work arounds for
strange programs is not a right, it is a nice optional feature.
 
> NO-ONE, including you, has come up with SERIOUS objections against a
> dirsync option, except "is it really so much slower than chattr +S? show
> figures" -- ext3 is being tuned to be fast in spite of chattr +S.

Clear objects against dirsync.  
- Extra code maintenance, makes the fs less reliable 
  (A reason for removing even synchrouns fs operations BTW).
- Unnecessary. fsync(dir) works today.
- dirsync is unlikely to be faster than fsync(file); fsync(dir) [not chattr +S]
  You really need something that can say remember these 5 syscalls,
  and sync the all their changes to disk togeter to really get an
  improvement in sync speed.
- I don't see anyone volunteering to write the code.

> Reconsider your position.

Nope.  Right now I would rather
a) Patch the mail programs to do the needed fsync(dir)
b) Totally remove synchrous disk updates from my OS, and
   make life really painful.
Before adding a dirsync option.

> Stop trolling please.

It wasn't trying to troll, just get this conversation on some productive
grounds.  I think supporting the MTA's is good, so long as it is a two
way relationship.

If someone went out and tried using fsync(dir) and then saying it
sucked we could definentily have more peace.

Using dirsync, and chattr +S hide the real problems that need to get
fixed.  Getting a good reliable, and high performance way to commit
actions to a filesystem.  

We already have one work around on linux that will work reliably.  So
now let's see if we can get a functional high performance solution.

And oh btw, new, functional high performance solutions are not
portable because they haven't been implemented in every operating
system.  Full understanding of the problem, and the solutions are two
new for the implementations to have gotten around.

Eric



