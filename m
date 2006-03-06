Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752074AbWCFTjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbWCFTjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWCFTjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:39:42 -0500
Received: from havoc.gtf.org ([69.61.125.42]:6843 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750729AbWCFTjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:39:41 -0500
Date: Mon, 6 Mar 2006 14:39:39 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060306193939.GA14122@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/chelsio/espi.c |    4 +---
 drivers/net/s2io.c         |    1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

Eric Sesterhenn:
      chelsio: fix kmalloc failure in t1_espi_create

Jeff Garzik:
      s2io: set_multicast_list bug

diff --git a/drivers/net/chelsio/espi.c b/drivers/net/chelsio/espi.c
index 2306425..e824aca 100644
--- a/drivers/net/chelsio/espi.c
+++ b/drivers/net/chelsio/espi.c
@@ -296,9 +296,7 @@ void t1_espi_destroy(struct peespi *espi
 
 struct peespi *t1_espi_create(adapter_t *adapter)
 {
-	struct peespi *espi = kmalloc(sizeof(*espi), GFP_KERNEL);
-
-	memset(espi, 0, sizeof(*espi));
+	struct peespi *espi = kzalloc(sizeof(*espi), GFP_KERNEL);
 
 	if (espi)
 		espi->adapter = adapter;
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 49b597c..b7f00d6 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -4092,6 +4092,7 @@ static void s2io_set_multicast(struct ne
 		     i++, mclist = mclist->next) {
 			memcpy(sp->usr_addrs[i].addr, mclist->dmi_addr,
 			       ETH_ALEN);
+			mac_addr = 0;
 			for (j = 0; j < ETH_ALEN; j++) {
 				mac_addr |= mclist->dmi_addr[j];
 				mac_addr <<= 8;
