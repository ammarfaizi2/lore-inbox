Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWC0PSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWC0PSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWC0PSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:18:44 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:4047 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751081AbWC0PSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:18:43 -0500
Date: Tue, 28 Mar 2006 00:18:54 +0900 (JST)
Message-Id: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, akpm@osdl.org
Subject: [PATCH] Fix sed regexp to generate asm-offset.h
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to Makefile.kbuild ("kbuild: add -fverbose-asm to i386
Makefile") breaks asm-offset.h file on MIPS.  Other archs possibly
suffer this change too but I'm not sure.

Here is a fix just for MIPS.  

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/Kbuild b/Kbuild
index 95d6a00..2d4f95e 100644
--- a/Kbuild
+++ b/Kbuild
@@ -18,7 +18,7 @@ define sed-y
 	"/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"
 endef
 # Override default regexp for specific architectures
-sed-$(CONFIG_MIPS) := "/^@@@/s///p"
+sed-$(CONFIG_MIPS) := "/^@@@/{s/^@@@//; s/ \#.*\$$//; p;}"
 
 quiet_cmd_offsets = GEN     $@
 define cmd_offsets
