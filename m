Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSGWUzX>; Tue, 23 Jul 2002 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318337AbSGWUzW>; Tue, 23 Jul 2002 16:55:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318326AbSGWUyW>;
	Tue, 23 Jul 2002 16:54:22 -0400
Message-ID: <3D3DC2BD.BC3B371@zip.com.au>
Date: Tue, 23 Jul 2002 13:55:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page-writeback.c compile warning fix
References: <1027457453.931.111.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Andrew and Linus,
> 
> Compile of mm/page-writeback.c gives a warning of undefined use of
> "writeback_backing_dev()".
> 

Yeah, sorry.  I missed a file when generating the diff.  I have
this in the pending pile:

 writeback.h |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.5.27/include/linux/writeback.h~writeback-warning	Mon Jul 22 12:33:39 2002
+++ 2.5.27-akpm/include/linux/writeback.h	Mon Jul 22 12:33:44 2002
@@ -8,6 +8,8 @@
 #ifndef WRITEBACK_H
 #define WRITEBACK_H
 
+struct backing_dev_info;
+
 extern spinlock_t inode_lock;
 extern struct list_head inode_in_use;
 extern struct list_head inode_unused;
@@ -38,6 +40,9 @@ void wake_up_inode(struct inode *inode);
 void __wait_on_inode(struct inode * inode);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
+void writeback_backing_dev(struct backing_dev_info *bdi, int *nr_to_write,
+			enum writeback_sync_modes sync_mode,
+			unsigned long *older_than_this);
 
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)

.
