Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTAQFyh>; Fri, 17 Jan 2003 00:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTAQFyh>; Fri, 17 Jan 2003 00:54:37 -0500
Received: from holomorphy.com ([66.224.33.161]:44436 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267393AbTAQFyg>;
	Fri, 17 Jan 2003 00:54:36 -0500
Date: Thu, 16 Jan 2003 22:03:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: i386 pgd_index() doesn't parenthesize its arg
Message-ID: <20030117060327.GQ919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030117055128.GP919@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117055128.GP919@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PAE's pte_none() and pte_pfn() evaluate their arguments twice;
analogous fixes have been made to other things; c.f. pgtable.h's long
list of one-line inlines with parentheses still around their args.


===== include/asm-i386/pgtable-3level.h 1.8 vs edited =====
--- 1.8/include/asm-i386/pgtable-3level.h	Fri Jul 26 06:23:51 2002
+++ edited/include/asm-i386/pgtable-3level.h	Thu Jan 16 21:59:08 2003
@@ -89,8 +89,8 @@
 }
 
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
-#define pte_none(x)	(!(x).pte_low && !(x).pte_high)
-#define pte_pfn(x)	(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
+static inline int pte_none(pte_t pte) { return !pte.pte_low && !pte.pte_high; }
+static inline unsigned long pte_pfn(pte_t pte) { return (pte.pte_low >> PAGE_SHIFT) | (pte.pte_high << (32 - PAGE_SHIFT)); }
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
