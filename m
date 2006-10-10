Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWJJMTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWJJMTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWJJMTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:19:55 -0400
Received: from thunk.org ([69.25.196.29]:53181 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965155AbWJJMTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:19:53 -0400
Date: Tue, 10 Oct 2006 08:19:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-ID: <20061010121950.GA25809@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061010000928.9d2d519a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:09:28AM -0700, Andrew Morton wrote:
> 
> - Added the ext4 filesystem.  Quick usage instructions:
> 
>   - Grab updated e2fsprogs from
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/
> 
>   - It's still mke2fs -j /dev/hda1
> 
>   - mount /dev/hda1 /wherever -t ext4dev
> 
>   - To enable extents,
> 
> 	mount /dev/hda1 /wherever -t ext4dev -o extents

Looks like you didn't take the updated patch from Shaggy which
requires that you use tune2fs -O extents first?  (This requires the
e2fsprogs-interim patches.)

The plan is that mount -o extents is not going to be the long-term way
that extents will be enabled.  I can imagine a -o noextents option,
which might be used with remount to do an on-line rollback from
extents to non-extents, but normally you shouldn't need to use a mount
option to enable a feature that are filesystem format-related.  Those
should be implied by the appropriate flags in the superblock.

Mount -o nobh is a different story, since that's just a implementation
detail --- although for ext4, maybe we should just make nobh a
default, since that way more people will test it and hopefully,
eventually nobh will be the only way of doing things, right?

>     Making the journal larger than the mke2fs default often helps
>     performance with metadata-intensive workloads.

The default was increased significantly in e2fsprogs 1.40; if someone
who has their favorite metadata-intesive benchmark could test and see
if we should be using even larger defaults for certain "mke2fs -T 
<workload-type>" configurations, I'd really appreciate it.

					- Ted
