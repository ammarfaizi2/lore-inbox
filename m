Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWFOLOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWFOLOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWFOLOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:14:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57298 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030204AbWFOLOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:14:21 -0400
Date: Thu, 15 Jun 2006 12:14:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: [PATCH] m68k traps.c constraints
Message-ID: <20060615111420.GK27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cast is not an lvalue; =r constraint wants an lvalue and really couldn't care
whether it's void * or other pointer type.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

bdc7b61b5412460e1c6d8c723e7744807d23131b
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index c640d0f..efc704e 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -114,7 +114,7 @@ void __init base_trap_init(void)
 	if(MACH_IS_SUN3X) {
 		extern e_vector *sun3x_prom_vbr;
 
-		__asm__ volatile ("movec %%vbr, %0" : "=r" ((void*)sun3x_prom_vbr));
+		__asm__ volatile ("movec %%vbr, %0" : "=r" (sun3x_prom_vbr));
 	}
 
 	/* setup the exception vector table */
-- 
1.3.GIT

