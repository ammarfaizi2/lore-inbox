Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUJBJ4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUJBJ4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUJBJ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:56:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23055 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267377AbUJBJ4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:56:45 -0400
Date: Sat, 2 Oct 2004 11:56:09 +0200
From: Adrian Bunk <adrian.bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [patch] 2.6.9-rc3-mm1: X86_LOCAL_APIC compile error
Message-ID: <20041002095609.GA2470@stusta.mhn.de>
References: <20041002014352.2b55e98d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002014352.2b55e98d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 01:43:52AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc2-mm4:
>...
> +generic-irq-subsystem-x86-port.patch
>...
>  IRQ handling code consolidation
>...


This causes the following compile error with X86_LOCAL_APIC=y:

<--  snip  -->

...
  CC      init/main.o
In file included from include/linux/hardirq.h:6,
                 from include/linux/interrupt.h:11,
                 from include/asm/highmem.h:24,
                 from include/linux/highmem.h:14,
                 from include/linux/skbuff.h:27,
                 from include/linux/security.h:33,
                 from init/main.c:36:
include/asm/hardirq.h: In function `ack_bad_irq':
include/asm/hardirq.h:34: warning: implicit declaration of function 
`ack_APIC_irq'
In file included from include/asm/smp.h:22,
                 from init/main.c:65:
include/asm/apic.h: At top level:
include/asm/apic.h:72: error: conflicting types for 'ack_APIC_irq'
include/asm/hardirq.h:34: error: previous implicit declaration of 
'ack_APIC_irq' was here
make[1]: *** [init/main.o] Error 1

<--  snip  -->


The following patch fixes this issue:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc3-mm1-full/include/asm-i386/hardirq.h.old	2004-10-02 11:46:13.000000000 +0200
+++ linux-2.6.9-rc3-mm1-full/include/asm-i386/hardirq.h	2004-10-02 11:46:38.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
+#include <asm/apic.h>
 
 typedef struct {
 	unsigned int __softirq_pending;

