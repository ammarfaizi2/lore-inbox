Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162253AbWLAXf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162253AbWLAXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162389AbWLAXfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:35:14 -0500
Received: from mx1.suse.de ([195.135.220.2]:16269 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162244AbWLAXWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:50 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/36] Driver core: convert vc code to use struct device
Date: Fri,  1 Dec 2006 15:21:41 -0800
Message-Id: <11650153591876-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <116501535622-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/vc_screen.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
index bd7a98c..f442b57 100644
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -476,16 +476,16 @@ static struct class *vc_class;
 
 void vcs_make_sysfs(struct tty_struct *tty)
 {
-	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 1),
-			NULL, "vcs%u", tty->index + 1);
-	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 129),
-			NULL, "vcsa%u", tty->index + 1);
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 1),
+			"vcs%u", tty->index + 1);
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 129),
+			"vcsa%u", tty->index + 1);
 }
 
 void vcs_remove_sysfs(struct tty_struct *tty)
 {
-	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
-	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
+	device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
+	device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
 }
 
 int __init vcs_init(void)
@@ -494,7 +494,7 @@ int __init vcs_init(void)
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
 	vc_class = class_create(THIS_MODULE, "vc");
 
-	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
-	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), "vcs");
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), "vcsa");
 	return 0;
 }
-- 
1.4.4.1

