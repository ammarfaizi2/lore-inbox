Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDCDDV>; Tue, 2 Apr 2002 22:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDCDDM>; Tue, 2 Apr 2002 22:03:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:52491 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313026AbSDCDCx>;
	Tue, 2 Apr 2002 22:02:53 -0500
Subject: [PATCH] 2.4: BUG_ON (1/2)
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 21:59:34 -0500
Message-Id: <1017802779.2941.594.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo and Alan,

The attached patch adds 2.5's BUG_ON construct to the 2.4 kernel.  This
is done to facilitate portability and back-porting 2.4 <=> 2.5, because
BUG_ON is a very readable construct, and because it is a small
optimization over standard BUG.

For the unaware,  BUG_ON(condition) is basically

        if (unlikely(condition) != 0) BUG();

This is not really about sprinkling BUG_ONs everywhere but helping
backporting.  And I like BUG_ON :)

This patch is against 2.4.19-pre5, but also applies to 2.4.19-pre4-ac3. 
Alan and Marcelo - please apply.

        Robert Love

diff -urN linux-2.4.19-pre5/include/linux/kernel.h linux/include/linux/kernel.h
--- linux-2.4.19-pre5/include/linux/kernel.h	Sat Mar 30 18:26:41 2002
+++ linux/include/linux/kernel.h	Sat Mar 30 18:30:18 2002
@@ -184,4 +184,6 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-#endif
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
+#endif /* _LINUX_KERNEL_H */

