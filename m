Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVADVra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVADVra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVADVq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:46:56 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:65534 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262276AbVADVkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:40:49 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214108.21749.55662.98205@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 3/7] ppc: remove cli()/sti() in arch/ppc/8xx_io/fec.c
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:40:48 -0600
Date: Tue, 4 Jan 2005 15:40:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c
--- linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c	2004-12-24 16:35:28.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c	2005-01-03 19:59:15.827049038 -0500
@@ -817,8 +817,7 @@
 
 	retval = 0;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if ((mip = mii_free) != NULL) {
 		mii_free = mip->mii_next;
@@ -836,7 +835,7 @@
 		retval = 1;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(retval);
 }
