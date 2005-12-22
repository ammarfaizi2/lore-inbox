Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVLVE7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVLVE7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLVE65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:58:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24528 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965071AbVLVEuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:15 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 14/36] m68k: memory input should be an lvalue (mac/misc.c)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIP8-0004rV-IU@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133435982 -0500

gcc4 is less forgiving and wants memory inputs to be real lvalues; variable
added and value stored in it explicitly before doing __asm__.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/mac/misc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

d084097faa15a24b42e36c3db025c7fa28a70876
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 99dd2c1..bbb0c3b 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -572,12 +572,13 @@ void mac_reset(void)
 		/* make a 1-to-1 mapping, using the transparent tran. reg. */
 		unsigned long virt = (unsigned long) mac_reset;
 		unsigned long phys = virt_to_phys(mac_reset);
+		unsigned long addr = (phys&0xFF000000)|0x8777;
 		unsigned long offset = phys-virt;
 		local_irq_disable(); /* lets not screw this up, ok? */
 		__asm__ __volatile__(".chip 68030\n\t"
 				     "pmove %0,%/tt0\n\t"
 				     ".chip 68k"
-				     : : "m" ((phys&0xFF000000)|0x8777));
+				     : : "m" (addr));
 		/* Now jump to physical address so we can disable MMU */
 		__asm__ __volatile__(
                     ".chip 68030\n\t"
-- 
0.99.9.GIT

