Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286440AbRLTWiS>; Thu, 20 Dec 2001 17:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286432AbRLTWhj>; Thu, 20 Dec 2001 17:37:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4017 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286433AbRLTWhS>;
	Thu, 20 Dec 2001 17:37:18 -0500
Date: Thu, 20 Dec 2001 17:37:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [OT] util-linux-2.11n
In-Reply-To: <UTC200112202219.WAA32267.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0112201723100.15555-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Dec 2001 Andries.Brouwer@cwi.nl wrote:

> >> Very off-topic: FSF promotes free software, but produces
> >> message translation files with header
> >>   # Copyright (C) 2001 Free Software Foundation, Inc.
> >> and without any indication that these files can be freely
> >> modified and distributed. No GPL or anything. Very unfree.
> 
> > Ask RMS... and he is likely to fix that.
> 
> I did.  You may well be right.  We'll see.

ObMount: now that MS_MOVE is in 2.5 (and submitted for merge in 2.4)
mount --move <oldpath> <newpath> would be nice...

Effect of mount(old, new, NULL, MS_MOVE, NULL): subtree mounted at
"old" is taken to "new". Move is atomic and takes all references
to objects in a subtree with it - opened files, current directories,
etc.  Requires CAP_SYS_ADMIN.

Errors:
	requires CAP_SYS_ADMIN (EPERM)
	old and new must exist (ENOENT)
	old must be a mountpoint (EINVAL)
	new must not be a descendent of old (ELOOP)
	old must not be the absolute root (EINVAL)
	if old is directory new must be a directory and vice versa (EINVAL)
+ usual set of errors from lookups for old and new (EFAULT if either
is not a valid address, ENOTDIR if component in the middle is not a
directory, ELOOP if too many links, EACCES if no execute permissions
on some component in the middle, ENOMEM if someone's out of memory, EIO
if fs feels like that, etc. - the usual)

