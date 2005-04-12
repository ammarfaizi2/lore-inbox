Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVDLTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVDLTRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVDLTQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:16:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:41417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262203AbVDLKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:32 -0400
Message-Id: <200504121032.j3CAWPPB005585@shell0.pdx.osdl.net>
Subject: [patch 112/198] fix pm_message_t vs. u32 in alsa
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@suse.cz>

I thought I'm done with fixing u32 vs.  pm_message_t ...  unfortunately that
turned out not to be the case as Russel King pointed out.  This fixes last few
bits in alsa.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/core/init.c        |    4 ++--
 25-akpm/sound/pci/atiixp_modem.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN sound/core/init.c~fix-pm_message_t-vs-u32-in-alsa sound/core/init.c
--- 25/sound/core/init.c~fix-pm_message_t-vs-u32-in-alsa	2005-04-12 03:21:30.477503616 -0700
+++ 25-akpm/sound/core/init.c	2005-04-12 03:21:30.482502856 -0700
@@ -744,7 +744,7 @@ struct snd_generic_device {
 
 #define SND_GENERIC_NAME	"snd_generic_pm"
 
-static int snd_generic_suspend(struct device *dev, u32 state, u32 level);
+static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level);
 static int snd_generic_resume(struct device *dev, u32 level);
 
 static struct device_driver snd_generic_driver = {
@@ -800,7 +800,7 @@ static void snd_generic_device_unregiste
 }
 
 /* suspend/resume callbacks for snd_generic platform device */
-static int snd_generic_suspend(struct device *dev, u32 state, u32 level)
+static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	snd_card_t *card;
 
diff -puN sound/pci/atiixp_modem.c~fix-pm_message_t-vs-u32-in-alsa sound/pci/atiixp_modem.c
--- 25/sound/pci/atiixp_modem.c~fix-pm_message_t-vs-u32-in-alsa	2005-04-12 03:21:30.479503312 -0700
+++ 25-akpm/sound/pci/atiixp_modem.c	2005-04-12 03:21:30.483502704 -0700
@@ -1121,7 +1121,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1132,7 +1132,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
_
