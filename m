Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWIWA2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWIWA2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIWA2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:28:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10639 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964972AbWIWA2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:28:18 -0400
Date: Sat, 23 Sep 2006 01:28:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 64bit bugs in s2io
Message-ID: <20060923002817.GC29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le32_to_cpu() on 64bit values

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/s2io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index e72e0e0..bb899f1 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -4302,11 +4302,11 @@ static struct net_device_stats *s2io_get
 	sp->stats.tx_errors =
 		le32_to_cpu(mac_control->stats_info->tmac_any_err_frms);
 	sp->stats.rx_errors =
-		le32_to_cpu(mac_control->stats_info->rmac_drop_frms);
+		le64_to_cpu(mac_control->stats_info->rmac_drop_frms);
 	sp->stats.multicast =
 		le32_to_cpu(mac_control->stats_info->rmac_vld_mcst_frms);
 	sp->stats.rx_length_errors =
-		le32_to_cpu(mac_control->stats_info->rmac_long_frms);
+		le64_to_cpu(mac_control->stats_info->rmac_long_frms);
 
 	return (&sp->stats);
 }
-- 
1.4.2.GIT
