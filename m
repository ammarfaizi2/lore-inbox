Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbQLEESG>; Mon, 4 Dec 2000 23:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbQLEER4>; Mon, 4 Dec 2000 23:17:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33994 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130552AbQLEERv>;
	Mon, 4 Dec 2000 23:17:51 -0500
Date: Mon, 4 Dec 2000 22:42:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012042232220.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Linus Torvalds wrote:

> 
> Ok, this contains one of the fixes for the dirty inode buffer list (the
> other fix is pending, simply because I still want to understand why it
> would be needed at all). Al?

See previous posting. BTW, -pre5 doesn't do the right thing in clear_inode().

Scenario: bh of indirect block is busy (whatever reason, flush_dirty_buffers(),
anything that can bump ->b_count for a while). ext2_truncate() frees the
thing and does bforget(). bh is left on the inode's list. Woops...

The minimal fix would be to make clear_inode() empty the list. IMO it's
worse than preventing the freed stuff from being on that list...

Comments?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
