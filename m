Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbQLOEkA>; Thu, 14 Dec 2000 23:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOEjw>; Thu, 14 Dec 2000 23:39:52 -0500
Received: from linuxcare.com.au ([203.29.91.49]:55314 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129257AbQLOEjk>; Thu, 14 Dec 2000 23:39:40 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Fri, 15 Dec 2000 15:08:44 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: fix for nfs on 64 bit archs.
Message-ID: <20001215150844.A6588@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Since we use bitops on wb_flags it needs to be unsigned long. With this
fix nfs works on sparc64 again.

Anton

--- linux/include/linux/nfs_page.h	Wed Dec  6 22:19:17 2000
+++ linux_work/include/linux/nfs_page.h	Fri Dec 15 14:38:18 2000
@@ -33,8 +33,8 @@
 	unsigned long		wb_timeout;	/* when to read/write/commit */
 	unsigned int		wb_offset,	/* Offset of read/write */
 				wb_bytes,	/* Length of request */
-				wb_count,	/* reference count */
-				wb_flags;
+				wb_count;	/* reference count */
+	unsigned long		wb_flags;
 	struct nfs_writeverf	wb_verf;	/* Commit cookie */
 };
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
