Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUGXWmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUGXWmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGXWmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 18:42:53 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:46835 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S262905AbUGXWmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 18:42:51 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 25 Jul 2004 00:41:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: MatzeBraun@gmx.de, tiwai@suse.de, zab@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 PATCH] front buttons wouldn't mute ESS Maestro
Message-ID: <20040724224129.GC19273@bouh.is-a-geek.org>
Mail-Followup-To: MatzeBraun@gmx.de, tiwai@suse.de, zab@redhat.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i-nntp3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a small fix to enable muting ESS Maestro sound card thanks to
the up/down buttons: when has reached the driver's minimum (! this is
something like -dB value), just mute.
(It was working in OSS driver, but not in ALSA)

--- linux-2.6.7-orig/sound/pci/es1968.c	2004-07-25 00:06:20.000000000 +0200
+++ linux/sound/pci/es1968.c	2004-07-25 00:29:54.000000000 +0200
@@ -1990,6 +1990,8 @@
 			if ((val & 0xff00) < 0x1f00)
 				val += 0x0100;
 		}
+		if (val == 0x1f1f)
+			val |= 0x8000;
 		snd_ac97_write_cache(chip->ac97, AC97_MASTER, val);
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &chip->master_volume->id);


Regards,
Samuel
