Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbVLOJSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbVLOJSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbVLOJSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61059 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422649AbVLOJSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:45 -0500
To: torvalds@osdl.org
Subject: [PATCH] dst_ca __user annotations, portability fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpG9-00080W-3X@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/media/dvb/bt8xx/dst_ca.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

29802c31b614ae72efd4aee01ec4349fa3098905
diff --git a/drivers/media/dvb/bt8xx/dst_ca.c b/drivers/media/dvb/bt8xx/dst_ca.c
index e6541af..2239651 100644
--- a/drivers/media/dvb/bt8xx/dst_ca.c
+++ b/drivers/media/dvb/bt8xx/dst_ca.c
@@ -406,7 +406,7 @@ static int ca_send_message(struct dst_st
 	}
 	dprintk(verbose, DST_CA_DEBUG, 1, " ");
 
-	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg))) {
+	if (copy_from_user(p_ca_message, arg, sizeof (struct ca_msg))) {
 		result = -EFAULT;
 		goto free_mem_and_exit;
 	}
@@ -579,7 +579,7 @@ static int dst_ca_release(struct inode *
 	return 0;
 }
 
-static int dst_ca_read(struct file *file, char __user *buffer, size_t length, loff_t *offset)
+static ssize_t dst_ca_read(struct file *file, char __user *buffer, size_t length, loff_t *offset)
 {
 	int bytes_read = 0;
 
@@ -588,7 +588,7 @@ static int dst_ca_read(struct file *file
 	return bytes_read;
 }
 
-static int dst_ca_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset)
+static ssize_t dst_ca_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset)
 {
 	dprintk(verbose, DST_CA_DEBUG, 1, " Device write.");
 
-- 
0.99.9.GIT

