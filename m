Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbSLLW7J>; Thu, 12 Dec 2002 17:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSLLW7I>; Thu, 12 Dec 2002 17:59:08 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:2176 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S267552AbSLLW7H>;
	Thu, 12 Dec 2002 17:59:07 -0500
Date: Thu, 12 Dec 2002 17:09:02 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: rth@twiddle.net
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] "extern inline" to "static inline" allows compile
Message-Id: <20021212170902.34e344b1.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't compile 2.5.51 on an EV56 without this. Tested, boots.
There are a bunch of symbols in core_cia.h that break the build if they're
extern inline because they're only defined in the header now. Make them
static inline instead. (Important, since they're #defined to things like
inb)

Comments?

Matt

diff -Nru a/include/asm-alpha/core_cia.h b/include/asm-alpha/core_cia.h
--- a/include/asm-alpha/core_cia.h	Thu Dec 12 16:59:06 2002
+++ b/include/asm-alpha/core_cia.h	Thu Dec 12 16:59:06 2002
@@ -293,7 +293,7 @@
 #ifdef __KERNEL__
 
 #ifndef __EXTERN_INLINE
-#define __EXTERN_INLINE extern inline
+#define __EXTERN_INLINE static inline
 #define __IO_EXTERN_INLINE
 #endif
 
