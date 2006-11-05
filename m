Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWKEKuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWKEKuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWKEKuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:50:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:34326 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932635AbWKEKuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:50:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hyJWe05lJflp459JAsjz7OdzsqkLaOIVNzEE689ylzoFkBsZk+08W5JnmAD/tMclbF/ew/JZXGK14h1z0z7DwYejUYfNtI9h2+TDIqDz+S2oYPjiJRDhvJGoEV73Ep1+MrrWcXxUZVtL4ctfgI09+4QJZEgCCmBc46+OJ9VWKm8=
Date: Sun, 5 Nov 2006 11:49:56 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH update7] drivers: add LCD support
Message-Id: <20061105114956.4257720b.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 3 minor fixes for the drivers-add-lcd-support saga.
---

 - cfag12864b_work should be static
 - spelling
 - coding style

 drivers/auxdisplay/cfag12864b.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

miguelojeda-drivers-add-LCD-support-7-minor-fixes
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-mod4/drivers/auxdisplay/cfag12864b.c linux/drivers/auxdisplay/cfag12864b.c
--- linux-mod4/drivers/auxdisplay/cfag12864b.c	2006-11-01 19:49:47.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864b.c	2006-11-05 11:39:58.000000000 +0000
@@ -63,10 +63,10 @@ unsigned int cfag12864b_getrate(void)
  *		cfag12864b/ks0108 reads the command/data.
  *
  *	CS1 = First ks0108controller.
- *		If high, the first ks0108 receives commands/data.
+ *		If high, the first ks0108 controller receives commands/data.
  *
  *	CS2 = Second ks0108 controller
- *		If high, the second ks0108 receives commands/data.
+ *		If high, the second ks0108 controller receives commands/data.
  *
  *	DI = Data/Instruction
  *		If low, cfag12864b will expect commands.
@@ -223,7 +223,7 @@ static DEFINE_MUTEX(cfag12864b_mutex);
 static unsigned char cfag12864b_updating;
 static void cfag12864b_update(void *arg);
 static struct workqueue_struct *cfag12864b_workqueue;
-DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
+static DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
 
 static void cfag12864b_queue(void)
 {
@@ -241,8 +241,7 @@ unsigned char cfag12864b_enable(void)
 		cfag12864b_updating = 1;
 		cfag12864b_queue();
 		ret = 0;
-	}
-	else
+	} else
 		ret = 1;
 
 	mutex_unlock(&cfag12864b_mutex);
