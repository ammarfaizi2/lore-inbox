Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132970AbRDJKs0>; Tue, 10 Apr 2001 06:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132971AbRDJKsQ>; Tue, 10 Apr 2001 06:48:16 -0400
Received: from swing.yars.free.net ([193.233.48.88]:31431 "EHLO
	swing.yars.free.net") by vger.kernel.org with ESMTP
	id <S132970AbRDJKsD>; Tue, 10 Apr 2001 06:48:03 -0400
Date: Tue, 10 Apr 2001 14:47:46 +0400
From: "Alexander V. Lukyanov" <lav@yars.free.net>
To: linux-kernel@vger.kernel.org
Cc: sparc-list@redhat.com
Subject: nfs_fsinfo->bsize size (2.4.2)
Message-ID: <20010410144746.A23745@swing.yars.free.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, sparc-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some time ago I had an undefined symbol in kernel compilation (__mul64) It
was sparc architecture, cross compilation on solaris/sparc. I have found
that 64-bit multiplication is in nfs2xdr.c, nfs_xdr_statfsres function. The
multiplication is by nfs_fsinfo->bsize.

For some reason nfs_fsinfo->bsize is declared as __u64. I don't see how
block size can be greater that 2G. What is the reason behind such type
for block size?

I did the following change and nfs still works fine. I've also rearranged
structure fields for alignment reasons.

--- include/linux/nfs_xdr.h.1	Fri Apr  6 17:57:25 2001
+++ include/linux/nfs_xdr.h	Fri Apr  6 17:59:14 2001
@@ -47,8 +47,8 @@
 	__u32			wtpref;	/* pref. write transfer size */
 	__u32			wtmult;	/* writes should be multiple of this */
 	__u32			dtpref;	/* pref. readdir transfer size */
+	__u32			bsize;	/* block size */
 	__u64			maxfilesize;
-	__u64			bsize;	/* block size */
 	__u64			tbytes;	/* total size in bytes */
 	__u64			fbytes;	/* # of free bytes */
 	__u64			abytes;	/* # of bytes available to user */

-- 
   Alexander.                      | http://www.yars.free.net/~lav/  
