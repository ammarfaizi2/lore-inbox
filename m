Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVC1OFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVC1OFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVC1Nj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:39:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50095 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261790AbVC1N1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:19 -0500
Subject: [RFC/PATCH 11/17][Kdump] Routines for copying dump pages fixes
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-vc+C9XAQu9HiqIp/Ezu+"
Date: Mon, 28 Mar 2005 18:57:16 +0530
Message-Id: <1112016436.4001.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vc+C9XAQu9HiqIp/Ezu+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-vc+C9XAQu9HiqIp/Ezu+
Content-Disposition: attachment; filename=crashdump-routines-for-copying-dump-pages-fixes.patch
Content-Type: text/x-patch; name=crashdump-routines-for-copying-dump-pages-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/crash_dump.c |    5 ++++-
 arch/i386/mm/highmem.c      |    0 
 include/asm-i386/highmem.h  |    0 
 include/linux/highmem.h     |    0 
 4 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/i386/mm/highmem.c~crashdump-routines-for-copying-dump-pages-fixes arch/i386/mm/highmem.c
diff -puN include/asm-i386/highmem.h~crashdump-routines-for-copying-dump-pages-fixes include/asm-i386/highmem.h
diff -puN include/linux/highmem.h~crashdump-routines-for-copying-dump-pages-fixes include/linux/highmem.h
diff -puN kernel/crash_dump.c~crashdump-routines-for-copying-dump-pages-fixes kernel/crash_dump.c
--- 25/kernel/crash_dump.c~crashdump-routines-for-copying-dump-pages-fixes	Fri Feb  4 15:21:25 2005
+++ 25-akpm/kernel/crash_dump.c	Fri Feb  4 15:22:39 2005
@@ -28,6 +28,8 @@ ssize_t copy_oldmem_page(unsigned long p
 		return 0;
 
 	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
 	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
 	copy_page(page, vaddr);
@@ -38,8 +40,9 @@ ssize_t copy_oldmem_page(unsigned long p
 			kfree(page);
 			return -EFAULT;
 		}
-	} else
+	} else {
 		memcpy(buf, page, csize);
+	}
 	kfree(page);
 
 	return 0;
_

--=-vc+C9XAQu9HiqIp/Ezu+--

