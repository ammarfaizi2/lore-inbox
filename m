Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWC3Q7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWC3Q7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWC3Q7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:59:35 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:49876 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932250AbWC3Q7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:59:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] vt: add TIOCL_GETKMSGREDIRECT
Date: Thu, 30 Mar 2006 18:58:26 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301858.26681.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add TIOCL_GETKMSGREDIRECT needed by the userland suspend tool to get
the current value of kmsg_redirect from the kernel so that it can save it and
restore it after resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/char/vt.c     |    4 ++++
 include/linux/tiocl.h |    1 +
 2 files changed, 5 insertions(+)

Index: linux-2.6.16-mm1/drivers/char/vt.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/char/vt.c
+++ linux-2.6.16-mm1/drivers/char/vt.c
@@ -2328,6 +2328,10 @@ int tioclinux(struct tty_struct *tty, un
 		case TIOCL_SETVESABLANK:
 			set_vesa_blanking(p);
 			break;
+		case TIOCL_GETKMSGREDIRECT:
+			data = kmsg_redirect;
+			ret = __put_user(data, p);
+			break;
 		case TIOCL_SETKMSGREDIRECT:
 			if (!capable(CAP_SYS_ADMIN)) {
 				ret = -EPERM;
Index: linux-2.6.16-mm1/include/linux/tiocl.h
===================================================================
--- linux-2.6.16-mm1.orig/include/linux/tiocl.h
+++ linux-2.6.16-mm1/include/linux/tiocl.h
@@ -34,5 +34,6 @@ struct tiocl_selection {
 #define TIOCL_SCROLLCONSOLE	13	/* scroll console */
 #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
 #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
+#define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
 
 #endif /* _LINUX_TIOCL_H */


