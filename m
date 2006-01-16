Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWAPJXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWAPJXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWAPJW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWAPJWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:37 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Panagiotis Christeas <p_christ@hol.gr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 15/25] Fix for lack of analog output on some cx88 boards
Date: Mon, 16 Jan 2006 07:11:23 -0200
Message-id: <20060116091123.PS01641700015@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Panagiotis Christeas <p_christ@hol.gr>

- Workaround to fix a known regression at cx88-tvaudio.c
- provide a module parameter workaround to always enable
analog output.

Signed-off-by: Panagiotis Christeas <p_christ@hol.gr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-tvaudio.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-tvaudio.c b/drivers/media/video/cx88/cx88-tvaudio.c
index 24118e4..da8d97c 100644
--- a/drivers/media/video/cx88/cx88-tvaudio.c
+++ b/drivers/media/video/cx88/cx88-tvaudio.c
@@ -60,6 +60,11 @@ static unsigned int audio_debug = 0;
 module_param(audio_debug, int, 0644);
 MODULE_PARM_DESC(audio_debug, "enable debug messages [audio]");
 
+static unsigned int always_analog = 0;
+module_param(always_analog,int,0644);
+MODULE_PARM_DESC(always_analog,"force analog audio out");
+
+
 #define dprintk(fmt, arg...)	if (audio_debug) \
 	printk(KERN_DEBUG "%s/0: " fmt, core->name , ## arg)
 
@@ -155,7 +160,8 @@ static void set_audio_finish(struct cx88
 		cx_write(AUD_I2SOUTPUTCNTL, 1);
 		cx_write(AUD_I2SCNTL, 0);
 		/* cx_write(AUD_APB_IN_RATE_ADJ, 0); */
-	} else {
+	}
+	if ((always_analog) || (!cx88_boards[core->board].blackbird)) {
 		ctl |= EN_DAC_ENABLE;
 		cx_write(AUD_CTL, ctl);
 	}

