Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVIUJRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIUJRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVIUJRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:17:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11206 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750760AbVIUJRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:17:44 -0400
Date: Wed, 21 Sep 2005 10:17:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921091738.GA28289@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
References: <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex> <20050921023601.GT7992@ftp.linux.org.uk> <20050921083525.GB27254@infradead.org> <20050921091524.GG26425@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921091524.GG26425@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:15:24AM -0700, Joel Becker wrote:
> 	My apologies for not having read the inotify thread, I'll go
> look in the morning.
> 	In ->drop_inode(), OCFS2 takes care of noticing that nlink has
> been changed by a remote node.  This is necessary for
> generic_drop...delete operation to proceed.
> 	If OCFS2 had to go back to the 2.4 method of checking i_count==1
> in ->put_inode(), I'm not sure we're allowed to modify i_nlink there
> unlocked, are we?
> 	I also think we had some sort of race with inode_lock that
> ->drop_inode() avoids, but I'm not sure.  Mark?

The real fix would be to put an equivalent of OCFS2_INODE_MAYBE_ORPHANED
into struct inode.  That way it could be shared by other clustered
filesystems aswell, and OCFS2 had no need to implement ->drop_inode.

I'm pretty sure I dicussed that with either Mark or Zab.

