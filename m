Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUBPVQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbUBPVQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:16:35 -0500
Received: from mail.tauceti.org.au ([203.32.61.7]:2821 "HELO
	mail.tauceti.org.au") by vger.kernel.org with SMTP id S265886AbUBPVQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:16:33 -0500
X-Qmail-Scanner-Mail-From: leachbj@bouncycastle.org via mail
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.228.150.36):. Processed in 0.499285 secs)
Subject: [PATCH] HFSPlus alignment fix
From: Bernard Leach <leachbj@bouncycastle.org>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Content-Type: text/plain
Message-Id: <1076968573.2097.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 22:56:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a patch against 2.4.24 that fixes an alignment issue in the
HFS+ filesystem.

The fix originates from Daniel Hazelbaker <cabal95 (at)
users.sourceforge.net>.

cheers,
bern.

--- fs/hfsplus/wrapper.c        4 Feb 2004 13:27:38 -0000       1.1.1.1
+++ fs/hfsplus/wrapper.c        4 Feb 2004 13:58:20 -0000       1.2
@@ -14,6 +14,7 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 #include <linux/buffer_head.h>
 #endif
+#include <asm/unaligned.h>
  
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -45,7 +46,7 @@
                return 0;
        wd->ablk_start = be16_to_cpu(*(u16 *)(bufptr +
HFSP_WRAPOFF_ABLKSTART));  
-       extent = be32_to_cpu(*(u32 *)(bufptr + HFSP_WRAPOFF_EMBEDEXT));
+       extent = be32_to_cpu(get_unaligned((u32 *)(bufptr +
HFSP_WRAPOFF_EMBEDEXT)));
        wd->embed_start = (extent >> 16) & 0xFFFF;
        wd->embed_count = extent & 0xFFFF;


