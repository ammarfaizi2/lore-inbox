Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWAEAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWAEAvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWAEAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:59577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750961AbWAEAtv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:51 -0500
Cc: pj@sgi.com
Subject: [PATCH] driver kill hotplug word from sn and others fix
In-Reply-To: <11364221692342@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <1136422169909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver kill hotplug word from sn and others fix

The first of these changes s/hotplug/uevent/ was needed to
compile sn2_defconfig (ia64/sn).  The other three files
changed are blind changes of all remaining bus_type.hotplug
references I could find to bus_type.uevent.

This patch attempts to finish similar changes made in the
gregkh-driver-kill-hotplug-word-from-driver-core Nov 22 patch.

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6d20b035dee4300e9786c6e1cb77a765c7f9460a
tree 104596b8fca1f4946da8d499a8429e5decf7e2d9
parent 712f47cea7703a340406fde61e84eb86ce781988
author Paul Jackson <pj@sgi.com> Fri, 25 Nov 2005 20:04:26 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 arch/arm/common/amba.c      |    6 +++---
 arch/ia64/sn/kernel/tiocx.c |    4 ++--
 drivers/s390/cio/ccwgroup.c |    4 ++--
 drivers/s390/cio/device.c   |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/common/amba.c b/arch/arm/common/amba.c
index e101311..c95ec9e 100644
--- a/arch/arm/common/amba.c
+++ b/arch/arm/common/amba.c
@@ -45,7 +45,7 @@ static int amba_match(struct device *dev
 }
 
 #ifdef CONFIG_HOTPLUG
-static int amba_hotplug(struct device *dev, char **envp, int nr_env, char *buf, int bufsz)
+static int amba_uevent(struct device *dev, char **envp, int nr_env, char *buf, int bufsz)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 
@@ -58,7 +58,7 @@ static int amba_hotplug(struct device *d
 	return 0;
 }
 #else
-#define amba_hotplug NULL
+#define amba_uevent NULL
 #endif
 
 static int amba_suspend(struct device *dev, pm_message_t state)
@@ -88,7 +88,7 @@ static int amba_resume(struct device *de
 static struct bus_type amba_bustype = {
 	.name		= "amba",
 	.match		= amba_match,
-	.hotplug	= amba_hotplug,
+	.uevent		= amba_uevent,
 	.suspend	= amba_suspend,
 	.resume		= amba_resume,
 };
diff --git a/arch/ia64/sn/kernel/tiocx.c b/arch/ia64/sn/kernel/tiocx.c
index 0d8592a..768c21d 100644
--- a/arch/ia64/sn/kernel/tiocx.c
+++ b/arch/ia64/sn/kernel/tiocx.c
@@ -65,7 +65,7 @@ static int tiocx_match(struct device *de
 
 }
 
-static int tiocx_hotplug(struct device *dev, char **envp, int num_envp,
+static int tiocx_uevent(struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size)
 {
 	return -ENODEV;
@@ -79,7 +79,7 @@ static void tiocx_bus_release(struct dev
 struct bus_type tiocx_bus_type = {
 	.name = "tiocx",
 	.match = tiocx_match,
-	.hotplug = tiocx_hotplug,
+	.uevent = tiocx_uevent,
 };
 
 /**
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e7bd7f3..be9d2d6 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -45,7 +45,7 @@ ccwgroup_bus_match (struct device * dev,
 	return 0;
 }
 static int
-ccwgroup_hotplug (struct device *dev, char **envp, int num_envp, char *buffer,
+ccwgroup_uevent (struct device *dev, char **envp, int num_envp, char *buffer,
 		  int buffer_size)
 {
 	/* TODO */
@@ -55,7 +55,7 @@ ccwgroup_hotplug (struct device *dev, ch
 static struct bus_type ccwgroup_bus_type = {
 	.name    = "ccwgroup",
 	.match   = ccwgroup_bus_match,
-	.hotplug = ccwgroup_hotplug,
+	.uevent = ccwgroup_uevent,
 };
 
 static inline void
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 811c9d1..85908ca 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -59,7 +59,7 @@ ccw_bus_match (struct device * dev, stru
  * Heavily modeled on pci and usb hotplug.
  */
 static int
-ccw_hotplug (struct device *dev, char **envp, int num_envp,
+ccw_uevent (struct device *dev, char **envp, int num_envp,
 	     char *buffer, int buffer_size)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
@@ -110,7 +110,7 @@ ccw_hotplug (struct device *dev, char **
 struct bus_type ccw_bus_type = {
 	.name  = "ccw",
 	.match = &ccw_bus_match,
-	.hotplug = &ccw_hotplug,
+	.uevent = &ccw_uevent,
 };
 
 static int io_subchannel_probe (struct device *);

