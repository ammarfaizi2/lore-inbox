Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFUIv1>; Fri, 21 Jun 2002 04:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFUIv0>; Fri, 21 Jun 2002 04:51:26 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:43948 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316491AbSFUIvZ>;
	Fri, 21 Jun 2002 04:51:25 -0400
Date: Fri, 21 Jun 2002 05:56:18 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: [PATCH] include/net/dsfield.h warning (2.4,2.5)
Message-ID: <20020621055618.B2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This "obviously correct" patch removes code that was never used,
and that yields warnings with recent versions of gcc. (It can
always be resurrected from archives in the unlikely event that
we should ever need those few cycles it would save.)

I tried this patch with 2.5.24, but it should be fine for any 2.4
or 2.5 kernel.

- Werner

---------------------------------- cut here -----------------------------------

--- include/net/dsfield.h.orig	Fri Jun 21 05:42:18 2002
+++ include/net/dsfield.h	Fri Jun 21 05:43:30 2002
@@ -50,30 +50,4 @@
 	*(__u16 *) ipv6h = htons(tmp);
 }
 
-
-#if 0 /* put this later into asm-i386 or such ... */
-
-static inline void ip_change_dsfield(struct iphdr *iph,__u16 dsfield)
-{
-	__u16 check;
-
-	__asm__ __volatile__("
-		movw	10(%1),%0
-		xchg	%b0,%h0
-		addb	1(%1),%b0
-		adcb	$0,%h0
-		adcw	$1,%0
-		cmc
-		sbbw	%2,%0
-		sbbw	$0,%0
-		movb	%b2,1(%1)
-		xchg	%b0,%h0
-		movw	%0,10(%1)"
-	    : "=&r" (check)
-	    : "r" (iph), "r" (dsfield)
-	    : "cc");
-}
-
-#endif
-
 #endif

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
