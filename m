Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbUDPVXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbUDPVXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:23:00 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:11679 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263816AbUDPVW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:22:56 -0400
Date: Fri, 16 Apr 2004 22:22:05 +0100
From: Dave Jones <davej@redhat.com>
To: jsimmons@infradead.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aty128fb dereference before null check
Message-ID: <20040416212205.GF25240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jsimmons@infradead.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.5/drivers/video/aty/aty128fb.c~	2004-04-16 22:20:26.000000000 +0100
+++ linux-2.6.5/drivers/video/aty/aty128fb.c	2004-04-16 22:21:29.000000000 +0100
@@ -1998,11 +1998,13 @@
 static void __devexit aty128_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
-	struct aty128fb_par *par = info->par;
+	struct aty128fb_par *par;
 
 	if (!info)
 		return;
 
+	par = info->par;
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)
