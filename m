Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSBWNG3>; Sat, 23 Feb 2002 08:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSBWNGT>; Sat, 23 Feb 2002 08:06:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42461 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293132AbSBWNGD>;
	Sat, 23 Feb 2002 08:06:03 -0500
Date: Sat, 23 Feb 2002 16:03:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Feb 2002, Rusty Russell wrote:

> 1) Interface is: open /dev/usem, pread, pwrite.

i like the patch, but the interface is ugly IMO. Why not new syscalls? I
think these lightweight semaphores will become an important part of Linux,
so having their own syscall entries is the most correct interface,
something like:

  sys_sem_create()
  sys_sem_destroy()
  sys_sem_down()
  sys_sem_up()

/dev/usem is such an ... ioctl()-ish approach. It's a scalability problem
as well: read()/write() has (or can have) some implicit locking that is
imposed on the usem interface as well. It's a usage robustness issue as
well: chroot() environments that have no /dev directory will suddenly lose
a functionality of Linux. There is absolutely no problem with adding new
syscalls for things like this.

Plus sys_sem_create() should do some proper resource limit management,
pinning down an unlimited number of pages is bad.

	Ingo

