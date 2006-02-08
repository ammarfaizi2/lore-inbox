Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWBHHOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWBHHOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWBHHOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:14:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:9372 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161046AbWBHHKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:46 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] compat_ioctl __user annotations
Message-Id: <E1F6jTS-0002Z0-0n@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138793613 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/compat_ioctl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

6b2b4e5a26fe3795b1c6711cee0eae057844491d
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 5dd0207..057e602 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -931,8 +931,8 @@ struct compat_sg_req_info { /* used by S
 static int sg_grt_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	int err, i;
-	sg_req_info_t *r;
-	struct compat_sg_req_info *o = (struct compat_sg_req_info *)arg;
+	sg_req_info_t __user *r;
+	struct compat_sg_req_info __user *o = (void __user *)arg;
 	r = compat_alloc_user_space(sizeof(sg_req_info_t)*SG_MAX_QUEUE);
 	err = sys_ioctl(fd,cmd,(unsigned long)r);
 	if (err < 0)
@@ -2739,8 +2739,8 @@ static int do_ncp_setprivatedata(unsigne
 static int
 lp_timeout_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct compat_timeval *tc = (struct compat_timeval *)arg;
-	struct timeval *tn = compat_alloc_user_space(sizeof(struct timeval));
+	struct compat_timeval __user *tc = (struct compat_timeval __user *)arg;
+	struct timeval __user *tn = compat_alloc_user_space(sizeof(struct timeval));
 	struct timeval ts;
 	if (get_user(ts.tv_sec, &tc->tv_sec) ||
 	    get_user(ts.tv_usec, &tc->tv_usec) ||
-- 
0.99.9.GIT

