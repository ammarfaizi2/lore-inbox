Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWFUO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWFUO1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWFUO05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:57 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751614AbWFUO0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:46 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 21/21] [MMC] Remove duplicate error message
Date: Wed, 21 Jun 2006 16:26:47 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142646.8857.98400.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When there is remaining blocks untransferred, we get two error messages
saying almost the same thing. Make sure at most one is shown.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 60d838c..8110ce0 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -470,9 +470,7 @@ static void sdhci_finish_data(struct sdh
 			"though there were blocks left. Please report this "
 			"to " BUGMAIL ".\n", mmc_hostname(host->mmc));
 		data->error = MMC_ERR_FAILED;
-	}
-
-	if (host->size != 0) {
+	} else if (host->size != 0) {
 		printk(KERN_ERR "%s: %d bytes were left untransferred. "
 			"Please report this to " BUGMAIL ".\n",
 			mmc_hostname(host->mmc), host->size);

