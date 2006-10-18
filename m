Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWJROZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWJROZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWJROZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:25:39 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:7863 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932194AbWJROZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:25:38 -0400
Date: Wed, 18 Oct 2006 10:25:12 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
Message-ID: <20061018142512.GA16570@think.oraclecorp.com>
References: <20061013143516.15438.8802.sendpatchset@linux.site> <20061013143616.15438.77140.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013143616.15438.77140.sendpatchset@linux.site>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c
> +++ linux-2.6/fs/buffer.c
> @@ -1856,6 +1856,9 @@ static int __block_commit_write(struct i
>  	unsigned blocksize;
>  	struct buffer_head *bh, *head;
>  
> +	if (from == to)
> +		return 0;
> +
>  	blocksize = 1 << inode->i_blkbits;

reiserfs v3 copied the __block_commit_write logic for checking for a
partially updated page, so reiserfs_commit_page will have to be updated
to handle from==to.  Right now it will set the page up to date.

I also used a prepare/commit pare where from==to as a way to trigger
tail conversions in the lilo ioctl.  I'll both for you and make a
patch.

-chris
