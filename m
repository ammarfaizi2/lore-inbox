Return-Path: <linux-kernel-owner+w=401wt.eu-S1754423AbWL3XoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbWL3XoV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbWL3XoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 18:44:21 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:44921 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416AbWL3XoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 18:44:20 -0500
Message-id: <1097529576320308434@wsc.cz>
Subject: [PATCH 1/1] Char: mxser_new, do not put pdev
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 00:44:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, do not put pdev

We don't call pci_dev_get, so do not call pci_dev_put in the pci release
function.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit c614729fee9638269d0881cf6ab895f19122225a
tree 84e4d767dbd91faf59e2e4dd93ea780439451cfd
parent 412f4e2b96e2d30da853368c2a04a2701c0be7b8
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 00:09:28 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 00:09:28 +0059

 drivers/char/mxser_new.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index f078ddf..0b66056 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2348,7 +2348,6 @@ static void mxser_release_res(struct mxser_board *brd, struct pci_dev *pdev,
 #ifdef CONFIG_PCI
 		pci_release_region(pdev, 2);
 		pci_release_region(pdev, 3);
-		pci_dev_put(pdev);
 #endif
 	} else {
 		release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
