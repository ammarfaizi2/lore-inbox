Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUHDP0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUHDP0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUHDP0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:26:02 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:60169 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267199AbUHDPZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:25:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47A37.44823A10"
Subject: RE: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile environment
Date: Wed, 4 Aug 2004 10:25:26 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D306E13AE1@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile environment
Thread-Index: AcR5pV+DhF1D8gnsSSGYYyJGgdOQcQAka5NQ
From: "Zink, Dan" <dan.zink@hp.com>
To: <akpm@osdl.org>, <linuxppc-dev@lists.linuxppc.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 15:25:48.0497 (UTC) FILETIME=[51A7FC10:01C47A37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47A37.44823A10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Resending as an attachment because of unwanted line wrapping by my
mailer.

Dan

-----Original Message-----
From: Zink, Dan=20
Sent: Tuesday, August 03, 2004 5:01 PM
To: 'akpm@osdl.org'; 'linuxppc-dev@lists.linuxppc.org'
Cc: 'linux-kernel@vger.kernel.org'
Subject: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile
environment

The mktree utility is using "unsigned long" in the definition of a boot
block structure.  This is bad when cross compiling from a 64-bit
architecture...

Thanks,
Dan


--- arch/ppc/boot/utils/mktree.c.old	2004-08-03 16:31:09.568992888
-0500
+++ arch/ppc/boot/utils/mktree.c	2004-08-03 16:32:26.773256056
-0500
@@ -15,19 +15,20 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <netinet/in.h>
+#include <asm/types.h>
=20
 /* This gets tacked on the front of the image.  There are also a few
  * bytes allocated after the _start label used by the boot rom (see
  * head.S for details).
  */
 typedef struct boot_block {
-	unsigned long bb_magic;		/* 0x0052504F */
-	unsigned long bb_dest;		/* Target address of the image
*/
-	unsigned long bb_num_512blocks;	/* Size, rounded-up, in 512 byte
blks */
-	unsigned long bb_debug_flag;	/* Run debugger or image after
load */
-	unsigned long bb_entry_point;	/* The image address to start */
-	unsigned long bb_checksum;	/* 32 bit checksum including
header */
-	unsigned long reserved[2];
+	__u32 bb_magic;		/* 0x0052504F */
+	__u32 bb_dest;		/* Target address of the image */
+	__u32 bb_num_512blocks;	/* Size, rounded-up, in 512 byte blks */
+	__u32 bb_debug_flag;	/* Run debugger or image after load */
+	__u32 bb_entry_point;	/* The image address to start */
+	__u32 bb_checksum;	/* 32 bit checksum including header */
+	__u32 reserved[2];
 } boot_block_t;
=20
 #define IMGBLK	512

------_=_NextPart_001_01C47A37.44823A10
Content-Type: application/octet-stream;
	name="ppcfix.patch"
Content-Transfer-Encoding: base64
Content-Description: ppcfix.patch
Content-Disposition: attachment;
	filename="ppcfix.patch"

LS0tIGFyY2gvcHBjL2Jvb3QvdXRpbHMvbWt0cmVlLmMub2xkCTIwMDQtMDgtMDMgMTY6MzE6MDku
NTY4OTkyODg4IC0wNTAwCisrKyBhcmNoL3BwYy9ib290L3V0aWxzL21rdHJlZS5jCTIwMDQtMDgt
MDMgMTY6MzI6MjYuNzczMjU2MDU2IC0wNTAwCkBAIC0xNSwxOSArMTUsMjAgQEAKICNpbmNsdWRl
IDxzeXMvc3RhdC5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPG5ldGluZXQvaW4u
aD4KKyNpbmNsdWRlIDxhc20vdHlwZXMuaD4KIAogLyogVGhpcyBnZXRzIHRhY2tlZCBvbiB0aGUg
ZnJvbnQgb2YgdGhlIGltYWdlLiAgVGhlcmUgYXJlIGFsc28gYSBmZXcKICAqIGJ5dGVzIGFsbG9j
YXRlZCBhZnRlciB0aGUgX3N0YXJ0IGxhYmVsIHVzZWQgYnkgdGhlIGJvb3Qgcm9tIChzZWUKICAq
IGhlYWQuUyBmb3IgZGV0YWlscykuCiAgKi8KIHR5cGVkZWYgc3RydWN0IGJvb3RfYmxvY2sgewot
CXVuc2lnbmVkIGxvbmcgYmJfbWFnaWM7CQkvKiAweDAwNTI1MDRGICovCi0JdW5zaWduZWQgbG9u
ZyBiYl9kZXN0OwkJLyogVGFyZ2V0IGFkZHJlc3Mgb2YgdGhlIGltYWdlICovCi0JdW5zaWduZWQg
bG9uZyBiYl9udW1fNTEyYmxvY2tzOwkvKiBTaXplLCByb3VuZGVkLXVwLCBpbiA1MTIgYnl0ZSBi
bGtzICovCi0JdW5zaWduZWQgbG9uZyBiYl9kZWJ1Z19mbGFnOwkvKiBSdW4gZGVidWdnZXIgb3Ig
aW1hZ2UgYWZ0ZXIgbG9hZCAqLwotCXVuc2lnbmVkIGxvbmcgYmJfZW50cnlfcG9pbnQ7CS8qIFRo
ZSBpbWFnZSBhZGRyZXNzIHRvIHN0YXJ0ICovCi0JdW5zaWduZWQgbG9uZyBiYl9jaGVja3N1bTsJ
LyogMzIgYml0IGNoZWNrc3VtIGluY2x1ZGluZyBoZWFkZXIgKi8KLQl1bnNpZ25lZCBsb25nIHJl
c2VydmVkWzJdOworCV9fdTMyIGJiX21hZ2ljOwkJLyogMHgwMDUyNTA0RiAqLworCV9fdTMyIGJi
X2Rlc3Q7CQkvKiBUYXJnZXQgYWRkcmVzcyBvZiB0aGUgaW1hZ2UgKi8KKwlfX3UzMiBiYl9udW1f
NTEyYmxvY2tzOwkvKiBTaXplLCByb3VuZGVkLXVwLCBpbiA1MTIgYnl0ZSBibGtzICovCisJX191
MzIgYmJfZGVidWdfZmxhZzsJLyogUnVuIGRlYnVnZ2VyIG9yIGltYWdlIGFmdGVyIGxvYWQgKi8K
KwlfX3UzMiBiYl9lbnRyeV9wb2ludDsJLyogVGhlIGltYWdlIGFkZHJlc3MgdG8gc3RhcnQgKi8K
KwlfX3UzMiBiYl9jaGVja3N1bTsJLyogMzIgYml0IGNoZWNrc3VtIGluY2x1ZGluZyBoZWFkZXIg
Ki8KKwlfX3UzMiByZXNlcnZlZFsyXTsKIH0gYm9vdF9ibG9ja190OwogCiAjZGVmaW5lIElNR0JM
Swk1MTIK

------_=_NextPart_001_01C47A37.44823A10--
