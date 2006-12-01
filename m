Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162258AbWLAX2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162258AbWLAX2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162260AbWLAXXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34541 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162258AbWLAXXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:17 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/36] Driver core: convert ppdev code to use struct device
Date: Fri,  1 Dec 2006 15:21:49 -0800
Message-Id: <11650153861854-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153833896-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/ppdev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index efc485e..c1e3dd8 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -752,13 +752,13 @@ static const struct file_operations pp_f
 
 static void pp_attach(struct parport *port)
 {
-	class_device_create(ppdev_class, NULL, MKDEV(PP_MAJOR, port->number),
-			NULL, "parport%d", port->number);
+	device_create(ppdev_class, NULL, MKDEV(PP_MAJOR, port->number),
+			"parport%d", port->number);
 }
 
 static void pp_detach(struct parport *port)
 {
-	class_device_destroy(ppdev_class, MKDEV(PP_MAJOR, port->number));
+	device_destroy(ppdev_class, MKDEV(PP_MAJOR, port->number));
 }
 
 static struct parport_driver pp_driver = {
-- 
1.4.4.1

