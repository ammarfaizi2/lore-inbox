Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSGRDUC>; Wed, 17 Jul 2002 23:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318000AbSGRDUC>; Wed, 17 Jul 2002 23:20:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58282 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317999AbSGRDT6>;
	Wed, 17 Jul 2002 23:19:58 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [patch, 2.5] cs4232 doesn't kfree on error path
Date: Thu, 18 Jul 2002 13:09:57 +1000
Message-Id: <20020718032338.511C04462@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: (via Rusty) Marcus Alanen <maalanen@ra.abo.fi>

  ===== sound/oss/cs4232.c 1.5 vs edited =====

--- trivial-2.5.26/sound/oss/cs4232.c.orig	Thu Jul 18 13:00:55 2002
+++ trivial-2.5.26/sound/oss/cs4232.c	Thu Jul 18 13:00:55 2002
@@ -406,6 +406,7 @@
 	isapnpcfg->io_base	= dev->resource[0].start;
 	if (probe_cs4232(isapnpcfg,TRUE) == 0) {
 		printk(KERN_ERR "cs4232: ISA PnP card found, but not detected?\n");
+		kfree(isapnpcfg);
 		return -ENODEV;
 	}
 	attach_cs4232(isapnpcfg);
-- 
  Don't blame me: the Monkey is driving
