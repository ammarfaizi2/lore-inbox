Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWIZFjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWIZFjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWIZFjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:56545 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751402AbWIZFjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:07 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/47] PM: add kconfig option for deprecated .../power/state files
Date: Mon, 25 Sep 2006 22:37:40 -0700
Message-Id: <11592491482560-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491451786-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Add a new PM_SYSFS_DEPRECATED config option to control whether or
not the /sys/devices/.../power/state files are provided.  This will
make it easier to get rid of that mechanism when the time comes,
and to verify that userspace tools work right without it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/sysfs.c |    6 ++++++
 kernel/power/Kconfig       |   11 +++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index e55b3c2..2d47517 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -7,6 +7,8 @@ #include <linux/string.h>
 #include "power.h"
 
 
+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
+
 /**
  *	state - Control current power state of device
  *
@@ -66,6 +68,8 @@ static ssize_t state_store(struct device
 static DEVICE_ATTR(state, 0644, state_show, state_store);
 
 
+#endif	/* CONFIG_PM_SYSFS_DEPRECATED */
+
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -139,7 +143,9 @@ static DEVICE_ATTR(wakeup, 0644, wake_sh
 
 
 static struct attribute * power_attrs[] = {
+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
 	&dev_attr_state.attr,
+#endif
 	&dev_attr_wakeup.attr,
 	NULL,
 };
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 619ecab..1ed9720 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -53,6 +53,17 @@ config PM_TRACE
 	CAUTION: this option will cause your machine's real-time clock to be
 	set to an invalid time after a resume.
 
+config PM_SYSFS_DEPRECATED
+	bool "Driver model /sys/devices/.../power/state files (DEPRECATED)"
+	depends on PM && SYSFS
+	default n
+	help
+	  The driver model started out with a sysfs file intended to provide
+	  a userspace hook for device power management.  This feature has never
+	  worked very well, except for limited testing purposes, and so it will
+	  be removed.   It's not clear that a generic mechanism could really
+	  handle the wide variability of device power states; any replacements
+	  are likely to be bus or driver specific.
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-- 
1.4.2.1

