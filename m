Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSH1Qbf>; Wed, 28 Aug 2002 12:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSH1Qbf>; Wed, 28 Aug 2002 12:31:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5136 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312560AbSH1Qbe>;
	Wed, 28 Aug 2002 12:31:34 -0400
Message-ID: <3D6CFE97.DA554FA9@zip.com.au>
Date: Wed, 28 Aug 2002 09:47:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Heinz Diehl <hd@cavy.de>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.5.32-mm1
References: <3D6C500E.426B163A@zip.com.au> <20020828132748.GA7466@chiara.cavy.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz Diehl wrote:
> 
> ...
> fs/fs.o(.text+0x5932): undefined reference to cpu_possible'

Bah.  Sorry about that.  cpu_possible() appears to be undefined
for uniprocessor builds.

How about this?

--- 2.5.32/include/linux/smp.h~cpu_possible	Wed Aug 28 09:43:05 2002
+++ 2.5.32-akpm/include/linux/smp.h	Wed Aug 28 09:44:00 2002
@@ -108,6 +108,9 @@ static inline int register_cpu_notifier(
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+
+#define cpu_possible(cpu)	((cpu) == 0)
+
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
--- 2.5.32/fs/buffer.c~cpu_possible	Wed Aug 28 09:43:09 2002
+++ 2.5.32-akpm/fs/buffer.c	Wed Aug 28 09:44:17 2002
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/smp.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>

.
