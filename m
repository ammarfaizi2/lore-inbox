Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVIIVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVIIVJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIIVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:09:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34743 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030318AbVIIVJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:09:12 -0400
Date: Fri, 9 Sep 2005 22:09:08 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] envctrl fixes
Message-ID: <20050909210908.GG9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

envctrl doesn't need unistd.h; moreover, since it declares errno static
gcc4 gets very unhappy about including unistd.h.
	
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-m68k-8390/drivers/sbus/char/bbc_envctrl.c RC13-git7-envctrl/drivers/sbus/char/bbc_envctrl.c
--- RC13-git7-m68k-8390/drivers/sbus/char/bbc_envctrl.c	2005-08-28 23:09:45.000000000 -0400
+++ RC13-git7-envctrl/drivers/sbus/char/bbc_envctrl.c	2005-09-07 13:55:16.000000000 -0400
@@ -5,6 +5,7 @@
  */
 
 #define __KERNEL_SYSCALLS__
+static int errno;
 
 #include <linux/kernel.h>
 #include <linux/kthread.h>
@@ -13,8 +14,6 @@
 #include <linux/delay.h>
 #include <asm/oplib.h>
 #include <asm/ebus.h>
-static int errno;
-#include <asm/unistd.h>
 
 #include "bbc_i2c.h"
 #include "max1617.h"
diff -urN RC13-git7-m68k-8390/drivers/sbus/char/envctrl.c RC13-git7-envctrl/drivers/sbus/char/envctrl.c
--- RC13-git7-m68k-8390/drivers/sbus/char/envctrl.c	2005-08-28 23:09:45.000000000 -0400
+++ RC13-git7-envctrl/drivers/sbus/char/envctrl.c	2005-09-07 13:55:16.000000000 -0400
@@ -20,6 +20,7 @@
  */
 
 #define __KERNEL_SYSCALLS__
+static int errno;
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -38,9 +39,6 @@
 #include <asm/uaccess.h>
 #include <asm/envctrl.h>
 
-static int errno;
-#include <asm/unistd.h>
-
 #define ENVCTRL_MINOR	162
 
 #define PCF8584_ADDRESS	0x55
