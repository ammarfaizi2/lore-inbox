Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUJWEaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUJWEaI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUJWE32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:29:28 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:6023
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267696AbUJWE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:17 -0400
Subject: [patch 2/5] UML: resync LDS script for SMP changes
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sat, 23 Oct 2004 05:53:16 +0200
Message-Id: <20041023035316.B7CC48F3C@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a couple entries to the linker script which are needed for SMP to link.
(From Yan Burman)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/dyn.lds.S |    2 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/uml.lds.S |    2 ++
 2 files changed, 4 insertions(+)

diff -puN arch/um/kernel/uml.lds.S~uml-smp-lds-fix arch/um/kernel/uml.lds.S
--- vanilla-linux-2.6.9/arch/um/kernel/uml.lds.S~uml-smp-lds-fix	2004-10-21 01:33:45.945044440 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/uml.lds.S	2004-10-21 01:33:45.947044136 +0200
@@ -35,6 +35,8 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
+    *(.fixup)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
diff -puN arch/um/kernel/dyn.lds.S~uml-smp-lds-fix arch/um/kernel/dyn.lds.S
--- vanilla-linux-2.6.9/arch/um/kernel/dyn.lds.S~uml-smp-lds-fix	2004-10-21 01:33:58.339160248 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/dyn.lds.S	2004-10-21 01:36:01.192483704 +0200
@@ -59,6 +59,8 @@ SECTIONS
   .text           : {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
+    *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
_
