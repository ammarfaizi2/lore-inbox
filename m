Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265525AbSKAAmI>; Thu, 31 Oct 2002 19:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265533AbSKAAli>; Thu, 31 Oct 2002 19:41:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1152 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265525AbSKAAke>;
	Thu, 31 Oct 2002 19:40:34 -0500
Date: Thu, 31 Oct 2002 17:46:22 -0800
From: Bob Miller <rem@osdl.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.45] Export blkdev_ioctl for raw block driver.
Message-ID: <20021031174622.A1185@doc.pdx.osdl.net>
References: <20021031165719.A26498@doc.pdx.osdl.net> <Pine.GSO.4.21.0210311909010.16688-100000@weyl.math.psu.edu> <20021031172007.A28402@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031172007.A28402@doc.pdx.osdl.net>; from rem@osdl.org on Thu, Oct 31, 2002 at 05:20:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 05:20:07PM -0800, Bob Miller wrote:
> On Thu, Oct 31, 2002 at 07:11:19PM -0500, Alexander Viro wrote:

Stuff deleted...

> > Why not use ioctl_by_bdev() in the first place?  (and yes, it's very likely
> > my fault - I hadn't realized that raw.c went modular at some point).
> Didn't know about ioctl_by_bdev()... I'll make a patch that converts
> the raw driver to call it instead of blkdev_ioctl().
> 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.869   -> 1.870  
#	  drivers/char/raw.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	rem@doc.pdx.osdl.net	1.870
# Changed raw driver to call ioctl_by_bdev() instead of
# blkdev_ioctl() so that it will build as a module.
# --------------------------------------------
#
diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Thu Oct 31 17:34:56 2002
+++ b/drivers/char/raw.c	Thu Oct 31 17:34:56 2002
@@ -95,7 +95,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+	return ioctl_by_bdev(bdev, command, arg);
 }
 
 /*
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
