Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUHXQuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUHXQuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUHXQuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:50:37 -0400
Received: from mail.nucleus.com ([207.34.93.23]:15372 "EHLO mail.nucleus.com")
	by vger.kernel.org with ESMTP id S268102AbUHXQuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:50:09 -0400
Date: Tue, 24 Aug 2004 10:50:02 -0600
From: Ray Lehtiniemi <rayl@mail.com>
To: linux-kernel@vger.kernel.org
Subject: nfsroot compile broken in 2.6.9-rc1?
Message-ID: <20040824165002.GA4314@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi folks

just pulled the latest changes, and it seems nfsroot no longer
compiles:

     CC      fs/nfs/nfsroot.o
   fs/nfs/nfsroot.c: In function `root_nfs_get_handle':
   fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
   fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
   make[2]: *** [fs/nfs/nfsroot.o] Error 1


i'm no bitkeeper expert yet, but it seems that this change:

   ChangeSet 1.1803.109.17 2004/08/23 18:16:26 trond.myklebust@fys.uio.no

may not be complete...

this patch compiles and boots for me...

===== fs/nfs/nfsroot.c 1.20 vs edited =====
--- 1.20/fs/nfs/nfsroot.c	2004-06-08 15:47:11 -06:00
+++ edited/fs/nfs/nfsroot.c	2004-08-24 10:26:29 -06:00
@@ -496,7 +496,7 @@
 		printk(KERN_ERR "Root-NFS: Server returned error %d "
 				"while mounting %s\n", status, nfs_path);
 	else
-		nfs_copy_fh(nfs_data.root, fh);
+		nfs_copy_fh((struct nfs_fh *)&nfs_data.root, (struct nfs_fh *)&fh);
 
 	return status;
 }



please cc me on replies, as i'm not subscribed.

thanks

-- 
----------------------------------------------------------------------
     Ray L   <rayl@mail.com>
