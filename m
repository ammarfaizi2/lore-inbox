Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSJ1Cgz>; Sun, 27 Oct 2002 21:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSJ1Cgz>; Sun, 27 Oct 2002 21:36:55 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:34827 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S262812AbSJ1Cgy>; Sun, 27 Oct 2002 21:36:54 -0500
Date: Sun, 27 Oct 2002 21:40:50 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: Naohiko Shimizu <nshimizu@keyaki.cc.u-tokai.ac.jp>
Cc: linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [PATCH,RFC] Transparent SuperPage Support for 2.5.44
Message-ID: <20021027214050.A7886@dsnt25.mro.cpqcorp.net>
References: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>; from nshimizu@keyaki.cc.u-tokai.ac.jp on Mon, Oct 28, 2002 at 10:58:49AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 10:58:49AM +0900, Naohiko Shimizu wrote:
> This patch includes i386, alpha, sparc64 ports.
> But I could not compile for alpha even with plain 2.5.44, and

Here's a small patch on top of yours to fix a typo and add set_pte_raw
for Alpha. 

/jeff

----
diff -Nuar superpage/include/asm-alpha/pgtable.h superpage.alpha/include/asm-alpha/pgtable.h
--- superpage/include/asm-alpha/pgtable.h	Sun Oct 27 21:16:02 2002
+++ superpage.alpha/include/asm-alpha/pgtable.h	Sun Oct 27 21:20:45 2002
@@ -275,7 +275,7 @@
 #define SUPER_PAGE_MASK 0x0060
 #define SUPER_PAGE_MASK_SHIFT 5
 #define SUPER_PAGE_NR 4
-#define SIZEOF_PTE_LOG2 SEZEOF_PTR_LOG2
+#define SIZEOF_PTE_LOG2 SIZEOF_PTR_LOG2
 void down_pte_sp(pte_t *pteptr, int index);
 void clear_pte_sp(pte_t *pteptr, int index);
 extern int super_page_order[];
@@ -288,6 +288,7 @@
 	{pte_val(pte) &= ~SUPER_PAGE_MASK; return pte;} 
 extern inline void pte_clear(pte_t *ptep)	\
 	{ pte_t pte; pte_val(pte)=0; set_pte(ptep, pte); }
+#define set_pte_raw(pteptr, pteval) set_pte(pteptr, pteval)
 #else
 extern inline int pte_none(pte_t pte)          { return !(pte_val(pte)); }
 extern inline void pte_clear(pte_t *ptep)      { pte_val(*ptep)=0; }


