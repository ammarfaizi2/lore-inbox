Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbUDFNrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUDFNqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:46:42 -0400
Received: from ns.suse.de ([195.135.220.2]:2467 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263829AbUDFNlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:41:00 -0400
Date: Tue, 6 Apr 2004 15:40:52 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 10/ Bitmap bugfix
Message-Id: <20040406154052.0eebd1ea.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bugfix to prevent miscompilation on gcc 3.2 of bitmap.h

diff -u linux-2.6.5-numa/include/linux/bitmap.h-o linux-2.6.5-numa/include/linux/bitmap.h
--- linux-2.6.5-numa/include/linux/bitmap.h-o	2004-03-17 12:17:59.000000000 +0100
+++ linux-2.6.5-numa/include/linux/bitmap.h	2004-04-06 13:36:12.000000000 +0200
@@ -29,7 +29,8 @@
 static inline void bitmap_copy(unsigned long *dst,
 			const unsigned long *src, int bits)
 {
-	memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	int len = BITS_TO_LONGS(bits)*sizeof(unsigned long);
+	memcpy(dst, src, len);
 }
 
 void bitmap_shift_right(unsigned long *dst,
