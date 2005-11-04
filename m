Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVKDXTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVKDXTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKDXTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:19:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50076 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751009AbVKDXTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:19:35 -0500
Date: Fri, 4 Nov 2005 15:19:32 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 2/4] Memory Add Fixes for ppc64
Message-ID: <20051104231932.GC25545@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104231552.GA25545@w-mikek2.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init_zone() sets page count to 1.  Before 'freeing' the
page, we need to clear the count.  This is the same that is done
on free_all_bootmem_core() for memory discovered at boot time.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7/arch/powerpc/mm/mem.c linux-2.6.14-git7.work/arch/powerpc/mm/mem.c
--- linux-2.6.14-git7/arch/powerpc/mm/mem.c	2005-11-04 21:21:05.000000000 +0000
+++ linux-2.6.14-git7.work/arch/powerpc/mm/mem.c	2005-11-04 22:09:59.000000000 +0000
@@ -107,6 +107,7 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 void online_page(struct page *page)
 {
 	ClearPageReserved(page);
+	set_page_count(page, 0);
 	free_cold_page(page);
 	totalram_pages++;
 	num_physpages++;
