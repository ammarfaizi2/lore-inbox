Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCOS7M>; Fri, 15 Mar 2002 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSCOS7B>; Fri, 15 Mar 2002 13:59:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2029 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293131AbSCOS6x>;
	Fri, 15 Mar 2002 13:58:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] Re: futex and timeouts
Date: Fri, 15 Mar 2002 13:59:38 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Joel Becker <jlbec@evilplan.org>, Rusty Russell <rusty@rustcorp.com.au>,
        matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <20020315151507.2370C3FE0C@smtp.linux.ibm.com> <20020315160444.P4836@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020315160444.P4836@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020315185844.8883E3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 11:04 am, Joel Becker wrote:
> On Fri, Mar 15, 2002 at 10:16:02AM -0500, Hubertus Franke wrote:
> > > 	Why waste a syscall?  The user is going to be using a library
> > > wrapper.  They don't have to know that futex_up() calls
> > > sys_futex(futex, FUTEX_UP, NULL);
> >
> > I agree with that, only for the reason that we are getting scarce on
> > syscall nubmers. Is 256-delta the max ?
>
> 	This was my impression, and why I called it "wasting" a syscall.
> On architectures where syscall numbers or handles are unlimited, of
> course there is no reason to keep it to one syscall.
>
> > One thing to consider is that many don't want to use libraries.
> > They want to inline, which would result only in a few instruction.
>
> 	Inlined you only take the penalty from the argument pushes.  You
> still have to go through the motions of checking whether you can
> get/release the lock in userspace.
>
> > What I would like to see is an interface that lets me pass optional
> > parameters to the syscall interface, so I can call with different number
> > of parameters.
>
> 	Is this to lock multiple futexes "atomically"?  If we are
> looking for a fast path stack-wise, this seems extra work.
>
> Joel

No, take for example...

syscall3(int,futex,int,op, struct futex*, futex, int opt_arg);

I will be always forced by the compiler (-Wall) to supply 3 arguments even 
as in the case of "no time out desired" I have to push a 3rd meaningless 
optional argument on the stack.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
