Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135684AbRDSU2T>; Thu, 19 Apr 2001 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135691AbRDSU2J>; Thu, 19 Apr 2001 16:28:09 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:61837 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135684AbRDSU17>;
	Thu, 19 Apr 2001 16:27:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        abramo@alsa-project.org (Abramo Bagnara), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz)
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qKlf-0007y7-00@the-village.bc.nu>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 13:26:49 -0700
In-Reply-To: Alan Cox's message of "Thu, 19 Apr 2001 21:11:04 +0100 (BST)"
Message-ID: <m3bsps1vqu.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I don't want nor need file permissions.  A program would look like this:
> 
> Your example opens/mmaps so has file permissions. Which is what I was asking

There are no permissions on the mutex object.  It is the shared memory
which counts.  If you would implement the global mutexes as
independent objects in the filesystem hierarchy you would somehow
magically make the permissions match those of the object containing
the memory representation of the global semaphore.


   fd = open("somefile", O_CREAT|O_TRUNC, 0666)
   addr=mmap(fd)
   // assume attr is for a global mutex
   pthread_mutex_init((pthread_mutex_t*)addr, &attr)
   fchmod(fd, 0600)
   fchown(fd, someuser, somegroup)

If pthread_mutex_attr() is allocating some kind of file, how do you
determine the permissions?  How are they changed if the permissions to
the file change?

The kernel representation of the mutex must not be disassociated from
the shared memory region.

Even if you all think very little about Solaris, look at the kernel
interface for semaphores.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
