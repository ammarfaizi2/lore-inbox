Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbQLDPfq>; Mon, 4 Dec 2000 10:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQLDPfh>; Mon, 4 Dec 2000 10:35:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28173 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129541AbQLDPfV>;
	Mon, 4 Dec 2000 10:35:21 -0500
Date: Mon, 4 Dec 2000 15:00:43 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001204150043.C8700@redhat.com>
In-Reply-To: <3A29008E.F05E5C95@uow.edu.au> <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 02, 2000 at 10:33:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 02, 2000 at 10:33:36AM -0500, Alexander Viro wrote:
> 
> On Sun, 3 Dec 2000, Andrew Morton wrote:
> 
> > It appears that this problem is not fixed.
> Sure, it isn't. Place where the shit hits the fan: fs/buffer.c::unmap_buffer().
> Add the call of remove_inode_queue(bh) there and see if it helps. I.e.

unmap_buffer() calls mark_buffer_clean() calls refile_buffer() calls
remove_inode_queue(), which is why we don't see this all the time.

However, refile_buffer() is only calling the remove_inode_queue() if
the buffer disposition changes.  I'm looking to see where we may be
going wrong here --- the refile_buffer() is not atomic wrt. the
bh->b_inode structures.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
