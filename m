Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272860AbRIIRJR>; Sun, 9 Sep 2001 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272853AbRIIRJH>; Sun, 9 Sep 2001 13:09:07 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:48436 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272819AbRIIRJB>; Sun, 9 Sep 2001 13:09:01 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: iafilius@xs4all.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1000010407.840.35.camel@phantasy>
In-Reply-To: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet> 
	<1000010407.840.35.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 13:09:43 -0400
Message-Id: <1000055386.15956.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

the following patch was written by Manfred Spraul to fix your highmem
bug.  I haven't had a chance to go over it, but I would like it if you
could test it.  It can't hurt.  Patch it on top of the preempt patch and
enable CONFIG_PREEMPT, CONFIG_HIGHMEM, and CONFIG_HIGHMEM_DEBUG.

let me know what happens...any relevant messages, etc. please pass
along. if it does work, id be curious if they are any slowdowns


--- highmem.h.prev      Sun Sep  9 08:59:04 2001
+++ highmem.h   Sun Sep  9 09:00:07 2001
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
-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

