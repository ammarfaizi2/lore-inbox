Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVAEOfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVAEOfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVAEOfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:35:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262448AbVAEOf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:35:26 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make pud_alloc() and pmd_alloc() non-existant on !MMU
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 14:35:16 +0000
Message-ID: <28616.1104935716@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the general pud_alloc() and pmd_alloc() inline
functions unavailable if CONFIG_MMU is not defined.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat nommu-pudpmd-alloc-2610bk8.diff 
 mm.h |    2 ++
 1 files changed, 2 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-bk8/include/linux/mm.h linux-2.6.10-bk8-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-bk8/include/linux/mm.h	2005-01-05 13:21:46.701484684 +0000
+++ linux-2.6.10-bk8-frv/include/linux/mm.h	2005-01-05 13:51:04.063609425 +0000
@@ -659,6 +659,7 @@ extern void remove_shrinker(struct shrin
  * The following ifdef needed to get the 4level-fixup.h header to work.
  * Remove it when 4level-fixup.h has been removed.
  */
+#ifdef CONFIG_MMU
 #ifndef __ARCH_HAS_4LEVEL_HACK 
 static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
@@ -674,6 +675,7 @@ static inline pmd_t *pmd_alloc(struct mm
 	return pmd_offset(pud, address);
 }
 #endif
+#endif /* CONFIG_MMU */
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
