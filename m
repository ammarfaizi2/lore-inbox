Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSHBMTl>; Fri, 2 Aug 2002 08:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSHBMTl>; Fri, 2 Aug 2002 08:19:41 -0400
Received: from calhau.terra.com.br ([200.176.3.20]:21656 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S312619AbSHBMTk>; Fri, 2 Aug 2002 08:19:40 -0400
Date: Fri, 2 Aug 2002 09:24:56 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Subject: [PATCH] __devexit_p macro
Message-Id: <20020802092456.23a3c49a.felipewd@terra.com.br>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This patch defines  __devexit_p when CONFIG_HOTPLUG || MODULE, instead of
when just CONFIG_HOTPLUG is defined.

	This is needed for some net drivers (at least) that use "remove_one"
(which use unregister_netdev), allowing the driver to be re-installed.

	This is the same behaviour that 2.4.

	Patch against 2.5.30

	Please consider pulling it from:

http://cscience.org/~coqueiro/linux/patches-fwd/2.5/init.h-__devexit_p.patch

Felipe

--- ./include/linux/init.h.orig	Fri Aug  2 09:15:44 2002
+++ ./include/linux/init.h	Fri Aug  2 09:06:39 2002
@@ -177,12 +177,16 @@
 #define __devinitdata
 #define __devexit
 #define __devexitdata
-#define __devexit_p(x)  &(x)
 #else
 #define __devinit __init
 #define __devinitdata __initdata
 #define __devexit __exit
 #define __devexitdata __exitdata
+#endif
+
+#ifdef MODULE || CONFIG_HOTPLUG
+#define __devexit_p(x)  &(x)
+#else
 #define __devexit_p(x)  0
 #endif
 
