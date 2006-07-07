Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWGGH4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWGGH4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWGGH4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:56:48 -0400
Received: from koto.vergenet.net ([210.128.90.7]:58255 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750996AbWGGH4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:56:47 -0400
Date: Fri, 7 Jul 2006 16:34:57 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <trivial@kernel.org>, Magnus Damm <damm@opensource.se>
Subject: [PATCH] x86_64, kexec: Remove unneccessary variable  page_list from machine_kexec()
Message-ID: <20060707073456.GB17741@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Horms <horms@verge.net.au>

 arch/x86_64/kernel/machine_kexec.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/machine_kexec.c b/arch/x86_64/kernel/machine_kexec.c
index 83fb24a..44ee2a3 100644
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -184,7 +184,6 @@ void machine_kexec_cleanup(struct kimage
  */
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
-	unsigned long page_list;
 	unsigned long control_code_buffer;
 	unsigned long start_pgtable;
 	relocate_new_kernel_t rnk;
@@ -193,7 +192,6 @@ NORET_TYPE void machine_kexec(struct kim
 	local_irq_disable();
 
 	/* Calculate the offsets */
-	page_list = image->head;
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 	control_code_buffer = start_pgtable + PAGE_SIZE;
 
@@ -227,5 +225,5 @@ NORET_TYPE void machine_kexec(struct kim
 	set_idt(phys_to_virt(0),0);
 	/* now call it */
 	rnk = (relocate_new_kernel_t) control_code_buffer;
-	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
+	(*rnk)(image->head, control_code_buffer, image->start, start_pgtable);
 }
