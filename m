Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSC1XwV>; Thu, 28 Mar 2002 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSC1XwB>; Thu, 28 Mar 2002 18:52:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5362 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313304AbSC1Xv7>;
	Thu, 28 Mar 2002 18:51:59 -0500
Date: Thu, 28 Mar 2002 18:51:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA356AE.2E61F712@zip.com.au>
Message-ID: <Pine.GSO.4.21.0203281838310.25746-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Mar 2002, Andrew Morton wrote:

> > For one thing, the latter is hell on any search.
> 
> If the usage of the type is hard to search for then
> then wrong identifier was chosen.

Huh?

Search for ext2_sb_info will give you all places that refer to it.
Including a buttload of
	struct ext2_sb_info *p;

Now, search for ext2_sb_info[ 	]*[^ 	*] is much more interesting.
With explicit sizeof it is guaranteed to give you all places where
such beast is allocated or subjected to memset, etc.

In this case it's not too interesting.  But try it for struct super_block
or struct dentry or struct buffer_head, etc. - anything that is widely
used.
 
> (and I think this is something on which you and I somewhat
> differ) code should be written for the convenience of others,
> not the original author.

Ahem.  Right now I'm digging through the <expletives> known as lvm.c
trying to fix the use of kdev_t in ioctls.  Believe me, I'm _not_
the original author.  "Where the heck do they initialize <field>" is
the question I've to deal with all the time and I'd rather have it
(along with "where the heck do they allocate and free their monsters")
as greppable as possible.

BTW, I _really_ wonder who had audited lvm.c for inclusion - quite a
few places in there pull such lovely stunts as, say it, use of strcmp()
on a user-supplied array of characters.  Whaddya mean, "what if there's
no NUL"?  Sigh...

