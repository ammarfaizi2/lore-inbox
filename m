Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268675AbUILL0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268675AbUILL0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUILLXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:23:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13819 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268678AbUILLWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:22:47 -0400
Date: Sun, 12 Sep 2004 13:22:31 +0200 (MEST)
Message-Id: <200409121122.i8CBMVff015162@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dahinds@users.sourceforge.net, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] pcmcia mem_op.h gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel caused by include/pcmcia/mem_op.h. The changes are all
backports from the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/include/pcmcia/mem_op.h.~1~	2001-02-22 15:23:49.000000000 +0100
+++ linux-2.4.28-pre3/include/pcmcia/mem_op.h	2004-09-12 01:56:20.000000000 +0200
@@ -81,7 +81,9 @@
     n -= odd;
     while (n) {
 	*(u_short *)to = __raw_readw(from);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	*(u_char *)to = readb(from);
@@ -93,7 +95,9 @@
     n -= odd;
     while (n) {
 	__raw_writew(*(u_short *)from, to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	writeb(*(u_char *)from, to);
@@ -105,7 +109,9 @@
     n -= odd;
     while (n) {
 	put_user(__raw_readw(from), (short *)to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	put_user(readb(from), (char *)to);
@@ -120,7 +126,9 @@
     while (n) {
 	get_user(s, (short *)from);
 	__raw_writew(s, to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd) {
 	get_user(c, (char *)from);
