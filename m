Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSC0XvE>; Wed, 27 Mar 2002 18:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293725AbSC0Xuz>; Wed, 27 Mar 2002 18:50:55 -0500
Received: from [202.135.142.196] ([202.135.142.196]:54029 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293713AbSC0Xun>; Wed, 27 Mar 2002 18:50:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Wed, 27 Mar 2002 16:05:51 CDT."
             <20020327210454.BBB763FE06@smtp.linux.ibm.com> 
Date: Thu, 28 Mar 2002 10:53:52 +1100
Message-Id: <E16qNEn-0000M7-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020327210454.BBB763FE06@smtp.linux.ibm.com> you write:
> On Tuesday 26 March 2002 06:10 pm, Rusty Russell wrote:
> > In message <3CA02E80.1000600@dlr.de> you write:
> > > >   And on top of them:
> > > >   futex_down(struct futex *);
> > > >   futex_up(struct futex *);
> > >
> > > Why not keep the simple one-sys-call interface for the fuxtexes. The
> > > code is so small that it is
> > >  not worth to delete it.
> >
> >
> 
> Rusty, you lost me in all these discussions now.

I know the feeling 8)

> Is the current position to export wait queues and drop the futex interface ?
> I would recommend against that. If we need 2 syscalls to implement
> the futex behavior that certainly will create quite some overhead.

I'm still playing with the options.  Two system calls in the slow path
is definitely slower, but it's not insanely slow, and it's becoming
fairly clear that the wider range of primitives is worthwhile.

Both approaches can coexist, but I would consider the sys_futex call a
premature optimization if uwaitqs go in: this comes down to the
numbers.  I can supply a uwaitq implementation for benchmarking if you
want?

> >From my own implementation, I exported the wait queues and I didn't need the
> add/wait sequence. This as you know is/was due to the fact that I used 
> semaphores in the kernel. While that created some allocation problems and 
> won't allow for usage of the wait queues, it seems more compact.
> Any chance to move the semaphore behavior into the futexes.

The allocation element is the one I don't like: there's no really good
way of limiting it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
