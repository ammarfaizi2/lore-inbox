Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVGKAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVGKAHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVGJThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53980 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262036AbVGJTg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:26 -0400
Date: Sun, 10 Jul 2005 19:36:25 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz
Subject: [PATCH 77/82] remove linux/version.h from sound/
Message-ID: <20050710193625.77.bwVcqK4317.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code for obsolete kernel versions

Signed-off-by: Olaf Hering <olh@suse.de>

include/sound/tea575x-tuner.h |    2 --
sound/mips/au1x00.c           |   19 -------------------
sound/oss/au1550_ac97.c       |    1 -
sound/oss/msnd.c              |    1 -
sound/oss/os.h                |    1 -
sound/oss/rme96xx.c           |    1 -
sound/oss/sh_dac_audio.c      |    1 -
sound/ppc/pmac.h              |    1 -
8 files changed, 27 deletions(-)

Index: linux-2.6.13-rc2-mm1/include/sound/tea575x-tuner.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/sound/tea575x-tuner.h
+++ linux-2.6.13-rc2-mm1/include/sound/tea575x-tuner.h
@@ -34,9 +34,7 @@ struct snd_tea575x_ops {
struct snd_tea575x {
snd_card_t *card;
struct video_device vd;		/* video device */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
struct file_operations fops;
-#endif
int dev_nr;			/* requested device number + 1 */
int vd_registered;		/* video device is registered */
int tea5759;			/* 5759 chip is present */
Index: linux-2.6.13-rc2-mm1/sound/mips/au1x00.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/mips/au1x00.c
+++ linux-2.6.13-rc2-mm1/sound/mips/au1x00.c
@@ -39,7 +39,6 @@
#include <sound/driver.h>
#include <linux/init.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <sound/core.h>
#include <sound/initval.h>
#include <sound/pcm.h>
@@ -50,12 +49,7 @@
MODULE_AUTHOR("Charles Eidsness <charles@cooper-street.com>");
MODULE_DESCRIPTION("Au1000 AC'97 ALSA Driver");
MODULE_LICENSE("GPL");
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
MODULE_SUPPORTED_DEVICE("{{AMD,Au1000 AC'97}}");
-#else
-MODULE_CLASSES("{sound}");
-MODULE_DEVICES("{{AMD,Au1000 AC'97}}");
-#endif

#define chip_t au1000_t

@@ -535,17 +529,12 @@ snd_au1000_ac97_new(void)
{
int err;

-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
ac97_bus_t *pbus;
ac97_template_t ac97;
static ac97_bus_ops_t ops = {
.write = snd_au1000_ac97_write,
.read = snd_au1000_ac97_read,
};
-#else
-	ac97_bus_t bus, *pbus;
-	ac97_t ac97;
-#endif

if ((au1000->ac97_res_port = request_region(AC97C_CONFIG,
sizeof(au1000_ac97_reg_t), "Au1x00 AC97")) == NULL) {
@@ -577,16 +566,8 @@ snd_au1000_ac97_new(void)
spin_unlock(&au1000->ac97_lock);

/* Initialise AC97 middle-layer */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
if ((err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)
return err;
-#else
-	memset(&bus, 0, sizeof(bus));
-	bus.write = snd_au1000_ac97_write;
-	bus.read = snd_au1000_ac97_read;
-	if ((err = snd_ac97_bus(au1000->card, &bus, &pbus)) < 0)
-		return err;
-#endif
memset(&ac97, 0, sizeof(ac97));
ac97.private_data = au1000;
ac97.private_free = snd_au1000_ac97_free;
Index: linux-2.6.13-rc2-mm1/sound/oss/au1550_ac97.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/oss/au1550_ac97.c
+++ linux-2.6.13-rc2-mm1/sound/oss/au1550_ac97.c
@@ -35,7 +35,6 @@

#undef DEBUG

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/ioport.h>
Index: linux-2.6.13-rc2-mm1/sound/oss/msnd.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/oss/msnd.c
+++ linux-2.6.13-rc2-mm1/sound/oss/msnd.c
@@ -24,7 +24,6 @@
*
********************************************************************/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/sound/oss/os.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/oss/os.h
+++ linux-2.6.13-rc2-mm1/sound/oss/os.h
@@ -5,7 +5,6 @@
#undef  DO_TIMINGS

#include <linux/module.h>
-#include <linux/version.h>

#ifdef __KERNEL__
#include <linux/utsname.h>
Index: linux-2.6.13-rc2-mm1/sound/oss/rme96xx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/oss/rme96xx.c
+++ linux-2.6.13-rc2-mm1/sound/oss/rme96xx.c
@@ -44,7 +44,6 @@ TODO:
#define RMEVERSION "0.8"
#endif

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/sched.h>
Index: linux-2.6.13-rc2-mm1/sound/oss/sh_dac_audio.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/oss/sh_dac_audio.c
+++ linux-2.6.13-rc2-mm1/sound/oss/sh_dac_audio.c
@@ -2,7 +2,6 @@
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
-#include <linux/version.h>
#include <linux/linkage.h>
#include <linux/slab.h>
#include <linux/fs.h>
Index: linux-2.6.13-rc2-mm1/sound/ppc/pmac.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/sound/ppc/pmac.h
+++ linux-2.6.13-rc2-mm1/sound/ppc/pmac.h
@@ -22,7 +22,6 @@
#ifndef __PMAC_H
#define __PMAC_H

-#include <linux/version.h>
#include <sound/control.h>
#include <sound/pcm.h>
#include "awacs.h"
