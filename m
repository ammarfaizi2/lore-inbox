Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSGSBaQ>; Thu, 18 Jul 2002 21:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSGSBaP>; Thu, 18 Jul 2002 21:30:15 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:3561 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S318426AbSGSBaN>;
	Thu, 18 Jul 2002 21:30:13 -0400
Date: Thu, 18 Jul 2002 22:06:35 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_MAGIC_SYSRQ without CONFIG_VT broken in 2.5.26
Message-ID: <20020718220635.A15794@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.26 fails with missing symbols fg_console and kbd_table if
enabling Magic SysRq but disabling virtual terminals. The
trivial patch below fixes this.

- Werner

------------------------------------ patch ------------------------------------

--- linux-2.5.26/drivers/char/sysrq.c.orig	Thu Jul 18 12:55:09 2002
+++ linux-2.5.26/drivers/char/sysrq.c	Thu Jul 18 12:55:15 2002
@@ -74,7 +74,6 @@
 	help_msg:	"saK",
 	action_msg:	"SAK",
 };
-#endif
 
 
 /* unraw sysrq handler */
@@ -91,6 +90,7 @@
 	help_msg:	"unRaw",
 	action_msg:	"Keyboard mode set to XLATE",
 };
+#endif /* CONFIG_VT */
 
 
 /* reboot sysrq handler */
@@ -371,7 +371,9 @@
 		 as 'Off' at init time */
 /* p */	&sysrq_showregs_op,
 /* q */	NULL,
+#ifdef CONFIG_VT
 /* r */	&sysrq_unraw_op,
+#endif
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
