Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271187AbRHYXkb>; Sat, 25 Aug 2001 19:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHYXkV>; Sat, 25 Aug 2001 19:40:21 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:35206
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S269817AbRHYXkJ>; Sat, 25 Aug 2001 19:40:09 -0400
Message-ID: <3B883767.2040004@fugmann.dhs.org>
Date: Sun, 26 Aug 2001 01:40:23 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3DNOW optimization fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Andreas Franck, the assembler instruction for
write prefetch is mistakenly a read prefetch. Below is for
linux-2.4.8-ac11 that corrects the error.

Regards
Anders Fugmann
--

--- linux/include/asm-i386/processor.h~ Sun Aug 26 01:18:12 2001
+++ linux/include/asm-i386/processor.h  Sun Aug 26 01:22:36 2001
@@ -501,7 +502,7 @@

   extern inline void prefetchw(const void *x)
   {
-        __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
+        __asm__ __volatile__ ("prefetchw (%0)" : : "r"(x));
   }
   #define spin_lock_prefetch(x)  prefetchw(x)





