Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTAITIp>; Thu, 9 Jan 2003 14:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbTAITIo>; Thu, 9 Jan 2003 14:08:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:45517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266967AbTAITI2>;
	Thu, 9 Jan 2003 14:08:28 -0500
Subject: [PATCH] slab.c warnings
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1042139831.4864.51.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 11:17:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the compiler warnings in mm/slab.c:
Example:

mm/slab.c: In function `slab_destroy':
mm/slab.c:806: warning: passing arg 1 of `__slab_error' discards
qualifiers from pointer target type
mm/slab.c:810: warning: passing arg 1 of `__slab_error' discards
qualifiers from pointer target type



diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Thu Jan  9 11:10:13 2003
+++ b/mm/slab.c	Thu Jan  9 11:10:13 2003
@@ -502,7 +502,8 @@
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
 
-static void __slab_error(char *function, kmem_cache_t *cachep, char
*msg)
+static void __slab_error(const char *function, kmem_cache_t *cachep, 
+			 const char *msg)
 {
 	printk(KERN_ERR "slab error in %s(): cache `%s': %s\n",
 		function, cachep->name, msg);



