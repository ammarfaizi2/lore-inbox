Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbUKXNEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUKXNEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUKXNDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:03:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39060 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262646AbUKXNBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:20 -0500
Subject: Suspend 2 merge: 11/51: Export vt functions.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294374.5805.232.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wide > 128 char displays, the text display gets messed up if gotoxy's
and gotoxay's variables are signed (I should confirm that this is still
the case - it's been a while).

We need to modify kmsg_redirect to see our messages when debugging :>


diff -ruN 401-export-vt-functions-old/drivers/char/vt.c 401-export-vt-functions-new/drivers/char/vt.c
--- 401-export-vt-functions-old/drivers/char/vt.c	2004-11-06 09:24:03.326462744 +1100
+++ 401-export-vt-functions-new/drivers/char/vt.c	2004-11-04 16:27:40.000000000 +1100
@@ -913,7 +913,7 @@
  */
 static void gotoxy(int currcons, int new_x, int new_y)
 {
-	int min_y, max_y;
+	unsigned int min_y, max_y;
 
 	if (new_x < 0)
 		x = 0;
@@ -940,7 +940,7 @@
 }
 
 /* for absolute user moves, when decom is set */
-static void gotoxay(int currcons, int new_x, int new_y)
+static void gotoxay(int currcons, unsigned int new_x, unsigned int new_y)
 {
 	gotoxy(currcons, new_x, decom ? (top+new_y) : new_y);
 }
@@ -3312,6 +3312,7 @@
  *	Visible symbols for modules
  */
 
+EXPORT_SYMBOL(kmsg_redirect);
 EXPORT_SYMBOL(color_table);
 EXPORT_SYMBOL(default_red);
 EXPORT_SYMBOL(default_grn);


