Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTDPBP5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTDPBP5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:15:57 -0400
Received: from palrel10.hp.com ([156.153.255.245]:12512 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264188AbTDPBP4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 21:15:56 -0400
Date: Tue, 15 Apr 2003 18:27:43 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304160127.h3G1Rh3b010502@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: module symbol fix
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for trivial typo.  Without it, you can't insert anything on top of
agpgart.ko because the agp_register_driver() will erroneously pick up
the symbol version from agp_backend_acquire().  I'm surprised a bug
like this would survive for 9+ weeks.  Lack of testers?

	--david

===== kernel/module.c 1.72 vs edited =====
--- 1.72/kernel/module.c	Tue Apr  8 12:36:21 2003
+++ edited/kernel/module.c	Tue Apr 15 18:14:55 2003
@@ -165,7 +165,7 @@
 		if (gplok) {
 			for (i = 0; i < mod->num_gpl_syms; i++) {
 				if (strcmp(mod->gpl_syms[i].name, name) == 0) {
-					*crc = symversion(mod->crcs, i);
+					*crc = symversion(mod->gpl_crcs, i);
 					return mod->gpl_syms[i].value;
 				}
 			}
