Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUFCPTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUFCPTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUFCPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:19:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54794 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265558AbUFCPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:19:18 -0400
Date: Thu, 3 Jun 2004 16:19:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Export swapper_space
Message-ID: <20040603161909.D8244@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swapper_space appears to be needed by modules:

  Building modules, stage 2.
  MODPOST
*** Warning: "swapper_space" [drivers/block/loop.ko] undefined!
*** Warning: "swapper_space" [drivers/scsi/st.ko] undefined!
*** Warning: "swapper_space" [drivers/scsi/sg.ko] undefined!

--- orig/mm/swap_state.c	Mon May 24 11:26:25 2004
+++ linux/mm/swap_state.c	Thu Jun  3 16:11:58 2004
@@ -6,7 +6,7 @@
  *
  *  Rewritten to use page cache, (C) 1998 Stephen Tweedie
  */
-
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
@@ -38,6 +38,7 @@ struct address_space swapper_space = {
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
 };
+EXPORT_SYMBOL(swapper_space);
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
