Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVKGDVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVKGDVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKGDQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:49 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:8535 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932428AbVKGDQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:43 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Torsten Seeboth <Torsten.Seeboth@t-online.de>
Subject: [Patch 17/20] V4L(919) Improves the audio handling for nicam on
	cx88 audio
Date: Mon, 07 Nov 2005 00:58:11 -0200
Message-Id: <1131333341.25215.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Seeboth <Torsten.Seeboth@t-online.de>

- Improves the audio handling for NICAM on cx88 audio.

Signed-off-by: Torsten Seeboth <Torsten.Seeboth@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/cx88/cx88-tvaudio.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- hg.orig/drivers/media/video/cx88/cx88-tvaudio.c
+++ hg/drivers/media/video/cx88/cx88-tvaudio.c
@@ -123,7 +123,9 @@ static void set_audio_start(struct cx88_
 	cx_write(AUD_VOL_CTL, (1 << 6));
 
 	// start programming
-	cx_write(AUD_CTL, 0x0000);
+	cx_write(MO_AUD_DMACNTRL, 0x0000);
+	msleep(100);
+	//cx_write(AUD_CTL, 0x0000);
 	cx_write(AUD_INIT, mode);
 	cx_write(AUD_INIT_LD, 0x0001);
 	cx_write(AUD_SOFT_RESET, 0x0001);
@@ -151,6 +153,7 @@ static void set_audio_finish(struct cx88
 
 	/* finish programming */
 	cx_write(AUD_SOFT_RESET, 0x0000);
+	cx_write(MO_AUD_DMACNTRL, 0x0003);
 
 	/* unmute */
 	volume = cx_sread(SHADOW_AUD_VOL_CTL);
@@ -341,6 +344,7 @@ static void set_audio_standard_NICAM(str
 		{ /* end of list */ },
 	};
 
+	set_audio_start(core,SEL_NICAM);
 	switch (core->tvaudio) {
 	case WW_L:
 		dprintk("%s SECAM-L NICAM (status: devel)\n", __FUNCTION__);
@@ -740,7 +744,7 @@ void cx88_set_tvaudio(struct cx88_core *
 
 		/* set nicam mode - otherwise
 		   AUD_NICAM_STATUS2 contains wrong values */
-		set_audio_standard_NICAM(core, EN_NICAM_FORCE_MONO1);
+		set_audio_standard_NICAM(core, EN_NICAM_AUTO_STEREO);
 		if (0 == cx88_detect_nicam(core)) {
 			/* fall back to fm / am mono */
 			set_audio_standard_A2(core, EN_A2_FORCE_MONO1);


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

