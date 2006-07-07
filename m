Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWGGH4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWGGH4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWGGH4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:56:49 -0400
Received: from koto.vergenet.net ([210.128.90.7]:57487 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750972AbWGGH4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:56:47 -0400
Date: Fri, 7 Jul 2006 16:34:38 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <trivial@kernel.org>, Magnus Damm <damm@opensource.se>
Subject: [PATCH] i386, kexec: Remove unneccessary variable  page_list from machine_kexec()
Message-ID: <20060707073436.GA17741@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Horms <horms@verge.net.au>

 arch/i386/kernel/machine_kexec.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index 511abe5..6f140d2 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -169,7 +169,6 @@ void machine_kexec_cleanup(struct kimage
  */
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
-	unsigned long page_list;
 	unsigned long reboot_code_buffer;
 
 	relocate_new_kernel_t rnk;
@@ -180,8 +179,6 @@ NORET_TYPE void machine_kexec(struct kim
 	/* Compute some offsets */
 	reboot_code_buffer = page_to_pfn(image->control_code_page)
 								<< PAGE_SHIFT;
-	page_list = image->head;
-
 	/* Set up an identity mapping for the reboot_code_buffer */
 	identity_map_page(reboot_code_buffer);
 
@@ -210,5 +207,5 @@ NORET_TYPE void machine_kexec(struct kim
 
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
+	(*rnk)(image->head, reboot_code_buffer, image->start, cpu_has_pae);
 }
