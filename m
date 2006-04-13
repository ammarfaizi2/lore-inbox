Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWDMBmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWDMBmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWDMBmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:42:32 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:8926 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932418AbWDMBmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:42:32 -0400
Message-ID: <443DACED.9010103@keyaccess.nl>
Date: Thu, 13 Apr 2006 03:44:13 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA STABLE 1/3] a few more -- fix the "enable" module parameter
 behaviour
Content-Type: multipart/mixed;
 boundary="------------000408030601060207040109"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408030601060207040109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

The !enable[i] patch is also applicable to sound/drivers. This gets them
all.

   sound/drivers/dummy.c         |    4 +++-
   sound/drivers/mpu401/mpu401.c |    4 +++-
   sound/drivers/serial-u16550.c |    4 +++-
   sound/drivers/virmidi.c       |    4 +++-
   4 files changed, 12 insertions(+), 4 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>



--------------000408030601060207040109
Content-Type: text/plain;
 name="alsa_platform_enable_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_enable_remainder.diff"

Index: local/sound/drivers/dummy.c
===================================================================
--- local.orig/sound/drivers/dummy.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/dummy.c	2006-04-13 03:02:43.000000000 +0200
@@ -669,8 +669,10 @@ static int __init alsa_card_dummy_init(v
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_DUMMY_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/drivers/mpu401/mpu401.c
===================================================================
--- local.orig/sound/drivers/mpu401/mpu401.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/mpu401/mpu401.c	2006-04-13 03:03:18.000000000 +0200
@@ -240,8 +240,10 @@ static int __init alsa_card_mpu401_init(
 		return err;
 
 	devices = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (pnp[i])
 			continue;
Index: local/sound/drivers/serial-u16550.c
===================================================================
--- local.orig/sound/drivers/serial-u16550.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/serial-u16550.c	2006-04-13 03:03:50.000000000 +0200
@@ -989,8 +989,10 @@ static int __init alsa_card_serial_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SERIAL_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/drivers/virmidi.c
===================================================================
--- local.orig/sound/drivers/virmidi.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/virmidi.c	2006-04-13 03:04:17.000000000 +0200
@@ -163,8 +163,10 @@ static int __init alsa_card_virmidi_init
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_VIRMIDI_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {


--------------000408030601060207040109--
