Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVL0XlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVL0XlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVL0XlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:41:14 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:24717 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932395AbVL0XlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:41:14 -0500
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20051227215351.3d581b13.khali@linux-fr.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
Content-Type: multipart/mixed; boundary="=-h6rUrWRvR9OwSURPX2lO"
Date: Tue, 27 Dec 2005 21:40:54 -0200
Message-Id: <1135726855.6709.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h6rUrWRvR9OwSURPX2lO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Jean,

Em Ter, 2005-12-27 às 21:53 +0100, Jean Delvare escreveu:
> Hi all,
> 
> I gave a try to 2.6.15-rc7 and "make menuconfig" tells me:
> Warning! Found recursive dependency: VIDEO_SAA7134_ALSA VIDEO_SAA7134_OSS VIDEO_SAA7134_ALSA
> 
> This seems to be the consequence of this patch:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7bb9529602f8bb41a92275825b808a42ed33e5be
> 
> How do we fix that? menuconfig is indeed really confused by the current
> setup. I have the following patch which makes it happier:

	Please test this patch. It seems that provides the same behavior with a
non-recursive logic.

Cheers, 
Mauro.

--=-h6rUrWRvR9OwSURPX2lO
Content-Disposition: attachment; filename=v4l_dvb_saa7134_kconfig_fix.patch
Content-Type: text/x-patch; name=v4l_dvb_saa7134_kconfig_fix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


---

 drivers/media/video/saa7134/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/saa7134/Kconfig b/drivers/media/video/saa7134/Kconfig
index c0f604a..6127c80 100644
--- a/drivers/media/video/saa7134/Kconfig
+++ b/drivers/media/video/saa7134/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_SAA7134
 
 config VIDEO_SAA7134_ALSA
 	tristate "Philips SAA7134 DMA audio support"
-	depends on VIDEO_SAA7134 && SOUND && SND && (!VIDEO_SAA7134_OSS || VIDEO_SAA7134_OSS = m)
+	depends on VIDEO_SAA7134 && SOUND && SND
 	select SND_PCM_OSS
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
@@ -25,7 +25,7 @@ config VIDEO_SAA7134_ALSA
 
 config VIDEO_SAA7134_OSS
 	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
-	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || VIDEO_SAA7134_ALSA = m)
+	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || ( VIDEO_SAA7134_ALSA = m && m ) )
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using OSS

--=-h6rUrWRvR9OwSURPX2lO--

