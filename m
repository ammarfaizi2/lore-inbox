Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCOPQN>; Fri, 15 Mar 2002 10:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292733AbSCOPPy>; Fri, 15 Mar 2002 10:15:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63872 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292730AbSCOPPs>;
	Fri, 15 Mar 2002 10:15:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Joel Becker <jlbec@evilplan.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Re: futex and timeouts
Date: Fri, 15 Mar 2002 10:16:02 -0500
X-Mailer: KMail [version 1.3.1]
Cc: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <E16lkRS-0001HN-00@wagner.rustcorp.com.au> <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020315151507.2370C3FE0C@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 01:08 am, Joel Becker wrote:
> On Fri, Mar 15, 2002 at 04:39:50PM +1100, Rusty Russell wrote:
> > Yep, sorry, my mistake.  I suggest make it a relative "struct timespec
> > *" (more futureproof that timeval).  It would make sense to split the
> > interface into futex_down and futex_up syuscalls, since futex_up
> > doesn't need a timeout arg, but I haven't for the moment.
>
> 	Why waste a syscall?  The user is going to be using a library
> wrapper.  They don't have to know that futex_up() calls sys_futex(futex,
> FUTEX_UP, NULL);
>
> Joel

I agree with that, only for the reason that we are getting scarce on 
syscall nubmers. Is 256-delta the max ?
On the other hand, it requires to always push 2 more arguments
(operand and useless parameter).

One thing to consider is that many don't want to use libraries.
They want to inline, which would result only in a few instruction.

What I would like to see is an interface that lets me pass optional 
parameters to the syscall interface, so I can call with different number
of parameters.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
