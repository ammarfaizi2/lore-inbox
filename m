Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLDPtr>; Mon, 4 Dec 2000 10:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQLDPth>; Mon, 4 Dec 2000 10:49:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17316 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129392AbQLDPt1>;
	Mon, 4 Dec 2000 10:49:27 -0500
Date: Mon, 4 Dec 2000 10:19:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <20001204150043.C8700@redhat.com>
Message-ID: <Pine.GSO.4.21.0012041014500.5153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Stephen C. Tweedie wrote:

> unmap_buffer() calls mark_buffer_clean() calls refile_buffer() calls
> remove_inode_queue(), which is why we don't see this all the time.

Not enough, since you can hit the window between the request completion
(bh is marked clean) and getting it picked by flush_dirty_buffers() et.al.
If you get destroy_inode() before that window will close...

> However, refile_buffer() is only calling the remove_inode_queue() if
> the buffer disposition changes.  I'm looking to see where we may be
> going wrong here --- the refile_buffer() is not atomic wrt. the
> bh->b_inode structures.

See above. Point about the metadata (bforget() is not enough) also stands,
ditto for ext2_update_inode() one.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
