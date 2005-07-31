Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbVGaL0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbVGaL0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGaL0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:26:39 -0400
Received: from coderock.org ([193.77.147.115]:59588 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261723AbVGaLMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:12:18 -0400
Message-Id: <20050731111213.636613000@homer>
Date: Sun, 31 Jul 2005 13:12:08 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Jan Veldeman <Jan.Veldeman@advalvas.be>,
       domen@coderock.org
Subject: [patch 3/5] Driver core: Documentation: use snprintf and strnlen
Content-Disposition: inline; filename=fixup-Documentation_filesystems_sysfs.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Veldeman <jan@mind.be>



Documentation should give the good example of using snprintf and
strnlen in stead of sprintf and strlen.

PAGE_SIZE is used as the maximal length to reflect the behaviour of
show/store.


Signed-off-by: Jan Veldeman <Jan.Veldeman@advalvas.be>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 sysfs.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/Documentation/filesystems/sysfs.txt
===================================================================
--- quilt.orig/Documentation/filesystems/sysfs.txt
+++ quilt/Documentation/filesystems/sysfs.txt
@@ -216,13 +216,13 @@ A very simple (and naive) implementation
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-        return sprintf(buf,"%s\n",dev->name);
+        return snprintf(buf,PAGE_SIZE,"%s\n",dev->name);
 }
 
 static ssize_t store_name(struct device * dev, const char * buf)
 {
 	sscanf(buf,"%20s",dev->name);
-	return strlen(buf);
+	return strnlen(buf,PAGE_SIZE);
 }
 
 static DEVICE_ATTR(name,S_IRUGO,show_name,store_name);

--
