Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRHVDiu>; Tue, 21 Aug 2001 23:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271922AbRHVDil>; Tue, 21 Aug 2001 23:38:41 -0400
Received: from zok.sgi.com ([204.94.215.101]:38336 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271921AbRHVDi1>;
	Tue, 21 Aug 2001 23:38:27 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: 2.4.9 new min/max definitions are buggy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Aug 2001 13:38:38 +1000
Message-ID: <9140.998451518@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving aside the question of whether the new min/max functions are
sane or not, the 2.4.9 definitions are buggy.  If type is a pointer
like char *, __x takes pointer type, __y takes base type, splat!

Index: 9.1/include/linux/kernel.h
--- 9.1/include/linux/kernel.h Tue, 21 Aug 2001 16:48:26 +1000 kaos (linux-2.4/g/b/11_kernel.h 1.1.1.5 644)
+++ 9.1(w)/include/linux/kernel.h Wed, 22 Aug 2001 13:33:28 +1000 kaos (linux-2.4/g/b/11_kernel.h 1.1.1.5 644)
@@ -113,9 +113,9 @@ static inline void console_verbose(void)
 	((unsigned char *)&addr)[0]
 
 #define min(type,x,y) \
-	({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
+	({ type __x = (x); type __y = (y); __x < __y ? __x: __y; })
 #define max(type,x,y) \
-	({ type __x = (x), __y = (y); __x > __y ? __x: __y; })
+	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
 
 #endif /* __KERNEL__ */
 

