Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbRDLPmv>; Thu, 12 Apr 2001 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135193AbRDLPmm>; Thu, 12 Apr 2001 11:42:42 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:3233 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S135205AbRDLPma>; Thu, 12 Apr 2001 11:42:30 -0400
Date: Thu, 12 Apr 2001 16:43:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <200104121457.f3CEv8o09656@foo-bar-baz.cc.vt.edu>
Message-ID: <Pine.LNX.4.21.0104121622520.1638-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001 Valdis.Kletnieks@vt.edu wrote:
> I've seen the same scenario about 2-3 times a week.  kswapd and one or
> more processes all CPU bound, totalling to 100%.  I've had 'esdplay' hung
> on several occasions, and 2-3 times it's been xscreensaver (3.29) hung.
> The 'hung' processes are consistently immune to kill -9, even as root, which
> indicates to me that they're hung inside a kernel call or something.
[snip]
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 3-order allocation failed.
[snip]
> In page_alloc.c, __alloc_pages() has a 'goto try_again;' which will
> cause it to loop around and try to get more memory.  I'm wondering if
[snip]
> I'm running the 2.4.3 kernel

2.4.3-pre6 quietly made a very significant change there:
it used to say "if (!order) goto try_again;" and now just
says "goto try_again;".  Which seems very sensible since
__GFP_WAIT is set, but I do wonder if it was a safe change.
We have mechanisms for freeing pages (order 0), but whether
any higher orders come out of that is a matter of chance.

(But of course, this may not be related to your problem,
and your "N-order allocation failed" messages must have
been from other instances than stuck in this loop.)

Hugh

