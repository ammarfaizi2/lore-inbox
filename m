Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSJOOcy>; Tue, 15 Oct 2002 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJOOcy>; Tue, 15 Oct 2002 10:32:54 -0400
Received: from dobit2.rug.ac.be ([157.193.42.8]:39338 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S262981AbSJOOcy>;
	Tue, 15 Oct 2002 10:32:54 -0400
Date: Tue, 15 Oct 2002 16:38:47 +0200 (MEST)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: Frank Cornelis <Frank.Cornelis@rug.ac.be>
Subject: [PATCH] ptrace, kernel 2.4.19
Message-ID: <Pine.GSO.4.31.0210151631570.20431-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As far as I understand Documentation/cachetlb.txt the access_process_vm
function in kernel/ptrace.c handles the D-cache not correctly.
I think it should go as I patched.

Frank.

--- ptrace.c.orig       Tue Oct 15 16:12:31 2002
+++ ptrace.c    Tue Oct 15 16:19:49 2002
@@ -163,11 +163,11 @@
                maddr = kmap(page);
                if (write) {
                        memcpy(maddr + offset, buf, bytes);
-                       flush_page_to_ram(page);
+                       flush_dcache_page(page);
                        flush_icache_user_range(vma, page, addr, len);
                } else {
+                       flush_dcache_page(page);
                        memcpy(buf, maddr + offset, bytes);
-                       flush_page_to_ram(page);
                }
                kunmap(page);
                put_page(page);


