Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVGIAve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVGIAve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVGIAvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:51:33 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:6114 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263058AbVGIAuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:50:04 -0400
Message-ID: <42CF1F3A.70909@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:50:02 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/14 2.6.13-rc2-mm1] V4L MXB fix to correct tuner ioctl
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090801060506030705070908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801060506030705070908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090801060506030705070908
Content-Type: text/x-patch;
 name="v4l_mxb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_mxb.diff"

- driver command adapted to use new control (TUNER_SET_TYPE_ADDR, 
  instead of TUNER_SET_TYPE)

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux-2.6.13-rc2-mm1/drivers/media/video/mxb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc2-mm1/drivers/media/video/mxb.c.orig	2005-07-07 23:05:25.000000000 -0300
+++ linux-2.6.13-rc2-mm1/drivers/media/video/mxb.c	2005-07-07 23:11:19.000000000 -0300
@@ -326,6 +326,7 @@ static int mxb_init_done(struct saa7146_
 	struct mxb* mxb = (struct mxb*)dev->ext_priv;
 	struct video_decoder_init init;
 	struct i2c_msg msg;
+	struct tuner_setup tun_setup;
 
 	int i = 0, err = 0;
 	struct	tea6415c_multiplex vm;	
@@ -349,8 +350,10 @@ static int mxb_init_done(struct saa7146_
 	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_VBI_BYPASS, &i);
 
 	/* select a tuner type */
-	i = 5; 
-	mxb->tuner->driver->command(mxb->tuner,TUNER_SET_TYPE, &i);
+	tun_setup.mode_mask = T_ANALOG_TV;
+	tun_setup.addr = ADDR_UNSET;
+	tun_setup.type = 5;
+	mxb->tuner->driver->command(mxb->tuner,TUNER_SET_TYPE_ADDR, &tun_setup);
 	
 	/* mute audio on tea6420s */
 	mxb->tea6420_1->driver->command(mxb->tea6420_1,TEA6420_SWITCH, &TEA6420_line[6][0]);

--------------090801060506030705070908--
