Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVEHTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVEHTJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVEHTJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:09:42 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:54678 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262759AbVEHTJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:31 -0400
Message-Id: <20050508184345.584546000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:33 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-audio.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 04/37] av7110: audio out fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch analog output of the Crystal sound chip to left/stereo/right mode.
This will fix problems with some (most?) channels which do not encode 2-channel
audio correctly. (Oliver Endriss)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110_av.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 20:24:44.000000000 +0200
@@ -1230,14 +1230,20 @@ static int dvb_audio_ioctl(struct inode 
 		switch(av7110->audiostate.channel_select) {
 		case AUDIO_STEREO:
 			audcom(av7110, AUDIO_CMD_STEREO);
+			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+				i2c_writereg(av7110, 0x20, 0x02, 0x49);
 			break;
 
 		case AUDIO_MONO_LEFT:
 			audcom(av7110, AUDIO_CMD_MONO_L);
+			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+				i2c_writereg(av7110, 0x20, 0x02, 0x4a);
 			break;
 
 		case AUDIO_MONO_RIGHT:
 			audcom(av7110, AUDIO_CMD_MONO_R);
+			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+				i2c_writereg(av7110, 0x20, 0x02, 0x45);
 			break;
 
 		default:

--

