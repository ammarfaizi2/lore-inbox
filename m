Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269378AbSIRWxr>; Wed, 18 Sep 2002 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbSIRWxr>; Wed, 18 Sep 2002 18:53:47 -0400
Received: from dp.samba.org ([66.70.73.150]:5053 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269378AbSIRWxq>;
	Wed, 18 Sep 2002 18:53:46 -0400
Date: Thu, 19 Sep 2002 08:58:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020918225828.GA2535@krispykreme>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is without preempt. I tried both with and without SMP, with and without
> large TLB pages, with and without pte highmem, all die in the same place.

I needed this to boot the latest BK on my ppc64 box. The question is
why we are suddenly ending up with prev == NULL, hch mentioned his
patch was only a cleanup in this area.

Anton

===== mm/mprotect.c 1.16 vs edited =====
--- 1.16/mm/mprotect.c	Wed Sep 18 04:05:14 2002
+++ edited/mm/mprotect.c	Wed Sep 18 22:44:40 2002
@@ -281,7 +281,7 @@
 		}
 	}
 
-	if (next && prev->vm_end == next->vm_start &&
+	if (prev && next && prev->vm_end == next->vm_start &&
 			can_vma_merge(next, prev->vm_flags) &&
 			!prev->vm_file && !(prev->vm_flags & VM_SHARED)) {
 		spin_lock(&prev->vm_mm->page_table_lock);
