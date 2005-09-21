Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVIUJQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVIUJQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIUJQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:16:21 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:14194 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1750787AbVIUJQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:16:20 -0400
Date: Wed, 21 Sep 2005 02:15:24 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921091524.GG26425@ca-server1.us.oracle.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
References: <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex> <20050921023601.GT7992@ftp.linux.org.uk> <20050921083525.GB27254@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921083525.GB27254@infradead.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 09:35:25AM +0100, Christoph Hellwig wrote:
> On Wed, Sep 21, 2005 at 03:36:01AM +0100, Al Viro wrote:
> > I have no problems with killing ->drop_inode(), but that should be
> > 	a) done for in-tree filesystems
> > 	b) announced on fsdevel, so that out-of-tree folks could deal
> > with that
> > 	c) given at least one release to avoid screwing them.
> 
> sure.  Note that clusterfs folks (ocfs2 in particular) really want
> ->drop_inode because they need additional checks instead of just the
> nlink one in there.  While hugetlbfs should just go away ->drop_inode
> makes some sense for them.

	My apologies for not having read the inotify thread, I'll go
look in the morning.
	In ->drop_inode(), OCFS2 takes care of noticing that nlink has
been changed by a remote node.  This is necessary for
generic_drop...delete operation to proceed.
	If OCFS2 had to go back to the 2.4 method of checking i_count==1
in ->put_inode(), I'm not sure we're allowed to modify i_nlink there
unlocked, are we?
	I also think we had some sort of race with inode_lock that
->drop_inode() avoids, but I'm not sure.  Mark?

Joel

-- 

"For every complex problem there exists a solution that is brief,
     concise, and totally wrong."
                                        -Unknown

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
