Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVILPAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVILPAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVILPAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:00:02 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:27143 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751361AbVILPAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:00:01 -0400
Date: Mon, 12 Sep 2005 10:48:59 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com, cramerj@intel.com,
       jgarzik@pobox.com
Subject: [patch 2.6.13 2/5] e1000: correct rx_dropped counting
Message-ID: <09122005104859.453@bilbo.tuxdriver.com>
In-Reply-To: <09122005104859.389@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not count frames dropped by the hardware as part of rx_dropped.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/e1000/e1000_main.c |    1 -
 1 files changed, 1 deletion(-)

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2544,7 +2544,6 @@ e1000_update_stats(struct e1000_adapter 
 		adapter->stats.crcerrs + adapter->stats.algnerrc +
 		adapter->stats.rlec + adapter->stats.mpc + 
 		adapter->stats.cexterr;
-	adapter->net_stats.rx_dropped = adapter->stats.mpc;
 	adapter->net_stats.rx_length_errors = adapter->stats.rlec;
 	adapter->net_stats.rx_crc_errors = adapter->stats.crcerrs;
 	adapter->net_stats.rx_frame_errors = adapter->stats.algnerrc;
