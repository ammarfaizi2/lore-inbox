Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273083AbRIIWiR>; Sun, 9 Sep 2001 18:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273087AbRIIWiG>; Sun, 9 Sep 2001 18:38:06 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:44556 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273083AbRIIWhy>; Sun, 9 Sep 2001 18:37:54 -0400
Subject: Re: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 18:38:39 -0400
Message-Id: <1000075124.17667.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick update:

pre6-preempt patch is up at:
http://tech9.net/rml/linux/patch-rml-2.4.10-pre6-preempt-kernel-1

pre5 does not diff cleanly against pre6, so use this if you are using
Linus's tree.  this patch contains the ieee1394 fix, too. highmem
updates are still pending (see below).

2.4.9-ac10 is still at:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac10-preempt-kernel-1

note this does not contain the ieee1394 fix or highmem update. as
always, you can find the newest patches there, fairly quickly.

if you are using 2.4.9-ac10 or earlier or 2.4.10-pre5 or earlier and
need the ieee1394 patch (fixes compile error) here it is (this is merged
in 2.4.10-pre6-preempt and will be in the next acXX-preempt:)

diff -urN linux-2.4.9-ac10/drivers/ieee1394/ linux/drivers/ieee1394/csr.c
--- linux-2.4.9-ac10/drivers/ieee1394/csr.c	Fri Sep  7 23:53:41 2001
+++ linux/drivers/ieee1394/csr.c	Sun Sep  9 00:07:21 2001
@@ -10,6 +10,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/sched.h>
 
 #include "ieee1394_types.h"
 #include "hosts.h"

if you are using any patch, and are using highmem, here is an
experimental patch that seems to work.  a final version will be in
future preempt patches:


--- linux-corndog/include/linux/highmem.h Sun Sep  9 08:59:04 2001
+++ linux/include/linux/highmem.h Sun Sep  9 09:00:07 2001
@@ -88,6 +88,7 @@
        if (page < highmem_start_page)
                return page_address(page);

+       ctx_sw_off();
        idx = type + KM_TYPE_NR*smp_processor_id();
        vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
#if HIGHMEM_DEBUG
@@ -119,6 +120,7 @@
        pte_clear(kmap_pte-idx);
        __flush_tlb_one(vaddr);
#endif
+       ctx_sw_on();
}

#endif /* __KERNEL__ */

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

