Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVAJFuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVAJFuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVAJFsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:48:00 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:33540
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262109AbVAJFOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:53 -0500
Message-Id: <200501100736.j0A7a2PW005835@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH 21/28] UML - Silence some message from the console driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This shuts up some messages about ioctls being called when they are handled
by the line discipline.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/drivers/line.c
===================================================================
--- linux-2.6.10.orig/arch/um/drivers/line.c	2005-01-04 11:12:17.000000000 -0500
+++ linux-2.6.10/arch/um/drivers/line.c	2005-01-07 00:37:45.000000000 -0500
@@ -198,6 +198,37 @@
 
 	ret = 0;
 	switch(cmd) {
+#ifdef TIOCGETP
+	case TIOCGETP:
+	case TIOCSETP:
+	case TIOCSETN:
+#endif
+#ifdef TIOCGETC
+	case TIOCGETC:
+	case TIOCSETC:
+#endif
+#ifdef TIOCGLTC
+	case TIOCGLTC:
+	case TIOCSLTC:
+#endif
+	case TCGETS:
+	case TCSETSF:
+	case TCSETSW:
+	case TCSETS:
+	case TCGETA:
+	case TCSETAF:
+	case TCSETAW:
+	case TCSETA:
+	case TCXONC:
+	case TCFLSH:
+	case TIOCOUTQ:
+	case TIOCINQ:
+	case TIOCGLCKTRMIOS:
+	case TIOCSLCKTRMIOS:
+	case TIOCPKT:
+	case TIOCGSOFTCAR:
+	case TIOCSSOFTCAR:
+		return -ENOIOCTLCMD;
 #if 0
 	case TCwhatever:
 		/* do something */

