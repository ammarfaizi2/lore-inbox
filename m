Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264278AbRFGBUI>; Wed, 6 Jun 2001 21:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264281AbRFGBT7>; Wed, 6 Jun 2001 21:19:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63483 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264278AbRFGBTm>;
	Wed, 6 Jun 2001 21:19:42 -0400
Date: Wed, 6 Jun 2001 21:19:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <3B1ED233.CCF2942D@gmx.de>
Message-ID: <Pine.GSO.4.21.0106062112340.10233-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Edgar Toernig wrote:

> Alexander Viro wrote:
> >         ...
> >         dir = open("/usr/local", O_DIRECTORY);
> >         /* error handling */
> >         new_mount(dir, MNT_SET, fs_fd); /* closes dir and fs_fd */
> 
> Do you really want to start using fds instead of strings for tree
> modifying commands (link, unlink, symlink, rename, mount and umount)?
> Even if it were possible in the new_mount case it wouldn't have the
> atomic lookup+act nature of the old mount.  And then, _I_ would
> prefer a uniform interface for tree management commands - strings.

You have exactly the same atomicity warranties. That is to say, none.
Mountpoint can be renamed between the lookup and mounting.

Moreover, even after mount(2) you can rename() parent of mountpoint. On
all Unices I've seen (well, aside of v7 which didn't have rename(2)).
So if you rely on anything of that kind - you are screwed. Portably
screwed, at that.

I would argue that mount(2) is seriously different from rename(2) and
friends, but even if your argument makes sense, it only makes sense for
"dir" argument. "device" is nothing but a filesystem-specific option.

