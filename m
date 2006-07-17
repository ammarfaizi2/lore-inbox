Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWGQQfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWGQQfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWGQQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:34:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:61884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750995AbWGQQdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:54 -0400
Date: Mon, 17 Jul 2006 09:29:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 42/45] ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port
Message-ID: <20060717162925.GQ4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-au88x0-fix-64bit-address-of-mpu401-mmio-port.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port

Fix 64bit address of MPU401 MMIO port on au88x0 chip.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/au88x0/au88x0_mpu401.c |    2 +-
 sound/pci/rme9652/hdsp.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/au88x0/au88x0_mpu401.c
+++ linux-2.6.17.6/sound/pci/au88x0/au88x0_mpu401.c
@@ -47,7 +47,7 @@ static int __devinit snd_vortex_midi(vor
 	struct snd_rawmidi *rmidi;
 	int temp, mode;
 	struct snd_mpu401 *mpu;
-	int port;
+	unsigned long port;
 
 #ifdef VORTEX_MPU401_LEGACY
 	/* EnableHardCodedMPU401Port() */
--- linux-2.6.17.6.orig/sound/pci/rme9652/hdsp.c
+++ linux-2.6.17.6/sound/pci/rme9652/hdsp.c
@@ -389,7 +389,7 @@ MODULE_SUPPORTED_DEVICE("{{RME Hammerfal
 
 /* use hotplug firmeare loader? */
 #if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-#ifndef HDSP_USE_HWDEP_LOADER
+#if !defined(HDSP_USE_HWDEP_LOADER) && !defined(CONFIG_SND_HDSP)
 #define HDSP_FW_LOADER
 #endif
 #endif

--
