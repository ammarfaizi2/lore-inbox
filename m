Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292832AbSCPTCH>; Sat, 16 Mar 2002 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310393AbSCPTBr>; Sat, 16 Mar 2002 14:01:47 -0500
Received: from bitmover.com ([192.132.92.2]:46212 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292832AbSCPTBp>;
	Sat, 16 Mar 2002 14:01:45 -0500
Date: Sat, 16 Mar 2002 11:01:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020316110144.H10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <20020316093832.F10086@work.bitmover.com> <3C938966.3080302@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C938966.3080302@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 16, 2002 at 01:05:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 01:05:26PM -0500, Jeff Garzik wrote:
> Larry McVoy wrote:
> 
> >>I think a fair question would be, is this scenario going to occur often? 
> >> I don't know.  But I'll bet you -will- see it come up again in kernel 
> >>development.  Why?  We are exercising the distributed nature of the 
> >>BitKeeper system.  The system currently punishes Joe in Alaska and 
> >>Mikhail in Russia if they independently apply the same GNU patch, and 
> >>then later on wind up attempting to converge trees.
> >>
> >
> >Indeed.  So speak in file systems, because a BK package is basically a file
> >system, with multiple distributed instances, all of which may be out of
> >sync.  The problems show up when the same patch is applied N times and 
> >then comes together.  The inodes collide.  Right now, you think that's
> >the problem, and want BK to fix it.  We can fix that.  But that's not 
> >the real problem.  The real problem is N sets of diffs being applied
> >and then merged.  The revision history ends up with the data inserted N
> >times.
> >
> 
> Another thought, that I'm betting you laugh at me for even suggesting :)
> 
> Don't insert the data N times.  Give the user the option to say that one 
> or more changesets are actually the same one.  In filesystem speak, 
> unlink a file B which is a user-confirmed duplicate of file A, and 
> re-create file B as a symlink to file A.  Or just unlink file B without 
> the symlink, whichever metaphor suits you better.  :)
> 
> Yes it is "altering history"... but... OTOH the user has just told 
> BitKeeper, in no uncertain terms, that he is altering history only to 
> make it more correct.

You need to put on the distributed-think hat.  The problem is never
what I do in any one instance, we can do all sorts of useful things
in that instance.  The problem is doing them in such a way so that
synchronization with repositories which are both ahead and behind works.
So if you repull from whereever you just pulled from, the system needs
to remember that some cset is a duplicate and has been eliminated.
And if you pull in the opposite direction, the past events, including
duplicate removal, propagate.

*All* of this stuff is trivial if you don't care about passing it on, if
your repository is a backwater dead end.  But that's not the case.
So you have to decide that you want the events to propagate and if you
do, then we can do something about it.

I'm starting to get psyched about this, I think I see a picture that 
works, I need to chew on it for a bit though.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
