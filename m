Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSJJCdJ>; Wed, 9 Oct 2002 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJJCdJ>; Wed, 9 Oct 2002 22:33:09 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:39591 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262805AbSJJCdI>;
	Wed, 9 Oct 2002 22:33:08 -0400
Date: Thu, 10 Oct 2002 12:38:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
Subject: [PATCH] fix __SI_CODE
Message-Id: <20021010123822.64c9bbc1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This small patch is extracted from George Anzinger's High-res-timer
patches.  Even if George's patches do not go in, this patch is necessary
to fix up something I missed when I consolidated the siginfo stuff.

Thanks, George.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.41-1.715/include/asm-generic/siginfo.h 2.5.41-1.715-si.2/include/asm-generic/siginfo.h
--- 2.5.41-1.715/include/asm-generic/siginfo.h	2002-06-09 16:12:33.000000000 +1000
+++ 2.5.41-1.715-si.2/include/asm-generic/siginfo.h	2002-10-10 12:26:46.000000000 +1000
@@ -91,7 +91,7 @@
 #define __SI_FAULT	(3 << 16)
 #define __SI_CHLD	(4 << 16)
 #define __SI_RT		(5 << 16)
-#define __SI_CODE(T,N)	((T) << 16 | ((N) & 0xffff))
+#define __SI_CODE(T,N)	((T) | ((N) & 0xffff))
 #else
 #define __SI_KILL	0
 #define __SI_TIMER	0
