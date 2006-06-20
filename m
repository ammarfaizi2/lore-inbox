Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWFTM3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWFTM3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWFTM3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:29:49 -0400
Received: from thunk.org ([69.25.196.29]:36244 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965056AbWFTM3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:29:48 -0400
Date: Tue, 20 Jun 2006 08:29:52 -0400
From: Theodore Tso <tytso@mit.edu>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060620122952.GB26030@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Steven Whitehouse <steve@chygwyn.com>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.418349000@candygram.thunk.org> <1150796596.3856.1333.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150796596.3856.1333.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 10:43:16AM +0100, Steven Whitehouse wrote:
> As a further suggestion, I wonder do we really need i_private at all?
> Since we have sb->s_op->alloc_inode and inode->i_sb->s_op->destroy_inode
> if all filesystems did something along the following lines:
> 
> struct myfs_inode {
> 	struct inode i_inode;
> 	...
> };
> 
> #define MYFS_I(inode) container_of((inode), struct myfs_inode, i_inode)

That would work for filesystems but we would also need some solution
for device inodes.  (And at that point, yes, we could move it into
device-specific union, but as I've already noted, that doesn't buy us
anything currently.)

It's worth thinking about, but for that amount of effort it might be
have better ROI to work on moving the address space out of the inode
given that many/most inodes in memory are caching stat information,
not pages.

						- Ted
