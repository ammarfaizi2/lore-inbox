Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSH0CD4>; Mon, 26 Aug 2002 22:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSH0CD4>; Mon, 26 Aug 2002 22:03:56 -0400
Received: from dp.samba.org ([66.70.73.150]:15327 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318332AbSH0CDz>;
	Mon, 26 Aug 2002 22:03:55 -0400
Date: Tue, 27 Aug 2002 12:08:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Compile fix for magic sysrq and !CONFIG_VT
Message-ID: <20020827020855.GW18818@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This fixes compilation of the magic sysrq code
when compiled without CONFIG_VT.

diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/char/sysrq.c linux-bluefish/drivers/char/sysrq.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/char/sysrq.c	2002-07-16 09:13:58.000000000 +1000
+++ linux-bluefish/drivers/char/sysrq.c	2002-08-02 16:36:30.000000000 +1000
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
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
