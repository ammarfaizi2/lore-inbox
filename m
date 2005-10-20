Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJTQxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJTQxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJTQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:53:25 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:35743 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932125AbVJTQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:53:24 -0400
Date: Thu, 20 Oct 2005 12:53:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH] SELinux - remove unecessary size_t checks in selinuxfs
Message-ID: <Pine.LNX.4.63.0510201250300.3536@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a bunch of unecessary checks for (size_t < 0) in 
selinuxfs.

Please apply.

Author: Davi Arnaut <davi.arnaut@gmail.com>
Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


---

 security/selinux/selinuxfs.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -105,7 +105,7 @@ static ssize_t sel_write_enforce(struct
 	ssize_t length;
 	int new_value;

-	if (count < 0 || count >= PAGE_SIZE)
+	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 	if (*ppos != 0) {
 		/* No partial writes. */
@@ -155,7 +155,7 @@ static ssize_t sel_write_disable(struct
 	int new_value;
 	extern int selinux_disable(void);

-	if (count < 0 || count >= PAGE_SIZE)
+	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 	if (*ppos != 0) {
 		/* No partial writes. */
@@ -242,7 +242,7 @@ static ssize_t sel_write_load(struct fil
 		goto out;
 	}

-	if ((count < 0) || (count > 64 * 1024 * 1024)
+	if ((count > 64 * 1024 * 1024)
 	    || (data = vmalloc(count)) == NULL) {
 		length = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t sel_write_context(struct
 	if (length)
 		return length;

-	if (count < 0 || count >= PAGE_SIZE)
+	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 	if (*ppos != 0) {
 		/* No partial writes. */
@@ -332,7 +332,7 @@ static ssize_t sel_write_checkreqprot(st
 	if (length)
 		return length;

-	if (count < 0 || count >= PAGE_SIZE)
+	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 	if (*ppos != 0) {
 		/* No partial writes. */
@@ -739,7 +739,7 @@ static ssize_t sel_read_bool(struct file
 	if (!filep->f_op)
 		goto out;

-	if (count < 0 || count > PAGE_SIZE) {
+	if (count > PAGE_SIZE) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -800,7 +800,7 @@ static ssize_t sel_write_bool(struct fil
 	if (!filep->f_op)
 		goto out;

-	if (count < 0 || count >= PAGE_SIZE) {
+	if (count >= PAGE_SIZE) {
 		length = -ENOMEM;
 		goto out;
 	}
@@ -858,7 +858,7 @@ static ssize_t sel_commit_bools_write(st
 	if (!filep->f_op)
 		goto out;

-	if (count < 0 || count >= PAGE_SIZE) {
+	if (count >= PAGE_SIZE) {
 		length = -ENOMEM;
 		goto out;
 	}
@@ -1032,7 +1032,7 @@ static ssize_t sel_write_avc_cache_thres
 	ssize_t ret;
 	int new_value;

-	if (count < 0 || count >= PAGE_SIZE) {
+	if (count >= PAGE_SIZE) {
 		ret = -ENOMEM;
 		goto out;
 	}
