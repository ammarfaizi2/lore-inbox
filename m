Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264158AbRFNXEv>; Thu, 14 Jun 2001 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264167AbRFNXEk>; Thu, 14 Jun 2001 19:04:40 -0400
Received: from jalon.able.es ([212.97.163.2]:13003 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264158AbRFNXEb>;
	Thu, 14 Jun 2001 19:04:31 -0400
Date: Fri, 15 Jun 2001 01:05:57 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kip Macy <kmacy@netapp.com>, ognen@gene.pbi.nrc.ca,
        linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010615010557.A3869@werewolf.able.es>
In-Reply-To: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com> <E15Abr6-00057R-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15Abr6-00057R-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 20:28:32 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010614 Alan Cox wrote:
>
>So you have two choices
>1.	Pthread performance is poorer due to library glue
>2.	Every single signal delivery is 20% slower threaded or otherwise due
>	to all the crap that it adds 
>	And it does damage to other calls too.
>

Pthreads are a standard. You say 'use linux native calls, are faster and
make signal management efficient'. But then portability goes to hell. Now
I can run the same code on Linux, Irix and Solaris. Your way, I would
have to write three versions with clone(), sproc() and lwp_xxxx().
Take the example of OpenGL on IRIX boxes. Time ago it was a wrapper over
IrisGL. Now it is native. If you have a notably poor implimentation of
an standard nobody will use your system.

>In the big picture #1 is definitely preferable. 
>
>There are really only two reasons for threaded programming. 
>
>- Poor programmer skills/language expression of event handling
>
>- OS implementation flaws (and yes the posix/sus unix api has some of these)
>
>Co-routines or better language choices are much more efficient ways to express
>the event handling problem.
>
>fork() is often a better approach than pthreads at least for the design of an
>SMP threaded application because unless you explicitly think about what you
>share you will never get the cache affinity you need for good performance.
>

Joking ? That only works if your more complex structure is an array. Try
to get a rendering program with a complex linked lits-tree data structure
for the geometry, materials, textures, etc and
thinking on cache affinity. You can only think about that locally: mmm, I
need a counter for each thread, I would not put them all in an array because
I will trash caches, lets put them in separate variables; need to return
data to a segment of a big array, lets use a local copy and then pass it back.
But no more. Yes, you can change all your malloc() or new for shm's, but
what is the gain ? That is the beauty of shared memory boxes.

What linux needs is a good implementation for POSIX threads. I do not mean
putting pthreads right into the kernel, but perhaps some small change or
addition can make the user space much much faster. There are many apps that
can benefit much from using threads, use a big data segment in ro mode,
and just communicate a bit between them (a threaded web server, a rendering
program).

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac13 #1 SMP Sun Jun 10 21:42:28 CEST 2001 i686
