Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQJ2UnG>; Sun, 29 Oct 2000 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbQJ2Um5>; Sun, 29 Oct 2000 15:42:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33194 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129322AbQJ2Umk>;
	Sun, 29 Oct 2000 15:42:40 -0500
Date: Sun, 29 Oct 2000 15:42:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Paul Mackerras <paulus@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <E13pz7a-0006JY-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0010291537380.27484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Alan Cox wrote:

> > I would expect problems with truncate, mmap, rename, POSIX locks, fasync,
> > ptrace and mount go unnoticed for _long_. Ditto for parts of procfs
> 
> Well the ptrace one still has mysteriously breaks usermode linux against it
> on my list here. Was that ever explained. It looked like the stack got corrupted
> which is weird.

Alan, is it me or usermode port really tends to catch the stack overflows?
<thinks> How about we allocate the pages by 4, not by 2 as we do now, and
explicitly unmap the pages below the task_struct? That would still leave the
chance of stack overflow going unnoticed, but the window would be limited.

Another possibility for ptrace-related screwups: past-the-EOF check in
filemap_nopage(). I'm still not convinced that it's right. It may be, but...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
