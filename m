Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVCCFfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVCCFfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVCCFe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:34:58 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261487AbVCCFbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:38 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][5/11] IB/mthca: fix reset value endianness
In-Reply-To: <2005322131.oecVhU1CS3swCooO@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.ube7cIPz9y7840bB@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0710 (UTC) FILETIME=[3C5A0760:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MTHCA_RESET_VALUE must always be swapped, since the HCA expects to see
it in big-endian order and we write it with writel.  This means on
little-endian systems we have to swap it to big-endian order before
writing, and on big-endian systems we need to swap it to make up for
the additional swap that writel will do.  This fixes resetting the HCA
on big-endian machines.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_reset.c	2005-03-02 20:26:02.970843287 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_reset.c	2005-03-02 20:26:12.219835642 -0800
@@ -50,7 +50,7 @@
 	struct pci_dev *bridge = NULL;
 
 #define MTHCA_RESET_OFFSET 0xf0010
-#define MTHCA_RESET_VALUE  cpu_to_be32(1)
+#define MTHCA_RESET_VALUE  swab32(1)
 
 	/*
 	 * Reset the chip.  This is somewhat ugly because we have to

