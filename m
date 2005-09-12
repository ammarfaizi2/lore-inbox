Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVILPBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVILPBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVILPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:01:39 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:29447 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751371AbVILPBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:01:30 -0400
Date: Mon, 12 Sep 2005 10:49:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: mchan@broadcom.com, davem@davemloft.net, jgarzik@pobox.com
Subject: [patch 2.6.13 5/5] tg3: correct rx_dropped and add rx_missed_errors
Message-ID: <09122005104900.650@bilbo.tuxdriver.com>
In-Reply-To: <09122005104900.585@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not count non-error frames dropped by the hardware as
rx_errors. Instead, count them as part of rx_missed_errors.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -6893,8 +6893,7 @@ static struct net_device_stats *tg3_get_
 		get_stat64(&hw_stats->tx_octets);
 
 	stats->rx_errors = old_stats->rx_errors +
-		get_stat64(&hw_stats->rx_errors) +
-		get_stat64(&hw_stats->rx_discards);
+		get_stat64(&hw_stats->rx_errors);
 	stats->tx_errors = old_stats->tx_errors +
 		get_stat64(&hw_stats->tx_errors) +
 		get_stat64(&hw_stats->tx_mac_errors) +
@@ -6922,6 +6921,9 @@ static struct net_device_stats *tg3_get_
 	stats->rx_crc_errors = old_stats->rx_crc_errors +
 		calc_crc_errors(tp);
 
+	stats->rx_missed_errors = old_stats->rx_missed_errors +
+		get_stat64(&hw_stats->rx_discards);
+
 	return stats;
 }
 
