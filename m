Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967417AbWLEKAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967417AbWLEKAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967454AbWLEKAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:00:43 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39125 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967417AbWLEKAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:00:43 -0500
Message-ID: <45754341.30500@drzeus.cx>
Date: Tue, 05 Dec 2006 11:00:33 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC update
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git for-linus

to receive the following updates:

 drivers/mmc/au1xmmc.c |    2 +-
 drivers/mmc/pxamci.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Sascha Hauer:
      mmc: pxamci compilation fix

Yoichi Yuasa:
      mmc: fix au1xmmc build error

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 447fba5..800527c 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -875,7 +875,7 @@ static void au1xmmc_init_dma(struct au1x
        host->rx_chan = rxchan;
 }

-struct const mmc_host_ops au1xmmc_ops = {
+static const struct mmc_host_ops au1xmmc_ops = {
        .request        = au1xmmc_request,
        .set_ios        = au1xmmc_set_ios,
 };
diff --git a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
index 471e9f4..45a9283 100644
--- a/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -355,7 +355,7 @@ static int pxamci_get_ro(struct mmc_host
        struct pxamci_host *host = mmc_priv(mmc);

        if (host->pdata && host->pdata->get_ro)
-               return host->pdata->get_ro(mmc->dev);
+               return host->pdata->get_ro(mmc_dev(mmc));
        /* Host doesn't support read only detection so assume writeable */
        return 0;
 }
@@ -383,7 +383,7 @@ static void pxamci_set_ios(struct mmc_ho
                host->power_mode = ios->power_mode;

                if (host->pdata && host->pdata->setpower)
-                       host->pdata->setpower(mmc->dev, ios->vdd);
+                       host->pdata->setpower(mmc_dev(mmc), ios->vdd);

                if (ios->power_mode == MMC_POWER_ON)
                        host->cmdat |= CMDAT_INIT;

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
