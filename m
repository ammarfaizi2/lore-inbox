Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293002AbSCFBn2>; Tue, 5 Mar 2002 20:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293004AbSCFBnS>; Tue, 5 Mar 2002 20:43:18 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:25362 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293002AbSCFBnI>; Tue, 5 Mar 2002 20:43:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Tue, 05 Mar 2002 14:39:53 -0800."
             <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com> 
Date: Wed, 06 Mar 2002 12:46:25 +1100
Message-Id: <E16iQVe-0005ss-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com> y
ou write:
> On Tue, 5 Mar 2002, Rusty Russell wrote:
> 
> > +	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
> > +
> > +	/* Must be "naturally" aligned, and not on page boundary. */
> > +	if ((pos_in_page % __alignof__(atomic_t)) != 0
> > +	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
> > +		return -EINVAL;
> 
> How can this :
> 
> 	(pos_in_page % __alignof__(atomic_t)) != 0
> 
> to be false, and together this :
> 
> 	pos_in_page + sizeof(atomic_t) > PAGE_SIZE
> 
> to be true ?

You're assuming that __alignof__(atomic_t) = N * sizeof(atomic_t),
where N is an integer.

If alignof == 1, and sizeof == 4, you lose.  I prefer to be
future-proof.

This means I should clarify the comment...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
