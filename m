Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTFBARi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 20:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbTFBARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 20:17:37 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:11923 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S264769AbTFBARg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 20:17:36 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16090.39595.933087.45491@wombat.chubb.wattle.id.au>
Date: Mon, 2 Jun 2003 10:30:35 +1000
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Fix PS/2 keyboard and mouse on I2000
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	 The appended fix is needed on I2000 machines, to map the
legacy ISA interrupt onto the actual interrupt provided.  Otherwise
the mouse and keyboard won't work.  Patch against 2.5.70.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1101  -> 1.1102 
#	drivers/input/serio/i8042-io.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/27	peterc@gelato.unsw.edu.au	1.1102
# IA64: Fix  I2000 no keyboard interrupt problem.
# --------------------------------------------
#
diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Tue May 27 14:07:29 2003
+++ b/drivers/input/serio/i8042-io.h	Tue May 27 14:07:29 2003
@@ -20,11 +20,14 @@
  */
 
 #ifdef __alpha__
-#define I8042_KBD_IRQ	1
-#define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
+# define I8042_KBD_IRQ	1
+# define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
+#elif defined(__ia64__)
+# define I8042_KBD_IRQ isa_irq_to_vector(1)
+# define I8042_AUX_IRQ isa_irq_to_vector(12)
 #else
-#define I8042_KBD_IRQ	1
-#define I8042_AUX_IRQ	12
+# define I8042_KBD_IRQ	1
+# define I8042_AUX_IRQ	12
 #endif
 
 /*

