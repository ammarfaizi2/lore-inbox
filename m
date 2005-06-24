Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVFXFwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVFXFwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVFXFwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:52:50 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:40965 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263131AbVFXFue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:50:34 -0400
To: tytso@mit.edu
CC: miklos@szeredi.hu, akpm@osdl.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
In-reply-to: <20050623233431.GB6485@thunk.org> (message from Theodore Ts'o on
	Thu, 23 Jun 2005 19:34:31 -0400)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622170135.GB18544@thunk.org> <E1Dl9LG-0007xP-00@dorka.pomaz.szeredi.hu> <20050623233431.GB6485@thunk.org>
Message-Id: <E1Dlh4Y-0001zv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Jun 2005 07:49:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On the other hand, sometimes a root process, or some other user's
> > > process, might _want_ to give permission to allow a trusted FUSE
> > > filesystem the potential to monkey with it (return potentially
> > > untrusted information, or stop it entirely), in exchange for access to
> > > the filesystem.  So it would be nice if there was some way that a
> > > process could tell the kernel that it is willing to give permission to
> > > allow certain FUSE filesystems to potentially affect it.  Say, via a
> > > fnctl() call, perhaps.
> > 
> > Hmm.  'su' works for root.  
> 
> ??  Not sure what you're saying.

If user X mounts a filesystem, and root wants to access it, it can do
'su X' and see the otherwise inaccesible files.

> > How do you think fcntl() could be used?  I think a task flag settable
> > via prctl() would be more appropriate.
> 
> The problem with a task flag is that a root process might not want to
> give permission for _all_ user-mountable filesystem, but only certain
> ones.  So the idea is that the process should be able to specify
> specific mountpoints as being "ok" for the process to access.

OK, so you're saying, it should be a per-mountpoint flag, and not a
per-process one.

Then the solution is simple I think.  Root can just remount the
filesystem with the 'allow_other' flag (that's currently not possible,
because the remount_fs operation is not yet implemented).

Thanks,
Miklos
