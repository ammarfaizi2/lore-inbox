Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJGSIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTJGSIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:08:25 -0400
Received: from zero.aec.at ([193.170.194.10]:46852 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262617AbTJGSIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:08:21 -0400
Date: Tue, 7 Oct 2003 20:08:13 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Fix 64bit issues in trident frame buffer driver
Message-ID: <20031007180813.GA2307@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[not sure if there's a trident framebuffer maintainer. Sending it to
the trivial patch monkey for now]

While going through some warnings on x86-64 I fixed this 
obvious 64bit problem.

-Andi

diff -u linux-2.5-cleanup/drivers/video/tridentfb.c-o linux-2.5-cleanup/drivers/video/tridentfb.c
--- linux-2.5-cleanup/drivers/video/tridentfb.c-o	2003-08-22 13:36:35.000000000 +0200
+++ linux-2.5-cleanup/drivers/video/tridentfb.c	2003-12-02 17:14:35.642957672 +0100
@@ -28,7 +28,7 @@
 
 struct tridentfb_par {
 	int vclk;		//in MHz
-	unsigned int io_virt;	//iospace virtual memory address
+	unsigned long io_virt;	//iospace virtual memory address
 };
 
 unsigned char eng_oper;		//engine operation...
@@ -1102,7 +1102,7 @@
 		return -1;
 	}
 
-	default_par.io_virt = (unsigned int)ioremap_nocache(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	default_par.io_virt = (unsigned long)ioremap_nocache(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 
 	if (!default_par.io_virt) {
 		release_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
