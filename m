Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWFUO0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWFUO0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWFUO0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:32 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751603AbWFUO0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:21 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 14/21] [MMC] Reset sdhci controller early
Date: Wed, 21 Jun 2006 16:26:22 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142621.8857.43968.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The specification states that the capabilities register might need a reset
to get correct values after boot up.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 0c19e27..7b55691 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1132,6 +1132,8 @@ static int __devinit sdhci_probe_slot(st
 		goto release;
 	}
 
+	sdhci_reset(host, SDHCI_RESET_ALL);
+
 	version = readw(host->ioaddr + SDHCI_HOST_VERSION);
 	version = (version & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 	if (version != 0) {

