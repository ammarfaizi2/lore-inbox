Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTBKBep>; Mon, 10 Feb 2003 20:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTBKBep>; Mon, 10 Feb 2003 20:34:45 -0500
Received: from kim.it.uu.se ([130.238.12.178]:62083 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265578AbTBKBeo>;
	Mon, 10 Feb 2003 20:34:44 -0500
Date: Tue, 11 Feb 2003 02:44:19 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302110144.CAA15199@kim.it.uu.se>
To: james.bottomley@steeleye.com
Subject: 2.5.60 3c509 & net/Space.c problem
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Linus' 2.5.60 announcement:

>James Bottomley <james.bottomley@steeleye.com>:
>  o 3c509 fixes: correct MCA probing, add back ISA probe to Space.c

This is somewhat broken. patch-2.5.60 has

--- a/drivers/net/Space.c       Mon Feb 10 10:39:23 2003
+++ b/drivers/net/Space.c       Mon Feb 10 10:39:23 2003
@@ -224,6 +224,9 @@
 #ifdef CONFIG_EL2              /* 3c503 */
        {el2_probe, 0},
 #endif
+#ifdef CONFIG_EL3
+       {el3_probe, 0},
+#endif
 #ifdef CONFIG_HPLAN
        {hp_probe, 0},
 #endif

but (a) there's no declaration for el3_probe() in scope at this
point, leading to a compile error, and (b) el3_probe() is still
'static' in 3c509.c, leading to a linkage error (assuming a
declaration for el3_probe() was added to Space.c to fix (a) first)

Reverting the patch to Space.c solved the problem for me.

Why the probe list entry? Isn't the module_init() in 3c509.c enough?

/Mikael
