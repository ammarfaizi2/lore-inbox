Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUKQGRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUKQGRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbUKQGRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:17:44 -0500
Received: from fmr05.intel.com ([134.134.136.6]:31183 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262186AbUKQGRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:17:40 -0500
Subject: [PATCH] Trival patch - flush TLB when pagetable changed
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1100671893.7781.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 14:11:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Possibly it doesn't change anything here (it's low mem), but it's better to fix it.

Thanks,
Shaohua

===== arch/i386/kernel/acpi/sleep.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/acpi/sleep.c	2004-10-19 13:26:45 +08:00
+++ edited/arch/i386/kernel/acpi/sleep.c	2004-10-20 13:39:58 +08:00
@@ -27,6 +27,7 @@ static void init_low_mapping(pgd_t *pgd,
 		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
+	flush_tlb_all();
 }
 
 /**


