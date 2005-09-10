Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVIJMEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIJMEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIJMEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:04:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:27857 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbVIJMEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:04:42 -0400
Date: Sat, 10 Sep 2005 14:04:40 +0200
From: "Andi Kleen" <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: [1/2] Make BUILD_BUG_ON fail at compile time.
Message-ID: <4322CBD8.mailE1M1FX8RR@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make BUILD_BUG_ON fail at compile time.

Force a compiler error instead of a link error, because they
are easier to track down. Idea stolen from code by Jan Beulich.

Cc: jbeulich@novell.com

Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h
+++ linux/include/linux/kernel.h
@@ -307,8 +307,8 @@ struct sysinfo {
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-extern void BUILD_BUG(void);
-#define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
+/* Force a compilation error if condition is false */
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
 #ifdef CONFIG_SYSCTL
 extern int randomize_va_space;
