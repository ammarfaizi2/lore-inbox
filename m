Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVCUUEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVCUUEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVCUUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:04:04 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:8972 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261853AbVCUUCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:02:34 -0500
Date: Mon, 21 Mar 2005 15:02:27 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: [patch 2.6.11] e1000: flush work queues on remove
Message-ID: <20050321200222.GA32390@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, cramerj@intel.com,
	john.ronciak@intel.com, ganesh.venkatesan@intel.com,
	netdev@oss.sgi.com, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flush work queues in ->remove() for e1000.

Acked-by: Ganesh Venkatesan <ganesh.venkatesan@intel.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Since e1000 is using work queues, we need to call
flush_scheduled_work() before removing the driver from memory.
Otherwise, we are prone to an Oops...

 drivers/net/e1000/e1000_main.c |    2 ++
 1 files changed, 2 insertions(+)

--- e1000-work-flush-2.6/drivers/net/e1000/e1000_main.c.orig	2005-03-17 21:37:30.000000000 -0500
+++ e1000-work-flush-2.6/drivers/net/e1000/e1000_main.c	2005-03-21 14:52:46.077220964 -0500
@@ -660,6 +660,8 @@ e1000_remove(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc;
 
+	flush_scheduled_work();
+
 	if(adapter->hw.mac_type >= e1000_82540 &&
 	   adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
-- 
John W. Linville
linville@tuxdriver.com
