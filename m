Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291853AbSBXXaH>; Sun, 24 Feb 2002 18:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291840AbSBXXaA>; Sun, 24 Feb 2002 18:30:00 -0500
Received: from [202.135.142.194] ([202.135.142.194]:40708 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291846AbSBXX3u>; Sun, 24 Feb 2002 18:29:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores... 
In-Reply-To: Your message of "Sat, 23 Feb 2002 16:03:14 BST."
             <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain> 
Date: Mon, 25 Feb 2002 10:29:39 +1100
Message-Id: <E16f85L-0005QM-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain> you 
write:
> 
> On Sat, 23 Feb 2002, Rusty Russell wrote:
> 
> > 1) Interface is: open /dev/usem, pread, pwrite.
> 
> i like the patch, but the interface is ugly IMO. Why not new syscalls? I
> think these lightweight semaphores will become an important part of Linux,
> so having their own syscall entries is the most correct interface,
> something like:
> 
>   sys_sem_create()
>   sys_sem_destroy()

There is no create and destroy (init is purely userspace).  There is
"this is a semapore: up it".  This is a feature.

>   sys_sem_down()
>   sys_sem_up()
> 
> /dev/usem is such an ... ioctl()-ish approach. It's a scalability problem
> as well: read()/write() has (or can have) some implicit locking that is
> imposed on the usem interface as well.

Agreed with implicit locking: good catch.  Disagree with neatness: I
like finding out in advance that there's no fast semaphore support.

> Plus sys_sem_create() should do some proper resource limit management,
> pinning down an unlimited number of pages is bad.

Since pages are pinned "on demand" and a process can only do one
syscall at a time, the maximum number of pinned pages per process ==
2.  Which is fine.

Will do syscall version, and see if I can actually get it to beat
fcntl locking on reasonable benchmarks (ie. tdbtorture).

Cheers!
Rusty.
PS.  Nomenclature: my fiance suggested FUS (Fast Userspace
     Semaphores), and I am legally obliged to agree.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
