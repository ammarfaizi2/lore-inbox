Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSJSSaV>; Sat, 19 Oct 2002 14:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265651AbSJSSaV>; Sat, 19 Oct 2002 14:30:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265649AbSJSSaU>; Sat, 19 Oct 2002 14:30:20 -0400
Date: Sat, 19 Oct 2002 20:36:23 +0200
From: Jan Kara <jack@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Message-ID: <20021019183623.GA22273@atrey.karlin.mff.cuni.cz>
References: <E181a3S-0006Nq-00@snap.thunk.org> <aojc1q$l37$1@forge.intermeta.de> <20021016161620.GC8210@think.thunk.org> <20021016170539.GA1201@clusterfs.com> <20021016193001.GB1335@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016193001.GB1335@think.thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 16, 2002 at 11:05:39AM -0600, Andreas Dilger wrote:
> > Err, wouldn't that be a 2TB FILE limit, and not a FILESYSTEM limit?
> 
> Yes, sorry about that.
> 
> I just took a quick look at this, and the limit is unfortunately
> fundamental to the VFS; the st_blocks in struct inode and struct kstat
> is an unsigned long, which means that we're stuck with the 2TB limit
> for *all* filesystems, even using the LFS API.  (Or rather, as you
> point out, since no one apparently is doing any overflow checking, so
> st_blocks will just be incorrect, even to callers using the stat64
> call.)
> 
> A quick fix would be to make st_blocks in struct inode and struct
> kstat take a __u64 instead of a unsigned long, but it will have a
> performance impact.  What do folks think?
  I'd vote for it. And also for storing used space in bytes - then you
  can remove i_bytes field quota is using from inode and inode_set_bytes,
  inode_add_bytes and such inline functions from fs.h ...

  								Honza
  
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
