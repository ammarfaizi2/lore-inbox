Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRB1URj>; Wed, 28 Feb 2001 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRB1URa>; Wed, 28 Feb 2001 15:17:30 -0500
Received: from cs.columbia.edu ([128.59.16.20]:8605 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129216AbRB1URQ>;
	Wed, 28 Feb 2001 15:17:16 -0500
Date: Wed, 28 Feb 2001 12:17:13 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102281416460.7107-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0102281152210.15118-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Alexander Viro wrote:

> > And disadvantages: you can't have broken symlinks.
> > 
> > This actually turns out to be quite a bit of a problem when one tries
> > to use bind mounts with autofs. For one thing, it's perfectly legal
> > to have /autofs/foo as a symlink to /autofs/bar/foo, where /autofs/bar
> > is not yet mounted -- but a bind mount can't handle that...
> 
> First of all, you still have symlinks. 

Oh yeah, of course. :-)

> What's more, the right solution is to use local objects at the
> mountpoints. And forget about having a small tree full of links to
> real mountpoints. Think of autofs-with-one-node.

That's what Sun's autofs and am-utils call 'direct mounts', which are not 
yet supported by our autofs (unless I missed something recently). Direct 
mounts are good for some things, but not for everything. In particular, 
they are useless for cascading auto-triggered mounts (think 
/usr/local/src, /usr/local, and /usr, all automounted).

[and, btw, Linux _still_ doesn't properly support am-utils' direct mounts, 
although all that's needed is to remove LOOKUP_FOLLOW from path_init in 
sys_umount...]

As for bind mounts, I'll probably revisit them after I'm done with the 
Solaris autofs support in am-utils -- which will probably be a while. If I 
can get the thing to chain-trigger all the necessary mounts, we might be 
able to do something useful with it..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

