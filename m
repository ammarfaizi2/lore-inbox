Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVKGUDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVKGUDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbVKGUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:03:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25362 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965215AbVKGUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:38 -0500
Date: Mon, 7 Nov 2005 21:03:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051107200336.GH3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, using an undeclared function gives a compile warning, but it 
can lead to a nasty runtime error if the prototype of the function is 
different from what gcc guessed.

With -Werror-implicit-function-declaration, we are getting an immediate 
compile error instead.

There will be some compile errors in cases where compilation previously
worked because the undefined function wasn't called due to gcc dead code
elimination, but in these cases a proper fix doesnt harm.


This patch also removes some unneeded spaces between two tabs in the 
following line.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 30 Aug 2005
- 30 Jul 2005

--- linux-2.6.13-rc3-mm3-full/Makefile.old	2005-07-30 13:55:32.000000000 +0200
+++ linux-2.6.13-rc3-mm3-full/Makefile	2005-07-30 13:55:56.000000000 +0200
@@ -351,7 +351,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration \
+		   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 

