Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBTWSG>; Tue, 20 Feb 2001 17:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129490AbRBTWR5>; Tue, 20 Feb 2001 17:17:57 -0500
Received: from [199.239.160.155] ([199.239.160.155]:8965 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129243AbRBTWRo>; Tue, 20 Feb 2001 17:17:44 -0500
Date: Tue, 20 Feb 2001 14:17:42 -0800
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] configurable printk buffer size
Message-ID: <20010220141742.D4106@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net> <3A92C76C.6519DF1A@cypress.com> <20010220121727.B4106@tenchi.datarithm.net> <3A92D930.6F11B505@cypress.com> <20010220140515.C4106@tenchi.datarithm.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220140515.C4106@tenchi.datarithm.net>; from rread@datarithm.net on Tue, Feb 20, 2001 at 02:05:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The obvious solution struck me just after the last email.  I change
the config parameter to be an order, like the argument to
get_free_pages().  How does this look?  It's not tested, but there
isn't much to it...

robert

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="printk-buflen.patch"

diff --exclude=*~ -ru linux-2.4.2-pre4/arch/i386/config.in linux-2.4.2-pre4-logbuf/arch/i386/config.in
--- linux-2.4.2-pre4/arch/i386/config.in	Mon Jan  8 13:27:56 2001
+++ linux-2.4.2-pre4-logbuf/arch/i386/config.in	Tue Feb 20 14:10:12 2001
@@ -366,4 +366,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size order 2**x' CONFIG_PRINTK_BUF_ORDER 14
 endmenu
diff --exclude=*~ -ru linux-2.4.2-pre4/kernel/printk.c linux-2.4.2-pre4-logbuf/kernel/printk.c
--- linux-2.4.2-pre4/kernel/printk.c	Tue Feb 20 11:56:31 2001
+++ linux-2.4.2-pre4-logbuf/kernel/printk.c	Tue Feb 20 14:10:06 2001
@@ -23,7 +23,11 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)
+#ifdef CONFIG_PRINTK_BUF_LEN
+# define LOG_BUF_LEN   (2**CONFIG_PRINTK_BUF_ORDER)
+#else
+# define LOG_BUF_LEN   (16384)
+#endif   
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 static char buf[1024];

--aM3YZ0Iwxop3KEKx--
