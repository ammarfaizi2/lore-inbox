Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLFAay>; Tue, 5 Dec 2000 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbQLFAao>; Tue, 5 Dec 2000 19:30:44 -0500
Received: from zeus.kernel.org ([209.10.41.242]:41988 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129524AbQLFAaj>;
	Tue, 5 Dec 2000 19:30:39 -0500
Date: Tue, 5 Dec 2000 23:15:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
Message-ID: <20001205231504.I10663@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012051144060.2178-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012051502140.12284-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0012051502140.12284-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Dec 05, 2000 at 03:17:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 05, 2000 at 03:17:07PM -0500, Alexander Viro wrote:
> 
> 
> On Tue, 5 Dec 2000, Linus Torvalds wrote:
> 
> > And this is not just a "it happens to be like this" kind of thing. It
> > _has_ to be like this, because every time we call clear_inode() we are
> > going to physically free the memory associated with the inode very soon
> > afterwards. Which means that _any_ use of the inode had better be long
> > gone. Dirty buffers included.
> 
> Urgh. Linus, AFAICS we _all_ agree on that. The only real question is
> whether we consider calling clear_inode() with droppable dirty buffers
> to be OK. It can't happen on the dispose_list() path and I'ld rather
> see it _not_ happening on the delete_inode() one. It's a policy question,
> not the correctness one.

Right, because if we get this wrong, the kernel won't complain, but
we'll have a rare, impossible-to-diagnose potential data corrupter for
any applications which do recovery on reboot.  

If we're not going to change the code, then at the very least a huge
warning comment above clear_inode() is necessary to make it explicit
that you shouldn't ever pass in an inode with dirty buffers unless
nlink==0, and I'd rather see the BUG there instead.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
