Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTFIGFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 02:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTFIGFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 02:05:17 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:8723 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S264219AbTFIGFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 02:05:14 -0400
Date: Mon, 9 Jun 2003 01:18:14 -0500 (CDT)
Message-Id: <200306090618.h596IEhX006480@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Hu Gang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oops in driver/serial/core.c
In-Reply-To: <20030608211928.3d425b56.hugang@soulinfo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the following patch instead, which preserves the reordering
done by Al Viro?

===== drivers/serial/core.c 1.62 vs edited =====
--- 1.62/drivers/serial/core.c	Fri Jun  6 01:36:47 2003
+++ edited/drivers/serial/core.c	Sun Jun  8 20:59:44 2003
@@ -2192,8 +2192,8 @@
 	drv->tty_driver = NULL;
 	tty_unregister_driver(p);
 	kfree(drv->state);
-	kfree(drv->tty_driver->termios);
-	kfree(drv->tty_driver);
+	kfree(p->termios);
+	kfree(p);
 }
 
 struct tty_driver *uart_console_device(struct console *co, int *index)
