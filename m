Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967298AbWKZFkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967298AbWKZFkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 00:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935244AbWKZFkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 00:40:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935243AbWKZFkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 00:40:52 -0500
Date: Sun, 26 Nov 2006 06:40:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, linux@wolfsonmicro.com, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [-mm patch] sound/soc/soc-dapm.c: make 4 functions static
Message-ID: <20061126054056.GK15364@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-alsa.patch
>...
>  git trees
>...


This patch makes the following needlessly global functions static:
- dapm_power_widgets()
- dapm_mux_update_power()
- dapm_mixer_update_power()
- dapm_free_widgets()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/soc/soc-dapm.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.19-rc6-mm1/sound/soc/soc-dapm.c.old	2006-11-26 05:40:58.000000000 +0100
+++ linux-2.6.19-rc6-mm1/sound/soc/soc-dapm.c	2006-11-26 05:42:25.000000000 +0100
@@ -463,7 +463,7 @@
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-int dapm_power_widgets(struct snd_soc_codec *codec, int event)
+static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 {
 	struct snd_soc_dapm_widget *w;
 	int in, out, i, c = 1, *seq = NULL, ret = 0, power_change, power;
@@ -664,8 +664,9 @@
 #endif
 
 /* test and update the power status of a mux widget */
-int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
-	struct snd_kcontrol *kcontrol, int mask, int val, struct soc_enum* e)
+static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int mask,
+				 int val, struct soc_enum* e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -697,11 +698,11 @@
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dapm_mux_update_power);
 
 /* test and update the power status of a mixer widget */
-int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
-	struct snd_kcontrol *kcontrol, int reg, int val_mask, int val, int invert)
+static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+				   struct snd_kcontrol *kcontrol, int reg,
+				   int val_mask, int val, int invert)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
@@ -733,7 +734,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dapm_mixer_update_power);
 
 /* show dapm widget status in sys fs */
 static ssize_t dapm_widget_show(struct device *dev,
@@ -808,7 +808,7 @@
 }
 
 /* free all dapm widgets and resources */
-void dapm_free_widgets(struct snd_soc_codec *codec)
+static void dapm_free_widgets(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_widget *w, *next_w;
 	struct snd_soc_dapm_path *p, *next_p;

