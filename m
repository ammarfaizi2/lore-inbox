Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSB0Byd>; Tue, 26 Feb 2002 20:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSB0ByY>; Tue, 26 Feb 2002 20:54:24 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:5870 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S291401AbSB0ByL>; Tue, 26 Feb 2002 20:54:11 -0500
Message-ID: <3C7C3B17.9050905@drugphish.ch>
Date: Wed, 27 Feb 2002 02:49:11 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@suse.cz>
Subject: Re: Linux 2.5.5-dj2
In-Reply-To: <20020226223406.A26905@suse.de>
Content-Type: multipart/mixed;
 boundary="------------030709000604060308060503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709000604060308060503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> Right up to date with Marcelo & Linus, and clear inbound patch queue.
> Despite the growing size, resync with Linus is still in progress,
> and some of the bigger bits have now either shown up in pre1, or
> are queued to go his way real soon.
This should be the last time I bother you today. I have some fixes for 
your 2.5.5-dj2 tree. Please consider applying.

compile-2.5.5-dj2.diff:
   o include missing <linux/interrupt.h>
   o spelling corrections
   o fix compile warnings
   o NOTE: rtc_timer.c has lots of useless #ifdef's, why can't we not
     just get rid of those? I talk about the USE_TASKLET. Or does the
     ALSA group plan to use something else then tasklets?

compile_warn_alsa.diff:
   o fix compile warnings

compile_warn_irda.diff:
   o fix compile warnings

compile_warn_vm.diff
   o fix compile warnings

There are still tons of compile warnings. If you're interested I can 
email them to you or put them in the web somewhere. Just in case you're 
getting bored ;)

Best regards,
Roberto Nibali, ratz

--------------030709000604060308060503
Content-Type: text/plain;
 name="compile-2.5.5-dj2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile-2.5.5-dj2.diff"

diff -ur linux-2.5.5-dj2-orig/sound/core/rtctimer.c linux-2.5.5/sound/core/rtctimer.c
--- linux-2.5.5-dj2-orig/sound/core/rtctimer.c	Wed Feb 27 00:34:38 2002
+++ linux-2.5.5/sound/core/rtctimer.c	Wed Feb 27 02:15:05 2002
@@ -31,6 +31,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/time.h>
+#include <linux/interrupt.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/info.h>
@@ -59,7 +60,7 @@
 
 
 /*
- * The harware depenant description for this timer.
+ * The hardware dependant description for this timer.
  */
 static struct _snd_timer_hardware rtc_hw = {
 	flags:		SNDRV_TIMER_HW_FIRST|SNDRV_TIMER_HW_AUTO,
@@ -210,9 +211,11 @@
 
 
 /*
- * exported stuffs
+ * exported stuff
  */
+#ifdef MODULE
 module_init(rtctimer_init)
+#endif
 module_exit(rtctimer_exit)
 
 MODULE_PARM(rtctimer_freq, "i");

--------------030709000604060308060503
Content-Type: text/plain;
 name="compile_warn_alsa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile_warn_alsa.diff"

diff -ur linux-2.5.5-dj2-orig/sound/core/pcm_lib.c linux-2.5.5/sound/core/pcm_lib.c
--- linux-2.5.5-dj2-orig/sound/core/pcm_lib.c	Wed Feb 27 00:34:38 2002
+++ linux-2.5.5/sound/core/pcm_lib.c	Wed Feb 27 01:24:17 2002
@@ -1130,11 +1130,12 @@
 			   snd_pcm_hw_params_t *params, 
 			   snd_pcm_hw_param_t var, int *dir)
 {
+	int err;
 	int changed = _snd_pcm_hw_param_first(params, var);
 	if (changed < 0)
 		return changed;
 	if (params->rmask) {
-		int err = snd_pcm_hw_refine(pcm, params);
+		err = snd_pcm_hw_refine(pcm, params);
 		assert(err >= 0);
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
@@ -1168,11 +1169,12 @@
 			  snd_pcm_hw_params_t *params,
 			  snd_pcm_hw_param_t var, int *dir)
 {
+	int err;
 	int changed = _snd_pcm_hw_param_last(params, var);
 	if (changed < 0)
 		return changed;
 	if (params->rmask) {
-		int err = snd_pcm_hw_refine(pcm, params);
+		err = snd_pcm_hw_refine(pcm, params);
 		assert(err >= 0);
 	}
 	return snd_pcm_hw_param_value(params, var, dir);

--------------030709000604060308060503
Content-Type: text/plain;
 name="compile_warn_irda.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile_warn_irda.diff"

diff -ur linux-2.5.5-dj2-orig/drivers/net/irda/ali-ircc.c linux-2.5.5/drivers/net/irda/ali-ircc.c
--- linux-2.5.5-dj2-orig/drivers/net/irda/ali-ircc.c	Wed Feb 27 00:34:35 2002
+++ linux-2.5.5/drivers/net/irda/ali-ircc.c	Wed Feb 27 02:20:51 2002
@@ -258,7 +258,6 @@
 	struct ali_ircc_cb *self;
 	struct pm_dev *pmdev;
 	int dongle_id;
-	int ret;
 	int err;
 			
 	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");	

--------------030709000604060308060503
Content-Type: text/plain;
 name="compile_warn_vm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile_warn_vm.diff"

diff -ur linux-2.5.5-dj2-orig/mm/vmscan.c linux-2.5.5/mm/vmscan.c
--- linux-2.5.5-dj2-orig/mm/vmscan.c	Wed Feb 27 00:34:38 2002
+++ linux-2.5.5/mm/vmscan.c	Wed Feb 27 01:18:36 2002
@@ -581,7 +581,6 @@
 static int FASTCALL(shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages));
 static int shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages)
 {
-	int chunk_size = nr_pages;
 	unsigned long ratio;
 
 	nr_pages -= kmem_cache_reap(gfp_mask);

--------------030709000604060308060503--

