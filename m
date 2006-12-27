Return-Path: <linux-kernel-owner+w=401wt.eu-S932983AbWL0RN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbWL0RN3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbWL0RNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41505 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbWL0RMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:12:49 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Akinobu Mita <akinobu.mita@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 24/28] V4L/DVB (4997): Bttv: delete duplicated ioremap()
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165732.PS14618100024@infradead.org>
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


From: Akinobu Mita <akinobu.mita@gmail.com>

ioremap() is called twice to same resource.
The returen value of first one is not error-checked.
second one is complely ignored.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bt8xx/bttv-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/bt8xx/bttv-driver.c b/drivers/media/video/bt8xx/bttv-driver.c
index 3c8e474..ab8f970 100644
--- a/drivers/media/video/bt8xx/bttv-driver.c
+++ b/drivers/media/video/bt8xx/bttv-driver.c
@@ -4050,8 +4050,8 @@ static int __devinit bttv_probe(struct p
 	       (unsigned long long)pci_resource_start(dev,0));
 	schedule();
 
-	btv->bt848_mmio=ioremap(pci_resource_start(dev,0), 0x1000);
-	if (NULL == ioremap(pci_resource_start(dev,0), 0x1000)) {
+	btv->bt848_mmio = ioremap(pci_resource_start(dev, 0), 0x1000);
+	if (NULL == btv->bt848_mmio) {
 		printk("bttv%d: ioremap() failed\n", btv->c.nr);
 		result = -EIO;
 		goto fail1;

