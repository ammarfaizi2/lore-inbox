Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbULaOhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbULaOhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbULaOhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:37:46 -0500
Received: from verein.lst.de ([213.95.11.210]:10700 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262085AbULaOgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:36:04 -0500
Date: Fri, 31 Dec 2004 15:36:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead OSS/AC97 code
Message-ID: <20041231143600.GA9210@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 1.5/sound/oss/ac97.c	2004-05-29 11:13:01 +02:00
+++ edited/sound/oss/ac97.c	2004-12-31 14:30:35 +01:00
@@ -133,7 +133,7 @@ ac97_reset (struct ac97_hwint *dev)
 
 /* Return the contents of register REG; use the cache if the value in it
    is valid.  Returns a negative error code on failure. */
-int
+static int
 ac97_get_register (struct ac97_hwint *dev, u8 reg) 
 {
     if (reg > 127 || (reg & 1))
@@ -226,7 +226,7 @@ ac97_scale_from_oss_val (int value, int 
     }
 }
 
-int
+static int
 ac97_set_mixer (struct ac97_hwint *dev, int oss_channel, u16 oss_value)
 {
     int scaled_value;
@@ -262,7 +262,7 @@ ac97_set_mixer (struct ac97_hwint *dev, 
     return result;
 }
 
-int
+static int
 ac97_get_mixer_scaled (struct ac97_hwint *dev, int oss_channel)
 {
     struct ac97_chn_desc *channel = ac97_find_chndesc (dev, oss_channel);
@@ -439,10 +439,7 @@ ac97_mixer_ioctl (struct ac97_hwint *dev
 
 EXPORT_SYMBOL(ac97_init);
 EXPORT_SYMBOL(ac97_set_values);
-EXPORT_SYMBOL(ac97_set_mixer);
-EXPORT_SYMBOL(ac97_get_register);
 EXPORT_SYMBOL(ac97_put_register);
-EXPORT_SYMBOL(ac97_get_mixer_scaled);
 EXPORT_SYMBOL(ac97_mixer_ioctl);
 EXPORT_SYMBOL(ac97_reset);
 MODULE_LICENSE("GPL");
===== sound/oss/ac97.h 1.4 vs edited =====
--- 1.4/sound/oss/ac97.h	2004-05-29 11:13:01 +02:00
+++ edited/sound/oss/ac97.h	2004-12-31 14:30:35 +01:00
@@ -184,25 +184,9 @@ extern int ac97_init (struct ac97_hwint 
 extern int ac97_set_values (struct ac97_hwint *dev,
 			    struct ac97_mixer_value_list *value_list);
 
-/* Sets one mixer channel OSS_CHANNEL to the scaled value OSS_VALUE.
-   Returns the resulting (rescaled) value, or a negative value
-   representing an error code.
-
-   Stereo channels have two values in OSS_VALUE (the left value is in the
-   lower 8 bits, the right value is in the upper 8 bits). */
-extern int ac97_set_mixer (struct ac97_hwint *dev, int oss_channel,
-			   u16 oss_value);
-
-/* Return the contents of the specified AC97 register REG; it uses the
-   last-written value if it is available.  */
-extern int ac97_get_register (struct ac97_hwint *dev, u8 reg);
-
 /* Writes the specified VALUE to the AC97 register REG in the mixer.
    Takes care of setting the last-written cache as well.  */
 extern int ac97_put_register (struct ac97_hwint *dev, u8 reg, u16 value);
-
-/* Returns the last OSS value written to the OSS_CHANNEL mixer channel.  */
-extern int ac97_get_mixer_scaled (struct ac97_hwint *dev, int oss_channel);
 
 /* Default ioctl. */
 extern int ac97_mixer_ioctl (struct ac97_hwint *dev, unsigned int cmd,
