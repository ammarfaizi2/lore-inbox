Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135996AbRAJRjH>; Wed, 10 Jan 2001 12:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135972AbRAJRi6>; Wed, 10 Jan 2001 12:38:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58532 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135994AbRAJRir>;
	Wed, 10 Jan 2001 12:38:47 -0500
Date: Wed, 10 Jan 2001 12:38:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
In-Reply-To: <169460000.979141737@tiny>
Message-ID: <Pine.GSO.4.21.0101101229050.13614-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Chris Mason wrote:

> 
> 
> On Wednesday, January 10, 2001 12:47:17 AM -0500 Alexander Viro
> <viro@math.psu.edu> wrote:
> 
> > However, actual code really looks like the end of filldir(). If that's the
> > case we are deep in it - argument of filldir() gets screwed. buf, that is.
> > Since it happens after we've already done dereferencing of buf in
> > filldir() and we don't trigger them... Fsck knows. copy_to_user() and
> > put_user() should not be able to screw the kernel stack.
> > 
> In filldir, I don't like the line where we ((char *)dirent += reclen ;  If
> reclen is much larger than the buffer sent from userspace, I don't see how
> we stay in bounds.

	So? copy_to_user() and put_user() will refuse to scramble the
kernel memory. IOW, dirent can be out of the userspace. Hell, user could
call getdents() and pass it a kernel pointer. Try it and you'll see what
happens.

	BTW, in that particular line we are actually even protected from
getting too large dirent, since if the sum was out of the user space we
would die several lines above upon copy_to_user().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
