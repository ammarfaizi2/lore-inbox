Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCOSju>; Fri, 15 Mar 2002 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293088AbSCOSjc>; Fri, 15 Mar 2002 13:39:32 -0500
Received: from bitmover.com ([192.132.92.2]:11985 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293075AbSCOSjQ>;
	Fri, 15 Mar 2002 13:39:16 -0500
Date: Fri, 15 Mar 2002 10:39:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020315103914.M29887@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C90E994.2030702@candelatech.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com> <20020315080408.D11940@work.bitmover.com> <a6tcnf$shg$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a6tcnf$shg$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 15, 2002 at 05:58:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 05:58:07PM +0000, Linus Torvalds wrote:
> In article <20020315080408.D11940@work.bitmover.com>,
> Larry McVoy  <lm@bitmover.com> wrote:
> >
> >Has anyone done this and made it work?  It would save a lot of disk space
> >and performance if someone were to so.
> 
> Hey, the _sane_ way to do it is to not have all those crappy SCCS
> dependencies in all the tools, but to simply make a bk work area be a
> real file tree!

That is *a* sane way to do it and I'm fine with that.  But just because
you like things to work that way does not mean we will disallow the
other way.  I *like* the way SCCS works, I can do a "make clobber",
which nukes all my .o's and does a "bk clean" and do a "ls" to see what
crud I have left.  I personally like going to a tree that has nothing
but subdirectories in it, typing making, and having it do the right thing.

Neither I nor anyone else will force this mode of working on you.  Not now,
not ever.  You, in turn, get to respect that some people like this mode and
accept that it is going to remain one of the ways you can use BK forever.

> Larry, your argument that there are tools that are SCCS-aware is just
> not sane. 

I want to be really really clear on this.  I'm not saying that because some
tools know this, that's how it should be.  I'm saying that I, and at least
some other people, find that mode of operation useful.  It's not going away.

That said, watch the changes that we are making and you'll see that we
keep enhancing / bugfixing the ability to run your tree in checkout:get
or checkout:edit mode, one of our customers has made some changes which
seem to actually respect timestamps in an error free way so that you
can run checkout:edit and not suffer the performance problems and also
not lose data because of NFS/SMB timestamp issues.  All that stuff is
actively being hacked on right now.

In addition, our bug database is going to *force* us to offer what you
want as an option.  LINUS, READ THIS PART.  The bug database uses a
file as a container for each bug.  That means that a query is as slow
as an integrity check, and that obviously doesn't scale.  While we can,
and will, add indices to the bug database to address this, we are also
addressing it by making a version of the software that stores the s.files
in what amounts to an "ar" archive, so you can mmap that once and be
done with it (as with everything, this is a simplification, there are
actually multiple ar archives which are searched in most recent to least
recent order so you don't rewrite the whole 170MB repository to make a
one line fix).

All this means is that the decision to make the bug database a BK
repository is exactly the right one from your point of view, Linus.
It means we have to have a mode where there are no s.files, no SCCS
directories, and it all still works.  And since we're reasonable 
people, we'll all you to decide on a repository by repository basis
what mode you want, so I can have my precious SCCS directories and
make behaviour, and you can get rid of your awful SCCS directories
and insane make behaviour.

> Right now simple things like command-line completion and
> 
> 	find . -name '*.[chS]' | xargs grep xxxx
> 
> do not work, because they either don't find files or they find the wrong
> ones (the internal bitkeeper files etc). 

Try

	bk -r grep xxxx

One gotcha, and we'll fix this now that I think of it, is that this only
greps the revision history.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
