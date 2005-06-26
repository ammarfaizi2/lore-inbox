Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFZDGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFZDGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 23:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFZDGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 23:06:31 -0400
Received: from THUNK.ORG ([69.25.196.29]:47046 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261509AbVFZDEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 23:04:45 -0400
Date: Sat, 25 Jun 2005 23:04:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050626030426.GA28616@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, pavel@ucw.cz,
	linux-kernel@vger.kernel.org
References: <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622170135.GB18544@thunk.org> <E1Dl9LG-0007xP-00@dorka.pomaz.szeredi.hu> <20050623233431.GB6485@thunk.org> <E1Dlh4Y-0001zv-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dlh4Y-0001zv-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 07:49:50AM +0200, Miklos Szeredi wrote:
> > ??  Not sure what you're saying.
> 
> If user X mounts a filesystem, and root wants to access it, it can do
> 'su X' and see the otherwise inaccesible files.

That's rather awkward, and will be painful in certain applications
that are trying to scan multiple filesystems, possibly run by
different users X, Y, and Z.

> > > How do you think fcntl() could be used?  I think a task flag settable
> > > via prctl() would be more appropriate.
> > 
> > The problem with a task flag is that a root process might not want to
> > give permission for _all_ user-mountable filesystem, but only certain
> > ones.  So the idea is that the process should be able to specify
> > specific mountpoints as being "ok" for the process to access.
> 
> OK, so you're saying, it should be a per-mountpoint flag, and not a
> per-process one.

No, I'm saying that it should be both per-mountpoint and per-process.
Hence something like fnctl.  Problem is though fnctl() works on a file
descriptor, and with FUSE running you wouldn't be able to even get a
file descriptor opened on the mountpoint.  

> Then the solution is simple I think.  Root can just remount the
> filesystem with the 'allow_other' flag (that's currently not possible,
> because the remount_fs operation is not yet implemented).

Globally remounting the filesystem allow_other isn't the right thing,
since applications that don't know what to expect will be taken by
surprise.  Hence my suggestion to do something which is both
per-mountpoint and per-process.

						- Ted
