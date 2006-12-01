Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162245AbWLAXXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162245AbWLAXXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162246AbWLAXW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:58 -0500
Received: from ns1.suse.de ([195.135.220.2]:11661 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162239AbWLAXWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:33 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/36] CONFIG_SYSFS_DEPRECATED
Date: Fri,  1 Dec 2006 15:21:34 -0800
Message-Id: <11650153362310-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165015333344-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Provide a way to support older versions of udev that are shipped in
older distros.  If this option is disabled, it will also turn off the
compatible symlinks in sysfs that older programs might rely on.

When in doubt, or if running a distro older than 2006, say Yes here.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 init/Kconfig |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 176f7e5..14d4846 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -249,6 +249,26 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config SYSFS_DEPRECATED
+	bool "Create deprecated sysfs files"
+	default y
+	help
+	  This option creates deprecated symlinks such as the
+	  "device"-link, the <subsystem>:<name>-link, and the
+	  "bus"-link. It may also add deprecated key in the
+	  uevent environment.
+	  None of these features or values should be used today, as
+	  they export driver core implementation details to userspace
+	  or export properties which can't be kept stable across kernel
+	  releases.
+
+	  If enabled, this option will also move any device structures
+	  that belong to a class, back into the /sys/class heirachy, in
+	  order to support older versions of udev.
+
+	  If you are using a distro that was released in 2006 or later,
+	  it should be safe to say N here.
+
 config RELAY
 	bool "Kernel->user space relay support (formerly relayfs)"
 	help
-- 
1.4.4.1

