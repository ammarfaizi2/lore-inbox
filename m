Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRAJPta>; Wed, 10 Jan 2001 10:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAJPtV>; Wed, 10 Jan 2001 10:49:21 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:45836 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129778AbRAJPtG>; Wed, 10 Jan 2001 10:49:06 -0500
Date: Wed, 10 Jan 2001 10:48:57 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
Message-ID: <169460000.979141737@tiny>
In-Reply-To: <Pine.GSO.4.21.0101092129380.11512-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 12:47:17 AM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> However, actual code really looks like the end of filldir(). If that's the
> case we are deep in it - argument of filldir() gets screwed. buf, that is.
> Since it happens after we've already done dereferencing of buf in
> filldir() and we don't trigger them... Fsck knows. copy_to_user() and
> put_user() should not be able to screw the kernel stack.
> 
In filldir, I don't like the line where we ((char *)dirent += reclen ;  If
reclen is much larger than the buffer sent from userspace, I don't see how
we stay in bounds.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
