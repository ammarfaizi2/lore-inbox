Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSFTPEv>; Thu, 20 Jun 2002 11:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSFTPEu>; Thu, 20 Jun 2002 11:04:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8301 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314787AbSFTPEt>; Thu, 20 Jun 2002 11:04:49 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
	<m1d6umtxe8.fsf@frodo.biederman.org>
	<20020619222444.A26194@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jun 2002 08:54:42 -0600
In-Reply-To: <20020619222444.A26194@work.bitmover.com>
Message-ID: <m14rfyt2z1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> > I totally agree, mostly I was playing devils advocate.  The model
> > actually in my head is when you have multiple kernels but they talk
> > well enough that the applications have to care in areas where it
> > doesn't make a performance difference (There's got to be one of those).
> 
> ....
> 
> > The compute cluster problem is an interesting one.  The big items
> > I see on the todo list are:
> > 
> > - Scalable fast distributed file system (Lustre looks like a
> >    possibility)
> > - Sub application level checkpointing.
> > 
> > Services like a schedulers, already exist.  
> > 
> > Basically the job of a cluster scheduler gets much easier, and the
> > scheduler more powerful once it gets the ability to suspend jobs.
> > Checkpointing buys three things.  The ability to preempt jobs, the
> > ability to migrate processes, and the ability to recover from failed
> > nodes, (assuming the failed hardware didn't corrupt your jobs
> > checkpoint).
> > 
> > Once solutions to the cluster problems become well understood I
> > wouldn't be surprised if some of the supporting services started to
> > live in the kernel like nfsd.  Parts of the distributed filesystem
> > certainly will.
> 
> http://www.bitmover.com/cc-pitch
> 
> I've been trying to get Linus to listen to this for years and he keeps
> on flogging the tired SMP horse instead. 

Hmm.  My impression is that Linux has been doing SMP but mostly because
it hasn't become a nightmare so far.  Linus just a moment ago noted that
there are scaleablity limits, to SMP.

As for the cc-SMP stuff.
a) Except dual cpu systems no-one makes affordable SMPs.
b) It doesn't solve anything except your problem with locks.

You have presented your idea, and maybe it will be useful.  But at
the moment it is not the place to start. What I need today is process
checkpointing.  The rest comes in easy incremental steps from there.

For me the natural place to start is with clusters, they are cheaper
and more accessible than SMPs.  And then work on the clustering
software with gradual refinements until it can be managed as one
machine.  At that point it should be easy to compare which does a
better job for SMPs.

Eric
