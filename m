Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbREZDMu>; Fri, 25 May 2001 23:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbREZDMl>; Fri, 25 May 2001 23:12:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21562 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262575AbREZDM3>; Fri, 25 May 2001 23:12:29 -0400
Date: Sat, 26 May 2001 05:11:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526051156.S9634@athlon.random>
In-Reply-To: <20010526043835.R9634@athlon.random> <Pine.LNX.4.33.0105252243570.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252243570.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 10:49:38PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 10:49:38PM -0400, Ben LaHaise wrote:
> Highmem.  0 free pages in ZONE_NORMAL.  Now try to allocate a buffer_head.

That's a longstanding deadlock, it was there the first time I read
fs/buffer.c, nothing related to highmem, we have it in 2.2 too. Also
getblk is deadlock prone in a smiliar manner.

Can you try to simply change NR_RESERVED to say 200*MAX_BUF_PER_PAGE and
see if it makes a difference? The unused_list logic doesn't give a
guarantee either and it's one of the "hiding" logics, but it was working
pretty well usually, maybe something changed that needs more than 2
pages (16 bh) reserved?

Andrea
