Return-Path: <linux-kernel-owner+w=401wt.eu-S1030242AbXAKIyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbXAKIyz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXAKIyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:54:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35617 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030238AbXAKIyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:54:54 -0500
Date: Thu, 11 Jan 2007 09:54:53 +0100
From: Jan Kara <jack@suse.cz>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Erez Zadok <ezk@cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070111085453.GC27059@atrey.karlin.mff.cuni.cz>
References: <20070109122644.GB1260@atrey.karlin.mff.cuni.cz> <200701091734.l09HYRHB009290@agora.fsl.cs.sunysb.edu> <20070110161215.GB12654@atrey.karlin.mff.cuni.cz> <20070110232054.GB5088@filer.fsl.cs.sunysb.edu> <45A576E7.1070808@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A576E7.1070808@cs.columbia.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Josef Sipek wrote:
> >On Wed, Jan 10, 2007 at 05:12:15PM +0100, Jan Kara wrote:
> >>  I see :). To me it just sounds as if you want to do remount-read-only
> >>for source filesystems, which is operation we support perfectly fine,
> >>and after that create union mount. But I agree you cannot do quite that
> >>since you need to have write access later from your union mount. So
> >>maybe it's not so easy as I thought.
> >>  On the other hand, there was some effort to support read-only 
> >>  bind-mounts of
> >>read-write filesystems (there were even some patches floating around but
> >>I don't think they got merged) and that should be even closer to what
> >>you'd need...
> >
> >Since the RO flag is per-mount point, how do you guarantee that no one is
> >messing with the fs? (I haven't looked at the patches that do per mount
> >ro flag, but this would require some over-arching ro flag - in the
> >superblock most likely.)
> 
> I thought about it, wrote an email, then cancelled it as it won't work.
> 
> what I thought was that you could a limited unionfs case would be with X 
> layers read-only and the top layer read-write, and what you would do is 
> dynamically make read only bind mounts for the the X layers and since 
> you control the top layer hide it from the system.
> 
> However, read only bind mounts are great if you want a limit a process 
> to accessing the files read-only, as they won't have access to the other 
> vfs_mounts, but it does nothing for the other vfs_mounts that are using 
> that same file system.  hence, does us no good.
  Right, you'd need to remount read-only all the mountpoints of one
filesystem. But if we had read-only bind-mounts, you could do such things
from userspace. It won't be 100% reliable (as it would be racy) but as a
basic protection against stupidity of admin it should work. And it would
be 100% safe against malicious intentions of average user (who has no
right to create new mountpoints).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
