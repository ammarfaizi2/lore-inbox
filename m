Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272577AbRIKVmR>; Tue, 11 Sep 2001 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272579AbRIKVmI>; Tue, 11 Sep 2001 17:42:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16397 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272577AbRIKVls>; Tue, 11 Sep 2001 17:41:48 -0400
Date: Tue, 11 Sep 2001 23:42:05 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: vs@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Freeing inode
Message-ID: <20010911234205.A9108@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010907193935.A5166@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0109111456160.28376-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0109111456160.28376-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 11, 2001 at 03:01:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> >   Vladimir pointed me to another bug in ext2 quota allocation. The problem is
> > that when inode is being created but creation fails (either from user being
> > over quota or from some other reason) then quota is decremented incorrectly
> > (previously the usual case when user is over quota was handled by DQUOT_DROP()
> > but this works no more because of DQUOT_INIT() in iput() and ext2_free_inode()).
> >   I made a patch which marks inode as bad and then quota is not initialized on
> > bad inodes (which makes sence anyway). The patch which is attached is just preliminary
> > and nontested (just now I'm realizing that inode being marked as bad might be
> > dirty which is not probably the best combination). I'd just like to know whether
> > this approach is ok with you or whether you have some better ideas.
> 
> I think I have a better approach - grab quota before everything else in
> ext2_new_inode() and explicitly release the leftovers in the end.  That
> way we simply do not call ext2_free_inode() - if we got to allocation
> we are done.
  But to allocate a quota I need an inode with proper owner & superblock. If I have
inode I have to put it with iput() if allocation fails -> ext2_free_inode() will be
called unless we play some dirty tricks. Am I missing something?

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
