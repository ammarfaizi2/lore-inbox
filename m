Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbTDGXgp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTDGXeq (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:34:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4993
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263877AbTDGXNe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:13:34 -0400
Date: Tue, 8 Apr 2003 01:32:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080032.h380WTNh009200@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: header for pc9800 type detection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/pc9800.h linux-2.5.67-ac1/include/asm-i386/pc9800.h
--- linux-2.5.67/include/asm-i386/pc9800.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/pc9800.h	2003-04-06 23:35:15.000000000 +0100
@@ -0,0 +1,27 @@
+/*
+ *  PC-9800 machine types.
+ *
+ *  Copyright (C) 1999	TAKAI Kosuke <tak@kmc.kyoto-u.ac.jp>
+ *			(Linux/98 Project)
+ */
+
+#ifndef _ASM_PC9800_H_
+#define _ASM_PC9800_H_
+
+#include <asm/pc9800_sca.h>
+#include <asm/types.h>
+
+#define __PC9800SCA(type, pa)	(*(type *) phys_to_virt(pa))
+#define __PC9800SCA_TEST_BIT(pa, n)	\
+	((__PC9800SCA(u8, pa) & (1U << (n))) != 0)
+
+#define PC9800_HIGHRESO_P()	__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 3)
+#define PC9800_8MHz_P()		__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 7)
+
+				/* 0x2198 is 98 21 on memory... */
+#define PC9800_9821_P()		(__PC9800SCA(u16, PC9821SCA_ROM_ID) == 0x2198)
+
+/* Note PC9821_...() are valid only when PC9800_9821_P() was true. */
+#define PC9821_IDEIF_DOUBLE_P()	__PC9800SCA_TEST_BIT(PC9821SCA_ROM_FLAG4, 4)
+
+#endif
