Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVIHVXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVIHVXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVIHVXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:23:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751386AbVIHVXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:23:10 -0400
Date: Thu, 8 Sep 2005 14:22:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
In-Reply-To: <20050908.134259.51218842.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
References: <20050908212236.A19542@flint.arm.linux.org.uk>
 <20050908.132634.88719733.davem@davemloft.net> <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
 <20050908.134259.51218842.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Sep 2005, David S. Miller wrote:
> 
> Ok, I'll revert the patch and fix the sunsab.c driver as
> Russell indicated.  So much for type checking...

Actually, I think there's a simpler fix. Instead of reverting, how about 
something like this?

(You might even remove the #ifdef inside the function by then, since "ch" 
being a constant zero will make 90% of it go away anyway).

rmk? Davem?

		Linus

---
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -401,6 +401,9 @@ uart_handle_sysrq_char(struct uart_port 
 #endif
 	return 0;
 }
+#ifndef SUPPORT_SYSRQ
+#define uart_handle_sysrq_char(port,ch,regs) uart_handle_sysrq_char(port, 0, NULL)
+#endif
 
 /*
  * We do the SysRQ and SAK checking like this...
