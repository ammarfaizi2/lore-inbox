Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSDNM7S>; Sun, 14 Apr 2002 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSDNM7R>; Sun, 14 Apr 2002 08:59:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1479 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312254AbSDNM7R>;
	Sun, 14 Apr 2002 08:59:17 -0400
Date: Sun, 14 Apr 2002 08:59:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: aliasing bug in blockdev-in-pagecache?
In-Reply-To: <20020413235948.E4937@redhat.com>
Message-ID: <Pine.GSO.4.21.0204140857190.394-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Apr 2002, Stephen C. Tweedie wrote:

> To solve this, we really do need to have block_read_full_page() test
> the uptodate state under protection of the buffer_head lock.  We
> already go through 3 stages in block_read_full_page(): gather the
> buffers needing IO, then lock them, then submit the IO.  To be safe,
> we need a final test for buffer_uptodate() *after* we have locked the
> required buffers.

Ouch.

I suspect that correct fix is to do that test in submit_bh() itself
(and remove it from ll_rw_block()).  IMO it's cleaner than messing
with all callers out there...  Linus?

