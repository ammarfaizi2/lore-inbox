Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWBFU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWBFU3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWBFU3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:24509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964785AbWBFU3e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:34 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Fix compiler warning in driver core for CONFIG_HOTPLUG=N
In-Reply-To: <11392577571272@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:18 -0800
Message-Id: <1139257758710@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix compiler warning in driver core for CONFIG_HOTPLUG=N

FYI, while running a build test, I found:

drivers/base/bus.c:166: warning: `driver_attr_unbind' defined but not used
drivers/base/bus.c:194: warning: `driver_attr_bind' defined but not used

Looks like these two attributes and supporting functions want to be
#ifdef HOTPLUG'd

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e485981e52b476c1b6a00873c2f8b75b3168718f
tree 37c0f979c90bbee395ff26d65a6ce3651cdcf423
parent b365b3daf2a9e2a8b002ea9fef877af1c71513fd
author Russell King <rmk@arm.linux.org.uk> Sat, 14 Jan 2006 20:01:02 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 drivers/base/bus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 29f6af5..c314156 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -133,6 +133,8 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
+#ifdef CONFIG_HOTPLUG
+
 /* Manually detach a device from its associated driver. */
 static int driver_helper(struct device *dev, void *data)
 {
@@ -193,6 +195,7 @@ static ssize_t driver_bind(struct device
 }
 static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
 
+#endif
 
 static struct device * next_device(struct klist_iter * i)
 {

