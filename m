Return-Path: <linux-kernel-owner+w=401wt.eu-S932484AbXAGKoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbXAGKoZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAGKoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:44:24 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58483 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484AbXAGKoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:44:06 -0500
Date: Sun, 7 Jan 2007 11:44:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Fix vmalloc area size calculation.
Message-ID: <20070107104403.GD14724@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Fix vmalloc area size calculation.

setup_memory_end() uses VMALLOC_END instead of VMALLOC_END_INIT to
calculate the maximum supported size of physical memory. Since
VMALLOC_END is zero, this will cause a crash on 31 bit systems.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2007-01-06 15:20:33.000000000 +0100
@@ -476,7 +476,7 @@ static void __init setup_memory_end(void
 	int i;
 
 	memory_size = real_size = 0;
-	max_phys = VMALLOC_END - VMALLOC_MIN_SIZE;
+	max_phys = VMALLOC_END_INIT - VMALLOC_MIN_SIZE;
 	memory_end &= PAGE_MASK;
 
 	max_mem = memory_end ? min(max_phys, memory_end) : max_phys;
