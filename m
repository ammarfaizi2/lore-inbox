Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDYU45>; Wed, 25 Apr 2001 16:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRDYU4s>; Wed, 25 Apr 2001 16:56:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8294 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132318AbRDYU4i>; Wed, 25 Apr 2001 16:56:38 -0400
Date: Wed, 25 Apr 2001 22:56:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] rw_semaphores, optimisations try #4
Message-ID: <20010425225621.B13531@athlon.random>
In-Reply-To: <01042521063800.02040@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01042521063800.02040@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Wed, Apr 25, 2001 at 09:06:38PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 09:06:38PM +0100, D . W . Howells wrote:
> This patch (made against linux-2.4.4-pre6 + rwsem-opt3) somewhat improves 
> performance on the i386 XADD optimised implementation:

It seems more similar to my code btw (you finally killed the useless
chmxchg ;).

I only had a short low at your attached patch, but the results are quite
suspect to my eyes beacuse we should still be equally fast in the fast
path and I should still beat you on the write fast path because I do a
much faster subl; js while you do movl -1; xadd ; js, while according to
your results you beat me on both. Do you have an explanation or you
don't know the reason either? I will re-benchmark the whole thing
shortly. But before re-benchmark if you have time could you fix the
benchmark to use the variable pointer and send me a new tarball?  For
your code it probably doesn't matter because you dereference the pointer
by hand anyways, but it matters for mine and we want to benchmark real
world fast path of course.

Andrea
