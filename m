Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269831AbUICUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269831AbUICUuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269814AbUICUtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:49:16 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:38835 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269763AbUICUsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:48:24 -0400
Date: Fri, 3 Sep 2004 21:47:52 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Remove bogus memset from cpqfc driver.
Message-ID: <20040903204752.GS26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that this driver compiles, but coverity picked up this nonsense.
If the pci_alloc_consistent fails, we go boom.
Amusingly, after the ==NULL check, is an identical memset.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.8/drivers/scsi/cpqfcTScontrol.c~	2004-09-03 21:44:41.742800408 +0100
+++ linux-2.6.8/drivers/scsi/cpqfcTScontrol.c	2004-09-03 21:45:37.163375200 +0100
@@ -116,7 +116,6 @@
   cpqfcHBAdata->fcLQ = pci_alloc_consistent(cpqfcHBAdata->PciDev,
 				 sizeof( FC_LINK_QUE), &cpqfcHBAdata->fcLQ_dma_handle);
   /* printk("@ %p (%u elements)\n", cpqfcHBAdata->fcLQ, FC_LINKQ_DEPTH); */
-  memset( cpqfcHBAdata->fcLQ, 0, sizeof( FC_LINK_QUE));
 
   if( cpqfcHBAdata->fcLQ == NULL ) // fatal error!!
   {
