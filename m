Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbVKZEEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbVKZEEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 23:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKZEEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 23:04:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39346 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932715AbVKZEEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 23:04:36 -0500
Date: Fri, 25 Nov 2005 20:04:26 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Cc: Paul Jackson <pj@sgi.com>
Message-Id: <20051126040426.26945.12817.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] driver kill hotplug word from sn and others fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first of these changes s/hotplug/uevent/ was needed to
compile sn2_defconfig (ia64/sn).  The other three files
changed are blind changes of all remaining bus_type.hotplug
references I could find to bus_type.uevent.

This patch attempts to finish similar changes made in the
gregkh-driver-kill-hotplug-word-from-driver-core Nov 22 patch.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 arch/arm/common/amba.c      |    6 +++---
 arch/ia64/sn/kernel/tiocx.c |    4 ++--
 drivers/s390/cio/ccwgroup.c |    4 ++--
 drivers/s390/cio/device.c   |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

--- 2.6.15-rc2-mm1.orig/arch/ia64/sn/kernel/tiocx.c	2005-11-25 17:09:59.175019269 -0800
+++ 2.6.15-rc2-mm1/arch/ia64/sn/kernel/tiocx.c	2005-11-25 18:09:19.834295281 -0800
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
--- 2.6.15-rc2-mm1.orig/arch/arm/common/amba.c	2005-11-25 17:09:12.046571395 -0800
+++ 2.6.15-rc2-mm1/arch/arm/common/amba.c	2005-11-25 18:48:25.476165433 -0800
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
--- 2.6.15-rc2-mm1.orig/drivers/s390/cio/ccwgroup.c	2005-11-25 17:22:09.111753515 -0800
+++ 2.6.15-rc2-mm1/drivers/s390/cio/ccwgroup.c	2005-11-25 18:47:47.084142033 -0800
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
--- 2.6.15-rc2-mm1.orig/drivers/s390/cio/device.c	2005-11-25 17:22:09.112730088 -0800
+++ 2.6.15-rc2-mm1/drivers/s390/cio/device.c	2005-11-25 19:21:23.574390939 -0800
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

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
