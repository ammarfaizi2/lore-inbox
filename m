Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUKQShq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUKQShq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUKQShi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:37:38 -0500
Received: from colino.net ([213.41.131.56]:46575 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262339AbUKQSfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:35:41 -0500
Date: Wed, 17 Nov 2004 19:34:16 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Switch therm_adt746x to new module_param
Message-ID: <20041117193416.52a86d03.colin.lkml@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this patch replaces MODULE_PARM to module_param for adt746x.

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/macintosh/therm_adt746x.c	2004-11-17 19:26:16.908413504 +0100
+++ b/drivers/macintosh/therm_adt746x.c	2004-11-17 19:28:01.193559752 +0100
@@ -23,6 +23,8 @@
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/suspend.h>
+#include <linux/kthread.h>
+#include <linux/moduleparam.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -30,7 +32,6 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
-#include <linux/kthread.h>
 
 #undef DEBUG
 
@@ -56,11 +57,11 @@
 		   "Powerbook G4 Alu");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(limit_adjust,"i");
+module_param(limit_adjust, int, 0);
 MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50 cpu, 70 gpu) "
 		 "by N degrees.");
 
-MODULE_PARM(fan_speed,"i");
+module_param(fan_speed, int, 64);
 MODULE_PARM_DESC(fan_speed,"Specify starting fan speed (0-255) "
 		 "(default 64)");
 
