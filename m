Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSHLHiC>; Mon, 12 Aug 2002 03:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHLHiC>; Mon, 12 Aug 2002 03:38:02 -0400
Received: from DHCP-144-56.resnet.ua.edu ([130.160.144.56]:31880 "EHLO
	monket.dyndns.org") by vger.kernel.org with ESMTP
	id <S317517AbSHLHiB>; Mon, 12 Aug 2002 03:38:01 -0400
Date: Mon, 12 Aug 2002 02:40:28 -0500
From: Crutcher Dunnavant <crutcher@eng.ua.edu>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [rusty@rustcorp.com.au: [TRIVIAL] Fix for magic sysrq when CONFIG_VT=n]
Message-ID: <20020812024028.A5420@monket.dyndns.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch for SysRQ.

----- Forwarded message from Rusty Trivial Russell <rusty@rustcorp.com.au> -----

Date: Mon, 12 Aug 2002 16:26:27 +1000
To: mj@atrey.karlin.mff.cuni.cz, crutcher+kernel@datastacks.com
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
Subject: [TRIVIAL] Fix for magic sysrq when CONFIG_VT=n

From:  David Gibson <david@gibson.dropbear.id.au>

  The "unRaw" option for the magic sysrq key fails to compile if
  CONFIG_VT is false.  This patch fixes that:
  

--- trivial-2.5.31/drivers/char/sysrq.c.orig	2002-08-12 16:14:29.000000000 +1000
+++ trivial-2.5.31/drivers/char/sysrq.c	2002-08-12 16:14:29.000000000 +1000
@@ -76,7 +76,7 @@
 };
 #endif
 
-
+#ifdef CONFIG_VT
 /* unraw sysrq handler */
 static void sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
 			       struct tty_struct *tty) 
@@ -91,7 +91,7 @@
 	help_msg:	"unRaw",
 	action_msg:	"Keyboard mode set to XLATE",
 };
-
+#endif /* CONFIG_VT */
 
 /* reboot sysrq handler */
 static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
@@ -371,7 +371,11 @@
 		 as 'Off' at init time */
 /* p */	&sysrq_showregs_op,
 /* q */	NULL,
+#ifdef CONFIG_VT
 /* r */	&sysrq_unraw_op,
+#else
+/* r */ NULL,
+#endif
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,
-- 
  Don't blame me: the Monkey is driving
  File: David Gibson <david@gibson.dropbear.id.au>: [TRIVIAL] Fix for magic sysrq when CONFIG_VT=n

----- End forwarded message -----

-- 
Crutcher Dunnavant <crutcher+spam@eng.ua.edu>
ECSS System Hacker / UA COE CS Senior
