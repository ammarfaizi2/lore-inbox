Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSFKJJT>; Tue, 11 Jun 2002 05:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSFKJJS>; Tue, 11 Jun 2002 05:09:18 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:7138 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316958AbSFKJJS>; Tue, 11 Jun 2002 05:09:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Tue, 11 Jun 2002 00:42:32 MST."
             <3D05A9E8.FF0DA223@zip.com.au> 
Date: Tue, 11 Jun 2002 19:09:44 +1000
Message-Id: <E17Hheq-0007r7-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D05A9E8.FF0DA223@zip.com.au> you write:
> and slowdown:

ARGH!  STOP IT!  I realize it's 'leet to be continually worrying about
possible microoptimizations, but I challenge you to *measure* the
slowdown between:

> > -       for (i = 0; i < smp_num_cpus; i++) {
> > -               int logical = cpu_logical_map(i);

and

> > +       for (i = 0; i < NR_CPUS; i++) {
> > +               if (!cpu_online(i))
> > +                       continue;

*Especially* in this context.  Sure, a new "max_cpu_number" or
"cpu_for_each(i)" macro would fix this, but at the expense of using up
additional stack in the reader's brain.

Let's not perpetuate the myth that everything in the kernel needs to
be tuned to the last cycle at all costs, hm?

Yes, you stepped on a sore point 8)
Rusty.
PS.  Of course, you know the correct answer, anyway.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
