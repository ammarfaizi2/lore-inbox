Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSKEEuw>; Mon, 4 Nov 2002 23:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSKEEuw>; Mon, 4 Nov 2002 23:50:52 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:51977
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263081AbSKEEuv>; Mon, 4 Nov 2002 23:50:51 -0500
Date: Mon, 4 Nov 2002 23:59:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][2.5] nolapic boot parameter (resend)
Message-ID: <Pine.LNX.4.44.0211042107290.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has bugged me for a while, also applies to 2.4.45

Index: linux-2.5.44-ac5/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.44-ac5/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.44-ac5/arch/i386/kernel/apic.c	3 Nov 2002 07:20:03 -0000	1.1.1.1
+++ linux-2.5.44-ac5/arch/i386/kernel/apic.c	3 Nov 2002 07:43:50 -0000
@@ -609,11 +609,20 @@
 
 #endif	/* CONFIG_PM */
 
+int dont_enable_local_apic __initdata = 0;
+
+static int __init nolapic_setup(char *str)
+{
+	dont_enable_local_apic = 1;
+	return 1;
+}
+
+__setup("nolapic", nolapic_setup);
+
 /*
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
-int dont_enable_local_apic __initdata = 0;
 
 static int __init detect_init_APIC (void)
 {

-- 
function.linuxpower.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


