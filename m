Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273545AbRIVEW3>; Sat, 22 Sep 2001 00:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273504AbRIVEWT>; Sat, 22 Sep 2001 00:22:19 -0400
Received: from ORION.SAS.UPENN.EDU ([128.91.55.26]:29179 "EHLO
	orion.sas.upenn.edu") by vger.kernel.org with ESMTP
	id <S273596AbRIVEWI>; Sat, 22 Sep 2001 00:22:08 -0400
Date: Sat, 22 Sep 2001 00:22:33 -0400 (EDT)
From: Matias Atria <matias@sas.upenn.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] UFS option parsing
Message-ID: <Pine.SOL.4.33.0109212358400.21407-100000@mail1.sas.upenn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Today I accidentally typed "mount -t ufs -o ufstype,ro ..." and the kernel
(2.4.9) oopsed. The following trivial patch fixes it.

Cheers,
Matias.

--- 2.4.9/fs/ufs/super.c.orig Fri Sep 21 20:30:30 2001
+++ 2.4.9/fs/ufs/super.c      Fri Sep 21 21:59:34 2001
@@ -264,6 +264,11 @@
                if ((value = strchr (this_char, '=')) != NULL)
                        *value++ = 0;
                if (!strcmp (this_char, "ufstype")) {
+                       if (!value) {
+                               printk ("UFS-fs: The `ufstype' option "
+                                       "requires an argument\n");
+                               return 0;
+                       }
                        ufs_clear_opt (*mount_options, UFSTYPE);
                        if (!strcmp (value, "old"))
                                ufs_set_opt (*mount_options, UFSTYPE_OLD);
@@ -287,6 +292,10 @@
                        }
                }
                else if (!strcmp (this_char, "onerror")) {
+                       if (!value) {
+                               printk ("UFS-fs: No `onerror' action specified\n");
+                               return 0;
+                       }
                        ufs_clear_opt (*mount_options, ONERROR);
                        if (!strcmp (value, "panic"))
                                ufs_set_opt (*mount_options, ONERROR_PANIC);


