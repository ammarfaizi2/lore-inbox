Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSDSEpu>; Fri, 19 Apr 2002 00:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314549AbSDSEpt>; Fri, 19 Apr 2002 00:45:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5012 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314546AbSDSEps>;
	Fri, 19 Apr 2002 00:45:48 -0400
Date: Fri, 19 Apr 2002 00:45:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/6) alpha fixes
Message-ID: <Pine.GSO.4.21.0204190037400.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Contents:
1)	bogus return value type for ->open() and ->release() on nfsd
(generic, caught on alpha since there ssize_t != int)

2)	missing defines/fields/includes for alpha (accumulated since 2.5.0)

3)	s/p_pptr/parent/, s/p_opptr/real_parent/ done for alpha

4)	(dumb) default_idle() provided (alpha)

5)	alpha/mm/init.c forgot to set max_pfn

6)	fixed off-by-PAGE_OFFSET in populate_pmd() (alpha, again)

	With that patchset the thing builds, boots and seems to be working
(on AS200).

diff -urN C8/fs/nfsd/nfsctl.c C8-nfsctl/fs/nfsd/nfsctl.c
--- C8/fs/nfsd/nfsctl.c	Sun Apr 14 17:53:09 2002
+++ C8-nfsctl/fs/nfsd/nfsctl.c	Thu Apr 18 23:21:29 2002
@@ -98,13 +98,13 @@
 	return size;
 }
 
-static ssize_t TA_open(struct inode *inode, struct file *file)
+static int TA_open(struct inode *inode, struct file *file)
 {
 	file->private_data = NULL;
 	return 0;
 }
 
-static ssize_t TA_release(struct inode *inode, struct file *file)
+static int TA_release(struct inode *inode, struct file *file)
 {
 	void *p = file->private_data;
 	file->private_data = NULL;

