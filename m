Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWIZFwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWIZFwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWIZFir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26837 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751299AbWIZFiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda Sandonis <maxextreme@gmail.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/47] Driver core: add const to class_create
Date: Mon, 25 Sep 2006 22:37:25 -0700
Message-Id: <11592490993970-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249096460-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda Sandonis <maxextreme@gmail.com>

Adds const to class_create second parameter, because:

struct class {
	const char * name;

	/*...*/
}

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |    2 +-
 include/linux/device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 75057aa..e078bc2 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -197,7 +197,7 @@ static int class_device_create_uevent(st
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *class_create(struct module *owner, char *name)
+struct class *class_create(struct module *owner, const char *name)
 {
 	struct class *cls;
 	int retval;
diff --git a/include/linux/device.h b/include/linux/device.h
index 8d92013..8a648cd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -271,7 +271,7 @@ struct class_interface {
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class *class_create(struct module *owner, char *name);
+extern struct class *class_create(struct module *owner, const char *name);
 extern void class_destroy(struct class *cls);
 extern struct class_device *class_device_create(struct class *cls,
 						struct class_device *parent,
-- 
1.4.2.1

