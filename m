Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVACRtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVACRtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVACRfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:35:39 -0500
Received: from holomorphy.com ([207.189.100.168]:39324 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261603AbVACReN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:34:13 -0500
Date: Mon, 3 Jan 2005 09:34:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [4/8] fix arch/x86_64/ia32/syscall32.c misdeclared pud variable
Message-ID: <20050103173406.GF29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103172839.GE29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pud needs to be declared as a pud_t in order to avoid an assignment
from incompatible pointer type warning or two; this patch makes it so.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/arch/x86_64/ia32/syscall32.c
===================================================================
--- mm1-2.6.10.orig/arch/x86_64/ia32/syscall32.c	2005-01-03 06:44:20.000000000 -0800
+++ mm1-2.6.10/arch/x86_64/ia32/syscall32.c	2005-01-03 07:56:06.000000000 -0800
@@ -41,7 +41,7 @@
 int __map_syscall32(struct mm_struct *mm, unsigned long address)
 { 
 	pgd_t *pgd;
-	pgd_t *pud;
+	pud_t *pud;
 	pte_t *pte;
 	pmd_t *pmd;
 	int err = -ENOMEM;
