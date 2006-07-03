Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWGCLgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWGCLgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGCLgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:36:44 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:60354 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751120AbWGCLgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:36:43 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFC][patch 09/44] IA64: Use the new IRQF_ constansts
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
	<20060701145224.258259000@cruncher.tec.linutronix.de>
From: Jes Sorensen <jes@sgi.com>
Date: 03 Jul 2006 07:36:42 -0400
In-Reply-To: <20060701145224.258259000@cruncher.tec.linutronix.de>
Message-ID: <yq0r712hqd1.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thomas" == Thomas Gleixner <tglx@linutronix.de> writes:

Thomas> Use the new IRQF_ constants and remove the SA_INTERRUPT define

Hi Thomas,

You forgot to remove the duplicate define of IRQF_PERCPU from
include/asm-ia64/irq.h when you introduced the one in
include/linux/interrupt.h.

On ia64, without this patch, building Linus' git tree spits out
compile warnings left right and center (harmless ones though).

I checked the ia64 code and I don't see any place that actually relied
on the old define or hardcoded it in asm, but I could be wrong of
course.

It compiles, it boots, Enterprise Ready<tm>!

Linus and/or Tony, please apply.

Cheers,
Jes

Remove duplicate define of IRQF_PERCPU which is now defined in
include/linux/interrupt.h

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 include/asm-ia64/irq.h |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/include/asm-ia64/irq.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/irq.h
+++ linux-2.6/include/asm-ia64/irq.h
@@ -14,8 +14,6 @@
 #define NR_IRQS		256
 #define NR_IRQ_VECTORS	NR_IRQS
 
-#define IRQF_PERCPU	0x02000000
-
 static __inline__ int
 irq_canonicalize (int irq)
 {
