Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUH0QOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUH0QOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUH0QOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:14:07 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:12051 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S266449AbUH0QNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:13:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.6.8.1 platform update for ES7000 
Date: Fri, 27 Aug 2004 12:13:41 -0400
Message-ID: <3010F4D7BBD5F64C9C2D17B9D17BB37704E55E80@USTR-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.8.1 platform update for ES7000 
Thread-Index: AcSMT+uDCtGP/bmGRWutvXjBZQ7hxgAAH2jA
From: "Davis, Jason" <jason.davis@unisys.com>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>, "Davis, Jason" <jason.davis@unisys.com>
X-OriginalArrivalTime: 27 Aug 2004 16:13:41.0485 (UTC) FILETIME=[D19769D0:01C48C50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

This update only applies to Unisys' ES7000 server machines. The patch
adds a OEM id check to verify the current machine running is actually a
Unisys type box before executing the Unisys OEM parser routine. It also
increases the MAX_MP_BUSSES definition from 32 to 256. On the ES7000s,
bus ID numbering can range from 0 to 255. Without the patch, the system
panics if booted with acpi=off.
This patch has been tested and verified on an authentic ES7000 machine.

Thanks,
Jason Davis

diff -Naur linux-2.6.8.1-inc/include/asm-i386/mach-es7000/mach_mpparse.h
linux-2.6.8.1-es7k/include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.8.1-inc/include/asm-i386/mach-es7000/mach_mpparse.h
2004-08-14 06:54:46.000000000 -0400
+++ linux-2.6.8.1-es7k/include/asm-i386/mach-es7000/mach_mpparse.h
2004-08-26 13:31:46.703952120 -0400
@@ -21,7 +21,8 @@
 	if (mpc->mpc_oemptr) {
 		struct mp_config_oemtable *oem_table = 
 			(struct mp_config_oemtable *)mpc->mpc_oemptr;
-		return parse_unisys_oem((char *)oem_table,
oem_table->oem_length);
+		if (!strncmp(oem, "UNISYS", 6))
+			return parse_unisys_oem((char *)oem_table,
oem_table->oem_length);
 	}
 	return 0;
 }

diff -Naur linux-2.6.8.1-inc/include/asm-i386/mach-es7000/mach_mpspec.h
linux-2.6.8.1-es7k/include/asm-i386/mach-es7000/mach_mpspec.h
--- linux-2.6.8.1-inc/include/asm-i386/mach-es7000/mach_mpspec.h
2004-08-14 06:55:09.000000000 -0400
+++ linux-2.6.8.1-es7k/include/asm-i386/mach-es7000/mach_mpspec.h
2004-08-26 11:29:32.074985208 -0400
@@ -3,6 +3,6 @@
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+#define MAX_MP_BUSSES 256
 
 #endif /* __ASM_MACH_MPSPEC_H */
