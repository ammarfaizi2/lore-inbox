Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbTGSLbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGSLbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 07:31:37 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:30696 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S266004AbTGSLbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 07:31:35 -0400
Message-Id: <200307191142.h6JBg7re022191@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Linux 2.4.22-pre7
To: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Sat, 19 Jul 2003 13:41:33 +0200
References: <aJyM.3dH.27@gated-at.bofh.it> <aNLX.6Go.5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

> on alpha:
> 
> internal.h:19:28: asm/kmap_types.h: No such file or directory

Same on s390 and some other platforms.We should just get rid of
this problem by providing a generic kmap_types header.

Marcello, please consider this patch.

        Arnd <><

-- 

D: Add generic <asm/kmap_types.h> for all architectures that are missing it.
D: This is needed to build the crypto drivers.

diff -Nru a/include/asm-generic/kmap_types.h b/include/asm-generic/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/kmap_types.h  Sat Jul 19 13:33:30 2003
@@ -0,0 +1,22 @@
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+/* This header defines a generic km_type that can be
+ * used by all architectures that do not support
+ * high memory.
+ */
+
+enum km_type {
+       KM_BOUNCE_READ,
+       KM_SKB_SUNRPC_DATA,
+       KM_SKB_DATA_SOFTIRQ,
+       KM_USER0,
+       KM_USER1,
+       KM_BH_IRQ,
+       KM_SOFTIRQ0,
+       KM_SOFTIRQ1,
+
+       KM_TYPE_NR
+};
+
+#endif
diff -Nru a/include/asm-alpha/kmap_types.h b/include/asm-alpha/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/kmap_types.h    Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-arm/kmap_types.h b/include/asm-arm/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm/kmap_types.h      Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-cris/kmap_types.h b/include/asm-cris/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-cris/kmap_types.h     Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-ia64/kmap_types.h b/include/asm-ia64/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/kmap_types.h     Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-s390/kmap_types.h b/include/asm-s390/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390/kmap_types.h     Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-s390x/kmap_types.h b/include/asm-s390x/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390x/kmap_types.h    Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-sh/kmap_types.h b/include/asm-sh/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-sh/kmap_types.h       Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
diff -Nru a/include/asm-sh64/kmap_types.h b/include/asm-sh64/kmap_types.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/asm-sh64/kmap_types.h     Sat Jul 19 13:33:30 2003
@@ -0,0 +1 @@
+#include <asm-generic/kmap_types.h>
