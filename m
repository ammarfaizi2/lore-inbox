Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWIOBDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWIOBDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWIOBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:03:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:19601 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWIOBDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:03:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding:x-sylpheed-account-id:resent-date:resent-from:resent-to:resent-cc:subject:resent-message-id;
        b=Rbr1Z7QueFRpbt3jzbYzlD3Zjjo8buud+Xut0OuRXKmIR0aALP0yl8SOCu6lzwLuc+6YREJaSN8kkv9KHCZuKhrW43+0a9EnYibslBfLoBJ01Yj54hGDaw7jCMgiUk48GQNXiMn3K5xqV54ytqevhUSLMXyO4CRshgdoYOxQ7V0=
Date: Wed, 13 Sep 2006 15:33:29 +0200
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: torvalds@osdl.org
Cc: greg@kroah.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Message-Id: <20060913153329.7737183c.maxextreme@gmail.com>
Organization: -
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Sylpheed-Account-Id: 1
Subject: [PATCH 0/1 Re] drivers: add const to class_create
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch.

Adds const to class_create second parameter, because:

struct class {
	const char * name;

	/*...*/
}

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/drivers/base/class.c linux-2.6.18-rc7/drivers/base/class.c
--- linux-2.6.18-rc7-vanilla/drivers/base/class.c	2006-09-13 14:01:47.000000000 +0200
+++ linux-2.6.18-rc7/drivers/base/class.c	2006-09-13 14:13:16.000000000 +0200
@@ -197,7 +197,7 @@ static int class_device_create_uevent(st
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *class_create(struct module *owner, char *name)
+struct class *class_create(struct module *owner, const char *name)
 {
 	struct class *cls;
 	int retval;
diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/include/linux/device.h linux-2.6.18-rc7/include/linux/device.h
--- linux-2.6.18-rc7-vanilla/include/linux/device.h	2006-09-13 14:02:12.000000000 +0200
+++ linux-2.6.18-rc7/include/linux/device.h	2006-09-13 14:12:45.000000000 +0200
@@ -271,7 +271,7 @@ struct class_interface {
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class *class_create(struct module *owner, char *name);
+extern struct class *class_create(struct module *owner, const char *name);
 extern void class_destroy(struct class *cls);
 extern struct class_device *class_device_create(struct class *cls,
 						struct class_device *parent,
