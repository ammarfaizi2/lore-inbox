Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKCNbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKCNbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUKCNbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:31:19 -0500
Received: from [212.223.124.118] ([212.223.124.118]:25476 "EHLO
	mail.telemotive.de") by vger.kernel.org with ESMTP id S261596AbUKCNbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:31:00 -0500
To: linux-kernel@vger.kernel.org
Subject: PATCH: stdint constants
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
From: roman.fietze@telemotive.de
Message-ID: <OF1C112AC2.560EA5F6-ONC1256F41.0049C0DE@telemotive.de>
Date: Wed, 3 Nov 2004 14:30:46 +0100
X-MIMETrack: Serialize by Router on muc/Telemotive(Release 6.5.1|January 21, 2004) at
 03.11.2004 14:31:09,
	Serialize complete at 03.11.2004 14:31:09
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all: sorry for using Notes MUA, but cannot route to kernel.org 
due to NJABL.

Allthough many books recommend using the types uint8_t to uint64_t as
well as their signed counterparts, I could not find the MIX/MAX values
for those types in any kernel include file.

Tested on a 2.4 ARM/PPC/I386 kernel with gcc 3.0.4/3.2.2/3.3.2. Not
tested on any 64 bit architecture.

Any comments to this patch?


diff -uprN linux-2.6.9/include/linux/kernel.h 
linux-2.6.9-stdint/include/linux/kernel.h
--- linux-2.6.9/include/linux/kernel.h  2004-10-18 23:53:05.000000000 
+0200
+++ linux-2.6.9-stdint/include/linux/kernel.h   2004-11-03 
14:15:24.000000000 +0100
@@ -23,6 +23,30 @@
 #define LONG_MIN       (-LONG_MAX - 1)
 #define ULONG_MAX      (~0UL)
 
+#define INT8_MIN       (-128)
+#define INT16_MIN      (-32767-1)
+#define INT32_MIN      (-2147483647-1)
+
+#define INT8_MAX       (127)
+#define INT16_MAX      (32767)
+#define INT32_MAX      (2147483647)
+
+#define UINT8_MAX      (255)
+#define UINT16_MAX     (65535)
+#define UINT32_MAX     (4294967295U)
+
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+# if BITS_PER_LONG == 32
+#  define INT64_MIN    (-9223372036854775807LL - 1LL)
+#  define INT64_MAX    (9223372036854775807LL)
+#  define UINT64_MAX   (18446744073709551615ULL)
+# else
+#  define INT64_MIN    (-9223372036854775807L - 1L)
+#  define INT64_MAX    (9223372036854775807L)
+#  define UINT64_MAX   (18446744073709551615UL)
+# endif
+#endif
+
 #define STACK_MAGIC    0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))



Roman

-- 
Roman Fietze              Telemotive AG Büro Mühlhausen
Breitwiesen                            73347 Mühlhausen
Tel.: +49(0)7335 18493-45      http://www.telemotive.de

