Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265332AbUEZHPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUEZHPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUEZHPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:15:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:48009 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265332AbUEZHPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:15:17 -0400
Subject: [PATCH] ppc32 implementation of ptep_set_access_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1085554527.7835.59.camel@gaston>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	 <1085522860.15315.133.camel@gaston>
	 <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	 <1085530867.14969.143.camel@gaston>
	 <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	 <1085541906.14969.412.camel@gaston>
	 <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
	 <1085546780.5584.19.camel@gaston>
	 <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
	 <1085551152.6320.38.camel@gaston>  <1085554527.7835.59.camel@gaston>
Content-Type: text/plain
Message-Id: <1085555491.7835.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 17:11:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the ppc32 implementation of ptep_set_access_flags:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc/pgtable.h 1.32 vs edited =====
--- 1.32/include/asm-ppc/pgtable.h	2004-05-23 07:56:24 +10:00
+++ edited/include/asm-ppc/pgtable.h	2004-05-26 17:07:35 +10:00
@@ -548,6 +548,16 @@
 	pte_update(ptep, 0, _PAGE_DIRTY);
 }
 
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
+{
+	unsigned long bits = pte_val(entry) &
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+	pte_update(ptep, 0, bits);
+}
+#define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+        __ptep_set_access_flags(__ptep, __entry, __dirty)
+
 /*
  * Macro to mark a page protection value as "uncacheable".
  */


