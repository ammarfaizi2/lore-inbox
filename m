Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSBRS2y>; Mon, 18 Feb 2002 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSBRSYQ>; Mon, 18 Feb 2002 13:24:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63311 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290962AbSBRSOy>; Mon, 18 Feb 2002 13:14:54 -0500
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: Larry McVoy <lm@work.bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org>
	<20020207165035.GA28384@ravel.coda.cs.cmu.edu>
	<200202072306.PAA08272@morrowfield.home>
	<20020207132558.D27932@work.bitmover.com>
	<20020211002057.A17539@helen.CS.Berkeley.EDU>
	<20020211070009.S28640@work.bitmover.com>
	<20020212030159.03649@helen.CS.Berkeley.EDU>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 11:10:23 -0700
In-Reply-To: <20020212030159.03649@helen.CS.Berkeley.EDU>
Message-ID: <m1n0y64q5s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh MacDonald <jmacd@CS.Berkeley.EDU> writes:

> Quoting Larry McVoy (lm@bitmover.com):
> > 
> > I'm sure it does, you are promoting xdelta, so anything else must be bad.
> > I am a bit curious, do you even know what a weave is?  Can you explain 
> > how one works?  Surely, after all that flaming, you do know how they 
> > work, right?
> 
> Of course.  But disk transfer cost is the same whether you're in RCS
> or SCCS, and rename is still a very expensive way to update your files.

Hmm.  Up to a certain point something like 256K disk I/O for an entire
file can be done with single seek.  So that is constant time.  Not in
all cases but in the normal case for source code files it is.  And beyond
that you get an extra seek for the inode and the directory.  The only
part that rename removes is touching the directory.  And given that
there is no requirement that rename be synchronous I don't see rename
waiting for the directory change to complete.  I can see problems
currently with large directories, but those problems are orthogonal to
the issue of just rename being slow.

So for source code sized files why is rename expensive?

I guess I can see some merit if you are processing thousands of
operations a second where the sheer volume of data makes things
expensive but I don't see that being the common case.

Eric

