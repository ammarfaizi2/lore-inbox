Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWFOGl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWFOGl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFOGl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:41:27 -0400
Received: from thunk.org ([69.25.196.29]:10385 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932449AbWFOGl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:41:26 -0400
Date: Thu, 15 Jun 2006 01:49:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: Nathan Scott <nathans@sgi.com>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615054931.GC7318@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Nathan Scott <nathans@sgi.com>,
	Nikita Danilov <nikita@clusterfs.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il> <20060614084155.C888012@wobbly.melbourne.sgi.com> <17551.58643.704359.815153@gargle.gargle.HOWL> <20060615075018.B884384@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615075018.B884384@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 07:50:19AM +1000, Nathan Scott wrote:
> As to whether a new inode operation is useful/needed - *shrug* - not
> really my call, I was saying we can work with whatever ends up being
> the final solution, provided it keeps per-inode granularity.

XFS should be return a per-inode value for st_blksize by simply setting
kstat->st_blksize in linvfs_getattr() found in fs/xfs/linux-2.6/xfs_iops.c.

In the inode diet patches that I'm working on, I've just deleted the
calls to set i_blksize in the XFS code, which will cause st_blksize to
default to PAGE_CACHE_SIZE (unless the filesystem overrides the value
found in sb->s_blksize).  I tried to figure out mind-twisting
conversion of the multiple data structures hanging off of each other
in the Irix/Linux compatibility layer (yuck, I still can't believe
this got into mainline), but since I didn't have the stomach for it,
I'll let the XFS maintainers decide how put in per-inode st_blksize
values --- but it is definitely doable.

Regards,

						- Ted
