Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVBQFuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVBQFuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBQFuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:50:32 -0500
Received: from mail.renesas.com ([202.234.163.13]:50102 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262221AbVBQFuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:50:24 -0500
Date: Thu, 17 Feb 2005 14:50:14 +0900 (JST)
Message-Id: <20050217.145014.607094576.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.11-rc4] m32r: warning fix
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the following warning of find_next_zero_bit() for m32r. 
Please apply.

---
$ make ARCH=m32r CROSS_COMPILE=m32r-linux- 
   :
  LDS     arch/m32r/kernel/vmlinux.lds
  CC      arch/m32r/mm/init.o
In file included from /project/m32r-linux/kernel/linux-2.6.11-rc4-bk4/b/arch/m32r/mm/init.c:20:
/project/m32r-linux/kernel/linux-2.6.11-rc4-bk4/b/include/linux/nodemask.h: In function `__first_unset_node':
/project/m32r-linux/kernel/linux-2.6.11-rc4-bk4/b/include/linux/nodemask.h:246: warning: passing arg 1 of `find_next_zero_bit' discards qualifiers from pointer target type
  CC      arch/m32r/mm/fault.o
  AS      arch/m32r/mm/mmu.o
   :
---

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/bitops.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -ruNp a/include/asm-m32r/bitops.h b/include/asm-m32r/bitops.h
--- a/include/asm-m32r/bitops.h	2005-02-16 20:58:08.000000000 +0900
+++ b/include/asm-m32r/bitops.h	2005-02-17 09:57:15.000000000 +0900
@@ -405,9 +405,10 @@ static __inline__ unsigned long ffz(unsi
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_zero_bit(void *addr, int size, int offset)
+static __inline__ int find_next_zero_bit(const unsigned long *addr,
+					 int size, int offset)
 {
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
+	const unsigned long *p = addr + (offset >> 5);
 	unsigned long result = offset & ~31UL;
 	unsigned long tmp;
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
