Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUBPIfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUBPIfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:35:53 -0500
Received: from dp.samba.org ([66.70.73.150]:26090 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265445AbUBPIfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:35:52 -0500
Date: Mon, 16 Feb 2004 19:30:33 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ppc64 LPAR
Message-ID: <20040216083033.GA25491@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch fixes pSeries LPAR (logical partitioned) machines.
We werent initialising the pci_dma_ops stuff.

Anton

--- linux-2.5/arch/ppc64/kernel/pSeries_lpar.c	2004-02-06 14:38:04.642245906 +1100
+++ build/arch/ppc64/kernel/pSeries_lpar.c	2004-02-16 18:30:45.581745104 +1100
@@ -296,6 +296,8 @@
 {
 	pSeries_lpar_mm_init();
 
+	tce_init_pSeries();
+
 	ppc_md.tce_build	 = tce_build_pSeriesLP;
 	ppc_md.tce_free_one	 = tce_free_one_pSeriesLP;
 
