Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUA0UGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUA0UGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:06:15 -0500
Received: from mail.timesys.com ([65.117.135.102]:55927 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S265828AbUA0UGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:06:11 -0500
Message-ID: <4016C477.4070505@timesys.com>
Date: Tue, 27 Jan 2004 15:05:11 -0500
From: Pratik Solanki <pratik.solanki@timesys.com>
Organization: TimeSys Corporation
User-Agent: Mozilla Thunderbird 0.5a (X11/20040118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: u_int32_t causes cross-compile problems [PATCH]
Content-Type: multipart/mixed;
 boundary="------------040108000808050306070308"
X-OriginalArrivalTime: 27 Jan 2004 20:00:18.0781 (UTC) FILETIME=[303960D0:01C3E510]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108000808050306070308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I came across this C standards issue while cross-compiling the Linux 
kernel with gcc on Solaris. The file gen_crc32table.c uses the 
non-standard type u_int32_t. It's possible that the host machine's 
sys/types.h does not define u_int32_t. The attached patch replaces 
u_int32_t with the POSIX standard uint32_t and includes POSIX inttypes.h 
instead of sys/types.h.

Please CC me when replying.

Pratik.

--------------040108000808050306070308
Content-Type: text/plain;
 name="gen_crc32table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gen_crc32table.patch"

===== lib/gen_crc32table.c 1.1 vs edited =====
--- 1.1/lib/gen_crc32table.c	Sun Nov 24 04:58:41 2002
+++ edited/lib/gen_crc32table.c	Fri Jan 23 11:06:00 2004
@@ -1,14 +1,14 @@
 #include <stdio.h>
 #include "crc32defs.h"
-#include <sys/types.h>
+#include <inttypes.h>
 
 #define ENTRIES_PER_LINE 4
 
 #define LE_TABLE_SIZE (1 << CRC_LE_BITS)
 #define BE_TABLE_SIZE (1 << CRC_BE_BITS)
 
-static u_int32_t crc32table_le[LE_TABLE_SIZE];
-static u_int32_t crc32table_be[BE_TABLE_SIZE];
+static uint32_t crc32table_le[LE_TABLE_SIZE];
+static uint32_t crc32table_be[BE_TABLE_SIZE];
 
 /**
  * crc32init_le() - allocate and initialize LE table data
@@ -20,7 +20,7 @@
 static void crc32init_le(void)
 {
 	unsigned i, j;
-	u_int32_t crc = 1;
+	uint32_t crc = 1;
 
 	crc32table_le[0] = 0;
 
@@ -37,7 +37,7 @@
 static void crc32init_be(void)
 {
 	unsigned i, j;
-	u_int32_t crc = 0x80000000;
+	uint32_t crc = 0x80000000;
 
 	crc32table_be[0] = 0;
 
@@ -48,7 +48,7 @@
 	}
 }
 
-static void output_table(u_int32_t table[], int len, char *trans)
+static void output_table(uint32_t table[], int len, char *trans)
 {
 	int i;
 

--------------040108000808050306070308--
