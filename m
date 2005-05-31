Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVEaGuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEaGuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVEaGuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:50:16 -0400
Received: from ozlabs.org ([203.10.76.45]:39561 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261275AbVEaGuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:50:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17052.2999.462074.378969@cargo.ozlabs.ibm.com>
Date: Tue, 31 May 2005 17:01:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: actually call prom_send_capabilities
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I sent in the patch adding the code for the kernel to tell the
firmware about its capabilities on pSeries machines, I included the
function to give the capabilities to firmware but somehow forgot the
hunk that adds the call to the new function.  This patch adds the
call.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc64/kernel/prom_init.c g5-ppc64/arch/ppc64/kernel/prom_init.c
--- linux-2.6/arch/ppc64/kernel/prom_init.c	2005-05-30 14:49:57.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/prom_init.c	2005-05-30 17:12:08.000000000 +1000
@@ -1881,6 +1881,12 @@
 		     &getprop_rval, sizeof(getprop_rval));
 
 	/*
+	 * On pSeries, inform the firmware about our capabilities
+	 */
+	if (RELOC(of_platform) & PLATFORM_PSERIES)
+		prom_send_capabilities();
+
+	/*
 	 * On pSeries, copy the CPU hold code
 	 */
        	if (RELOC(of_platform) & PLATFORM_PSERIES)

