Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313640AbSDPJJO>; Tue, 16 Apr 2002 05:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313641AbSDPJJN>; Tue, 16 Apr 2002 05:09:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46608 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313640AbSDPJJN>;
	Tue, 16 Apr 2002 05:09:13 -0400
Message-ID: <3CBBEA24.23A6ACFF@zip.com.au>
Date: Tue, 16 Apr 2002 02:08:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] add __LINE__ to out_of_line_bug()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 2.4.19-pre6/include/linux/kernel.h~oolb	Thu Apr 11 21:43:09 2002
+++ 2.4.19-pre6-akpm/include/linux/kernel.h	Thu Apr 11 21:44:26 2002
@@ -162,7 +162,8 @@ extern const char *print_tainted(void);
 #define max_t(type,x,y) \
 	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
 
-extern void out_of_line_bug(void) ATTRIB_NORET;
+extern void __out_of_line_bug(int line) ATTRIB_NORET;
+#define out_of_line_bug() __out_of_line_bug(__LINE__)
 
 #endif /* __KERNEL__ */
 
--- 2.4.19-pre6/kernel/panic.c~oolb	Thu Apr 11 21:44:37 2002
+++ 2.4.19-pre6-akpm/kernel/panic.c	Thu Apr 11 21:45:59 2002
@@ -134,8 +134,10 @@ int tainted = 0;
  * tells us what we want to know.
  */
 
-void out_of_line_bug(void)
+void __out_of_line_bug(int line)
 {
+	printk("kernel BUG in header file at line %d\n", line);
+
 	BUG();
 
 	/* Satisfy __attribute__((noreturn)) */
--- 2.4.19-pre6/kernel/ksyms.c~oolb	Thu Apr 11 21:46:03 2002
+++ 2.4.19-pre6-akpm/kernel/ksyms.c	Thu Apr 11 21:46:10 2002
@@ -454,7 +454,7 @@ EXPORT_SYMBOL(nr_running);
 
 /* misc */
 EXPORT_SYMBOL(panic);
-EXPORT_SYMBOL(out_of_line_bug);
+EXPORT_SYMBOL(__out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);
 EXPORT_SYMBOL(sscanf);
