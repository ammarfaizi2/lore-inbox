Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbSJHVzL>; Tue, 8 Oct 2002 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJHVzL>; Tue, 8 Oct 2002 17:55:11 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:62345 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263140AbSJHVyM>; Tue, 8 Oct 2002 17:54:12 -0400
Date: Tue, 08 Oct 2002 16:59:38 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.41] New version of shared page tables
Message-ID: <223810000.1034114378@baldur.austin.ibm.com>
In-Reply-To: <181170000.1034109448@baldur.austin.ibm.com>
References: <181170000.1034109448@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1070740887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1070740887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Ok, Bill Irwin found another bug.  Here's the 2 lines of change.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1070740887==========
Content-Type: text/plain; charset=us-ascii; name="shpte-tweak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shpte-tweak.diff"; size=541

--- a/fs/exec.c	8 Oct 2002 17:32:52 -0000	1.2
+++ b/fs/exec.c	8 Oct 2002 21:46:04 -0000
@@ -46,6 +46,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
+#include <asm/rmap.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -308,7 +309,7 @@
 	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
 	page_add_rmap(page, pte);
-	increment_rss(virt_to_page(pte));
+	increment_rss(kmap_atomic_to_page(pte));
 	pte_unmap(pte);
 	spin_unlock(&tsk->mm->page_table_lock);
 

--==========1070740887==========--

