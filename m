Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSJPHPk>; Wed, 16 Oct 2002 03:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJPHPk>; Wed, 16 Oct 2002 03:15:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:761 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264944AbSJPHPj>;
	Wed, 16 Oct 2002 03:15:39 -0400
Date: Wed, 16 Oct 2002 13:03:01 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.43-mm1
Message-ID: <20021016130301.A29405@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <3DAD0F3D.39E5B5DC@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAD0F3D.39E5B5DC@digeo.com>; from akpm@digeo.com on Wed, Oct 16, 2002 at 07:05:06AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Few changes in dcache_rcu patch due to new intermezzo file system. Patch against
2.5.43-mm1

Regards,
Maneesh


diff -urN linux-2.5.43-mm1/fs/intermezzo/journal.c linux-2.5.43-mm1-dcache_rcu/fs/intermezzo/journal.c
--- linux-2.5.43-mm1/fs/intermezzo/journal.c	Wed Oct 16 12:30:03 2002
+++ linux-2.5.43-mm1-dcache_rcu/fs/intermezzo/journal.c	Wed Oct 16 12:26:47 2002
@@ -1518,7 +1518,7 @@
         }
 
         if (!dentry->d_inode || (dentry->d_inode->i_nlink == 0) 
-            || ((dentry->d_parent != dentry) && list_empty(&dentry->d_hash))) {
+            || ((dentry->d_parent != dentry) && d_unhashed(dentry))) {
                 EXIT;
                 return 0;
         }
@@ -2129,7 +2129,7 @@
         }
 
         if (!dentry->d_inode || (dentry->d_inode->i_nlink == 0) 
-            || ((dentry->d_parent != dentry) && list_empty(&dentry->d_hash))) {
+            || ((dentry->d_parent != dentry) && d_unhashed(dentry))) {
                 EXIT;
                 return 0;
         }
@@ -2391,7 +2391,7 @@
         }
 
         if (!dentry->d_inode || (dentry->d_inode->i_nlink == 0) 
-            || ((dentry->d_parent != dentry) && list_empty(&dentry->d_hash))) {
+            || ((dentry->d_parent != dentry) && d_unhashed(dentry))) {
                 EXIT;
                 return 0;
         }



-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
