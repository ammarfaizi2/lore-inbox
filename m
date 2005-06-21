Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVFUPbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVFUPbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFUPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:31:06 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41127 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262128AbVFUP0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:26:49 -0400
Message-ID: <42B831B4.9020603@pobox.com>
Date: Tue, 21 Jun 2005 11:26:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org>
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> git-ocfs
> 
>     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
>     review.

Every time I come up with a complaint about ocfs2, the Oracle guys 
manage to shoot me down.  I think it's OK to merge.


> sparsemem
> 
>     OK by me for a merge.  Need to poke arch maintainers first, check that
>     they've looked at it sufficiently closely.

seems sane, though there are some whitespace niggles that should be 
cleaned up


> rapidio-*
> 
>     Will merge.

send through netdev, as is proper


> dlm-*.patch: Red Hat distributed lock manager
> 
>     Hard.  Right now it seems that no in-kernel projects will use this and
>     only one out-of-kernel project will use it.  Shelve the problem until
>     after Kernel Summit, where some light may be shed.
> 
>     Opinions are sought...

I hate to say it, since its my own employer, but I agree:  wait for 
in-kernel users, at the very least.


> connector.patch
> 
>     Nice idea IMO, but there are still questions around the
>     implementation.  More dialogue needed ;)
> 
> connector-add-a-fork-connector.patch
> 
>     OK, but needs connector.

I don't like connector


> inotify
> 
>     There are still concerns about the userspace API and internal
>     implementation details.  More slogging needed.

We should ask hpa what he needs for kernel.org.  Ideally kernel.org 
probably wants <something> that facilitates listening to <something> for 
a list of files being changed.  That would greatly speed up the robots, 
and possibly rsync-like activities too.


> pcmcia-*.patch
> 
>     Makes the pcmcia layer generate hotplug events and deprecates cardmgr.
>     Will merge.

Testing?  The goal behind the patch is certainly good, but I worry about 
exposure.


> cachefs
> 
>     This is a ton of code which knows rather a lot about pagecache
>     internals.  It allows the AFS client to cache file contents on a local
>     blockdev.
> 
>     I don't think it's a justified addition for only AFS and I'd prefer to
>     see it proven for NFS as well.
> 
>     Issues around add-page-becoming-writable-notification.patch need to
>     be resolved.
> 
> cachefs-for-nfs
> 
>     A recent addition.  Needs review from NFS developers and considerably
>     more testing.
> 
>     These things aren't looking likely for 2.6.13.

If I could vote more than once, I would!  I really like cachefs, and 
have been pushing for its inclusion for a while.


> kexec and kdump
> 
>     I guess we should merge these.
> 
>     I'm still concerned that the various device shutdown problems will
>     mean that the success rate for crashing kernels is not high enough for
>     kdump to be considered a success.  In which case in six months time we'll
>     hear rumours about vendors shipping wholly different crashdump
>     implementations, which would be quite bad.
> 
>     But I think this has gone as far as it can go in -mm, so it's a bit of
>     a punt.

I'm not particularly pleased with these, and indeed vendors ARE shipping 
other crashdump methods.


> reiser4
> 
>     Merge it, I guess.
> 
>     The patches still contain all the reiser4-specific namespace
>     enhancements, only it is disabled, so it is effectively dead code.  Maybe
>     we should ask that it actually be removed?

The plugin stuff is crap.  This is not a filesystem but a filesystem + 
new layer.  IMO considered in that light, it duplicates functionality 
elsewhere.


> v9fs
> 
>     I'm not sure that this has a sufficiently high
>     usefulness-to-maintenance-cost ratio.

agreed (though I think 9P is neat)


>       It has been said that a userspace NFS server can be used to get
>       full NFS server functionality with FUSE.  I think the half-assed kernel
>       implementation should be done away with.

"It has been said" -- its true.  A userspace NFS server can do 100% of 
userspace FS functionality.

	Jeff


