Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130865AbQLEEX6>; Mon, 4 Dec 2000 23:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQLEEXt>; Mon, 4 Dec 2000 23:23:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26130 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130865AbQLEEXl>; Mon, 4 Dec 2000 23:23:41 -0500
Date: Mon, 4 Dec 2000 19:52:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <Pine.GSO.4.21.0012042211310.7166-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012041945470.860-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Alexander Viro wrote:
> 
> Well, to start with you don't want random bh's floating around on the
> inode's list. With the current code truncate()+fsync() can send a lot
> of already freed stuff to disk. Even though we can survive that (making
> clear_inode() to get rid of the list will save you from corruption)...
> it doesn't look like a good idea.

Now, I'll agree with that, certainly. 

I just wanted to be clear on the purpose of the patches. The bforget() one
looks like "taking care of the details", but not like a bug-fix. Agreed?

(Which is not to say I won't apply it - I just want to make sure we have
the issues under control).

> BTW, in the current form clear_inode() doesn't get rid of the dirty
> buffers. It misses the pages that became anonymous and it misses the
> metadata that became freed. We can do that, but I'ld rather avoid
> leaving these buffer_heads on the inode's list - stuff that got freed
> has no business to be accessible from in-core inode.

Again, I agree with you, but it looks like that is a cleanup issue rather
than a bug.

> > I think that the second patch from Al (the inode dirty meta-data) is the
> > _real_ fix, and I don't see why the bforget changes should matter.
> 
> We can survive without them (modulo patch to clear_inode()), but...

The "patch to clean-inode" is the one I already did from sct? Or are we
talking about another issue?

> BTW, there is another reason why we want to have separate function
> for freeing the stuff: we may want to mark them clean. If they are
> already under IO it will do nothing, but if they are merely dirty...

Yes. Make it so. In the meantime, does everybody agree that pre5 fixes the
bugs, even though it still has these discussion items left?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
