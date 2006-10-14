Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWJNMJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWJNMJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWJNMIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25255 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932209AbWJNMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:31 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/18] V4L/DVB (4727): Support status readout for saa713x
	based FM radio
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS25085200003@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

This patch adds readout for stereo and signal level for
saa713x cards which use the saa713x as FM demodulator.
These are many cards based on saa7133, tda8290 and tda8275a.
FM channel search should work now.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-video.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-video.c b/drivers/media/video/saa7134/saa7134-video.c
index 203302f..830617e 100644
--- a/drivers/media/video/saa7134/saa7134-video.c
+++ b/drivers/media/video/saa7134/saa7134-video.c
@@ -2248,7 +2248,11 @@ static int radio_do_ioctl(struct inode *
 		t->type = V4L2_TUNER_RADIO;
 
 		saa7134_i2c_call_clients(dev, VIDIOC_G_TUNER, t);
-
+		if (dev->input->amux == TV) {
+			t->signal = 0xf800 - ((saa_readb(0x581) & 0x1f) << 11);
+			t->rxsubchans = (saa_readb(0x529) & 0x08) ?
+					V4L2_TUNER_SUB_STEREO : V4L2_TUNER_SUB_MONO;
+		}
 		return 0;
 	}
 	case VIDIOC_S_TUNER:

