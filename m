Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278264AbRJMEaX>; Sat, 13 Oct 2001 00:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278266AbRJMEaN>; Sat, 13 Oct 2001 00:30:13 -0400
Received: from hermes.toad.net ([162.33.130.251]:15807 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S278264AbRJMEaD>;
	Sat, 13 Oct 2001 00:30:03 -0400
Subject: [PATCH] Minor bootflag.c fix
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Oct 2001 00:29:36 -0400
Message-Id: <1002947377.757.8.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, bootflag.c misleadingly reports an
invalid value read from CMOS RAM if SBF was not
enabled.

The patch:
--- linux-2.4.10-ac12/arch/i386/kernel/bootflag.c	Thu Oct 11 21:56:08 2001
+++ linux-2.4.10-ac12-fix/arch/i386/kernel/bootflag.c	Fri Oct 12 23:46:57 2001
@@ -128,7 +128,10 @@
 
 static void __init sbf_bootup(void)
 {
-	u8 v = sbf_read();
+	u8 v;
+	if(sbf_port == -1)
+		return;
+	v = sbf_read();
 	if(!sbf_value_valid(v))
 		printk(KERN_WARNING "SBF: Simple boot flag value 0x%x read from CMOS RAM was invalid\n",v);
 	v &= ~SBF_RESERVED;

