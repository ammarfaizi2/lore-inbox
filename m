Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269779AbUJSQzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269779AbUJSQzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUJSQwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:52:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:53188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269786AbUJSQiq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:46 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037633428@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:06 -0700
Message-Id: <10982037663778@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.8, 2004/09/08 21:23:42-07:00, greg@kroah.com

[PATCH] kobject: hotplug_seqnum is not 64 bits on all platforms, so fix it.

Thanks to Kay Sievers for pointing this out.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject.h |    2 +-
 kernel/ksysfs.c         |    2 +-
 lib/kobject.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-10-19 09:23:15 -07:00
+++ b/include/linux/kobject.h	2004-10-19 09:23:15 -07:00
@@ -27,7 +27,7 @@
 #define KOBJ_NAME_LEN	20
 
 /* counter to tag the hotplug event, read only except for the kobject core */
-extern unsigned long hotplug_seqnum;
+extern u64 hotplug_seqnum;
 
 struct kobject {
 	char			* k_name;
diff -Nru a/kernel/ksysfs.c b/kernel/ksysfs.c
--- a/kernel/ksysfs.c	2004-10-19 09:23:15 -07:00
+++ b/kernel/ksysfs.c	2004-10-19 09:23:15 -07:00
@@ -24,7 +24,7 @@
 
 static ssize_t hotplug_seqnum_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%lu\n", hotplug_seqnum);
+	return sprintf(page, "%llu\n", hotplug_seqnum);
 }
 KERNEL_ATTR_RO(hotplug_seqnum);
 
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:23:15 -07:00
+++ b/lib/kobject.c	2004-10-19 09:23:15 -07:00
@@ -118,7 +118,7 @@
 	return path;
 }
 
-unsigned long hotplug_seqnum;
+u64 hotplug_seqnum;
 #ifdef CONFIG_HOTPLUG
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */

