Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVLCAYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVLCAYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVLCAYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:24:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751116AbVLCAYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:24:48 -0500
Date: Fri, 2 Dec 2005 16:24:36 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fls in asm for x86_64
Message-ID: <20051202162436.2a96313b@localhost.localdomain>
In-Reply-To: <20051202162240.746c436e@localhost.localdomain>
References: <20051202162240.746c436e@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use single instruction for find largest set bit on x86_64.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- orig/include/asm-x86_64/bitops.h
+++ new/include/asm-x86_64/bitops.h
@@ -370,6 +370,22 @@ static __inline__ int ffs(int x)
 }
 
 /**
+ * fls - find last bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs.
+ */
+static __inline__ int fls(int x)
+{
+	int r;
+
+	__asm__("bsrl %1,%0\n\t"
+		"cmovzl %2,%0"
+		: "=r" (r) : "rm" (x), "r" (-1));
+	return r+1;
+}
+
+/**
  * hweightN - returns the hamming weight of a N-bit word
  * @x: the word to weigh
  *
@@ -407,9 +423,6 @@ static __inline__ int ffs(int x)
 #define minix_find_first_zero_bit(addr,size) \
 	find_first_zero_bit((void*)addr,size)
 
-/* find last set bit */
-#define fls(x) generic_fls(x)
-
 #endif /* __KERNEL__ */
 
 #endif /* _X86_64_BITOPS_H */
