Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTDIFFR (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTDIFFR (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:05:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11695 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262722AbTDIFFQ (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:05:16 -0400
Date: Wed, 9 Apr 2003 01:16:53 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Variable PTE_FILE_MAX_BITS
Message-ID: <20030409011653.A9103@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

would you be so kind to take this and forward to Linus?
I think this segment of the code is your brainchild.

On sparc, the PTE_FILE_MAX_BITS is variable (Worse, actually...
we change all occurences in kernel text segment to correct value
at boot time.) This should not harm other arches, because
gcc is capable to optimize constant conditions.

-- Pete

--- linux-2.5.66-bk11/mm/fremap.c	2003-04-05 13:26:24.000000000 -0800
+++ linux-2.5.66-bk11-sparc/mm/fremap.c	2003-04-05 13:28:22.000000000 -0800
@@ -136,10 +136,10 @@
 		return err;
 
 	/* Can we represent this offset inside this architecture's pte's? */
-#if PTE_FILE_MAX_BITS < BITS_PER_LONG
-	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
-#endif
+	/* This needs to be evaluated at runtime on some platforms */
+	if (PTE_FILE_MAX_BITS < BITS_PER_LONG)
+		if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
+			return err;
 
 	down_read(&mm->mmap_sem);
 
