Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157209AbPI3NYR>; Thu, 30 Sep 1999 09:24:17 -0400
Received: by vger.rutgers.edu id <S157153AbPI3NYF>; Thu, 30 Sep 1999 09:24:05 -0400
Received: from dukat.scot.redhat.com ([195.89.149.246]:1138 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S157160AbPI3NXu>; Thu, 30 Sep 1999 09:23:50 -0400
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14323.25688.156773.889175@dukat.scot.redhat.com>
Date: Thu, 30 Sep 1999 14:23:36 +0100 (BST)
To: Chuck Lever <cel@monkey.org>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com, Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] Re: Solaris 100K TCP connections, good example?  was:[Fwd: [Fwd:
In-Reply-To: <Pine.BSO.4.10.9909291443200.25236-100000@funky.monkey.org>
References: <Pine.GSO.4.10.9909291352400.23883-100000@stokes.math.psu.edu> <Pine.BSO.4.10.9909291443200.25236-100000@funky.monkey.org>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Wed, 29 Sep 1999 15:30:29 -0400 (EDT), Chuck Lever <cel@monkey.org> said:

> one of the difficulties i had understanding this code is the seeming
> interchangeability of the terms "unused" and "free".  there are more
> than simply the three states alluded to in the block comment at the
> top of fs/inode.c:

> 4.  zero count fs inode -- it's hashed, and on the in_use list, but
>       is a target for reclamation if i_nrpages is zero (*)

> (*) since it's use count is zero, it can also be said that this type of
> inode is "unused."

No, these inodes are not necessarily unused.  The page cache does not
count as a user on the inode's i_count field, but it does count against
the i_nrpages field.  That's why the CAN_UNUSE macro reads as

#define CAN_UNUSE(inode) \
	(((inode)->i_count | (inode)->i_state | (inode)->i_nrpages) == 0)

An inode with zero i_count may also be dirty, and hence still contain
important state.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
