Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbTF3Auf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 20:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbTF3Auf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 20:50:35 -0400
Received: from dp.samba.org ([66.70.73.150]:61095 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265765AbTF3Aue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 20:50:34 -0400
Date: Mon, 30 Jun 2003 11:01:16 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix return value after hugetlb mmap failure
Message-ID: <20030630010116.GA1784@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

At the moment no one uses is_aligned_hugepage_range or is_hugepage_only_range,
but it is reasonable to assume they return true or false. 

On error we want to return -EINVAL back to userspace.

Anton

===== /mnt/kernels/linux-2.5/mm/mmap.c 1.86 vs edited =====
--- 1.86/mm/mmap.c	Thu Jun 26 09:30:53 2003
+++ edited//mnt/kernels/linux-2.5/mm/mmap.c	Mon Jun 30 10:56:22 2003
@@ -846,7 +846,7 @@
 			ret = is_hugepage_only_range(addr, len);
 		}
 		if (ret)
-			return ret;
+			return -EINVAL;
 		return addr;
 	}
 
