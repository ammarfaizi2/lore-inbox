Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVFVFMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVFVFMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVFVFMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:12:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:30103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262671AbVFVFML convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:11 -0400
Cc: gregkh@suse.de
Subject: [PATCH] w1: fix build issues
In-Reply-To: <11194171271261@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <111941712742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: fix build issues

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c7b2b2a723174d22a743180d5367f0028226031b
tree 9f4261361e660b64c71da0022304e23875c3561e
parent ca775c629a366ded01aae69da8410f70aaf85de1
author Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:01:59 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:10 -0700

 drivers/w1/w1_smem.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -37,14 +37,11 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
 
 static ssize_t w1_smem_read_name(struct device *, struct device_attribute *attr, char *);
-static ssize_t w1_smem_read_val(struct device *, struct device_attribute *attr, char *);
 static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_smem_fops = {
 	.rname = &w1_smem_read_name,
 	.rbin = &w1_smem_read_bin,
-	.rval = &w1_smem_read_val,
-	.rvalname = "id",
 };
 
 static ssize_t w1_smem_read_name(struct device *dev, struct device_attribute *attr, char *buf)
@@ -54,19 +51,6 @@ static ssize_t w1_smem_read_name(struct 
 	return sprintf(buf, "%s\n", sl->name);
 }
 
-static ssize_t w1_smem_read_val(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-	int i;
-	ssize_t count = 0;
-	
-	for (i = 0; i < 8; ++i)
-		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
-	count += sprintf(buf + count, "\n");
-
-	return count;
-}
-
 static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),

