Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVBJPnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVBJPnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVBJPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:43:33 -0500
Received: from sd291.sivit.org ([194.146.225.122]:5509 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262145AbVBJPn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:43:26 -0500
Date: Thu, 10 Feb 2005 16:45:07 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/5] sonypi: replace schedule_timeout() with msleep()
Message-ID: <20050210154507.GF3493@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Replace schedule_timeout() with msleep() - from janitors.

Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 sonypi.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

===================================================================

Index: drivers/char/sonypi.c
===================================================================
--- a/drivers/char/sonypi.c	(revision 26538)
+++ b/drivers/char/sonypi.c	(revision 26539)
@@ -1,7 +1,7 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
@@ -286,17 +286,14 @@ static void sonypi_camera_on(void)
 
 	for (j = 5; j > 0; j--) {
 
-		while (sonypi_call2(0x91, 0x1)) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		while (sonypi_call2(0x91, 0x1))
+			msleep(10);
 		sonypi_call1(0x93);
 
 		for (i = 400; i > 0; i--) {
 			if (sonypi_camera_ready())
 				break;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			msleep(10);
 		}
 		if (i)
 			break;
-- 
Stelian Pop <stelian@popies.net>
