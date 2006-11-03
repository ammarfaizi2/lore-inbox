Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753083AbWKCEF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbWKCEF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWKCEF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:05:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52683 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753077AbWKCEFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:05:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 5/7] V4L/DVB (4770): Fix mode switch of Compro Videomate
	T300
Date: Fri, 03 Nov 2006 01:02:14 -0300
Message-id: <20061103040214.PS0825230005@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

The board did not return to analog mode since the board specific
"demod sleep" function was not called. 

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-dvb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 1ba53b5..6b61d9b 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -1147,6 +1147,8 @@ static int dvb_init(struct saa7134_dev *
 					       &philips_europa_config,
 					       &dev->i2c_adap);
 		if (dev->dvb.frontend) {
+			dev->original_demod_sleep = dev->dvb.frontend->ops.sleep;
+			dev->dvb.frontend->ops.sleep = philips_europa_demod_sleep;
 			dev->dvb.frontend->ops.tuner_ops.init = philips_europa_tuner_init;
 			dev->dvb.frontend->ops.tuner_ops.sleep = philips_europa_tuner_sleep;
 			dev->dvb.frontend->ops.tuner_ops.set_params = philips_td1316_tuner_set_params;

