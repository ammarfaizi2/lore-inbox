Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWDDQ3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDDQ3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDDQ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:29:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63501 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750729AbWDDQ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:29:16 -0400
Date: Tue, 4 Apr 2006 18:29:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hjlipp@web.de, tilman@imap.cc
Cc: gigaset307x-common@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       kkeil@suse.de, isdn4linux@listserv.isdn4linux.de
Subject: [2.6 patch] drivers/isdn/gigaset/common.c: small cleanups
Message-ID: <20060404162915.GJ6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- makethe needlessly global gigaset_get_cs_by_tty() static
- remove the unused EXPORT_SYMBOL_GPL(gigaset_debugdrivers)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/gigaset/common.c  |   17 ++++++++---------
 drivers/isdn/gigaset/gigaset.h |    1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

--- linux-2.6.16-mm2-full/drivers/isdn/gigaset/gigaset.h.old	2006-04-04 00:15:36.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/isdn/gigaset/gigaset.h	2006-04-04 00:15:42.000000000 +0200
@@ -754,7 +754,6 @@
 /* Deallocate driver structure. */
 void gigaset_freedriver(struct gigaset_driver *drv);
 void gigaset_debugdrivers(void);
-struct cardstate *gigaset_get_cs_by_minor(unsigned minor);
 struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty);
 struct cardstate *gigaset_get_cs_by_id(int id);
 
--- linux-2.6.16-mm2-full/drivers/isdn/gigaset/common.c.old	2006-04-04 00:06:34.000000000 +0200
+++ linux-2.6.16-mm2-full/drivers/isdn/gigaset/common.c	2006-04-04 00:16:45.000000000 +0200
@@ -962,16 +962,8 @@
 	}
 	spin_unlock_irqrestore(&driver_lock, flags);
 }
-EXPORT_SYMBOL_GPL(gigaset_debugdrivers);
 
-struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty)
-{
-	if (tty->index < 0 || tty->index >= tty->driver->num)
-		return NULL;
-	return gigaset_get_cs_by_minor(tty->index + tty->driver->minor_start);
-}
-
-struct cardstate *gigaset_get_cs_by_minor(unsigned minor)
+static struct cardstate *gigaset_get_cs_by_minor(unsigned minor)
 {
 	unsigned long flags;
 	static struct cardstate *ret = NULL;
@@ -994,6 +986,13 @@
 	return ret;
 }
 
+struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty)
+{
+	if (tty->index < 0 || tty->index >= tty->driver->num)
+		return NULL;
+	return gigaset_get_cs_by_minor(tty->index + tty->driver->minor_start);
+}
+
 void gigaset_freedriver(struct gigaset_driver *drv)
 {
 	unsigned long flags;

