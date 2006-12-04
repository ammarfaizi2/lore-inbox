Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758355AbWLDK25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbWLDK25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361AbWLDK25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:28:57 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:54474 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1758351AbWLDK25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:28:57 -0500
Date: Mon, 4 Dec 2006 11:28:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: drzeus-mmc@drzeus.cx
Subject: mmc: pxamci compilation fix
Message-ID: <20061204102852.GC5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre and all,

since commit fcaf71fd51f9cfc504455d3e19ec242e4b2073ed
struct mmc_host does not have a dev field. Retrieve the device with
mmc_dev() instead.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: drivers/mmc/pxamci.c
===================================================================
--- a/drivers/mmc/pxamci.c.orig
+++ b/drivers/mmc/pxamci.c
@@ -355,7 +355,7 @@ static int pxamci_get_ro(struct mmc_host
 	struct pxamci_host *host = mmc_priv(mmc);
 
 	if (host->pdata && host->pdata->get_ro)
-		return host->pdata->get_ro(mmc->dev);
+		return host->pdata->get_ro(mmc_dev(mmc));
 	/* Host doesn't support read only detection so assume writeable */
 	return 0;
 }
@@ -383,7 +383,7 @@ static void pxamci_set_ios(struct mmc_ho
 		host->power_mode = ios->power_mode;
 
 		if (host->pdata && host->pdata->setpower)
-			host->pdata->setpower(mmc->dev, ios->vdd);
+			host->pdata->setpower(mmc_dev(mmc), ios->vdd);
 
 		if (ios->power_mode == MMC_POWER_ON)
 			host->cmdat |= CMDAT_INIT;


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
