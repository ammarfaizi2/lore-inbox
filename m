Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289380AbSAVUKo>; Tue, 22 Jan 2002 15:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289383AbSAVUKe>; Tue, 22 Jan 2002 15:10:34 -0500
Received: from ns.caldera.de ([212.34.180.1]:43930 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289381AbSAVUKW>;
	Tue, 22 Jan 2002 15:10:22 -0500
Date: Tue, 22 Jan 2002 21:10:14 +0100
Message-Id: <200201222010.g0MKAE929935@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: oliendm@us.ibm.com (Dave Olien)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.17 pthread support for SEM_UNDO in semop()
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200201221834.g0MIY9s08359@eng2.beaverton.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201221834.g0MIY9s08359@eng2.beaverton.ibm.com> you wrote:
> +/* Each PROCESS (i.e. collection of tasks that are running POSIX style threads)
> + * must share the same semundo list, in order to support POSIX SEMUNDO
> + * semantics for threads.  The sem_undohd controls shared access to this
> + * list among all the tasks (threads) in that process.

Just because pthreads exist the Linux notation of process doesn't
change.  Could you please change that comment to talk about thread
groups?

> +/* For now, assume that if ALL clone flags are set, then
> + * we must be creating a POSIX thread, and we want undo lists
> + * to be shared among all the threads in that thread group.
> + *
> + * See the notes above unlock_semundo() regarding the spin_lock_init()
> + * in this code.  Initialize the undohd->lock here instead of get_undohd()
> + * because of the reasoning in the note referenced here.
> + */
> +#define CLONE_SEMUNDO (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND)

That's junk.  Define a new CLONE_SYSVIPC flags instead of overloading a
collection (!) of old flags.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
