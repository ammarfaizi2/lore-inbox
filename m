Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUDVWdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUDVWdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUDVWbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:31:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:8624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264270AbUDVWbE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:31:04 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.6-rc2
In-Reply-To: <10826730481875@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 22 Apr 2004 15:30:48 -0700
Message-Id: <10826730482148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1929, 2004/04/22 15:11:12-07:00, lxiep@us.ibm.com

[PATCH] symlink doesn't support kobj name > 20 charaters (KOBJ_NAME_LEN)

Since symlink.c uses "name" field of a kobj when it calculates the
length,  it gets a wrong value if the kobj's name  has more than 20
charathers.  A correct way to do that is to call kobject_name(kobj)
instead of using kobj->name directly.


 fs/sysfs/symlink.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	Thu Apr 22 15:27:07 2004
+++ b/fs/sysfs/symlink.c	Thu Apr 22 15:27:07 2004
@@ -42,7 +42,7 @@
 	struct kobject * p = kobj;
 	int length = 1;
 	do {
-		length += strlen(p->name) + 1;
+		length += strlen(kobject_name(p)) + 1;
 		p = p->parent;
 	} while (p);
 	return length;
@@ -54,11 +54,11 @@
 
 	--length;
 	for (p = kobj; p; p = p->parent) {
-		int cur = strlen(p->name);
+		int cur = strlen(kobject_name(p));
 
 		/* back up enough to print this bus id with '/' */
 		length -= cur;
-		strncpy(buffer + length,p->name,cur);
+		strncpy(buffer + length,kobject_name(p),cur);
 		*(buffer + --length) = '/';
 	}
 }

