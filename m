Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVBOAmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVBOAmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBOAmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:42:51 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:45280 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261404AbVBOAmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:42:12 -0500
Date: Tue, 15 Feb 2005 01:41:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in OSS
Message-ID: <20050215004151.GC5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes (part of) u32 vs. pm_message_t confusion in OSS. I found no
maintainer for OSS in MAINTAINERS, that's why it goes to you... It
should cause no code changes. Please apply,

                                                                Pavel


--- clean-mm/sound/oss/ali5455.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/ali5455.c	2005-02-15 01:04:11.000000000 +0100
@@ -3528,7 +3528,7 @@
 }
 
 #ifdef CONFIG_PM
-static int ali_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int ali_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
 	struct ali_card *card = pci_get_drvdata(dev);
 	struct ali_state *state;
--- clean-mm/sound/oss/cs4281/cs4281_wrapper-24.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/cs4281/cs4281_wrapper-24.c	2005-02-15 01:04:11.000000000 +0100
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 
 static int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
-static int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
+static int cs4281_suspend_null(struct pci_dev *pcidev, pm_message_t state) { return 0; }
 
 #define free_dmabuf(state, dmabuf) \
 	pci_free_consistent(state->pcidev, \
--- clean-mm/sound/oss/cs46xx.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/cs46xx.c	2005-02-15 01:04:11.000000000 +0100
@@ -388,7 +388,7 @@
 static int cs46xx_powerup(struct cs_card *card, unsigned int type);
 static int cs461x_powerdown(struct cs_card *card, unsigned int type, int suspendflag);
 static void cs461x_clear_serial_FIFOs(struct cs_card *card, int type);
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 
 #ifndef CS46XX_ACPI_SUPPORT
@@ -5774,7 +5774,7 @@
 #endif
 
 #if CS46XX_ACPI_SUPPORT
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state)
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state)
 {
 	struct cs_card *s = PCI_GET_DRIVER_DATA(pcidev);
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 2, 
--- clean-mm/sound/oss/cs46xxpm-24.h	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/cs46xxpm-24.h	2005-02-15 01:04:11.000000000 +0100
@@ -36,7 +36,7 @@
 * for now (12/22/00) only enable the pm_register PM support.
 * allow these table entries to be null.
 */
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 #define cs_pm_register(a, b, c)  NULL
 #define cs_pm_unregister_all(a) 
--- clean-mm/sound/oss/esssolo1.c	2004-12-25 13:35:04.000000000 +0100
+++ linux-mm/sound/oss/esssolo1.c	2005-02-15 01:04:11.000000000 +0100
@@ -2257,7 +2257,7 @@
 }
 
 static int
-solo1_suspend(struct pci_dev *pci_dev, u32 state) {
+solo1_suspend(struct pci_dev *pci_dev, pm_message_t state) {
 	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
 	if (!s)
 		return 1;
--- clean-mm/sound/oss/i810_audio.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/i810_audio.c	2005-02-15 01:04:11.000000000 +0100
@@ -3470,7 +3470,7 @@
 }
 
 #ifdef CONFIG_PM
-static int i810_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int i810_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
         struct i810_card *card = pci_get_drvdata(dev);
         struct i810_state *state;
--- clean-mm/sound/oss/maestro3.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/maestro3.c	2005-02-15 01:04:11.000000000 +0100
@@ -375,7 +375,7 @@
  * I'm not very good at laying out functions in a file :)
  */
 static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
-static int m3_suspend(struct pci_dev *pci_dev, u32 state);
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state);
 static void check_suspend(struct m3_card *card);
 
 static struct notifier_block m3_reboot_nb = {
@@ -2777,12 +2777,12 @@
 
     for(card = devs; card != NULL; card = card->next) {
         if(!card->in_suspend)
-            m3_suspend(card->pcidev, 3); /* XXX legal? */
+            m3_suspend(card->pcidev, PMSG_SUSPEND); /* XXX legal? */
     }
     return 0;
 }
 
-static int m3_suspend(struct pci_dev *pci_dev, u32 state)
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
     unsigned long flags;
     int i;
--- clean-mm/sound/oss/trident.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/trident.c	2005-02-15 01:04:11.000000000 +0100
@@ -487,7 +487,7 @@
 static struct trident_channel *ali_alloc_pcm_channel(struct trident_card *card);
 static void ali_restore_regs(struct trident_card *card);
 static void ali_save_regs(struct trident_card *card);
-static int trident_suspend(struct pci_dev *dev, u32 unused);
+static int trident_suspend(struct pci_dev *dev, pm_message_t unused);
 static int trident_resume(struct pci_dev *dev);
 static void ali_free_pcm_channel(struct trident_card *card, unsigned int channel);
 static int ali_setup_multi_channels(struct trident_card *card, int chan_nums);
@@ -3723,7 +3723,7 @@
 }
 
 static int
-trident_suspend(struct pci_dev *dev, u32 unused)
+trident_suspend(struct pci_dev *dev, pm_message_t unused)
 {
 	struct trident_card *card = pci_get_drvdata(dev);
 
--- clean-mm/sound/oss/ymfpci.c	2005-02-15 00:34:42.000000000 +0100
+++ linux-mm/sound/oss/ymfpci.c	2005-02-15 01:04:11.000000000 +0100
@@ -2074,7 +2074,7 @@
 /*
  */
 
-static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
+static int ymf_suspend(struct pci_dev *pcidev, pm_message_t unused)
 {
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
