Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754611AbWKHRev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbWKHRev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbWKHRev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:34:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754612AbWKHReu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:34:50 -0500
Date: Wed, 8 Nov 2006 09:34:29 -0800
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Cc: sfr@canb.auug.org.au, hch@lst.de, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH]  powerpc iseries link error in allmodconfig
Message-ID: <20061108173429.GB14991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Choose rpa_vscsi.c over iseries_vscsi.c when building both
pseries and iseries.  This fixes a link error. 

Signed-off-by:  Judith Lebzelter <judith@osdl.org>
---

Index: linux/drivers/scsi/ibmvscsi/Makefile
===================================================================
--- linux.orig/drivers/scsi/ibmvscsi/Makefile	2006-11-06 16:52:09.000000000 -0800
+++ linux/drivers/scsi/ibmvscsi/Makefile	2006-11-07 09:35:34.019969437 -0800
@@ -1,7 +1,9 @@
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsic.o
 
 ibmvscsic-y			+= ibmvscsi.o
+ifndef CONFIG_PPC_PSERIES
 ibmvscsic-$(CONFIG_PPC_ISERIES)	+= iseries_vscsi.o 
+endif
 ibmvscsic-$(CONFIG_PPC_PSERIES)	+= rpa_vscsi.o 
 
 obj-$(CONFIG_SCSI_IBMVSCSIS)	+= ibmvstgt.o
