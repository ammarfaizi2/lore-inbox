Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752138AbWCCBtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWCCBtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWCCBsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:41 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:9428 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752131AbWCCBsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:16 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 8/15] EDAC: fix minor logic bug in e7xxx_remove_one()
Date: Thu, 2 Mar 2006 17:48:03 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.03346.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor logic bug in e7xxx_remove_one().

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e7xxx_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c	2006-02-27 17:05:19.000000000 -0800
@@ -512,7 +512,7 @@ static void __devexit e7xxx_remove_one(s
 	debugf0("%s()\n", __func__);
 
 	if (((mci = edac_mc_find_mci_by_pdev(pdev)) != 0) &&
-	    edac_mc_del_mc(mci)) {
+	    !edac_mc_del_mc(mci)) {
 		pvt = (struct e7xxx_pvt *) mci->pvt_info;
 		pci_dev_put(pvt->bridge_ck);
 		edac_mc_free(mci);
