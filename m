Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131928AbQL1V6g>; Thu, 28 Dec 2000 16:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQL1V60>; Thu, 28 Dec 2000 16:58:26 -0500
Received: from proxy.jakinternet.co.uk ([212.187.250.66]:57103 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S131916AbQL1V6S>; Thu, 28 Dec 2000 16:58:18 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Linus Torvalds
In-Reply-To: <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>
Subject: Re: test13-pre5 (via82cxxx_audio.c)
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <3ff.3a4bb03c.65b25@trespassersw.daria.co.uk>
Date: Thu, 28 Dec 2000 21:27:24 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>,
	Linus Torvalds <torvalds@transmeta.com> writes:
LT> 
LT> The mm cleanups also include removing "swapout()" as a VM operation, as

swapout was not removed from drivers/sound/via82cxxx_audio.c; the
following does so (compiles and produces sound, someone who
understands this please check).


--- drivers/sound/via82cxxx_audio.c.orig	Thu Dec 28 21:02:03 2000
+++ drivers/sound/via82cxxx_audio.c	Thu Dec 28 21:12:58 2000
@@ -1727,20 +1727,8 @@
 }
 
 
-#ifndef VM_RESERVE
-static int via_mm_swapout (struct page *page, struct file *filp)
-{
-	return 0;
-}
-#endif /* VM_RESERVE */
-
-
 struct vm_operations_struct via_mm_ops = {
 	nopage:		via_mm_nopage,
-
-#ifndef VM_RESERVE
-	swapout:	via_mm_swapout,
-#endif
 };
 
 
 
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
