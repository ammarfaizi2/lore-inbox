Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTJTHqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJTHqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:46:35 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:32354 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261427AbTJTHqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:46:33 -0400
Date: Mon, 20 Oct 2003 00:46:30 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: vojtech@suse.cz
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Add needed __devexit_p's to two gameport drivers
Message-ID: <Pine.GSO.4.58.0310171453570.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vojtech,

Two gameport drivers need __devexit_p wrapped around their remove functions.  A
newer binutils caught this is a link error.  This patch fixes that.

The patch is against linux-2.5 BK as of 0700 UTC 10/20/2003 and for about two
months prior to that.  The modified drivers compile cleanly for (to the best of
my recollection) alpha, sparc, sparc64, and i386.  I am not aware of any
hardware I have access to that I could test the patch on, but I think the change
is fairly straightforward.  Please consider.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1368  -> 1.1369
#	drivers/input/gameport/fm801-gp.c	1.7     -> 1.8
#	drivers/input/gameport/vortex.c	1.7     -> 1.8
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	noah@caltech.edu	1.1369
# Wrapped a __devexit_p around the 'remove' functions of two gameport
# drivers.  The lack of __devexit_p was wrong according to linux/init.h,
# differed from the practices in nearby files, and caused a link error
# with binutils 2.14.90.0.5.
# --------------------------------------------
#
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	Fri Oct 17 13:40:32 2003
+++ b/drivers/input/gameport/fm801-gp.c	Fri Oct 17 13:40:32 2003
@@ -140,7 +140,7 @@
 	.name =		"FM801 GP",
 	.id_table =	fm801_gp_id_table,
 	.probe =	fm801_gp_probe,
-	.remove =	fm801_gp_remove,
+	.remove =	__devexit_p(fm801_gp_remove),
 };

 int __init fm801_gp_init(void)
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	Fri Oct 17 13:40:32 2003
+++ b/drivers/input/gameport/vortex.c	Fri Oct 17 13:40:32 2003
@@ -168,7 +168,7 @@
 	.name =		"vortex",
 	.id_table =	vortex_id_table,
 	.probe =	vortex_probe,
-	.remove =	vortex_remove,
+	.remove =	__devexit_p(vortex_remove),
 };

 int __init vortex_init(void)

