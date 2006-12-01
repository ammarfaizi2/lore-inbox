Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031633AbWLARLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031633AbWLARLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031634AbWLARLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:11:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43530 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031633AbWLARLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:11:42 -0500
Date: Fri, 1 Dec 2006 18:11:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove mtd/jffs2-user.h
Message-ID: <20061201171147.GF11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- not included by any other header
- not defining any userspace <-> kernel interface
- depends on userspace providing a variable "target_endian"

mtd-utils already has a copy of this file.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/mtd/Kbuild       |    1 -
 include/mtd/jffs2-user.h |   35 -----------------------------------
 2 files changed, 36 deletions(-)

--- a/include/mtd/jffs2-user.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * $Id: jffs2-user.h,v 1.1 2004/05/05 11:57:54 dwmw2 Exp $
- *
- * JFFS2 definitions for use in user space only
- */
-
-#ifndef __JFFS2_USER_H__
-#define __JFFS2_USER_H__
-
-/* This file is blessed for inclusion by userspace */
-#include <linux/jffs2.h>
-#include <endian.h>
-#include <byteswap.h>
-
-#undef cpu_to_je16
-#undef cpu_to_je32
-#undef cpu_to_jemode
-#undef je16_to_cpu
-#undef je32_to_cpu
-#undef jemode_to_cpu
-
-extern int target_endian;
-
-#define t16(x) ({ uint16_t __b = (x); (target_endian==__BYTE_ORDER)?__b:bswap_16(__b); })
-#define t32(x) ({ uint32_t __b = (x); (target_endian==__BYTE_ORDER)?__b:bswap_32(__b); })
-
-#define cpu_to_je16(x) ((jint16_t){t16(x)})
-#define cpu_to_je32(x) ((jint32_t){t32(x)})
-#define cpu_to_jemode(x) ((jmode_t){t32(x)})
-
-#define je16_to_cpu(x) (t16((x).v16))
-#define je32_to_cpu(x) (t32((x).v32))
-#define jemode_to_cpu(x) (t32((x).m))
-
-#endif /* __JFFS2_USER_H__ */
--- linux-2.6.19-rc6-mm2/include/mtd/Kbuild.old	2006-12-01 13:10:01.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/mtd/Kbuild	2006-12-01 13:10:07.000000000 +0100
@@ -1,5 +1,4 @@
 header-y += inftl-user.h
-header-y += jffs2-user.h
 header-y += mtd-abi.h
 header-y += mtd-user.h
 header-y += nftl-user.h
