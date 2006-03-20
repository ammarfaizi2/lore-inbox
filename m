Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbWCTWJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbWCTWJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbWCTWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:55737 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030530AbWCTWBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:12 -0500
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/23] kobject: fix build error if CONFIG_SYSFS=n
In-Reply-To: <11428920371618-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:37 -0800
Message-Id: <11428920371527-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving uevent_seqnum and uevent_helper to kobject_uevent.c
because they are used even if CONFIG_SYSFS=n
while kernel/ksysfs.c is built only if CONFIG_SYSFS=y,

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 kernel/ksysfs.c      |    3 ---
 lib/kobject_uevent.c |    2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

51107301b629640f9ab76fe23bf385e187b9ac29
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index d5eeae0..f2690ed 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -15,9 +15,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-u64 uevent_seqnum;
-char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
-
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 086a0c6..982226d 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -26,6 +26,8 @@
 #define NUM_ENVP	32	/* number of env pointers */
 
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
+u64 uevent_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
 
-- 
1.2.4


