Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRGNQlS>; Sat, 14 Jul 2001 12:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbRGNQk6>; Sat, 14 Jul 2001 12:40:58 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:50358 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262568AbRGNQky>; Sat, 14 Jul 2001 12:40:54 -0400
Message-ID: <3B50765F.6ECF7B17@uow.edu.au>
Date: Sun, 15 Jul 2001 02:42:07 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Neil Brown <neilb@cse.unsw.edu.au>, Mike Black <mblack@csihq.com>,
        lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: raid5d, page_launder and scheduling latency
In-Reply-To: <3B507380.79381536@uow.edu.au> from "Andrew Morton" at Jul 15, 2001 02:29:52 AM <E15LSMl-0001Pk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Happily, we've just fixed the four most gross sources of poor
> > interactivity in the kernel, so let's knock over some of the others as
> > well - a few /proc functions.  That mainly leaves zap_page_range() and
> > exit() with a lot of open files.
> 
> Nowhere near it. We have to fix copy_*_user and strlen_user (there are reasons
> 2.2 uses strnlen_user). Map the same page into 2Gig of address space filled with
> non zero bytes. Map a zero terminator on the end of it. Pass pointers to this
> for all your args and do an exec().

By "interactivity" I mean "things which make it feel jerky".
The commonly occurring things, not the oddball corner cases.

- huge reads from /dev/mem
- exit with 1,000 files open
- exit with half a million pages to be zapped

And "fixing" copy_*_user is outright dumb.  Just fix the four
or five places where it matters.

-
