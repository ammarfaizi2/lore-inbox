Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUDZBCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUDZBCt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 21:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUDZBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 21:02:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3274 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263736AbUDZBCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 21:02:47 -0400
Message-ID: <408C5F8B.3010104@austin.ibm.com>
Date: Sun, 25 Apr 2004 20:02:03 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: remove duplicated mb() and comment from __cpu_up
Content-Type: multipart/mixed;
 boundary="------------070505070004080400020106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505070004080400020106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

This seems to have slipped in during a manual merge at some point. Patch 
is against 2.6.6-rc2-mm1.

Nathan



--------------070505070004080400020106
Content-Type: text/x-patch;
 name="remove_redundant_mb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_redundant_mb.patch"

diff -rU 5 linux-2.6.6-rc2-mm1/arch/ppc64/kernel/smp.c linux-2.6.6-rc2-mm1.new/arch/ppc64/kernel/smp.c
--- linux-2.6.6-rc2-mm1/arch/ppc64/kernel/smp.c	2004-04-25 19:45:24.000000000 -0500
+++ linux-2.6.6-rc2-mm1.new/arch/ppc64/kernel/smp.c	2004-04-25 19:50:46.000000000 -0500
@@ -893,14 +893,10 @@
 		memset(tmp, 0, PAGE_SIZE); 
 		paca[cpu].xStab_data.virt = (unsigned long)tmp;
 		paca[cpu].xStab_data.real = virt_to_abs(tmp);
 	}
 
-	/* The information for processor bringup must be written out
-	 * to main store before we release the processor. */
-	mb();
-
 	/* The information for processor bringup must
 	 * be written out to main store before we release
 	 * the processor.
 	 */
 	mb();

--------------070505070004080400020106--
