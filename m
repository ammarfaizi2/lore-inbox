Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTFWXta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTFWXs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:48:27 -0400
Received: from palrel11.hp.com ([156.153.255.246]:16578 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264692AbTFWXrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:47:11 -0400
Date: Mon, 23 Jun 2003 17:01:18 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306240001.h5O01IjH011137@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: compat_sys_old_getrlimit() depends on sys_old_getrlimit()
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compat_sys_old_getrlimit() depends on sys_old_getrlimit() and the patch
below updates the guarding #ifdef accordingly.

	--david

===== kernel/sys.c 1.47 vs edited =====
--- 1.47/kernel/sys.c	Thu Jun 12 15:53:14 2003
+++ edited/kernel/sys.c	Mon Jun 23 16:01:39 2003
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/utsname.h>
@@ -1219,7 +1220,7 @@
 			? -EFAULT : 0;
 }
 
-#if !defined(__ia64__) && !defined(CONFIG_V850)
+#if defined(COMPAT_RLIM_OLD_INFINITY) || !(defined(CONFIG_IA64) || defined(CONFIG_V850))
 
 /*
  *	Back compatibility for getrlimit. Needed for some apps.
