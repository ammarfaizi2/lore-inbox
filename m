Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSKLABF>; Mon, 11 Nov 2002 19:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264692AbSKLABF>; Mon, 11 Nov 2002 19:01:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:65259 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263321AbSKLABE>; Mon, 11 Nov 2002 19:01:04 -0500
Date: Mon, 11 Nov 2002 16:16:11 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: [PATCH 2.4] Backport of container_of macro
Message-ID: <14650000.1037060171@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This nifty little macro is used a lot in 2.5 but does not exist
in 2.4 yet. Here is a patch to include it.

Hanna

 kernel.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -Nru linux-2.4.20-rc1/include/linux/kernel.h 
linux-container_of/include/linux/kernel.h
--- linux-2.4.20-rc1/include/linux/kernel.h	Mon Nov 11 15:23:09 2002
+++ linux-container_of/include/linux/kernel.h	Mon Nov 11 15:23:16 2002
@@ -174,6 +174,17 @@
 extern void __out_of_line_bug(int line) ATTRIB_NORET;
 #define out_of_line_bug() __out_of_line_bug(__LINE__)

+/*
+ * container_of - cast a member of a structure out to the containing 
structure
+ *
+ * @ptr:        the pointer to the member.
+ * @type:       the type of the container struct this is embedded in.
+ * @member:     the name of the member within the struct.
+ */
+#define container_of(ptr, type, member) ({                      \
+	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
 #endif /* __KERNEL__ */

 #define SI_LOAD_SHIFT	16

