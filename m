Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310442AbSBRLYs>; Mon, 18 Feb 2002 06:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310444AbSBRLYh>; Mon, 18 Feb 2002 06:24:37 -0500
Received: from p3EE02AF2.dip.t-dialin.net ([62.224.42.242]:31760 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S310442AbSBRLYf>;
	Mon, 18 Feb 2002 06:24:35 -0500
Date: Mon, 18 Feb 2002 12:22:21 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 fix for loop driver to support 256 devices
Message-ID: <20020218122221.A28805@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While faking large volume groups a minor flaw in the loop driver showed up,
which fails creating the maximum of 256 devices.

The followong patch against 2.4.17 fixes that here.


diff -u linux-2.4.17.orig/drivers/block/loop.c linux-2.4.17/drivers/block/loop.c
--- linux-2.4.17.orig/drivers/block/loop.c      Fri Dec 21 18:41:53 2001
+++ linux-2.4.17/drivers/block/loop.c   Mon Feb 18 12:23:32 2002
@@ -36,6 +36,9 @@
  * Al Viro too.
  * Jens Axboe <axboe@suse.de>, Nov 2000
  *
+ * Support up to 256 loop devices
+ * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
+ *
  * Still To Fix:
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
@@ -965,7 +968,7 @@
  * And now the modules code and kernel interface.
  */
 MODULE_PARM(max_loop, "i");
-MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-255)");
+MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
 MODULE_LICENSE("GPL");

 int loop_register_transfer(struct loop_func_table *funcs)
@@ -1001,9 +1004,9 @@
 {
        int     i;

-       if ((max_loop < 1) || (max_loop > 255)) {
+       if ((max_loop < 1) || (max_loop > 256)) {
                printk(KERN_WARNING "loop: invalid max_loop (must be between"
-                                   " 1 and 255), using default (8)\n");
+                                   " 1 and 256), using default (8)\n");
                max_loop = 8;
        }

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
