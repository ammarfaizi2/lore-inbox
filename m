Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSAQQHA>; Thu, 17 Jan 2002 11:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289194AbSAQQGw>; Thu, 17 Jan 2002 11:06:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5180 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289191AbSAQQGf>; Thu, 17 Jan 2002 11:06:35 -0500
Date: Thu, 17 Jan 2002 16:08:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020117164515.N4847@athlon.random>
Message-ID: <Pine.LNX.4.21.0201171556330.2023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> On Thu, Jan 17, 2002 at 12:14:13PM +0000, Hugh Dickins wrote:
> > 
> > But people should realize that moving page tables and other such
> > structures into not-always-mapped highmem will make them harder to
> > access with kernel debuggers - I think those will want some changes.
> 
> the debugging prospective is probably the one I care less (you can
> always drop a __GFP_HIGHMEM into the right alloc_pages to get the memory
> direct mapped) that's most of the time a one liner in just one place.

I was thinking there of peering at a crashed kernel with some debugger,
trying to see the page tables (or whatever).  In most cases, if they're
relevant to the problem, they will already be kmapped (or perhaps the
problem would just be that they're not).  The maintainers of debuggers
will probably need to add something to help find the right mapping.

But you're right, Linux is not primarily designed as a platform for
kernel debuggers, and that should not stop progress: sooner or later
we have to extend use of highmem, you've found good reason to extend
it to page tables (and Christoph's shmem index is a very similar case).

Hugh

