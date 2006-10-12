Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWJLSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWJLSIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWJLSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:08:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29368 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750965AbWJLSIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:08:00 -0400
Date: Thu, 12 Oct 2006 19:07:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] more kernel_execve() fallout (sbus)
Message-ID: <20061012180759.GI29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	drivers/sbus/char stuff using kernel_execve() needs linux/syscalls.h
now; includes trimmed, while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index d27e4f6..0d3660c 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -4,10 +4,8 @@
  * Copyright (C) 2001 David S. Miller (davem@redhat.com)
  */
 
-#include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/delay.h>
 #include <asm/oplib.h>
 #include <asm/ebus.h>
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 728a133..6b6a855 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -20,16 +20,12 @@
  */
 
 #include <linux/module.h>
-#include <linux/sched.h>
+#include <linux/init.h>
 #include <linux/kthread.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/init.h>
 #include <linux/miscdevice.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
+#include <linux/syscalls.h>
 
 #include <asm/ebus.h>
 #include <asm/uaccess.h>
