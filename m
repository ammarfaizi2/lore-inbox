Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbTCNGRG>; Fri, 14 Mar 2003 01:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbTCNGRG>; Fri, 14 Mar 2003 01:17:06 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59844 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263251AbTCNGRF>;
	Fri, 14 Mar 2003 01:17:05 -0500
Date: Fri, 14 Mar 2003 12:01:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH][FIX] kiocbClear should use clear_bit instead of set_bit
Message-ID: <20030314120155.A2370@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an obvious fix.
The kiocbClearX macros were doing a set_bit !
They should be calling clear_bit.
Ran into this now that I'm actually using kiocbClearKicked.

Regards
Suparna

diff -ur linux-2.5.62/include/linux/aio.h linux-2.5.62-aio/include/linux/aio.h
--- linux-2.5.62/include/linux/aio.h	Tue Feb 18 04:25:50 2003
+++ linux-2.5.62-aio/include/linux/aio.h	Tue Mar 11 21:31:22 2003
@@ -37,9 +37,9 @@
 #define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
 
-#define kiocbClearLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
-#define kiocbClearKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
-#define kiocbClearCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearLocked(iocb)	clear_bit(KIF_LOCKED, &(iocb)->ki_flags)
+#define kiocbClearKicked(iocb)	clear_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbClearCancelled(iocb)	clear_bit(KIF_CANCELLED, &(iocb)->ki_flags)
 
 #define kiocbIsLocked(iocb)	test_bit(0, &(iocb)->ki_flags)
 #define kiocbIsKicked(iocb)	test_bit(1, &(iocb)->ki_flags)

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

