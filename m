Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKDSTw>; Mon, 4 Nov 2002 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSKDSTw>; Mon, 4 Nov 2002 13:19:52 -0500
Received: from [198.149.18.6] ([198.149.18.6]:65516 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262620AbSKDSTv>;
	Mon, 4 Nov 2002 13:19:51 -0500
Subject: Re: [2.5.45] Unable to umount XFS filesystems
From: Steve Lord <lord@sgi.com>
To: kronos@kronoz.cjb.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021102151320.GA308@dreamland.darkstar.net>
References: <20021102151320.GA308@dreamland.darkstar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 12:25:08 -0600
Message-Id: <1036434308.23501.16.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 09:13, Kronos wrote:
> Hi,
> with kernel  2.5.45 I'm  unable to unmount  XFS filesystems. 'umount' is
> blocked in D state:
> 

Here is the fix for this hang.

Steve

===========================================================================
Index: linux/fs/xfs/xfs_vfsops.c
===========================================================================

--- /usr/tmp/TmpDir.27770-0/linux/fs/xfs/xfs_vfsops.c_1.390	Mon Nov  4 12:20:05 2002
+++ linux/fs/xfs/xfs_vfsops.c	Mon Nov  4 12:18:52 2002
@@ -592,8 +592,6 @@
 	rvp->v_flag |= VPURGE;			/* OK for vn_purge */
 	VN_RELE(rvp);
 
-	vn_remove(rvp);
-
 	/*
 	 * If we're forcing a shutdown, typically because of a media error,
 	 * we want to make sure we invalidate dirty pages that belong to

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
