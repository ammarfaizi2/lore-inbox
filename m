Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUIUF0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUIUF0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUIUF0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:26:41 -0400
Received: from peabody.ximian.com ([130.57.169.10]:33768 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267304AbUIUF0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:26:37 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095652572.23128.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-zwHOnZjxMXuoekA8GBTE"
Date: Tue, 21 Sep 2004 01:26:36 -0400
Message-Id: <1095744396.2454.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zwHOnZjxMXuoekA8GBTE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 23:56 -0400, John McCutchan wrote:

> I would appreciate design review, code review and testing.

Hi, John.

Attached patches fixes two compile warnings I receive in
drivers/char/inotify.c:

	- Declaration after code in inotify_watch()

	- Uncasted conversion from pointer to integer

Also, wrap some arithmetic in parenthesis, to be safe.

Best,

	Robert Love


--=-zwHOnZjxMXuoekA8GBTE
Content-Disposition: attachment; filename=inotify-compile-warnings-rml-1.patch
Content-Type: text/x-patch; name=inotify-compile-warnings-rml-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix a couple misc. compile warnings in inotify.c
Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux-inotify/drivers/char/inotify.c	2004-09-21 00:58:03.912389824 -0400
+++ linux/drivers/char/inotify.c	2004-09-21 01:24:07.042757888 -0400
@@ -45,7 +45,7 @@
 #define MAX_INOTIFY_QUEUED_EVENTS 256 /* Only the first Z events will be queued */
 #define __BITMASK_SIZE (MAX_INOTIFY_DEV_WATCHERS / 8)
 
-#define INOTIFY_DEV_TIMER_TIME jiffies + (HZ/4)
+#define INOTIFY_DEV_TIMER_TIME	(jiffies + (HZ/4))
 
 static atomic_t watcher_count; // < MAX_INOTIFY_DEVS
 
@@ -668,7 +668,7 @@
 
 	file->private_data = dev;
 
-	dev->timer.data = dev;
+	dev->timer.data = (unsigned long) dev;
 	dev->timer.function = inotify_dev_timer;
 	dev->timer.expires = INOTIFY_DEV_TIMER_TIME;
 
@@ -745,8 +745,10 @@
 	 * watching, we just update the mask and return 0
 	 */
 	if (inotify_dev_is_watching_inode (dev, inode)) {
-		iprintk(INOTIFY_DEBUG_ERRORS, "adjusting event mask for inode %p\n", inode);
-		struct inotify_watcher *owatcher; // the old watcher
+		struct inotify_watcher *owatcher;	/* the old watcher */
+
+		iprintk(INOTIFY_DEBUG_ERRORS,
+				"adjusting event mask for inode %p\n", inode);
 
 		owatcher = inode_find_dev (inode, dev);
 

--=-zwHOnZjxMXuoekA8GBTE--

