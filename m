Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTANIQn>; Tue, 14 Jan 2003 03:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTANIQn>; Tue, 14 Jan 2003 03:16:43 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:27520 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S261600AbTANIQm>; Tue, 14 Jan 2003 03:16:42 -0500
Date: Tue, 14 Jan 2003 09:25:41 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: [PATCH] ptrace, kernel 2.5.56
Message-ID: <Pine.LNX.4.44.0301140917240.11512-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to Documentation/cachetlb.txt flush_dcache_page should also be 
called when the kernel _is about_ to read from a page and user space 
shared&writable mappings of this page potentially exist. I think 
kernel/ptrace.c should be fixed on this issue.
I already posted this patch on the lkml a few months ago, but it got lost 
I guess.
Where should I send ptrace patches to in the future? Anyone out there who 
maintains the ptrace stuff?

Frank.

--- ptrace.c.2.5.56	2003-01-13 14:31:45.000000000 +0100
+++ ptrace.c	2003-01-13 14:32:43.000000000 +0100
@@ -182,11 +182,11 @@
 		maddr = kmap(page);
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);
-			flush_page_to_ram(page);
+			flush_dcache_page(page);
 			flush_icache_user_range(vma, page, addr, bytes);
 		} else {
+			flush_dcache_page(page);
 			memcpy(buf, maddr + offset, bytes);
-			flush_page_to_ram(page);
 		}
 		kunmap(page);
 		page_cache_release(page);


