Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSL1XZu>; Sat, 28 Dec 2002 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSL1XZu>; Sat, 28 Dec 2002 18:25:50 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:62139 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264711AbSL1XZs>; Sat, 28 Dec 2002 18:25:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: william stinson <wstinson@wanadoo.fr>
Subject: Re: [PATCH] deprecated function attribute
Date: Sun, 29 Dec 2002 00:32:48 +0100
User-Agent: KMail/1.4.3
To: Robert Love <rml@tech9.net>
Cc: Alexander Kellett <lypanov@kde.org>, Rusty Russell <rusty@rustcorp.com.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212290032.48372.wstinson@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

here's a patch to mark check_region "deprecated".

I have not done much testing with it yet (and maybe there is a more elegant implementation)

I do get nice warning messages for programs that still use check_region for example
	drivers/parport/parport_pc.c:2215: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:111)

Best regards
William

--- linux-2.5.53/kernel/resource.c	2002-12-28 23:05:37.000000000 +0100
+++ linux-local/kernel/resource.c	2002-12-28 23:05:55.000000000 +0100
@@ -237,7 +237,7 @@
 	return res;
 }
 
-int __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource * res;
 
--- linux-2.5.53/include/linux/ioport.h	2002-12-28 23:02:52.000000000 +0100
+++ linux-local/include/linux/ioport.h	2002-12-28 23:14:46.000000000 +0100
@@ -8,6 +8,7 @@
 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
 
+#include <linux/compiler.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -107,7 +108,7 @@
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
+extern int deprecated __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
 
 #define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)




