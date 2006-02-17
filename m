Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWBQB3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWBQB3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWBQB3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:29:39 -0500
Received: from sipsolutions.net ([66.160.135.76]:64785 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750857AbWBQB3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:29:38 -0500
Subject: [PATCH linux-2.6] allow windfarm_pm112 module to load
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 02:29:21 +0100
Message-Id: <1140139762.10320.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The windfarm_pm112 module relies on smu_sat_get_sdb_partition which is
in windfarm_smu_sat.c but is not exported to modules, so despite Kconfig
having the option to build the pm112 as modules, this can never be
loaded.

This patch fixes that by exporting smu_sat_get_sdb_partition with
EXPORT_SYMBOL_GPL

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

diff --git a/drivers/macintosh/windfarm_smu_sat.c
b/drivers/macintosh/windfarm_smu_sat.c
index 3a32c59..24e51d5 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -151,6 +151,7 @@ struct smu_sdbp_header *smu_sat_get_sdb_
 	kfree(buf);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(smu_sat_get_sdb_partition);
 
 /* refresh the cache */
 static int wf_sat_read_cache(struct wf_sat *sat)


