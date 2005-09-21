Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVIUIfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIUIfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIUIfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:35:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17060 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750749AbVIUIfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:35:40 -0400
Date: Wed, 21 Sep 2005 09:35:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Linus Torvalds <torvalds@osdl.org>,
       Ray Lee <ray@madrabbit.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921083525.GB27254@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
References: <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org> <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex> <20050921023601.GT7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921023601.GT7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 03:36:01AM +0100, Al Viro wrote:
> On Tue, Sep 20, 2005 at 09:41:47PM -0400, John McCutchan wrote:
> > I grepped all the filesystems
> 
> ... in the tree
> 
> > , and they all seem to use
> > generic_drop_inode, except for hugetlbfs, which seems to have the same
> > logic of (!inode->i_nlink).
> 
> I have no problems with killing ->drop_inode(), but that should be
> 	a) done for in-tree filesystems
> 	b) announced on fsdevel, so that out-of-tree folks could deal
> with that
> 	c) given at least one release to avoid screwing them.
> 
> Christoph, could you send the patch you've mentioned?  I'd rather avoid
> duplicating what you've done...

sure.  Note that clusterfs folks (ocfs2 in particular) really want
->drop_inode because they need additional checks instead of just the
nlink one in there.  While hugetlbfs should just go away ->drop_inode
makes some sense for them.

