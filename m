Return-Path: <linux-kernel-owner+w=401wt.eu-S932964AbWL0RJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWL0RJ2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWL0RJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:09:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41751 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932964AbWL0RJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:09:17 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 19/28] V4L/DVB (4991): Cafe_ccic.c: fix NULL dereference
Date: Wed, 27 Dec 2006 14:57:31 -0200
Message-id: <20061227165731.PS02276300019@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

We shouldn't dereference "cam" when we already know it's NULL.
Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cafe_ccic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cafe_ccic.c b/drivers/media/video/cafe_ccic.c
index e347c7e..3083c80 100644
--- a/drivers/media/video/cafe_ccic.c
+++ b/drivers/media/video/cafe_ccic.c
@@ -2166,7 +2166,7 @@ static void cafe_pci_remove(struct pci_d
 	struct cafe_camera *cam = cafe_find_by_pdev(pdev);
 
 	if (cam == NULL) {
-		cam_warn(cam, "pci_remove on unknown pdev %p\n", pdev);
+		printk(KERN_WARNING "pci_remove on unknown pdev %p\n", pdev);
 		return;
 	}
 	mutex_lock(&cam->s_mutex);

