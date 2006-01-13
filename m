Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161659AbWAMDY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161659AbWAMDY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161671AbWAMDYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:24:31 -0500
Received: from ozlabs.org ([203.10.76.45]:43908 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161648AbWAMDYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:24:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17351.7469.959679.355418@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jan 2006 14:23:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] Increase AT_VECTOR_SIZE
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On PowerPC, we want to be able to provide an AT_PLATFORM aux table
entry to userspace, so that glibc can choose optimized libraries for
the processor we're running on.  Unfortunately that would be the 21st
aux table entry on powerpc, meaning that the aux table including the
terminating null entry would overflow the mm->saved_auxv[] array,
leading to userland programs segfaulting.

This increases the size of the mm->saved_auxv array to be large enough
to accommodate an AT_PLATFORM entry on powerpc.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus, can this go in before 2.6.16-rc1 please?  I can't see that it
will break anything, and the glibc guys are keen to have the
AT_PLATFORM value provided by 2.6.16 and later kernels.

Thanks,
Paul.

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 9a7b374..d2bc0d6 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -26,6 +26,6 @@
 
 #define AT_SECURE 23   /* secure mode boolean */
 
-#define AT_VECTOR_SIZE  42 /* Size of auxiliary table.  */
+#define AT_VECTOR_SIZE  44 /* Size of auxiliary table.  */
 
 #endif /* _LINUX_AUXVEC_H */
