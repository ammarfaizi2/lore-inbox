Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291927AbSBYBLI>; Sun, 24 Feb 2002 20:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291934AbSBYBK6>; Sun, 24 Feb 2002 20:10:58 -0500
Received: from [202.135.142.194] ([202.135.142.194]:55826 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291927AbSBYBKq>; Sun, 24 Feb 2002 20:10:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@elte.hu, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores... 
In-Reply-To: Your message of "Sun, 24 Feb 2002 15:48:58 -0800."
             <Pine.LNX.4.33.0202241543550.28708-100000@home.transmeta.com> 
Date: Mon, 25 Feb 2002 12:10:34 +1100
Message-Id: <E16f9f0-0006N2-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0202241543550.28708-100000@home.transmeta.com> you wr
ite:
> 
> 
> On Mon, 25 Feb 2002, Rusty Russell wrote:
> > >
> > >   sys_sem_create()
> > >   sys_sem_destroy()
> >
> > There is no create and destroy (init is purely userspace).  There is
> > "this is a semapore: up it".  This is a feature.
> 
> You have to realize that there are architectures that need special
> initialization and page allocation for semaphores: they need special flags
> in the TLB for "careful access", for example (sometimes the careful access
> ends up being non-cached).

Bugger.  How about:

	sys_sem_area(void *pagestart, size_t len)
	sys_unsem_area(void *pagestart, size_t len)

Is that sufficient?  Is sys_unsem_area required at all?

TDB has an arbitrary number of semaphores in the mmap file...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
