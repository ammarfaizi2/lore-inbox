Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQL2Vo5>; Fri, 29 Dec 2000 16:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132322AbQL2Voq>; Fri, 29 Dec 2000 16:44:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130061AbQL2Vof>; Fri, 29 Dec 2000 16:44:35 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] filemap_fdatasync & related changes
Date: 29 Dec 2000 13:13:55 -0800
Organization: Transmeta Corporation
Message-ID: <92iuqj$vi$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <Pine.LNX.4.21.0012291446560.13194-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0012291446560.13194-100000@freak.distro.conectiva>,
Marcelo Tosatti  <marcelo@conectiva.com.br> wrote:
>
>Ok, here it is.
>
>I hope I got all locking and all special cases right.
>
>Comments ?

Looks good.

There's a few things this misses, the worst of which were all my bugs in
the original description.  Things like "don't unlock the page after
calling writepage, becasue writepage will do it on its own".  Details
like that. 

The worst problem actually ends up being the fact that the global sync()
doesn't work, after all, because if it's associated with syncing the
inodes it will only sync the dirty page list for inodes that are dirty. 
Now, this probably doesn't show up in testing, because mostly if you
have dirty pages the inode too _will_ be dirty, but that only makes the
bug more insidious. 

So I'll work on this a bit to polish up these problems, but on the whole
this is all fine.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
