Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUI0KqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUI0KqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUI0KqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:46:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:23984 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266631AbUI0KqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:46:01 -0400
Date: Mon, 27 Sep 2004 12:42:56 +0200
From: Andi Kleen <ak@suse.de>
To: "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix LH workaround on UP systems
Message-ID: <20040927104256.GF3532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Didn't compile on !CONFIG_SMP

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux/drivers/pci/quirks.c-o linux/drivers/pci/quirks.c
--- linux/drivers/pci/quirks.c-o	2004-09-27 12:34:05.000000000 +0200
+++ linux/drivers/pci/quirks.c	2004-09-27 12:34:44.000000000 +0200
@@ -761,7 +761,9 @@
 #endif
 		noirqdebug_setup("");
 #endif
+#ifdef CONFIG_SMP
 		no_irq_affinity = 1;
+#endif
 	}
 
 	config &= ~0x2;
