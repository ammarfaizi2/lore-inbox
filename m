Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311965AbSCQI7M>; Sun, 17 Mar 2002 03:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311967AbSCQI7C>; Sun, 17 Mar 2002 03:59:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:65286 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311965AbSCQI6x>; Sun, 17 Mar 2002 03:58:53 -0500
Message-ID: <3C945A5A.9673053F@zip.com.au>
Date: Sun, 17 Mar 2002 00:56:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Has anyone ever done an madvise(2)-type syscall for file descriptors?
> (or does the capability exist and I'm missing it?)

Well, question is: is madvise() any use? :)

> I was thinking, in playing around with stuff like cp(1) I've found that
> standard read(2) and write(2) of a 4-8K buffer is the fastest solution
> overall, in addition to providing the useful side effect of better error
> reporting, such as ENOSPC report.  Better error reporting than the
> alternative I see anyway, mmap(2).

4k to 8k is best on x86 at least.  And if you're actually going to *use*
each byte in the file, the zero-copy characteristics of mmap aren't
worth much at all.
 
> So... we have madvise, why not fadvise?  I would love the capability for
> applications to provide hints to the OS like madvise, but for file
> descriptors...

The one hint which I can think of which would be beneficial would
be an equivalent to MADV_SEQUENTIAL.  Something which says "this
is a big streaming read/write - don't go and evict other stuff because
of it".  O_STREAMING perhaps.  Or working dropbehind heuristics,
although I suspect that explicit controls will always do better.

For MADV_RANDOM, readahead window scaling should get that right.

What else were you thinking of?

-
