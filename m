Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317907AbSFSPUF>; Wed, 19 Jun 2002 11:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSFSPUE>; Wed, 19 Jun 2002 11:20:04 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:1377 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317907AbSFSPUD>; Wed, 19 Jun 2002 11:20:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "Tue, 18 Jun 2002 17:12:45 MST."
             <Pine.LNX.4.33.0206181701240.2562-100000@penguin.transmeta.com> 
Date: Thu, 20 Jun 2002 01:23:53 +1000
Message-Id: <E17KhJj-0001Pb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0206181701240.2562-100000@penguin.transmeta.com> you 
write:
> 
> On Wed, 19 Jun 2002, Rusty Russell wrote:
> >  
> > -	new_mask &= cpu_online_map;
> > +	/* Eliminate offline cpus from the mask */
> > +	for (i = 0; i < NR_CPUS; i++)
> > +		if (!cpu_online(i))
> > +			new_mask &= ~(1<<i);
> > +
> 
> And why can't cpu_online_map be a bitmap?
> 
> What's your beef against sane and efficient data structures? The above is 
> just crazy. 

Oh, it can be.  I wasn't going to require something from all archs for
this one case (well, it was more like zero cases when I first did the
patch).

> and then add a few simple operations like
> 
> 	cpumask_and(cpu_mask_t * res, cpu_mask_t *a, cpu_mask_t *b);

Sure... or just make all archs supply a "cpus_online_of(mask)" which
does that, unless there are other interesting cases.  Or we can go the
other way and have a general "and_region(void *res, void *a, void *b,
int len)".  Which one do you want?

> This is not rocket science, and I find it ridiculous that you claim to
> worry about scaling up to thousands of CPU's, and then you try to send me
> absolute crap like the above which clearly is unacceptable for lots of
> CPU's.

Spinning 1000 times doesn't phase me until someone complains.
Breaking userspace code does.  One can be fixed if it proves to be a
bottleneck.  Understand?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
