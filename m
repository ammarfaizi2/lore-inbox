Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbULFU4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbULFU4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbULFU4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:56:03 -0500
Received: from math.ut.ee ([193.40.5.125]:57740 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261645AbULFUzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:55:13 -0500
Date: Mon, 6 Dec 2004 22:55:11 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "shadows global", "unused parameter"
 warnings
Message-ID: <Pine.SOC.4.61.0412062253040.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warnings "declaration of `prefetch' shadows a global declaration"
(occuring on line 141) and "unused parameter `addr'" (occuring on line 136)

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/arch/i386/mm/fault.c	2004-12-02 21:30:30.000000000 +0000
+++ b/arch/i386/mm/fault.c	2004-12-02 21:30:59.000000000 +0000
@@ -133,12 +133,12 @@
   * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
   * Check that here and ignore it.
   */
-static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
+static int __is_prefetch(struct pt_regs *regs)
  {
  	unsigned long limit;
  	unsigned long instr = get_segment_eip (regs, &limit);
  	int scan_more = 1;
-	int prefetch = 0; 
+	int really_prefetch = 0;
  	int i;

  	for (i = 0; scan_more && i < 15; i++) { 
@@ -177,7 +177,7 @@
  				break;
  			if (__get_user(opcode, (unsigned char *) instr))
  				break;
-			prefetch = (instr_lo == 0xF) &&
+			really_prefetch = (instr_lo == 0xF) &&
  				(opcode == 0x0D || opcode == 0x18);
  			break;
  		default:
@@ -185,7 +185,7 @@
  			break;
  		}
  	}
-	return prefetch;
+	return really_prefetch;
  }

  static inline int is_prefetch(struct pt_regs *regs, unsigned long addr,
