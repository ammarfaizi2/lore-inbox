Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVL3NjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVL3NjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVL3NjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:39:09 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:51072 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751261AbVL3NjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:39:08 -0500
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
In-Reply-To: <20051230120607.47951ec6.khali@linux-fr.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	 <200512292100.27536.zippel@linux-m68k.org>
	 <20051229211350.4115b799.khali@linux-fr.org>
	 <200512292119.10139.zippel@linux-m68k.org>
	 <20051229220730.1c22b1a4.khali@linux-fr.org>
	 <1135936882.7465.18.camel@localhost>
	 <20051230120607.47951ec6.khali@linux-fr.org>
Content-Type: multipart/mixed; boundary="=-ozMdGSoST9ifVlrwUkym"
Date: Fri, 30 Dec 2005 11:39:01 -0200
Message-Id: <1135949941.25274.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ozMdGSoST9ifVlrwUkym
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Em Sex, 2005-12-30 às 12:06 +0100, Jean Delvare escreveu:
> Hi Mauro,

> Can you please rebase it on Linus' latest (2.6.15-rc7-git4)? So that I
> can give it a try...
	Updated.
> 
> Thanks,
Cheers, 
Mauro.

--=-ozMdGSoST9ifVlrwUkym
Content-Disposition: attachment; filename=v4l_dvb_tmp_saa7134_choice.patch
Content-Type: text/x-patch; name=v4l_dvb_tmp_saa7134_choice.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

V4L/DVB: change alsa/oss option to choice

From:  <>

Using tristate choice Kconfig option seems to produce a
better result.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
---

 drivers/media/video/saa7134/Kconfig |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/saa7134/Kconfig b/drivers/media/video/saa7134/Kconfig
index 8a5c3e7..70f03f5 100644
--- a/drivers/media/video/saa7134/Kconfig
+++ b/drivers/media/video/saa7134/Kconfig
@@ -12,9 +12,14 @@ config VIDEO_SAA7134
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa7134.
 
+choice
+	prompt "Philips SAA7134 DMA audio support"
+	depends on VIDEO_SAA7134 && SOUND
+	default m
+
 config VIDEO_SAA7134_ALSA
-	tristate "Philips SAA7134 DMA audio support"
-	depends on VIDEO_SAA7134 && SND
+	tristate "ALSA audio support"
+	depends on SND
 	select SND_PCM_OSS
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
@@ -24,8 +29,8 @@ config VIDEO_SAA7134_ALSA
 	  module will be called saa7134-alsa.
 
 config VIDEO_SAA7134_OSS
-	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
-	depends on VIDEO_SAA7134 && SOUND_PRIME && !VIDEO_SAA7134_ALSA
+	tristate "OSS audio support (DEPRECATED)"
+	depends on SOUND_PRIME
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using OSS
@@ -34,6 +39,7 @@ config VIDEO_SAA7134_OSS
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa7134-oss.
+endchoice
 
 config VIDEO_SAA7134_DVB
 	tristate "DVB/ATSC Support for saa7134 based TV cards"

--=-ozMdGSoST9ifVlrwUkym--

