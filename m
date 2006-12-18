Return-Path: <linux-kernel-owner+w=401wt.eu-S1752706AbWLRDqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbWLRDqU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbWLRDqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4273 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752717AbWLRDqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:19 -0500
Date: Mon, 18 Dec 2006 04:46:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jonathan Corbet <corbet-v4l@lwn.net>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/cafe_ccic.c: fix NULL dereference
Message-ID: <20061218034619.GW10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't dereference "cam" when we already know it's NULL.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/drivers/media/video/cafe_ccic.c.old	2006-12-18 01:14:24.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/media/video/cafe_ccic.c	2006-12-18 01:21:29.000000000 +0100
@@ -2166,7 +2166,7 @@ static void cafe_pci_remove(struct pci_d
 	struct cafe_camera *cam = cafe_find_by_pdev(pdev);
 
 	if (cam == NULL) {
-		cam_warn(cam, "pci_remove on unknown pdev %p\n", pdev);
+		printk(KERN_WARNING "pci_remove on unknown pdev %p\n", pdev);
 		return;
 	}
 	mutex_lock(&cam->s_mutex);

