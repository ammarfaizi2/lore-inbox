Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbULEGCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbULEGCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 01:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbULEGCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 01:02:16 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:13244 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261256AbULEGCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 01:02:12 -0500
Date: Sat, 4 Dec 2004 23:01:35 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2/2] NX: Triple fault with 4k kernel mappings and PAE
Message-ID: <Pine.LNX.4.61.0412042253160.6378@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with NX, CONFIG_X86_PAE and CONFIG_DEBUG_PAGEALLOC or 
mem=nopentium triple faults really early during boot as it appears to be 
tripping over pages from PAGE_OFFSET -> PAGE_OFFSET + 0x100000 not being 
marked as executable.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2/arch/i386/mm/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.10-rc2/arch/i386/mm/init.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/mm/init.c	5 Dec 2004 05:41:19 -0000
@@ -126,7 +126,7 @@ static void __init page_table_range_init
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)__init_end)
+	if (addr >= PAGE_OFFSET && addr <= (unsigned long)__init_end)
 		return 1;
 	return 0;
 }
 
