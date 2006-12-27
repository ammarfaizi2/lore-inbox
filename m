Return-Path: <linux-kernel-owner+w=401wt.eu-S933016AbWL0ROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016AbWL0ROp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWL0ROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:14:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41553 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0RN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:58 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Akinobu Mita <akinobu.mita@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 22/28] V4L/DVB (4995): Vivi: fix kthread_run() error check
Date: Wed, 27 Dec 2006 14:57:31 -0200
Message-id: <20061227165731.PS71474700022@infradead.org>
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

The return value of kthread_run() should be checked by IS_ERR().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/vivi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index 3cead24..bacb311 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -535,9 +535,9 @@ static int vivi_start_thread(struct vivi
 
 	dma_q->kthread = kthread_run(vivi_thread, dma_q, "vivi");
 
-	if (dma_q->kthread == NULL) {
+	if (IS_ERR(dma_q->kthread)) {
 		printk(KERN_ERR "vivi: kernel_thread() failed\n");
-		return -EINVAL;
+		return PTR_ERR(dma_q->kthread);
 	}
 	dprintk(1,"returning from %s\n",__FUNCTION__);
 	return 0;

