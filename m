Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWFYTsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWFYTsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWFYTsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:48:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:21465 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964878AbWFYTsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:48:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EI7OUXJRe5+Y7Xo15lMuaruQC/fdK5sJ9da4ppXwu9MaK2vaRKgwa9lAELDr4o/wkW5gfpzUj9TpZP5zDJ4YgKLPVoVtFeqvUWRB9+15i7d7MfVErVBcvXsShhUZt6dbZV7p8EWZMofWKTSiixKVvsSGN+E/OqdlqO3OewJ5A0U=
Message-ID: <9e4733910606251248l2b80af8dp817aa7f39c393be8@mail.gmail.com>
Date: Sun, 25 Jun 2006 15:48:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060625182147.GA17945@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <20060625182147.GA17945@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n Kconfig all of the radio cards depend on VIDEO_V4L1. But V4L1 has
been deprecated and replaced with V4L2. V4L2 offers a V4L1
compatibility layer. Should the Kconfig for these devices be changed
to depend on (VIDEO_V4L1. || VIDEO_V4L1_COMPAT)? I'm not the
maintainer for this but they seem to build ok. New version that
combines the test for VIDEO_V4L1 || VIDEO_V4L1_COMPAT.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com

-- 
Jon Smirl
jonsmirl@gmail.com


diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index de3128a..26044a5 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -4,10 +4,15 @@ #

 menu "Radio Adapters"
 	depends on VIDEO_DEV!=n
-
+	
+# Use either the V4L1 layer or the V4L1 compatibility layer from V4L2
+config RADIO_V4L1
+	def_bool y
+	depends on VIDEO_V4L1 || VIDEO_V4L1_COMPAT
+	
 config RADIO_CADET
 	tristate "ADS Cadet AM/FM Tuner"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these AM/FM radio cards, and then
 	  fill in the port address below.
@@ -25,7 +30,7 @@ config RADIO_CADET

 config RADIO_RTRACK
 	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
@@ -59,7 +64,7 @@ config RADIO_RTRACK_PORT

 config RADIO_RTRACK2
 	tristate "AIMSlab RadioTrack II support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below.
@@ -82,7 +87,7 @@ config RADIO_RTRACK2_PORT

 config RADIO_AZTECH
 	tristate "Aztech/Packard Bell Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
@@ -106,7 +111,7 @@ config RADIO_AZTECH_PORT

 config RADIO_GEMTEK
 	tristate "GemTek Radio Card support"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below.
@@ -131,7 +136,7 @@ config RADIO_GEMTEK_PORT

 config RADIO_GEMTEK_PCI
 	tristate "GemTek PCI Radio Card support"
-	depends on VIDEO_V4L1 && PCI
+	depends on RADIO_V4L1 && PCI
 	---help---
 	  Choose Y here if you have this PCI FM radio card.

@@ -145,7 +150,7 @@ config RADIO_GEMTEK_PCI

 config RADIO_MAXIRADIO
 	tristate "Guillemot MAXI Radio FM 2000 radio"
-	depends on VIDEO_V4L1 && PCI
+	depends on RADIO_V4L1 && PCI
 	---help---
 	  Choose Y here if you have this radio card.  This card may also be
 	  found as Gemtek PCI FM.
@@ -160,7 +165,7 @@ config RADIO_MAXIRADIO

 config RADIO_MAESTRO
 	tristate "Maestro on board radio"
-	depends on VIDEO_V4L1
+	depends on RADIO_V4L1
 	---help---
 	  Say Y here to directly support the on-board radio tuner on the
 	  Maestro 2 or 2E sound card.
@@ -175,7 +180,7 @@ config RADIO_MAESTRO

 config RADIO_MIROPCM20
 	tristate "miroSOUND PCM20 radio"
-	depends on ISA && VIDEO_V4L1 && SOUND_ACI_MIXER
+	depends on ISA && RADIO_V4L1 && SOUND_ACI_MIXER
 	---help---
 	  Choose Y here if you have this FM radio card. You also need to say Y
 	  to "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20 radio)" (in "Sound")
@@ -208,7 +213,7 @@ config RADIO_MIROPCM20_RDS

 config RADIO_SF16FMI
 	tristate "SF16FMI Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards.  If you
 	  compile the driver into the kernel and your card is not PnP one, you
@@ -225,7 +230,7 @@ config RADIO_SF16FMI

 config RADIO_SF16FMR2
 	tristate "SF16FMR2 Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards.

@@ -239,7 +244,7 @@ config RADIO_SF16FMR2

 config RADIO_TERRATEC
 	tristate "TerraTec ActiveRadio ISA Standalone"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have this FM radio card, and then fill in the
 	  port address below. (TODO)
@@ -268,7 +273,7 @@ config RADIO_TERRATEC_PORT

 config RADIO_TRUST
 	tristate "Trust FM radio card"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	help
 	  This is a driver for the Trust FM radio cards. Say Y if you have
 	  such a card and want to use it under Linux.
@@ -286,7 +291,7 @@ config RADIO_TRUST_PORT

 config RADIO_TYPHOON
 	tristate "Typhoon Radio (a.k.a. EcoRadio)"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address and the frequency used for muting below.
@@ -330,7 +335,7 @@ config RADIO_TYPHOON_MUTEFREQ

 config RADIO_ZOLTRIX
 	tristate "Zoltrix Radio"
-	depends on ISA && VIDEO_V4L1
+	depends on ISA && RADIO_V4L1
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
