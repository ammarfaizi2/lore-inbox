Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLDStl>; Mon, 4 Dec 2000 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129605AbQLDSta>; Mon, 4 Dec 2000 13:49:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57349 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129604AbQLDSt0>;
	Mon, 4 Dec 2000 13:49:26 -0500
Date: Mon, 4 Dec 2000 18:16:21 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] inode dirty blocks  Re: test12-pre4
Message-ID: <20001204181621.E8700@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012031828170.22914-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012040054400.5055-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0012040054400.5055-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Dec 04, 2000 at 01:01:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 01:01:36AM -0500, Alexander Viro wrote:
> 
> It doesn't solve the problem. If you unlink a file with dirty metadata
> you have a nice chance to hit the BUG() in inode.c:83. I hope that patch
> below closes all remaining holes. See analysis in previous posting
> (basically, bforget() is not enough when we free the block; bh should
> be removed from the inode's list regardless of the ->b_count).

Agreed.  However, is there any reason to have this as a separate
function?  bforget() should _always_ remove the buffer from any inode
queue.  You can make that operation conditional on (bh->b_inode !=
NULL) if you want to avoid taking the lru lock unnecessarily.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
