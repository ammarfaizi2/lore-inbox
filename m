Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRKJB1L>; Fri, 9 Nov 2001 20:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280382AbRKJB1B>; Fri, 9 Nov 2001 20:27:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11532 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280365AbRKJB0o>; Fri, 9 Nov 2001 20:26:44 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: paging Oops in 2.4.1{4,5-pre1}
Date: Sat, 10 Nov 2001 01:23:09 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9shvht$7i5$1@penguin.transmeta.com>
In-Reply-To: <200111100038.fAA0cbU13195@danapple.com>
X-Trace: palladium.transmeta.com 1005355596 29032 127.0.0.1 (10 Nov 2001 01:26:36 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Nov 2001 01:26:36 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111100038.fAA0cbU13195@danapple.com>,
Daniel I. Applebaum <kernel@danapple.com> wrote:
>
>I have a problem with kernels 2.4.14 and 2.4.15-pre1.  As soon as my
>system needs to page, it generates the following Oops.  I can
>duplicate this error at will by running a few memory-intensive
>processes, such as 4-5 simultaneously compiles, StarOffice, and
>Netscape.  If I duplicate the test, but running with no swap, just
>RAM, then I get the expected "Out of Memory: Killed process..."
>errors.

It is jumping to la-la land, apparently from "do_swap_page()". The
interesting part there is that do_swap_page() doesn't even follow any
suspicious function pointers or anything..

Can you do a

	gdb vmlinux

and send me the output of "disassemble do_swap_page", along with a copy
of the oops (the latter just because I don't keep archives of
linux-kernel, so I don't want to have to search for the oops again).

Oh, and only the first oops tends to be the really interesting one -
after the kernel has oopsed once, kernel data structures are quite
possibly corrupt, and subsequent oopses are suspect. That do_swap_page
one _was_ the first oops, right?

		Linus
