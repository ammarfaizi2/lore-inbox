Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286734AbSAGUb0>; Mon, 7 Jan 2002 15:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286841AbSAGUaC>; Mon, 7 Jan 2002 15:30:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4114 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286734AbSAGU3v>; Mon, 7 Jan 2002 15:29:51 -0500
Date: Mon, 7 Jan 2002 12:28:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <Pine.LNX.4.33.0201071902070.5064-101000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.33.0201071223450.6942-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Matthew Kirkwood wrote:
>
>  * It leaks.  How were you going to refcount the kernel
>    portions?  Could they be attached to the VM mapping?
>    Would a lockfs be too expensive?

Yes, I was going to just attach to the vma, along with potentially also
require a flag at mmap time (MAP_SEMAPHORE - some other unixes have
something like it already) to tell the OS about the consistency issues
that might come up on some architectures (on x86 it would be a no-op).

>  * It doesn't have a timeout.  Is there something like a
>    down_timeout() available?

Not as-is, but all the kernel infrastructure should be there in theory.

>  * I don't do the:
>
> 	if (kfs->user_address != fs)
> 		goto bad_sem;
>
>    because it doesn't seem to add anything, and prevents
>    putting these locks in a non-fixed file or SysV SHM
>    map.

Fair enough. I think I suggested that just as another sanity check, and
because some architectures _will_ require address issues (not necessarily
total equality, but at least "modulo X equality").

			Linus

