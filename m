Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270039AbUJHQxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270039AbUJHQxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbUJHQxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:53:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:15003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270039AbUJHQxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:53:34 -0400
Subject: [PATCH] protect against buggy drivers
From: Stephen Hemminger <shemminger@osdl.org>
To: linus@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 08 Oct 2004 09:53:41 -0700
Message-Id: <1097254421.16787.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/08 09:52:03-07:00 shemminger@zqx3.pdx.osdl.net 
#   Protect against bad driver writers who pass invalid names when
#   setting up character devices.
# 
# fs/char_dev.c
#   2004/10/08 09:51:52-07:00 shemminger@zqx3.pdx.osdl.net +5 -0
#   Protect against bad driver writers who pass invalid names when
#   setting up character devices.
# 
diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	2004-10-08 09:52:15 -07:00
+++ b/fs/char_dev.c	2004-10-08 09:52:15 -07:00
@@ -196,6 +196,11 @@
 	char *s;
 	int err = -ENOMEM;
 
+	if (name == NULL || *name == '\0' || 
+	    strlen(name) >= KOBJ_NAME_LEN || 
+	    !strcmp(name, ".") || !strcmp(name, ".."))
+		return -EINVAL;
+
 	cd = __register_chrdev_region(major, 0, 256, name);
 	if (IS_ERR(cd))
 		return PTR_ERR(cd);


