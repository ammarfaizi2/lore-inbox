Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSB0BkL>; Tue, 26 Feb 2002 20:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291308AbSB0BkC>; Tue, 26 Feb 2002 20:40:02 -0500
Received: from [202.135.142.194] ([202.135.142.194]:50962 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291291AbSB0Bjv>; Tue, 26 Feb 2002 20:39:51 -0500
Date: Fri, 1 Jan 1904 00:19:53 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@engr.sgi.com>
Cc: dipankar@in.ibm.com, k-suganuma@mvj.biglobe.ne.jp, focht@ess.nec.de,
        rml@tech9.net, linux-kernel@vger.kernel.org, mingo@elte.hu,
        colpatch@us.ibm.com, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Message-Id: <19040101001954.51000b1d.rusty@rustcorp.com.au>
In-Reply-To: <Pine.SGI.4.21.0202251948150.592622-100000@sam.engr.sgi.com>
In-Reply-To: <20020225175853.B15397@in.ibm.com>
	<Pine.SGI.4.21.0202251948150.592622-100000@sam.engr.sgi.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 19:59:49 -0800
Paul Jackson <pj@engr.sgi.com> wrote:

> On Mon, 25 Feb 2002, Dipankar Sarma wrote:
> >
> > If these are processes that are bound to the CPU to be shut down,
> > wouldn't it make sense to fail the CPU shut down operation ? If you
> > are giving enough control to the user to make CPU affinity decisions,
> > they better know how to cleanup before shutting down a CPU.
> 
> I can imagine some users (applications) wanting to insist on
> staying on a particular CPU (Pike's Peak or Bust), and some
> content to be migrated automatically, and some wanting to
> receive and act on requests to migrate.
> 
> One of these policies might be default, with others as options.
> 
> Some CPU shut down operations _can't_ fail ... if they are motivated
> say by hardware about to fail.

Exactly.  If I run the RC5 challenge, one per cpu (using a mythical
oncpu(1) program, say), I'd be very upset if my whole machine dies because
it don't take down a faulty CPU!

I think SIGPWR is appropriate here.  If that doesn't work, then SIGKILL.
Of course, ksoftirqd is a special case, etc.

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
