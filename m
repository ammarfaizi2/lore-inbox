Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTLSOOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 09:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLSOOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 09:14:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11147 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262324AbTLSOOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 09:14:21 -0500
Date: Fri, 19 Dec 2003 15:14:20 +0100
From: Jan Kara <jack@suse.cz>
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: ext3 truncate bug in 2.6.0?
Message-ID: <20031219141420.GA21129@atrey.karlin.mff.cuni.cz>
References: <20031218210713.GA21777@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20031218210713.GA21777@ping.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  it seems there's really a problem - does attached patch fix it?

								Honza

> When writing to the file, and the filesystem (ext3) is full, it
> seems to block count gets wrong.
> 
> I ran an e2fsck on the fs and found no problems.  Then I mounted
> it again, wrote a file until the fs was full, unmounted and ran
> e2fsck again, and get this:
> 
> e2fsck 1.32 (09-Nov-2002)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 276481, i_blocks is 681584, should be 681582.  Fix<y>?
> 
> If my memory is any good, their was a simular problem in 2.4
> once.
> 
> I'm testing this with 2.6.0-test11, but couldn't find anything in
> the changelog for 2.6.0.
> 
> 
> Kurt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="balloc.c.diff"

--- linux/fs/ext3/balloc.c	Fri Dec 19 15:09:19 2003
+++ linux/fs/ext3/balloc.c	Fri Dec 19 15:10:18 2003
@@ -517,7 +517,7 @@
 		sbi->s_resuid != current->fsuid &&
 		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
 		*errp = -ENOSPC;
-		return 0;
+		goto out;
 	}
 
 	/*

--T4sUOijqQbZv57TR--
