Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSFRSrO>; Tue, 18 Jun 2002 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317547AbSFRSrN>; Tue, 18 Jun 2002 14:47:13 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:20585 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317544AbSFRSrN>; Tue, 18 Jun 2002 14:47:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Subject: Re: latest linus-2.5 BK broken 
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
In-reply-to: Your message of "18 Jun 2002 10:46:49 MST."
             <1024422409.1476.208.camel@sinai> 
Date: Wed, 19 Jun 2002 04:51:31 +1000
Message-Id: <E17KO4i-0002xn-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1024422409.1476.208.camel@sinai> you write:
> On Tue, 2002-06-18 at 10:18, James Simmons wrote:
> 
> >   gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/tmp/fbdev-2.5/include -Wall -Wst
rict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -f
no-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -
nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sche
d   -c -o sched.o sched.c
> > sched.c: In function `sys_sched_setaffinity':
> > sched.c:1329: `cpu_online_map' undeclared (first use in this function)
> > sched.c:1329: (Each undeclared identifier is reported only once
> > sched.c:1329: for each function it appears in.)
> > sched.c: In function `sys_sched_getaffinity':
> > sched.c:1389: `cpu_online_map' undeclared (first use in this function)
> > make[1]: *** [sched.o] Error 1
> 
> Rusty, I assume this is a side-effect of the hotplug merge?

Yes, sorry.

> Can you fix this or tell me what is the new equivalent of
> cpu_online_map?

Well, I'm heading away from assumptions on the arch representations of
online CPUs (which the NUMA guys need anyway).

You could do a loop here, but the real problem is the broken userspace
interface.  Can you fix this so it takes a single CPU number please?

ie.
	/* -1 = remove affinity */
	sys_sched_setaffinity(pid_t pid, int cpu);

This will work everywhere, and doesn't require userspace to know the
size of the cpu bitmask etc.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
