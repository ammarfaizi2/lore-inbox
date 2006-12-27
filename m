Return-Path: <linux-kernel-owner+w=401wt.eu-S933020AbWL0RNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbWL0RNa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWL0RMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:12:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41476 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0RL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:59 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Akinobu Mita <akinobu.mita@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 23/28] V4L/DVB (4996): Msp3400: fix kthread_run error check
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165731.PS93321100023@infradead.org>
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

 drivers/media/video/msp3400-driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 295cb99..2fb9fe6 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -949,7 +949,7 @@ static int msp_attach(struct i2c_adapter
 	if (thread_func) {
 		state->kthread = kthread_run(thread_func, client, "msp34xx");
 
-		if (state->kthread == NULL)
+		if (IS_ERR(state->kthread))
 			v4l_warn(client, "kernel_thread() failed\n");
 		msp_wake_thread(client);
 	}

