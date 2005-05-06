Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVEFECB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVEFECB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 00:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEFECB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 00:02:01 -0400
Received: from ozlabs.org ([203.10.76.45]:7383 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262196AbVEFEBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 00:01:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.58856.453073.883611@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 13:35:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: apw@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: fix reloc_offset comment
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code in reloc_offset is actually subtracting the address in the link
register from the address calculated by the linker.  Perhaps the
extended mnemonic `sub' replaced an original `subf' and the comment just
did not get updated.

        bl      1f
1:      mflr    r3
        LOADADDR(r4,1b)
        sub     r3,r4,r3

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
===== arch/ppc64/kernel/misc.S 1.98 vs edited =====
--- 1.98/arch/ppc64/kernel/misc.S	2005-01-14 14:56:04 -05:00
+++ edited/arch/ppc64/kernel/misc.S	2005-03-22 21:35:48 -05:00
@@ -32,7 +32,7 @@
 	.text
 
 /*
- * Returns (address we're running at) - (address we were linked at)
+ * Returns (address we were linked at) - (address we are running at)
  * for use before the text and data are mapped to KERNELBASE.
  */
 

