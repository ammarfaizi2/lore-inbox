Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUHXKSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUHXKSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUHXKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:18:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267404AbUHXKR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:17:58 -0400
Date: Tue, 24 Aug 2004 11:17:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.9-rc1 compile fix: nfsroot.c
Message-ID: <20040824111751.A23041@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an untested patch for this error:

fs/nfs/nfsroot.c: In function `root_nfs_get_handle':
fs/nfs/nfsroot.c:499: error: incompatible type for argument 1 of `nfs_copy_fh'
fs/nfs/nfsroot.c:499: error: incompatible type for argument 2 of `nfs_copy_fh'

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/fs/nfs/nfsroot.c linux/fs/nfs/nfsroot.c
--- orig/fs/nfs/nfsroot.c	Tue Aug 24 09:56:32 2004
+++ linux/fs/nfs/nfsroot.c	Tue Aug 24 11:11:01 2004
@@ -496,7 +496,7 @@ static int __init root_nfs_get_handle(vo
 		printk(KERN_ERR "Root-NFS: Server returned error %d "
 				"while mounting %s\n", status, nfs_path);
 	else
-		nfs_copy_fh(nfs_data.root, fh);
+		nfs_copy_fh(&nfs_data.root, &fh);
 
 	return status;
 }

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
