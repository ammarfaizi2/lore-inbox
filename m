Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264001AbTJOSmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTJOSmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:42:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:63665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263938AbTJOS0b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10662422904150@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test7
In-Reply-To: <1066242289283@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:24:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.3, 2003/10/13 11:07:23-07:00, greg@kroah.com

PCI: fix up probe functions for OSS drivers
  
Can not be marked __init, must be marked __devinit or not at all.
If it is marked __init, then oops can happen by a user writing to the
"new_id" file from sysfs.


 sound/oss/ali5455.c         |    8 ++++----
 sound/oss/i810_audio.c      |    6 +++---
 sound/oss/maestro3.c        |    4 ++--
 sound/oss/trident.c         |    4 ++--
 sound/oss/via82cxxx_audio.c |   10 +++++-----
 5 files changed, 16 insertions(+), 16 deletions(-)


diff -Nru a/sound/oss/ali5455.c b/sound/oss/ali5455.c
--- a/sound/oss/ali5455.c	Wed Oct 15 11:18:41 2003
+++ b/sound/oss/ali5455.c	Wed Oct 15 11:18:41 2003
@@ -3228,7 +3228,7 @@
 
 /* AC97 codec initialisation. */
 
-static int __init ali_ac97_init(struct ali_card *card)
+static int __devinit ali_ac97_init(struct ali_card *card)
 {
 	int num_ac97 = 0;
 	int total_channels = 0;
@@ -3333,7 +3333,7 @@
 	return num_ac97;
 }
 
-static void __init ali_configure_clocking(void)
+static void __devinit ali_configure_clocking(void)
 {
 	struct ali_card *card;
 	struct ali_state *state;
@@ -3403,8 +3403,8 @@
 /* install the driver, we do not allocate hardware channel nor DMA buffer now, they are defered 
    until "ACCESS" time (in prog_dmabuf called by open/read/write/ioctl/mmap) */
 
-static int __init ali_probe(struct pci_dev *pci_dev, const struct pci_device_id
-			    *pci_id)
+static int __devinit ali_probe(struct pci_dev *pci_dev,
+			       const struct pci_device_id *pci_id)
 {
 	struct ali_card *card;
 	if (pci_enable_device(pci_dev))
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Wed Oct 15 11:18:41 2003
+++ b/sound/oss/i810_audio.c	Wed Oct 15 11:18:41 2003
@@ -2807,7 +2807,7 @@
 	return 1;
 }
 
-static int __init i810_ac97_init(struct i810_card *card)
+static int __devinit i810_ac97_init(struct i810_card *card)
 {
 	int num_ac97 = 0;
 	int ac97_id;
@@ -3011,7 +3011,7 @@
 	return num_ac97;
 }
 
-static void __init i810_configure_clocking (void)
+static void __devinit i810_configure_clocking (void)
 {
 	struct i810_card *card;
 	struct i810_state *state;
@@ -3083,7 +3083,7 @@
 /* install the driver, we do not allocate hardware channel nor DMA buffer now, they are defered 
    until "ACCESS" time (in prog_dmabuf called by open/read/write/ioctl/mmap) */
    
-static int __init i810_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
+static int __devinit i810_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
 	struct i810_card *card;
 
diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Wed Oct 15 11:18:41 2003
+++ b/sound/oss/maestro3.c	Wed Oct 15 11:18:41 2003
@@ -2297,7 +2297,7 @@
 #endif
 }
 
-static int __init m3_codec_install(struct m3_card *card)
+static int __devinit m3_codec_install(struct m3_card *card)
 {
     struct ac97_codec *codec;
 
@@ -2594,7 +2594,7 @@
 /*
  * great day!  this function is ugly as hell.
  */
-static int __init m3_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
+static int __devinit m3_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
     u32 n;
     int i;
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Wed Oct 15 11:18:41 2003
+++ b/sound/oss/trident.c	Wed Oct 15 11:18:41 2003
@@ -3957,7 +3957,7 @@
 }
 
 /* AC97 codec initialisation. */
-static int __init trident_ac97_init(struct trident_card *card)
+static int __devinit trident_ac97_init(struct trident_card *card)
 {
 	int num_ac97 = 0;
 	unsigned long ready_2nd = 0;
@@ -4120,7 +4120,7 @@
 
 /* install the driver, we do not allocate hardware channel nor DMA buffer now, they are defered 
    until "ACCESS" time (in prog_dmabuf called by open/read/write/ioctl/mmap) */
-static int __init trident_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
+static int __devinit trident_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
 	unsigned long iobase;
 	struct trident_card *card;
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	Wed Oct 15 11:18:41 2003
+++ b/sound/oss/via82cxxx_audio.c	Wed Oct 15 11:18:41 2003
@@ -1642,7 +1642,7 @@
 };
 
 
-static int __init via_ac97_reset (struct via_info *card)
+static int __devinit via_ac97_reset (struct via_info *card)
 {
 	struct pci_dev *pdev = card->pdev;
 	u8 tmp8;
@@ -1752,7 +1752,7 @@
 }
 
 
-static int __init via_ac97_init (struct via_info *card)
+static int __devinit via_ac97_init (struct via_info *card)
 {
 	int rc;
 	u16 tmp16;
@@ -2070,7 +2070,7 @@
 };
 
 
-static int __init via_dsp_init (struct via_info *card)
+static int __devinit via_dsp_init (struct via_info *card)
 {
 	u8 tmp8;
 
@@ -3394,7 +3394,7 @@
  *
  */
 
-static int __init via_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
+static int __devinit via_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 #ifdef CONFIG_MIDI_VIA82CXXX
 	u8 r42;
@@ -3772,7 +3772,7 @@
 }
 
 
-static int __init via_card_init_proc (struct via_info *card)
+static int __devinit via_card_init_proc (struct via_info *card)
 {
 	char s[32];
 	int rc;

