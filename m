Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbTHZOtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTHZOtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:49:06 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:37643 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261263AbTHZOsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:48:50 -0400
Date: Tue, 26 Aug 2003 09:55:03 -0500
From: mike.miller@hp.com
To: axboe@suse.de, akpm@digeo.com
Cc: francis.wiran@hp.com, linux-kernel@vger.kernel.org
Subject: cciss fix for 2.6.0-test4
Message-ID: <20030826145503.GA1000@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a panic in the cciss driver during driver initialization. It was built & tested against 2.6.0-test4.
Authored by Francis Wiran of Hewlett-Packard.

--------------------------------------------------------------------------------

   * Fix panic due to missing q assignment in cciss_init_one()


 drivers/block/cciss.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.0-test3/drivers/block/cciss.c~cciss_blk_alloc	2003-08-18 15:38:06.000000000 -0500
+++ linux-2.6.0-test3-root/drivers/block/cciss.c	2003-08-18 17:58:11.000000000 -0500
@@ -2525,6 +2525,8 @@ err_all:
 	if (!q)
 		goto err_all;
 
+	hba[i]->queue = q;
+
 	/* Initialize the pdev driver private data. 
 		have it point to hba[i].  */
 	pci_set_drvdata(pdev, hba[i]);

_
