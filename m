Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318676AbSG0ByH>; Fri, 26 Jul 2002 21:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318677AbSG0ByG>; Fri, 26 Jul 2002 21:54:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61824 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318676AbSG0ByG>;
	Fri, 26 Jul 2002 21:54:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu 
In-reply-to: Your message of "Fri, 26 Jul 2002 11:46:34 MST."
             <3D41990A.EDC1A530@zip.com.au> 
Date: Sat, 27 Jul 2002 11:56:13 +1000
Message-Id: <20020727015833.D0C534134@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +       for( i=0; i < NR_CPUS; i++ )
> > +               res += *per_cpu_ptr(stctr->ctr, i);
> > +       return res;
> > +}
> 
> Oh dear.  Most people only have two CPUs.
> 
> Rusty, can we *please* fix this?  Really soon?

Linus just applied the hotplug cpu boot patch in bk, which gives
cpu_possible(i), for exactly this purpose.

> General comment:  we need to clean up the kernel_stat stuff.  We
> cannot just make it per-cpu because it is 32k in size already.  I
> would suggest that we should break out the disk accounting and
> make the rest of kernel_stat per CPU.

kernel_stat is dynamically allocated???

Personally, I think that dynamically allocated per-cpu datastructures,
like dynamically-allocated brlocks, are something we might need
eventually, but look at what a certain driver did with the "make it
per-cpu" concept already.  I don't want to rush in that direction.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
