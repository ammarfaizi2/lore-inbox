Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbQLVCw0>; Thu, 21 Dec 2000 21:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131786AbQLVCwG>; Thu, 21 Dec 2000 21:52:06 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:27387 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131274AbQLVCwB>; Thu, 21 Dec 2000 21:52:01 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012220220.eBM2Kpj19962@webber.adilger.net>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0012212133380.2533-100000@freak.distro.conectiva>
 "from Marcelo Tosatti at Dec 21, 2000 10:19:20 pm"
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Thu, 21 Dec 2000 19:20:50 -0700 (MST)
CC: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> It seems your code has a problem with bh flush time.
> 
> In flush_dirty_buffers(), a buffer may (if being called from kupdate) only
> be written in case its old enough. (bh->b_flushtime)
> 
> If the flush happens for an anonymous buffer, you'll end up writing all
> buffers which are sitting on the same page (with block_write_anon_page),
> but these other buffers are not necessarily old enough to be flushed.

This isn't really a "problem" however.  The page is the _maximum_ age of
the buffer before it needs to be written.  If we can efficiently write it
out with another buffer (essentially for free if they are on the same
spot on disk), then there is less work for us to do later.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
