Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292178AbSCGJOd>; Thu, 7 Mar 2002 04:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSCGJOY>; Thu, 7 Mar 2002 04:14:24 -0500
Received: from [202.135.142.196] ([202.135.142.196]:47888 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292178AbSCGJOD>; Thu, 7 Mar 2002 04:14:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: Your message of "Thu, 07 Mar 2002 00:48:21 -0800."
             <20020307004821.A26624@twiddle.net> 
Date: Thu, 07 Mar 2002 20:17:16 +1100
Message-Id: <E16iu1V-0007a0-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020307004821.A26624@twiddle.net> you write:
> On Thu, Mar 07, 2002 at 02:39:47PM +1100, Rusty Russell wrote:
> > But since the real problem here is "lock held forever", so I don't care.
> 
> No, "lock held forever" merely makes the example trivial.  
> "Lock held for a while" is the real problem.
> 
> > > You really do need that cmpxchg loop.
> > 
> > Well, not decrementing if count < 0 already also works
> 
> How, exactly, are you planning on doing that atomically?
> Clue: 386 SMP requires an extra spinlock.

Fortuntely, it doesn't need to be atomic.  This got me too, but Paul
Mackerras convinced me.

We don't care if someone decrements it between us checking < 0 and
doing the atomic_dec_and_test.  So the only thing we worry about is
the "up" case.  A userspace "up" will go into the kernel (since count
< 0), and the kernel "up" will wake us since we are on the queue
before we do this test.

> > PS. Will Alpha have to do any special magic with the mmap PROT_SEM flag?
> 
> No.

Damn, I was hoping to find out which arch actually is going to use
this.  I hate untested code.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
