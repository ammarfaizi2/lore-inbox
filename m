Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDJXMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDJXMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDJXMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:12:42 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:37093 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932147AbWDJXMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:12:41 -0400
Message-ID: <443AE6C0.9030206@keyaccess.nl>
Date: Tue, 11 Apr 2006 01:14:08 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA STABLE 1/3] fix the "enable" module parameter behaviour
Content-Type: multipart/mixed;
 boundary="------------050206070105080200040106"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206070105080200040106
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This fixes the "enable" module parameter for -stable. Against 2.6.16.2.

Was submitted and acked before. Could you relay to -stable yourself?

   sound/isa/ad1848/ad1848.c       |    4 +++-
   sound/isa/cmi8330.c             |    4 ++--
   sound/isa/cs423x/cs4231.c       |    4 +++-
   sound/isa/cs423x/cs4236.c       |    4 ++--
   sound/isa/es1688/es1688.c       |    4 +++-
   sound/isa/es18xx.c              |    4 ++--
   sound/isa/gus/gusclassic.c      |    4 +++-
   sound/isa/gus/gusextreme.c      |    4 +++-
   sound/isa/gus/gusmax.c          |    4 +++-
   sound/isa/gus/interwave.c       |    4 +++-
   sound/isa/opl3sa2.c             |    4 +++-
   sound/isa/sb/sb16.c             |    4 ++--
   sound/isa/sb/sb8.c              |    4 +++-
   sound/isa/sgalaxy.c             |    4 +++-
   sound/isa/wavefront/wavefront.c |    4 +++-
   15 files changed, 41 insertions(+), 19 deletions(-)

Rene.



--------------050206070105080200040106
Content-Type: text/plain;
 name="alsa_platform_enable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_enable.diff"

Index: local/sound/isa/ad1848/ad1848.c
===================================================================
--- local.orig/sound/isa/ad1848/ad1848.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/ad1848/ad1848.c	2006-04-10 20:58:20.000000000 +0200
@@ -187,8 +187,10 @@ static int __init alsa_card_ad1848_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_AD1848_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/cmi8330.c
===================================================================
--- local.orig/sound/isa/cmi8330.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/cmi8330.c	2006-04-10 20:58:20.000000000 +0200
@@ -690,9 +690,9 @@ static int __init alsa_card_cmi8330_init
 	if ((err = platform_driver_register(&snd_cmi8330_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/cs423x/cs4231.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4231.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/cs423x/cs4231.c	2006-04-10 20:58:20.000000000 +0200
@@ -203,8 +203,10 @@ static int __init alsa_card_cs4231_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_CS4231_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/cs423x/cs4236.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4236.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/cs423x/cs4236.c	2006-04-10 20:58:20.000000000 +0200
@@ -771,9 +771,9 @@ static int __init alsa_card_cs423x_init(
 	if ((err = platform_driver_register(&cs423x_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CS423X_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/es1688/es1688.c
===================================================================
--- local.orig/sound/isa/es1688/es1688.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/es1688/es1688.c	2006-04-10 20:58:20.000000000 +0200
@@ -207,8 +207,10 @@ static int __init alsa_card_es1688_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(ES1688_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusclassic.c
===================================================================
--- local.orig/sound/isa/gus/gusclassic.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/gus/gusclassic.c	2006-04-10 20:58:20.000000000 +0200
@@ -247,8 +247,10 @@ static int __init alsa_card_gusclassic_i
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSCLASSIC_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusextreme.c
===================================================================
--- local.orig/sound/isa/gus/gusextreme.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/gus/gusextreme.c	2006-04-10 20:58:20.000000000 +0200
@@ -357,8 +357,10 @@ static int __init alsa_card_gusextreme_i
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSEXTREME_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusmax.c
===================================================================
--- local.orig/sound/isa/gus/gusmax.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/gus/gusmax.c	2006-04-10 20:58:20.000000000 +0200
@@ -384,8 +384,10 @@ static int __init alsa_card_gusmax_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSMAX_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/interwave.c
===================================================================
--- local.orig/sound/isa/gus/interwave.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/gus/interwave.c	2006-04-10 20:58:20.000000000 +0200
@@ -935,8 +935,10 @@ static int __init alsa_card_interwave_in
 	if ((err = platform_driver_register(&snd_interwave_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;
Index: local/sound/isa/opl3sa2.c
===================================================================
--- local.orig/sound/isa/opl3sa2.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/opl3sa2.c	2006-04-10 20:58:20.000000000 +0200
@@ -949,8 +949,10 @@ static int __init alsa_card_opl3sa2_init
 	if ((err = platform_driver_register(&snd_opl3sa2_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;
Index: local/sound/isa/sb/sb16.c
===================================================================
--- local.orig/sound/isa/sb/sb16.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/sb/sb16.c	2006-04-10 20:58:20.000000000 +0200
@@ -712,9 +712,9 @@ static int __init alsa_card_sb16_init(vo
 	if ((err = platform_driver_register(&snd_sb16_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(SND_SB16_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/sb/sb8.c
===================================================================
--- local.orig/sound/isa/sb/sb8.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/sb/sb8.c	2006-04-10 20:58:20.000000000 +0200
@@ -258,8 +258,10 @@ static int __init alsa_card_sb8_init(voi
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SB8_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/sgalaxy.c
===================================================================
--- local.orig/sound/isa/sgalaxy.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/sgalaxy.c	2006-04-10 20:58:20.000000000 +0200
@@ -360,8 +360,10 @@ static int __init alsa_card_sgalaxy_init
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SGALAXY_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/wavefront/wavefront.c
===================================================================
--- local.orig/sound/isa/wavefront/wavefront.c	2006-04-10 20:31:27.000000000 +0200
+++ local/sound/isa/wavefront/wavefront.c	2006-04-10 20:58:20.000000000 +0200
@@ -710,8 +710,10 @@ static int __init alsa_card_wavefront_in
 	if ((err = platform_driver_register(&snd_wavefront_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;
Index: local/sound/isa/es18xx.c
===================================================================
--- local.orig/sound/isa/es18xx.c	2006-04-10 20:58:20.000000000 +0200
+++ local/sound/isa/es18xx.c	2006-04-10 21:14:52.000000000 +0200
@@ -2225,9 +2225,9 @@ static int __init alsa_card_es18xx_init(
 	if ((err = platform_driver_register(&snd_es18xx_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(ES18XX_DRIVER,
 							 i, NULL, 0);


--------------050206070105080200040106--
