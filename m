Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWARUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWARUii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWARUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:38:38 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:40497 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030424AbWARUih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:38:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Rn1TluL4PVROElkBncCBiPgNCTRz/2zLHP1ptukAHgTToDI9gIG0vYpmSHCVL+3aYgDwFyMC0+nBhgPcvDTsdee5Vfl5TBK65YxO/CzLUjpR9Z4n4nO30fREgzBthOD46lDTpa1lXHHsfbxCGucwxOnFgMwxm9tp6yd09I2AA1Q=
Date: Wed, 18 Jan 2006 23:55:56 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: fix find_first_zero_bit related warnings
Message-ID: <20060118205556.GA12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/nodemask.h: In function `__first_unset_node':
include/linux/nodemask.h:254: warning: passing arg 1 of `_find_first_zero_bit_le' discards qualifiers from pointer target type
fs/minix/bitmap.c: In function `minix_new_block':
fs/minix/bitmap.c:89: warning: passing arg 1 of `_find_first_zero_bit_le' from incompatible pointer type

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/bitops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/asm-arm26/bitops.h
+++ b/include/asm-arm26/bitops.h
@@ -186,7 +186,7 @@ extern void _change_bit_le(int nr, volat
 extern int _test_and_set_bit_le(int nr, volatile unsigned long * p);
 extern int _test_and_clear_bit_le(int nr, volatile unsigned long * p);
 extern int _test_and_change_bit_le(int nr, volatile unsigned long * p);
-extern int _find_first_zero_bit_le(void * p, unsigned size);
+extern int _find_first_zero_bit_le(const unsigned long * p, unsigned size);
 extern int _find_next_zero_bit_le(void * p, int size, int offset);
 extern int _find_first_bit_le(const unsigned long *p, unsigned size);
 extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
@@ -326,7 +326,7 @@ static inline int sched_find_first_bit(u
 #define minix_test_and_clear_bit(nr,p)		\
 		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define minix_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		_find_first_zero_bit_le((unsigned long *)(p),sz)
 
 #endif /* __KERNEL__ */
 

