Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278338AbRJ1NPw>; Sun, 28 Oct 2001 08:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJ1NPm>; Sun, 28 Oct 2001 08:15:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17388 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278354AbRJ1NPh>;
	Sun, 28 Oct 2001 08:15:37 -0500
Date: Sun, 28 Oct 2001 08:16:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Richard Gooch <rgooch@atnf.csiro.au>, Rik van Riel <riel@conectiva.com.br>,
        Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <3BDBF9C8.8E1F96AB@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0110280805220.24880-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Oct 2001, Roman Zippel wrote:

> What about putting them somewhere in a CVS repository, so people can see
> what's going on and maybe even can help out?

Looks like I'll get around to creating a CVS repository starting at the
last known code in a couple of days anyway...

> BTW you should really do something about your coding style, your code is
> very confusing to read. I wouldn't care if it would be just some driver,
> but devfs is supposed to be a very important part, so it would be nice
> to use the same rules that apply to other important parts of the kernel.

Good luck.

BTW, Richard - the last one for tonight:

devfs_unregister() vs. get_vfs_inode().  The latter blocks, so devfs_lookup()
and devfs_d_revalidate() can give you a nasty surprise - entry gets
unregistered while we allocate the inode and there's no connection between
it and inode or dentry at that point.  Then we merrily get dentry/inode
tied to unregistered devfs_entry.  And that includes reference _to_ dentry.
Enjoy...

