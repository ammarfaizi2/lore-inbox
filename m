Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSFLHxr>; Wed, 12 Jun 2002 03:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317407AbSFLHxq>; Wed, 12 Jun 2002 03:53:46 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:35592 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317664AbSFLHxQ>; Wed, 12 Jun 2002 03:53:16 -0400
Message-Id: <5.1.0.14.2.20020612084157.041970e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 08:54:01 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp
In-Reply-To: <E17I180-0000IT-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:57 12/06/02, Rusty Russell wrote:
>In message <5.1.0.14.2.20020611120032.00aec7f0@pop.cus.cam.ac.uk> you write:
> > >In which case, CONFIG_NR_CPUS is the only way to get the memory
> > >back...
> >
> > Why? You can get rid of all uses of NR_CPUS (except for using it as a max
> > capping value so none goes above it) and always use smp_num_cpus instead.
> > And make the cpu hotplug code update smp_num_cpus as appropriate.
>
>You remove CPU 2 of 4 and the others renumber?

I would hope not! That would be insane. I am only talking about adding 
CPUs. Who cares if you remove one. The buffers can stay allocated. Chances 
are you will be adding a replacement very soon anyway.

>Everyone using per-cpu buffers needs to write code to move them.  And what 
>do apps bound to CPU 3 do?  What about *their* per-cpu data structures?
>
> > So zero penalty for non-hotplug users and loads of penalty for hotplug
> > users but frankly I couldn't care less for those. The slow path will
> > trigger so seldom it is not worth thinking about the performance hit there.
>
>And a greater requirement for everyone using per-cpu buffers (which
>are becoming more common, not less) to write more code.  And it
>doesn't deal with CPU removal.

And it doesn't need to.

> > There are a lot of ways to deal with this corner case dynamically, so
> > please use one of them. I don't buy the "lets penalise 99% of users for 
> the
> > sake of a feature that almost noone will ever use" argument.
>
>Sorry, you're arguing to maintain a traditionally problematic
>interface for an unmeasurable time benifit, and a slight space benefit
>(on SMP machines, where noone has cared space about until recently).

I guess we disagree about the definition OS "slight" space benefit... I 
used to have a dual-Celeron with 128mb ram for a while. Throwing away 1-2mb 
just for a single driver is throwing away 1-2% of all RAM. And I would 
think adding more drivers it quickly adds up to 5-10% of RAM. And that 
sounds like way too much waste to me.

RAM is cheap if you are using a hot plug 32-CPU system, sure. But if you 
are using a low-end SMP system ram is more expensive than the rest of the 
system all together so it is not cheap at all. It is just a question of 
perspective.

>Now, you *could* only allocate buffers for cpus where cpu_possible(i)
>is true, once the rest of the patch goes in.  That would be a valid
>optimization.

Please explain. What is cpu_possible()?

btw. I agree that CONFIG_NR_CPUS or whatever it is called would solve my 
problems. It is only in distro kernels where they are likely to leave it to 
the maximum value and most people use distro kernels...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

