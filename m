Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTAFPYP>; Mon, 6 Jan 2003 10:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbTAFPYP>; Mon, 6 Jan 2003 10:24:15 -0500
Received: from www.wireboard.com ([216.151.155.101]:14981 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S266958AbTAFPYN>; Mon, 6 Jan 2003 10:24:13 -0500
To: "Dirk Bull" <dirkbull102@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat problem
References: <F10zrLCCtgx8VUkRacU000005ae@hotmail.com>
From: Doug McNaught <doug@mcnaught.org>
Date: 06 Jan 2003 10:32:50 -0500
In-Reply-To: "Dirk Bull"'s message of "Mon, 06 Jan 2003 14:53:41 +0000"
Message-ID: <m31y3qi999.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dirk Bull" <dirkbull102@hotmail.com> writes:

> Doug, thanks for the reply. I've set SHM_RND in the call and used
> "__attribute__ ((aligned(4096)))" during the the declaration of
> variable global01_
> (as shown below) such that it is aligned on a page boundary. I'm
> porting code that was
> written for a Unix system to Linux and the example shown below is how
> the code is
> implemented on Unix.

Hmmm, I may be ignorant, but I don't see how the below could work.
You're asking for the kernel to map your shared memory in the middle
of an already-mapped area (the bss segment).  I'm actually surprised
it works on any Unix.

If you can point out a clear violation of the POSIX spec, someone may
be willing to change it, but it's not clear to me that you're
guaranteed to be able to map a shared memory area inside your existing
data segment.

> union {
> 	long IN[2048];
> } global01_ __attribute__ ((aligned(4096)));

[...]

> 	if ( (shmptr = shmat(shmid, &global01_, SHM_RND)) == (void *) -1)
> 		printf("shmat error: %d %s\n",errno, strerror(errno));
> 	else
> 		printf("shared memory attached from %x to %x\n",
> 				shmptr, shmptr+sizeof(global01_));

-Doug
