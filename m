Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424300AbWLBRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424300AbWLBRzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424301AbWLBRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:55:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56581 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424300AbWLBRzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:55:20 -0500
Date: Sat, 2 Dec 2006 18:55:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix v850 compilation
Message-ID: <20061202175525.GU11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More fallout of the post 2.6.19-rc1 IRQ changes...

<--  snip  -->

...
  CC      init/main.o
In file included from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/include/linux/rtc.h:102,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/include/linux/efi.h:19,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/init/main.c:43:
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/include/linux/interrupt.h:67: 
error: conflicting types for 'irq_handler_t'
include2/asm/irq.h:49: error: previous declaration of 'irq_handler_t' was here
make[2]: *** [init/main.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/include/asm-v850/irq.h.old	2006-12-02 18:44:10.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-v850/irq.h	2006-12-02 18:44:17.000000000 +0100
@@ -46,8 +46,6 @@
 init_irq_handlers (int base_irq, int num, int interval,
 		   struct hw_interrupt_type *irq_type);
 
-typedef void (*irq_handler_t)(int irq, void *data, struct pt_regs *regs);
-
 /* Handle interrupt IRQ.  REGS are the registers at the time of ther
    interrupt.  */
 extern unsigned int handle_irq (int irq, struct pt_regs *regs);

