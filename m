Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292840AbSCOQFL>; Fri, 15 Mar 2002 11:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292842AbSCOQFC>; Fri, 15 Mar 2002 11:05:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292840AbSCOQEo>;
	Fri, 15 Mar 2002 11:04:44 -0500
Date: Fri, 15 Mar 2002 16:04:44 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Joel Becker <jlbec@evilplan.org>, Rusty Russell <rusty@rustcorp.com.au>,
        matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Re: futex and timeouts
Message-ID: <20020315160444.P4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, matthew@hairy.beasts.org,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <E16lkRS-0001HN-00@wagner.rustcorp.com.au> <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk> <20020315151507.2370C3FE0C@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020315151507.2370C3FE0C@smtp.linux.ibm.com>; from frankeh@watson.ibm.com on Fri, Mar 15, 2002 at 10:16:02AM -0500
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 10:16:02AM -0500, Hubertus Franke wrote:
> > 	Why waste a syscall?  The user is going to be using a library
> > wrapper.  They don't have to know that futex_up() calls sys_futex(futex,
> > FUTEX_UP, NULL);
> 
> I agree with that, only for the reason that we are getting scarce on 
> syscall nubmers. Is 256-delta the max ?

	This was my impression, and why I called it "wasting" a syscall.
On architectures where syscall numbers or handles are unlimited, of
course there is no reason to keep it to one syscall.

> One thing to consider is that many don't want to use libraries.
> They want to inline, which would result only in a few instruction.

	Inlined you only take the penalty from the argument pushes.  You
still have to go through the motions of checking whether you can
get/release the lock in userspace.

> What I would like to see is an interface that lets me pass optional 
> parameters to the syscall interface, so I can call with different number
> of parameters.

	Is this to lock multiple futexes "atomically"?  If we are
looking for a fast path stack-wise, this seems extra work.

Joel

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

			http://www.jlbec.org/
			jlbec@evilplan.org
