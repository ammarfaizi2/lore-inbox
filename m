Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSJKOLf>; Fri, 11 Oct 2002 10:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJKOLR>; Fri, 11 Oct 2002 10:11:17 -0400
Received: from holomorphy.com ([66.224.33.161]:14977 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262484AbSJKOJr>;
	Fri, 11 Oct 2002 10:09:47 -0400
Date: Fri, 11 Oct 2002 07:12:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz
Subject: make idedisk_suspend()/idedisk_resume() conditional on CONFIG_SOFTWARE_SUSPEND
Message-ID: <20021011141218.GP12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-disk.c gets the following warning:

drivers/ide/ide-disk.c:1614: warning: `idedisk_suspend' defined but not used
drivers/ide/ide-disk.c:1651: warning: `idedisk_resume' defined but not used


--- akpm-2.5.41-3/drivers/ide/ide-disk.c	2002-10-11 06:09:31.000000000 -0700
+++ wli-2.5.41-3/drivers/ide/ide-disk.c	2002-10-11 06:53:58.000000000 -0700
@@ -1610,6 +1610,7 @@
 #endif
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
 {
 	ide_drive_t *drive = dev->driver_data;
@@ -1659,7 +1660,7 @@
 	drive->blocked = 0;
 	return 0;
 }
-
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 /* This is just a hook for the overall driver tree.
  */
