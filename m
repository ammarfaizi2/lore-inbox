Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315397AbSEGQAr>; Tue, 7 May 2002 12:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSEGQAq>; Tue, 7 May 2002 12:00:46 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:31104 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S315397AbSEGQAp>;
	Tue, 7 May 2002 12:00:45 -0400
Date: Tue, 7 May 2002 18:00:43 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS: Allow user to select 1:1 mapping
Message-ID: <20020507160043.GB15298@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
   patch below allows user to select 'default' encoding,
which has defined mapping for each of 255 byte values, so
one can use it as a fallback when it finds filesystem
with unknown encoding (EBCDIC for example) just to get
characters through filesystem.
				Petr Vandrovec
				vandrove@vc.cvut.cz



diff -urdN linux/fs/nls/nls_base.c linux/fs/nls/nls_base.c
--- linux/fs/nls/nls_base.c	Mon May  6 03:37:54 2002
+++ linux/fs/nls/nls_base.c	Tue May  7 10:06:53 2002
@@ -20,7 +20,8 @@
 #endif
 #include <linux/spinlock.h>
 
-static struct nls_table *tables;
+static struct nls_table default_table;
+static struct nls_table *tables = &default_table;
 static spinlock_t nls_lock = SPIN_LOCK_UNLOCKED;
 
 /*
