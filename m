Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316511AbSEOWmM>; Wed, 15 May 2002 18:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSEOWmL>; Wed, 15 May 2002 18:42:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17050 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316511AbSEOWmL>;
	Wed, 15 May 2002 18:42:11 -0400
Date: Wed, 15 May 2002 15:42:00 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
Message-ID: <20020515154200.B8975@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:33:23PM -0700, Andrew Morton wrote:
> Martin Schwidefsky wrote:
> >                                          The system call that caused
> > this has been sys_ipc with IPC_RMID and from there the call chain is
> > as follows: sys_shmctl, shm_destroy, fput, dput, iput, truncate_inode_pages,
> > truncate_list_pages, schedule. The scheduler picked a process that called
> > sys_shmat. It tries to get the lock and hangs.
> 
> There's no way the kernel can successfully hold a spinlock
> across that call chain.
> 

Is adding a check for this type of situation (under CONFIG_DEBUG_SPINLOCK
of course) worth the effort?  One would simply add a 'locks_held' count
for each task and check for zero at certain places such as return to
user mode, and during context switching.

It appears that this was done for 'sparc64', but no other architectures.
I would consider doing this for i386, if anyone would actually use it.

One would think these types of things are easily found, but this example
suggests otherwise.  Has anyone run the kernel through an extensive
(stress) test suite with any of the kernel debug options enabled?

-- 
Mike
