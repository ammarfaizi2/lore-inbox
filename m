Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272721AbRITAEU>; Wed, 19 Sep 2001 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRITAEJ>; Wed, 19 Sep 2001 20:04:09 -0400
Received: from [195.223.140.107] ([195.223.140.107]:4082 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272721AbRITAEB>;
	Wed, 19 Sep 2001 20:04:01 -0400
Date: Thu, 20 Sep 2001 02:01:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920020100.H720@athlon.random>
In-Reply-To: <20010919232818.T720@athlon.random> <Pine.LNX.4.21.0109200022360.1221-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109200022360.1221-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Sep 20, 2001 at 12:51:06AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 12:51:06AM +0100, Hugh Dickins wrote:
> I'm off-by-one when I try it tomorrow.

yes you're off by one but that was because of something I wasn't allowed
to do safely ;) sorry (see my last email to Linus).

> I don't think so: as the comment says, one for the page cache,
> one for the caller of writepage, one (perhaps) for page->buffers.

btw, we should be even smarter, even if there are buffers we should
still drop both the buffers and then the page from the pagecaceh. It's
just an orphan, it must be collected away cleanly without any I/O even
if there are buffers.  The other option would be to cleanup the orphans
from free_page_and_swap_cache but that would not be optimal as we try to
be lazy and to avoid the swap_count checks in the exit(2)/munmap(2) fast
paths.

Andrea
