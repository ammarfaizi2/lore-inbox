Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132499AbRACRJI>; Wed, 3 Jan 2001 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRACRI7>; Wed, 3 Jan 2001 12:08:59 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:28172 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132499AbRACRIr>; Wed, 3 Jan 2001 12:08:47 -0500
Date: Wed, 03 Jan 2001 11:37:46 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <428710000.978539866@tiny>
In-Reply-To: <Pine.LNX.4.21.0012291446560.13194-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

Just noticed the filemap_fdatasync code doesn't check the return value from
writepage.  Linus, would you take a patch that redirtied the page, puts it
back onto the dirty list (at the tail), and unlocks the page when writepage
returns 1?

That would loop forever if the writepage func kept returning 1 though...I
think that's what we want, unless someone like ramfs made a writepage func
that always returned 1.

For the reiserfs code, I'd like to be able to tell page_launder and
filemap_fdatasync to try the page again later.  reiserfs would clean and
unlock the page if no io needs to be done at all.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
