Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTAQFmh>; Fri, 17 Jan 2003 00:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbTAQFmh>; Fri, 17 Jan 2003 00:42:37 -0500
Received: from holomorphy.com ([66.224.33.161]:39828 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267389AbTAQFmh>;
	Fri, 17 Jan 2003 00:42:37 -0500
Date: Thu, 16 Jan 2003 21:51:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: i386 pgd_index() doesn't parenthesize its arg
Message-ID: <20030117055128.GP919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pgd_index() doesn't parenthesize its argument. This is a bad idea for
macros, since it's legitimate to pass expressions to them that will
get misinterpreted given operator precedence and the shift.

vs. 2.5.59


-- wli


===== include/asm-i386/pgtable.h 1.22 vs edited =====
--- 1.22/include/asm-i386/pgtable.h	Mon Nov 25 14:41:15 2002
+++ edited/include/asm-i386/pgtable.h	Thu Jan 16 21:08:06 2003
@@ -242,7 +242,7 @@
 	((pmd_val(pmd) & (_PAGE_PSE|_PAGE_PRESENT)) == (_PAGE_PSE|_PAGE_PRESENT))
 
 /* to find an entry in a page-table-directory. */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
 #define __pgd_offset(address) pgd_index(address)
 
