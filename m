Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVCGJGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVCGJGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCGJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:06:38 -0500
Received: from ozlabs.org ([203.10.76.45]:32144 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261713AbVCGJGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:06:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.6585.352912.779615@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 20:07:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: Amos Waterland <apw@us.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix init_boot_display link error
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Amos Waterland <apw@us.ibm.com>.

In pmac_setup.c, the function init_boot_display as currently written
only makes sense with CONFIG_BOOTX_TEXT enabled, and causes a link error
if it is not enabled.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- 1.15/arch/ppc64/kernel/pmac_setup.c	2005-01-08 00:43:52 -05:00
+++ edited/arch/ppc64/kernel/pmac_setup.c	2005-03-02 19:37:31 -05:00
@@ -244,7 +244,6 @@
 {
 	btext_drawchar(c);
 }
-#endif /* CONFIG_BOOTX_TEXT */
 
 static void __init init_boot_display(void)
 {
@@ -280,6 +279,7 @@
 			return;
 	}
 }
+#endif /* CONFIG_BOOTX_TEXT */
 
 /* 
  * Early initialization.
