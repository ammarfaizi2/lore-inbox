Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319584AbSIMJdh>; Fri, 13 Sep 2002 05:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319585AbSIMJdh>; Fri, 13 Sep 2002 05:33:37 -0400
Received: from [61.149.34.153] ([61.149.34.153]:272 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S319584AbSIMJdg>;
	Fri, 13 Sep 2002 05:33:36 -0400
Date: Fri, 13 Sep 2002 17:35:40 +0800
From: Hu Gang <hugang@soulinfo.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [Patch]Make 2.5.3x serial can compile.
Message-Id: <20020913173540.74c49e74.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.7.8claws9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

The code is copy from arm 2.5.30 tree.
----------------------------------------------------
diff -ur ./8250.c /tmp/serial/8250.c
--- ./8250.c	Sun Sep  1 11:09:03 2002
+++ /tmp/serial/8250.c	Fri Sep 13 11:23:29 2002
@@ -31,7 +31,8 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
-#include <linux/serialP.h>
+#include <linux/circ_buf.h>
+#include <linux/serial.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
diff -ur ./8250.h /tmp/serial/8250.h
--- ./8250.h	Sun Sep  1 11:08:52 2002
+++ /tmp/serial/8250.h	Fri Sep 13 11:25:56 2002
@@ -58,4 +58,16 @@
 #define SERIAL8250_SHARE_IRQS 1
 #else
 #define SERIAL8250_SHARE_IRQS 0
+
+#if defined(__alpha__) && !defined(CONFIG_PCI)
+/*
+ * Digital did something really horribly wrong with the OUT1 and OUT2
+ * lines on at least some ALPHA's.  The failure mode is that if either
+ * is cleared, the machine locks up with endless interrupts.
+ */
+#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
+#else
+#define ALPHA_KLUDGE_MCR 0
+#endif
+
 #endif


-- 
		- Hu Gang
