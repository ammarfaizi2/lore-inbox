Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUJTD6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUJTD6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270280AbUJTD6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:58:45 -0400
Received: from mail.renesas.com ([202.234.163.13]:36784 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267988AbUJTD54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 23:57:56 -0400
Date: Wed, 20 Oct 2004 12:57:31 +0900 (JST)
Message-Id: <20041020.125731.576022571.takata.hirokazu@renesas.com>
To: rusty@rustcorp.com.au
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 2.6.9] [m32r] Update M32R SIO driver to use module_param()
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Sorry for my late reply.
Thank you for your kind comment, Rusty.

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
Date: Fri, 15 Oct 2004 11:27:45 +1000
> > +MODULE_PARM(share_irqs_sio, "i");
> 
> Hi Hirokazu!
> 
> 	Please use the modern "module_param(share_irqs_sio, bool, 0400)" here
> (I assume you don't want this parameter to be writable, hence the 0400
> permissions).  MODULE_PARM is deprecated.
> 
> Thankyou!
> Rusty.


Here is a patch for M32R SIO driver, which replaces deprecated 
MODULE_PARAM() with modern module_param().

	* drivers/serial/m32r_sio.c:
	- Replace MODULE_PARAM() with module_param().
	- Fix a typo: UARRT_RSA_BASE --> UART_RSA_BASE.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/serial/m32r_sio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


--- a/drivers/serial/m32r_sio.c	2004-10-12 10:18:43.000000000 +0900
+++ b/drivers/serial/m32r_sio.c	2004-10-20 12:47:27.000000000 +0900
@@ -848,7 +848,7 @@ m32r_sio_request_std_resource(struct uar
 			*res = request_mem_region(up->port.mapbase, size, "serial");
 #else
 			start = up->port.mapbase;
-			start += UARRT_RSA_BASE << up->port.regshift;
+			start += UART_RSA_BASE << up->port.regshift;
 			*res = request_mem_region(start, size, "serial");
 #endif
 			if (!*res)
@@ -1333,7 +1333,7 @@ static int __init m32r_sio_init(void)
 {
 	int ret, i;
 
-	printk(KERN_INFO "Serial: M32R SIO driver $Revision: 1.6 $ "
+	printk(KERN_INFO "Serial: M32R SIO driver $Revision: 1.9 $ "
 		"IRQ sharing %sabled\n", share_irqs_sio ? "en" : "dis");
 
 	for (i = 0; i < NR_IRQS; i++)
@@ -1366,8 +1366,8 @@ EXPORT_SYMBOL(m32r_sio_suspend_port);
 EXPORT_SYMBOL(m32r_sio_resume_port);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic M32R SIO serial driver $Revision: 1.6 $");
+MODULE_DESCRIPTION("Generic M32R SIO serial driver $Revision: 1.9 $");
 
-MODULE_PARM(share_irqs_sio, "i");
+module_param(share_irqs_sio, bool, 0400);
 MODULE_PARM_DESC(share_irqs_sio, "Share IRQs with other non-M32R SIO devices"
 	" (unsafe)");

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
