Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313682AbSDHQBJ>; Mon, 8 Apr 2002 12:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313684AbSDHQBI>; Mon, 8 Apr 2002 12:01:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41488 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313682AbSDHQBH>; Mon, 8 Apr 2002 12:01:07 -0400
Date: Mon, 8 Apr 2002 08:59:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
        <jfs-discussion@www-126.southbury.usf.ibm.com>
Subject: Re: [PATCH] rw-semaphore asm constraints patch fix
In-Reply-To: <26894.1018269838@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0204080855060.16914-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Apr 2002, David Howells wrote:
>
> The attached patch should fix the compile error that asm-i386/rwsem.h causes
> with old gcc's whilst maintaining the asm constraints correctly.

Doesn't work.

> +             : "=m"(sem->count), "=d"(tmp)
> +             : "0"(sem->count), "1"(tmp), "a"(sem)

A "m" constraint cannot be used together with a subsequent number (ie the
"=m" -> "0" thing is illegal - the numbering traditionally only works on
hard registers). It may work with some compilers and with the right
register pressure, but it absolutely _will_ cause problems on other
setups.

I should know, I tried to work around gcc stupidities in this area enough
times, and cursed how various things didn't work with various compilers.

The best thing to do is probably to mark "sem->count" a memory input only,
which together with the memory clobber should be ok.

		Linus

