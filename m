Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317634AbSFLFyK>; Wed, 12 Jun 2002 01:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317635AbSFLFyJ>; Wed, 12 Jun 2002 01:54:09 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:26834 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317634AbSFLFyJ>; Wed, 12 Jun 2002 01:54:09 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Tue, 11 Jun 2002 12:22:15 +0100."
             <5.1.0.14.2.20020611120032.00aec7f0@pop.cus.cam.ac.uk> 
Date: Wed, 12 Jun 2002 15:57:08 +1000
Message-Id: <E17I180-0000IT-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20020611120032.00aec7f0@pop.cus.cam.ac.uk> you write:
> >In which case, CONFIG_NR_CPUS is the only way to get the memory
> >back...
> 
> Why? You can get rid of all uses of NR_CPUS (except for using it as a max 
> capping value so none goes above it) and always use smp_num_cpus instead. 
> And make the cpu hotplug code update smp_num_cpus as appropriate.

You remove CPU 2 of 4 and the others renumber?  Everyone using per-cpu
buffers needs to write code to move them.  And what do apps bound to
CPU 3 do?  What about *their* per-cpu data structures?

> So zero penalty for non-hotplug users and loads of penalty for hotplug 
> users but frankly I couldn't care less for those. The slow path will 
> trigger so seldom it is not worth thinking about the performance hit there.

And a greater requirement for everyone using per-cpu buffers (which
are becoming more common, not less) to write more code.  And it
doesn't deal with CPU removal.

> There are a lot of ways to deal with this corner case dynamically, so 
> please use one of them. I don't buy the "lets penalise 99% of users for the 
> sake of a feature that almost noone will ever use" argument.

Sorry, you're arguing to maintain a traditionally problematic
interface for an unmeasurable time benifit, and a slight space benefit
(on SMP machines, where noone has cared space about until recently).

Now, you *could* only allocate buffers for cpus where cpu_possible(i)
is true, once the rest of the patch goes in.  That would be a valid
optimization.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
