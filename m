Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRHJMgt>; Fri, 10 Aug 2001 08:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRHJMga>; Fri, 10 Aug 2001 08:36:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34311 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267450AbRHJMgV>; Fri, 10 Aug 2001 08:36:21 -0400
Date: Fri, 10 Aug 2001 14:36:16 +0200
From: Jan Kara <jack@ucw.cz>
To: paulus@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: byteorder.h
Message-ID: <20010810143616.E10853@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I think I've found a small bug in asm-ppc/byteorder.h. The problem is that symbol
__BYTEORDER_HAS_U64__ is defined only if __KERNEL__ is defined but on other archs
it's defined also if __STRICT_ANSI__ is not defined and this is IMHO right. Patch
which fixes it is below.

									Honza

----------------------------------------------------------------------------------
--- linux/include/asm-ppc/byteorder.h	Fri Aug 10 14:25:17 2001
+++ linux/include/asm-ppc/byteorder.h	Fri Aug 10 14:28:10 2001
@@ -6,8 +6,8 @@
 
 #include <asm/types.h>
 
-#ifdef __KERNEL__
 #ifdef __GNUC__
+#ifdef __KERNEL__
 
 extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
 {
@@ -72,12 +72,13 @@
 #define __arch__swab16s(addr) st_le16(addr,*addr)
 #define __arch__swab32s(addr) st_le32(addr,*addr)
 
-#ifndef __STRICT_ANSI__
+#endif /* __KERNEL__ */
+
+#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #define __BYTEORDER_HAS_U64__
 #endif
 
 #endif /* __GNUC__ */
-#endif /* __KERNEL__ */
 
 #include <linux/byteorder/big_endian.h>
 
