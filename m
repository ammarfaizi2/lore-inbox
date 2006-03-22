Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWCVWNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWCVWNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWCVWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:13:33 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:40601 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932106AbWCVWNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:13:11 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 11/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:13:07 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221513.07366.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/sscape.c
===================================================================
--- work-mm6.orig/sound/isa/sscape.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/sscape.c	2006-03-22 12:14:57.000000000 -0700
@@ -1255,7 +1255,7 @@
 }
 
 
-static int __init snd_sscape_probe(struct platform_device *pdev)
+static int __devinit snd_sscape_probe(struct platform_device *pdev)
 {
 	int dev = pdev->id;
 	struct snd_card *card;
@@ -1469,7 +1469,7 @@
 	if (ret < 0)
 		return ret;
 #ifdef CONFIG_PNP
-	if (pnp_register_card_driver(&sscape_pnpc_driver) >= 0)
+	if (pnp_register_card_driver(&sscape_pnpc_driver) == 0)
 		pnp_registered = 1;
 #endif
 	return 0;
