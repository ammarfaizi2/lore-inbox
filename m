Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVADUAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVADUAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVADT5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:57:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261969AbVADT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:56:38 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Exclude PUD/PMD alloc functions if !MMU
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 04 Jan 2005 19:56:28 +0000
Message-ID: <17892.1104868588@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't declare pud_alloc() and pmd_alloc() if a nommu kernel is being
compiled. These functions require various things that aren't defined for
nommu.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat nommu-exclusions-2610mm1.diff 
 mm.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/linux/mm.h linux-2.6.10-mm1-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-mm1/include/linux/mm.h	2005-01-04 11:15:27.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/linux/mm.h	2005-01-04 17:39:56.462745022 +0000
@@ -668,7 +668,7 @@ extern void remove_shrinker(struct shrin
  * The following ifdef needed to get the 4level-fixup.h header to work.
  * Remove it when 4level-fixup.h has been removed.
  */
-#ifndef __ARCH_HAS_4LEVEL_HACK 
+#if defined(CONFIG_MMU) && !defined(__ARCH_HAS_4LEVEL_HACK)
 static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	if (pgd_none(*pgd))
