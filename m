Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbRBMLRH>; Tue, 13 Feb 2001 06:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbRBMLQ6>; Tue, 13 Feb 2001 06:16:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129117AbRBMLQv>;
	Tue, 13 Feb 2001 06:16:51 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102131116.f1DBGFx02086@flint.arm.linux.org.uk>
Subject: Re: [PATCH] swapin flush cache bug
To: gniibe@m17n.org (NIIBE Yutaka)
Date: Tue, 13 Feb 2001 11:16:14 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <200102131053.TAA11808@mule.m17n.org> from "NIIBE Yutaka" at Feb 13, 2001 07:53:11 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIIBE Yutaka writes:
> My case (SH-4) is: virtual address indexed, physical address tagged cache
> (which has alias issue).

vivt caches have the same alias issue.

> Suppose there's I/O to the physical page P asynchronously, and the
> page is placed in the swap cache.

Unless someone else (Rik/DaveM) says otherwise, it is my understanding
that any IO for page P will only ever be a write to disk.  Therefore,
when you get a copy of the page from the swap cache, the physical memory
for that page is the same as it was when the process was using it last.

> It remains cache entry, say, indexed kernel virtual address K.  Then,
> process maps P at U.  U and K (may) indexes differently.  The process
> will get the data from memory (not the one in the cashe), if it's not
> flushed.

The data from memory will still be up to date though.  However, I agree
that you will end up with cache aliases.  I will also end up with cache
aliases.  The question now is, do these aliases really matter?

On my caches, the answer is no because they're not marked dirty, and
therefore will get dropped from the cache without writeback to memory.

If your cache doesn't write back clean cache data to memory, then you
should also behave well.

However, that said, someone more experienced with the Linux MM should
comment.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

