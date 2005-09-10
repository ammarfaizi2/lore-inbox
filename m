Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVIJMWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVIJMWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIJMVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:40 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:40839 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750786AbVIJMVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:17 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9s5017250@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 6/10] drivers/char: pci_find_device remove (drivers/char/stallion.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 stallion.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -2726,7 +2726,7 @@ static inline int stl_findpcibrds(void)
 #endif
 
 	for (i = 0; (i < stl_nrpcibrds); i++)
-		while ((dev = pci_find_device(stl_pcibrds[i].vendid,
+		while ((dev = pci_get_device(stl_pcibrds[i].vendid,
 		    stl_pcibrds[i].devid, dev))) {
 
 /*
@@ -2737,8 +2737,10 @@ static inline int stl_findpcibrds(void)
 				continue;
 
 			rc = stl_initpcibrd(stl_pcibrds[i].brdtype, dev);
-			if (rc)
+			if (rc) {
+				pci_dev_put(dev);
 				return(rc);
+			}
 		}
 
 	return(0);
