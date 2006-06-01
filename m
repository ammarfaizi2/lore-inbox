Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWFANyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWFANyB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFANyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:54:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:23528 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750943AbWFANyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:54:00 -0400
Message-ID: <447EF175.4040608@fr.ibm.com>
Date: Thu, 01 Jun 2006 15:53:57 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
References: <20060601014806.e86b3cc0.akpm@osdl.org>	 <447EE5A4.7050201@fr.ibm.com> <1149168482.5279.34.camel@localhost>
In-Reply-To: <1149168482.5279.34.camel@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:

> Can't comment on the port issues yet but we plan to add the s390 support
> to the lock-validator. It is just a cool debugging tool.

OK. So I'll keep my #ifdef hack for the moment.

> Seems reasonable. __io_wirt() is a nop, so you are simply writing to the
> specified address.

Here it is,

thanks !

C.

This patch adds __raw_writeq required by __iowrite64_copy.

It also adds all the related quad routines.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 include/asm-s390/io.h |    5 +++++
 1 files changed, 5 insertions(+)

Index: 2.6.17-rc5-mm2/include/asm-s390/io.h
===================================================================
--- 2.6.17-rc5-mm2.orig/include/asm-s390/io.h
+++ 2.6.17-rc5-mm2/include/asm-s390/io.h
@@ -86,20 +86,25 @@
 #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#define readq(addr) (*(volatile unsigned long *) __io_virt(addr))

 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
+#define readq_relaxed(addr) readq(addr)
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
+#define __raw_readq readq

 #define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
 #define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
 #define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#define writeq(b,addr) (*(volatile unsigned long *) __io_virt(addr) = (b))
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
+#define __raw_writeq writeq

 #define memset_io(a,b,c)        memset(__io_virt(a),(b),(c))
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
