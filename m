Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWCXSQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWCXSQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCXSQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:16:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:24990 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751377AbWCXSQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:16:08 -0500
Date: Fri, 24 Mar 2006 23:43:23 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Use loff_t for size in struct proc_dir_entry
Message-ID: <20060324181323.GA13108@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following patch is needed for seeing correct size for
/proc/vmcore for 32-bit systems with > 4G RAM.


Thanks
Maneesh




o Change proc_dir_entry->size to be loff_t to represent files
  like /proc/vmcore for 32bit systems with more than 4G memory.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.16-mm1-maneesh/include/linux/proc_fs.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/proc_fs.h~fix-proc_dir_entry-for-64bit-filesize include/linux/proc_fs.h
--- linux-2.6.16-mm1/include/linux/proc_fs.h~fix-proc_dir_entry-for-64bit-filesize	2006-03-24 23:22:43.630837640 +0530
+++ linux-2.6.16-mm1-maneesh/include/linux/proc_fs.h	2006-03-24 23:25:10.134565688 +0530
@@ -56,7 +56,7 @@ struct proc_dir_entry {
 	nlink_t nlink;
 	uid_t uid;
 	gid_t gid;
-	unsigned long size;
+	loff_t size;
 	struct inode_operations * proc_iops;
 	const struct file_operations * proc_fops;
 	get_info_t *get_info;
_
