Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbWCQU57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWCQU57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWCQU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:683 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932191AbWCQU5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Hunold <hunold@linuxtv.org>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 15/21] Restore tuning capabilities in v4l2 mxb driver
Date: Fri, 17 Mar 2006 17:54:37 -0300
Message-id: <20060317205437.PS07135600015@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Hunold <hunold@linuxtv.org>
Date: 1142446742 \-0300

The behaviour of the all-in-one Video4Linux tuner driver apparently
changed.  It now wants to know the tv standard, otherwise it refuses to
tune.
Restore tuning functionality in my driver for the "Multimedia eXtension
Board".  The all-in-one tuner driver apparently changed its behaviour.

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/mxb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/mxb.c b/drivers/media/video/mxb.c
index 8416cef..e2b36ce 100644
--- a/drivers/media/video/mxb.c
+++ b/drivers/media/video/mxb.c
@@ -327,6 +327,7 @@ static int mxb_init_done(struct saa7146_
 	struct video_decoder_init init;
 	struct i2c_msg msg;
 	struct tuner_setup tun_setup;
+	v4l2_std_id std = V4L2_STD_PAL_BG;
 
 	int i = 0, err = 0;
 	struct	tea6415c_multiplex vm;	
@@ -361,6 +362,9 @@ static int mxb_init_done(struct saa7146_
 	mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_FREQUENCY,
 					&mxb->cur_freq);
 
+	/* set a default video standard */
+	mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_STD, &std);
+
 	/* mute audio on tea6420s */
 	mxb->tea6420_1->driver->command(mxb->tea6420_1,TEA6420_SWITCH, &TEA6420_line[6][0]);
 	mxb->tea6420_2->driver->command(mxb->tea6420_2,TEA6420_SWITCH, &TEA6420_line[6][1]);

