Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVDCGL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDCGL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDCGL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:11:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17063 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261511AbVDCGLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:11:20 -0500
Date: Sat, 2 Apr 2005 22:11:35 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 1/4] Add deprecated_for_modules
Message-ID: <20050403061135.GA1641@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a deprecated_for_modules macro that allows symbols to be
deprecated only when used by modules, as suggested by Andrew
Morton some months back.

Signed-off-by: <paulmck@us.ibm.com>
---

diff -urpN -X dontdiff linux-2.6.12-rc1/include/linux/module.h linux-2.6.12-rc1-bettersk/include/linux/module.h
--- linux-2.6.12-rc1/include/linux/module.h	Thu Mar 31 09:53:20 2005
+++ linux-2.6.12-rc1-bettersk/include/linux/module.h	Sat Apr  2 11:47:43 2005
@@ -195,6 +195,12 @@ void *__symbol_get_gpl(const char *symbo
 #define EXPORT_SYMBOL_GPL(sym)					\
 	__EXPORT_SYMBOL(sym, "_gpl")
 
+#ifdef MODULE
+#define deprecated_for_modules __deprecated
+#else
+#define deprecated_for_modules
+#endif
+
 #endif
 
 struct module_ref
