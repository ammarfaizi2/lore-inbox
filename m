Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160525AbPJUDnz>; Wed, 20 Oct 1999 23:43:55 -0400
Received: by vger.rutgers.edu id <S160695AbPJUDea>; Wed, 20 Oct 1999 23:34:30 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:28800 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S160921AbPJUDdg>; Wed, 20 Oct 1999 23:33:36 -0400
Date: Wed, 20 Oct 1999 20:35:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@linuxcare.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: architecture bootup changes..
In-Reply-To: <99102112411604.19371@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.9910202032260.982-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 21 Oct 1999, Paul Mackerras wrote:
> 
> There's a problem that doesn't show up on intel, and that is that
> flush_page_to_ram() is called with inconsistent arguments.  Sometimes it's
> a struct page * (mm/filemap.c and mm/memory.c), in other cases it's a
> kernel virtual address (e.g. kernel/ptrace.c, include/linux/highmem.h).
> 
> I'm inclined to think it should be a kernel virtual address.  Comments?

Ho humm.. I would almost prefer the "struct page" because in theory you
might want to do it without mapping the page at all. But this is
definitely a case where most of the time it's only needed with virtual
caches, so at the same time a virtual address is not necessarily wrong
either.

So my preference would be a "struct page", but if you have a stronger
opinion you can override me with a little argumentation for show, ok?

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
