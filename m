Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTLYTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLYTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 14:21:26 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:26382 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262126AbTLYTVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 14:21:22 -0500
To: Andrea Barisani <lcars@infis.univ.trieste.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
References: <20031222235622.GA17030@sole.infis.univ.trieste.it>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 26 Dec 2003 04:20:21 +0900
In-Reply-To: <20031222235622.GA17030@sole.infis.univ.trieste.it>
Message-ID: <87smj8bt6y.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - SOUND_GAMEPORT option is always turned on
> 
> ./drivers/input/gameport/Kconfig
> 
> 22: config SOUND_GAMEPORT
> 23:         tristate
> 24:         default y if GAMEPORT!=m
> 25:         default m if GAMEPORT=m
> 
> line 24 is definetly wrong, option is enabled if GAMEPORT=n.

This patch uses "select" for the dependency of GAMEPORT.

Thanks.

 drivers/input/gameport/Kconfig |    5 -----
 sound/oss/Kconfig              |   18 ++++++++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff -puN drivers/input/gameport/Kconfig~fix-config-gameport drivers/input/gameport/Kconfig
--- linux-2.6.0/drivers/input/gameport/Kconfig~fix-config-gameport	2003-12-26 04:10:12.000000000 +0900
+++ linux-2.6.0-hirofumi/drivers/input/gameport/Kconfig	2003-12-26 04:10:12.000000000 +0900
@@ -19,11 +19,6 @@ config GAMEPORT
 	  To compile this driver as a module, choose M here: the
 	  module will be called gameport.
 
-config SOUND_GAMEPORT
-	tristate
-	default y if GAMEPORT!=m
-	default m if GAMEPORT=m
-
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
 	depends on GAMEPORT
diff -puN sound/oss/Kconfig~fix-config-gameport sound/oss/Kconfig
--- linux-2.6.0/sound/oss/Kconfig~fix-config-gameport	2003-12-26 04:10:12.000000000 +0900
+++ linux-2.6.0-hirofumi/sound/oss/Kconfig	2003-12-26 04:10:12.000000000 +0900
@@ -173,7 +173,8 @@ config SOUND_CS4281
 
 config SOUND_ES1370
 	tristate "Ensoniq AudioPCI (ES1370)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND && PCI
+	select GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1370 chipset, such as Ensoniq's AudioPCI (non-97). To find
@@ -186,7 +187,8 @@ config SOUND_ES1370
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND && PCI
+	select GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -199,7 +201,8 @@ config SOUND_ES1371
 
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND
+	select GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the ESS Technology
 	  Solo1 chip. To find out if your sound card uses a
@@ -237,7 +240,8 @@ config SOUND_HARMONY
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND
+	select GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -269,7 +273,8 @@ config SOUND_VRC5477
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND
+	select GAMEPORT
 	---help---
 	  Say Y or M if you have a PCI sound card utilizing the Trident
 	  4DWave-DX/NX chipset or your mother board chipset has SiS 7018
@@ -782,7 +787,8 @@ config SOUND_NM256
 
 config SOUND_MAD16
 	tristate "OPTi MAD16 and/or Mozart based cards"
-	depends on SOUND_OSS && SOUND_GAMEPORT
+	depends on SOUND_OSS
+	select GAMEPORT
 	---help---
 	  Answer Y if your card has a Mozart (OAK OTI-601) or MAD16 (OPTi
 	  82C928 or 82C929 or 82C931) audio interface chip. These chips are

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
