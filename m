Return-Path: <linux-kernel-owner+w=401wt.eu-S965257AbXAGXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbXAGXss (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbXAGXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:48:48 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:57724 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965257AbXAGXsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:48:47 -0500
X-Originating-Ip: 74.109.98.176
Date: Sun, 7 Jan 2007 18:43:41 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: hskinnemoen@atmel.com
Subject: [PATCH] Remove a couple final references to obsolete verify_area().
Message-ID: <Pine.LNX.4.64.0701071839560.18341@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove a couple final references to the obsolete verify_area() call,
which was long ago replaced by access_ok().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  it *appears* that these last two references can be removed, unless
there's something really strange i'm not seeing here.


 include/asm-avr32/checksum.h |    2 +-
 include/asm-avr32/uaccess.h  |    6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)


diff --git a/include/asm-avr32/checksum.h b/include/asm-avr32/checksum.h
index af9d53f..4ddbfd2 100644
--- a/include/asm-avr32/checksum.h
+++ b/include/asm-avr32/checksum.h
@@ -38,7 +38,7 @@ __wsum csum_partial_copy_generic(const void *src, void *dst, int len,
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst,
diff --git a/include/asm-avr32/uaccess.h b/include/asm-avr32/uaccess.h
index 821deb5..74a679e 100644
--- a/include/asm-avr32/uaccess.h
+++ b/include/asm-avr32/uaccess.h
@@ -68,12 +68,6 @@ static inline void set_fs(mm_segment_t s)

 #define access_ok(type, addr, size) (likely(__range_ok(addr, size) == 0))

-static inline int
-verify_area(int type, const void __user *addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
 /* Generic arbitrary sized copy. Return the number of bytes NOT copied */
 extern __kernel_size_t __copy_user(void *to, const void *from,
 				   __kernel_size_t n);
