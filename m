Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUIJDem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUIJDem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUIJDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:32:40 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:55468 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267918AbUIJD3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:29:32 -0400
Date: Fri, 10 Sep 2004 12:32:06 +0900 (JST)
Message-Id: <200409100332.i8A3W6YV007141@mailsv.bs1.fc.nec.co.jp>
To: akpm@osdl.org, hugh@veritas.com, davem@davemloft.net, ecd@skynet.be,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Cc: wli@holomorphy.com, takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_inc_return() for sparc64[5/5] (Re: atomic_inc_return)
In-Reply-To: Your message of "Thu, 9 Sep 2004 20:48:27 +0100 (BST)".
	<Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[5/5] atomic_inc_return-linux-2.6.9-rc1.sparc64.patch
  This patch declares atomic_add_return() as an alias of __atomic_add().
  atomic64_add_return(),atomic_sub_return() and atomic64_sub_return() are same.
  This patch has not been tested, since we don't have SPARC64 machine.  
  I want to let this reviewed by SPARC64 specialists.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc1/include/asm-sparc64/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-sparc64/atomic.h
--- linux-2.6.9-rc1/include/asm-sparc64/atomic.h	2004-08-24 16:03:32.000000000 +0900
+++ linux-2.6.9-rc1.atomic_inc_return/include/asm-sparc64/atomic.h	2004-09-10 10:13:25.000000000 +0900
@@ -39,8 +39,14 @@
 
 #define atomic_inc_return(v) __atomic_add(1, v)
 #define atomic64_inc_return(v) __atomic64_add(1, v)
 
+#define atomic_sub_return(i, v) __atomic_sub(i, v)
+#define atomic64_sub_return(i, v) __atomic64_sub(i, v)
+
+#define atomic_add_return(i, v) __atomic_add(i, v)
+#define atomic64_add_return(i, v) __atomic64_add(i, v)
+
 /*
  * atomic_inc_and_test - increment and test
  * @v: pointer of type atomic_t
  *
