Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJ2JTw>; Tue, 29 Oct 2002 04:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJ2JTw>; Tue, 29 Oct 2002 04:19:52 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:48838 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S261723AbSJ2JTv>; Tue, 29 Oct 2002 04:19:51 -0500
Date: Tue, 29 Oct 2002 10:26:07 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: [PATCH] ptrace on 2.5.44
Message-ID: <Pine.LNX.4.44.0210291018001.10072-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to cachetlb.txt the following should be fixed in order to get 
it right on some architectures.

Frank.

--- ptrace.c.2.5.44     Wed Oct 30 10:09:42 2002
+++ ptrace.c    Wed Oct 30 10:11:33 2002
@@ -181,11 +181,11 @@
                maddr = kmap(page);
                if (write) {
                        memcpy(maddr + offset, buf, bytes);
-                       flush_page_to_ram(page);
+                       flush_dcache_page(page);
                        flush_icache_user_range(vma, page, addr, bytes);
                } else {
+                       flush_dcache_page(page);
                        memcpy(buf, maddr + offset, bytes);
-                       flush_page_to_ram(page);
                }
                kunmap(page);
                page_cache_release(page);


