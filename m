Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbUKRLlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbUKRLlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUKRLjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:39:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63243 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262742AbUKRLgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:36:31 -0500
Date: Thu, 18 Nov 2004 12:36:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, kkeil@suse.de, kai.germaschewski@gmx.de
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Subject: [patch] 2.6.10-rc2-mm2: ISDN divert_init.c compile error
Message-ID: <20041118113624.GC4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/isdn/divert/divert_init.o
drivers/isdn/divert/divert_init.c:25: error: conflicting types for 'printk'
include/linux/kernel.h:106: error: previous declaration of 'printk' was here
drivers/isdn/divert/divert_init.c:25: error: conflicting types for 'printk'
include/linux/kernel.h:106: error: previous declaration of 'printk' was here
make[3]: *** [drivers/isdn/divert/divert_init.o] Error 1

<--  snip  -->


The fix is simple:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm2-full/drivers/isdn/divert/divert_init.c.old	2004-11-18 12:28:11.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/isdn/divert/divert_init.c	2004-11-18 12:31:08.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 
 #include "isdn_divert.h"
 
@@ -19,11 +20,6 @@
 MODULE_AUTHOR("Werner Cornelius");
 MODULE_LICENSE("GPL");
 
-/********************/
-/* needed externals */
-/********************/
-extern int printk(const char *fmt,...);
-
 /****************************************/
 /* structure containing interface to hl */
 /****************************************/

