Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751999AbWJXDFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWJXDFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbWJXDFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:05:20 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:6538 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751999AbWJXDFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:05:18 -0400
Date: Mon, 23 Oct 2006 20:06:45 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ankita Garg <ankita@in.ibm.com>, akpm <akpm@osdl.org>
Subject: [PATCH] lkdtm: cleanup headers and module_param/MODULE_PARM_DESC
Message-Id: <20061023200645.1657b7ab.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix module_param/sysfs file permission typo.

Clean up MODULE_PARM_DESC strings to avoid fancy (and incorrect)
formatting.

Fix header includes for lkdtm; add some needed ones, remove unused ones;
and fix this gcc warning:
drivers/misc/lkdtm.c:150: warning: 'struct buffer_head' declared inside parameter list
drivers/misc/lkdtm.c:150: warning: its scope is only this definition or declaration, which is probably not what you want

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/misc/lkdtm.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

--- linux-2619-rc2g8.orig/drivers/misc/lkdtm.c
+++ linux-2619-rc2g8/drivers/misc/lkdtm.c
@@ -44,12 +44,14 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/buffer_head.h>
 #include <linux/kprobes.h>
-#include <linux/kallsyms.h>
+#include <linux/list.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/hrtimer.h>
 #include <scsi/scsi_cmnd.h>
 
 #ifdef CONFIG_IDE
@@ -116,16 +118,16 @@ static enum ctype cptype = NONE;
 static int count = DEFAULT_COUNT;
 
 module_param(recur_count, int, 0644);
-MODULE_PARM_DESC(recur_count, "Recurcion level for the stack overflow test,\
-				 default is 10");
+MODULE_PARM_DESC(recur_count, " Recursion level for the stack overflow test, "\
+				 "default is 10");
 module_param(cpoint_name, charp, 0644);
-MODULE_PARM_DESC(cpoint_name, "Crash Point, where kernel is to be crashed");
-module_param(cpoint_type, charp, 06444);
-MODULE_PARM_DESC(cpoint_type, "Crash Point Type, action to be taken on\
-				hitting the crash point");
-module_param(cpoint_count, int, 06444);
-MODULE_PARM_DESC(cpoint_count, "Crash Point Count, number of times the \
-				crash point is to be hit to trigger action");
+MODULE_PARM_DESC(cpoint_name, " Crash Point, where kernel is to be crashed");
+module_param(cpoint_type, charp, 0644);
+MODULE_PARM_DESC(cpoint_type, " Crash Point Type, action to be taken on "\
+				"hitting the crash point");
+module_param(cpoint_count, int, 0644);
+MODULE_PARM_DESC(cpoint_count, " Crash Point Count, number of times the "\
+				"crash point is to be hit to trigger action");
 
 unsigned int jp_do_irq(unsigned int irq)
 {


---
~Randy
