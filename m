Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUJBXnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUJBXnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUJBXnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:43:08 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41434 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S267618AbUJBXnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:43:03 -0400
Subject: [Announce]: Software Suspend 2.1-rc1 for 2.6.8.1 and 2.6.9-rc3.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-tFzRSbrqZe+ZmFlG2A44"
Message-Id: <1096760717.8556.9.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 03 Oct 2004 09:45:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tFzRSbrqZe+ZmFlG2A44
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all.

Software suspend 2.1-rc1 for the above kernels has been uploaded to
http://softwaresuspend.berlios.de.

Changes since 2.0.0.109 are pretty minimal, amounting almost exclusively
to compile fixes. There is no new functionality, but some refrigerator
calls have been fixed (hvc console and pdflush in particular).

Since the announcement on the suspend-devel list, one minor issue has
been found which applies to the 2.6.8.1 version only. And additional
patch (which can be applied after the others or popped into the patch
directory before applying) is attached.

Regards,

Nigel

--=-tFzRSbrqZe+ZmFlG2A44
Content-Disposition: attachment; filename=999
Content-Type: text/x-patch; name=999; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ruN 999-old/kernel/power/suspend.c 999-new/kernel/power/suspend.c
--- 999-old/kernel/power/suspend.c	2004-09-28 08:21:43.000000000 +1000
+++ 999-new/kernel/power/suspend.c	2004-09-28 08:21:33.000000000 +1000
@@ -325,10 +325,11 @@
 
 	/* Now check for graphics class devices, so we can keep the display on while suspending */
 	class = class_find("graphics");
-	if (class)
+	if (class) {
 		list_for_each_entry(class_dev, &class->children, node)
 			device_switch_trees(class_dev->dev, suspend_device_tree);
-	class_put(class);
+		class_put(class);
+	}
 	return 0;
 }
 

--=-tFzRSbrqZe+ZmFlG2A44--

