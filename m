Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVILO6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVILO6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVILO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:14 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:19207 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751325AbVILO6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:10 -0400
Date: Mon, 12 Sep 2005 10:49:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       ayyappan.veeraiyan@intel.com, jgarzik@pobox.com
Subject: [patch 2.6.13 4/5] ixgb: correct rx_dropped counting
Message-ID: <09122005104900.585@bilbo.tuxdriver.com>
In-Reply-To: <09122005104859.522@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not count frames dropped by the hardware as part of rx_dropped.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/ixgb/ixgb_main.c |    2 --
 1 files changed, 2 deletions(-)

diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -1616,8 +1616,6 @@ ixgb_update_stats(struct ixgb_adapter *a
 	    adapter->stats.icbc +
 	    adapter->stats.ecbc + adapter->stats.mpc;
 
-	adapter->net_stats.rx_dropped = adapter->stats.mpc;
-
 	/* see above
 	 * adapter->net_stats.rx_length_errors = adapter->stats.rlec;
 	 */
