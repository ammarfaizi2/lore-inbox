Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319054AbSHSWEx>; Mon, 19 Aug 2002 18:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319061AbSHSWEx>; Mon, 19 Aug 2002 18:04:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46040 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319054AbSHSWEw>;
	Mon, 19 Aug 2002 18:04:52 -0400
Subject: [TRIVIAL] [PATCH] notsc-warning_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 14:53:01 -0700
Message-Id: <1029793982.948.204.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 
	This patch simply prints a warning message when "notsc" is passed to a
kernel that is compiled w/ CONFIG_X86_TSC, and thus ignores the boot
option (Also renames tsc_setup -> notsc_setup).

thanks
-john

diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Aug 19 14:49:55 2002
+++ b/arch/i386/kernel/setup.c	Mon Aug 19 14:49:55 2002
@@ -1138,14 +1138,19 @@
 #ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;
 
-static int __init tsc_setup(char *str)
+static int __init notsc_setup(char *str)
 {
 	tsc_disable = 1;
 	return 1;
 }
-
-__setup("notsc", tsc_setup);
+#else
+static int __init notsc_setup(char *str)
+{
+	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
+	return 1;
+}
 #endif
+__setup("notsc", notsc_setup);
 
 static int __init highio_setup(char *str)
 {

