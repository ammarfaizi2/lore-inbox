Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUE1Jbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUE1Jbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUE1Jbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:31:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:27806 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262434AbUE1J3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:29:07 -0400
Subject: [PATCH] use new msleep() in ADT746x driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085736188.5584.153.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 19:23:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces schedule_timeout() with the new msleep().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Colin Leroy <colin@colino.net>

--- drivers/macintosh/therm_adt746x.c.orig	2004-05-27 08:55:17.000000000 +0200
+++ drivers/macintosh/therm_adt746x.c	2004-05-28 08:59:27.589388936 +0200
@@ -247,8 +247,7 @@
 
 	while(monitor_running)
 	{
-		set_task_state(current, TASK_UNINTERRUPTIBLE);
-		schedule_timeout(2*HZ);
+		msleep(2000);
 
 		/* Check status */
 		/* local   : chip */
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

