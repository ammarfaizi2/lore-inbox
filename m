Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTL0HwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 02:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTL0HwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 02:52:18 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:25527 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265338AbTL0Hv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 02:51:29 -0500
Date: Fri, 26 Dec 2003 23:50:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: perex@suse.cz, alsa-devel@lists.sourceforge.net
cc: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
Subject: OSS sound emulation broken between 2.6.0-test2 and test3
Message-ID: <8240000.1072511437@[10.10.2.4]>
In-Reply-To: <1072500516.12203.2.camel@duergar>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1812539384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1812539384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Something appears to have broken OSS sound emulation between 
test2 and test3. Best I can tell (despite the appearance of the BK logs), 
that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
understands the sound architecture better than I can fix this?

If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
I'll get some wierd effect for a few seconds, either static, or the track
will mysteriously speed up or slow down. Then all is back to normal for
another couple of minutes.

I cut the core-looking ALSA changes out of test3, and attatch them here.
Backing out this patch from test3 makes the problem go away, and sound
emulation works normally again. But now I'm stuck - I can't split it
further than this. Changelogs for 0.9.5 and 0.9.6 include:

	  - PCM OSS interface
	    - implemented POST ioctl
	    - fixed read() semantics according original OSS API

	  - OSS PCM emulation
	    - fixed write() behaviour
	    - added two new options no-silence & whole-frag
	    - a try to fix OOPSes caused in the rate plugin

I'll test patches if anyone can come up with anything.

Thanks,

M.

--==========1812539384==========
Content-Type: text/plain; charset=us-ascii; name=alsa
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa; size=49323

Return-Path: <mbligh@w-mbligh>
X-Sieve: cmu-sieve 2.0
Return-path: <bk-commits-head-owner@vger.kernel.org>
Envelope-to: mbligh@localhost
Delivery-date: Thu, 31 Jul 2003 23:25:47 -0700
Received: from w-mbligh.beaverton.ibm.com
	([127.0.0.1] helo=mail.aracnet.com ident=mbligh)
	by w-mbligh.beaverton.ibm.com with esmtp (Exim 3.35 #1 (Debian))
	id 19iTMH-0006Y5-00
	for <mbligh@localhost>; Thu, 31 Jul 2003 23:25:45 -0700
Received: from psmtp.com (exprod5mx38.postini.com [12.158.34.195])
	by obsidian.spiritone.com (8.12.9/8.12.8) with SMTP id h716Plgu017805
	for <mbligh@aracnet.com>; Thu, 31 Jul 2003 23:25:47 -0700
Delivered-To: <mbligh@aracnet.com>
Received: from source ([67.72.78.212]) by exprod5mx38.postini.com ([12.158.34.245]) with SMTP;
	Thu, 31 Jul 2003 23:24:50 PDT
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274837AbTHAGYB (ORCPT <rfc822;mbligh@aracnet.com>);
	Fri, 1 Aug 2003 02:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275118AbTHAGYB
	(ORCPT <rfc822;bk-commits-head-outgoing>);
	Fri, 1 Aug 2003 02:24:01 -0400
Received: from hera.kernel.org ([63.209.29.2]:3986 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S274837AbTHAGQl (ORCPT
	<rfc822;bk-commits-head@vger.kernel.org>);
	Fri, 1 Aug 2003 02:16:41 -0400
Received: from hera.kernel.org (dwmw2@localhost [127.0.0.1])
	by hera.kernel.org (8.12.8/8.12.8) with ESMTP id h716GeUk003941
	for <bk-commits-head@vger.kernel.org>; Thu, 31 Jul 2003 23:16:40 -0700
Received: (from dwmw2@localhost)
	by hera.kernel.org (8.12.8/8.12.8/Submit) id h716GasI003916
	for bk-commits-head@vger.kernel.org; Thu, 31 Jul 2003 23:16:36 -0700
Message-Id: <200308010616.h716GasI003916@hera.kernel.org>
Subject: ALSA 0.9.6 update
Date: 	Mon, 28 Jul 2003 11:35:31 +0000
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: bk-commits-head@vger.kernel.org
X-BK-Repository: hera.kernel.org:/home/dwmw2/BK/linus-2.5
X-BK-ChangeSetKey: perex@suse.cz|ChangeSet|20030728113531|60648
Sender: bk-commits-head-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	bk-commits-head@vger.kernel.org

ChangeSet 1.1595.3.2, 2003/07/28 13:35:31+02:00, perex@suse.cz

	ALSA 0.9.6 update
	  - added __setup() to all midlevel modules
	  - sequencer protocol 1.0.1
	    - added timestamping flags for ports
	  - OSS PCM emulation
	    - fixed write() behaviour
	    - added two new options no-silence & whole-frag
	    - a try to fix OOPSes caused in the rate plugin
	  - emu10k1 driver
	    - more support for Audigy/Audigy2 EX
	    - fixed soundfont locking
	  - sb16 driver
	    - fixed fm_res handling (and proc OOPS)
	  - via82xx driver
	    - fixed revision check for 8233A
	  - usbaudio driver
	    - added a workaround for M-Audio Audiophile USB


# This patch includes the following deltas:
#	           ChangeSet	1.1595.3.1 -> 1.1595.3.2
#	sound/pci/emu10k1/emu10k1.c	1.11    -> 1.12   
#	Documentation/sound/alsa/ALSA-Configuration.txt	1.10    -> 1.11   
#	sound/core/seq/seq_clientmgr.c	1.18    -> 1.19   
#	sound/core/rawmidi.c	1.26    -> 1.27   
#	include/sound/emu10k1.h	1.16    -> 1.17   
#	sound/core/oss/pcm_plugin.c	1.5     -> 1.6    
#	sound/core/oss/plugin_ops.h	1.1     -> 1.2    
#	sound/core/pcm_native.c	1.36    -> 1.37   
#	include/sound/version.h	1.61    -> 1.62   
#	sound/core/pcm_lib.c	1.22    -> 1.23   
#	sound/core/oss/rate.c	1.3     -> 1.4    
#	sound/pci/emu10k1/emufx.c	1.23    -> 1.24   
#	include/sound/asequencer.h	1.5     -> 1.6    
#	sound/pci/maestro3.c	1.23    -> 1.24   
#	sound/pci/intel8x0.c	1.36    -> 1.37   
#	  sound/core/timer.c	1.19    -> 1.20   
#	include/sound/asound.h	1.15    -> 1.16   
#	  sound/core/sound.c	1.30    -> 1.31   
#	sound/core/pcm_memory.c	1.10    -> 1.11   
#	sound/core/seq/seq_ports.h	1.2     -> 1.3    
#	sound/core/seq/seq_ports.c	1.10    -> 1.11   
#	include/sound/pcm_oss.h	1.2     -> 1.3    
#	sound/pci/emu10k1/irq.c	1.7     -> 1.8    
#	sound/usb/usbaudio.c	1.40    -> 1.41   
#	sound/synth/emux/soundfont.c	1.4     -> 1.5    
#	sound/core/oss/pcm_plugin.h	1.2     -> 1.3    
#	 sound/isa/sb/sb16.c	1.18    -> 1.19   
#	sound/core/rtctimer.c	1.14    -> 1.15   
#	 sound/pci/via82xx.c	1.33    -> 1.34   
#	sound/pci/emu10k1/emumixer.c	1.8     -> 1.9    
#	sound/core/oss/pcm_oss.c	1.25    -> 1.26   
#	sound/drivers/dummy.c	1.17    -> 1.18   
#	sound/pci/ac97/ac97_patch.c	1.15    -> 1.16   
#	sound/core/oss/route.c	1.3     -> 1.4    
#	sound/pci/emu10k1/emu10k1_main.c	1.13    -> 1.14   
#	sound/core/memalloc.c	1.9     -> 1.10   
#	include/sound/soundfont.h	1.2     -> 1.3    
#

 Documentation/sound/alsa/ALSA-Configuration.txt |    3 
 include/sound/asequencer.h                      |    7 +-
 include/sound/asound.h                          |    3 
 include/sound/emu10k1.h                         |    1 
 include/sound/pcm_oss.h                         |    4 -
 include/sound/soundfont.h                       |    1 
 include/sound/version.h                         |    4 -
 sound/core/memalloc.c                           |   19 +++++
 sound/core/oss/pcm_oss.c                        |   52 +++++++++++++--
 sound/core/oss/pcm_plugin.c                     |   23 +++++-
 sound/core/oss/pcm_plugin.h                     |    1 
 sound/core/oss/plugin_ops.h                     |    2 
 sound/core/oss/rate.c                           |   22 +-----
 sound/core/oss/route.c                          |    4 +
 sound/core/pcm_lib.c                            |    9 --
 sound/core/pcm_memory.c                         |   16 ++++
 sound/core/pcm_native.c                         |   12 ++-
 sound/core/rawmidi.c                            |   20 +++++
 sound/core/rtctimer.c                           |   14 +++-
 sound/core/seq/seq_clientmgr.c                  |   56 +++++++++-------
 sound/core/seq/seq_ports.c                      |   14 ++++
 sound/core/seq/seq_ports.h                      |    3 
 sound/core/sound.c                              |   18 +++++
 sound/core/timer.c                              |   14 +++-
 sound/drivers/dummy.c                           |   26 +++++--
 sound/isa/sb/sb16.c                             |   16 ++++
 sound/pci/ac97/ac97_patch.c                     |   22 ++++++
 sound/pci/emu10k1/emu10k1.c                     |    8 --
 sound/pci/emu10k1/emu10k1_main.c                |    8 ++
 sound/pci/emu10k1/emufx.c                       |   23 ++++--
 sound/pci/emu10k1/emumixer.c                    |   82 ++++++++++++++++++++----
 sound/pci/emu10k1/irq.c                         |   45 ++++++-------
 sound/pci/intel8x0.c                            |    3 
 sound/pci/maestro3.c                            |    7 +-
 sound/pci/via82xx.c                             |    6 -
 sound/synth/emux/soundfont.c                    |   18 +----
 sound/usb/usbaudio.c                            |    8 ++
 37 files changed, 456 insertions(+), 138 deletions(-)


diff -Nru a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
--- a/Documentation/sound/alsa/ALSA-Configuration.txt	Thu Jul 31 23:16:39 2003
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt	Thu Jul 31 23:16:39 2003
@@ -1303,6 +1303,9 @@
 	  - direct    don't use plugins
 	  - block     force block mode (rvplayer)
 	  - non-block force non-block mode
+	  - whole-frag  write only whole fragments (optimization affecting
+			playback only)
+	  - no-silence  do not fill silence ahead to avoid clicks
 
   Example: echo "x11amp 128 16384" > /proc/asound/card0/pcm0p/oss
            echo "squake 0 0 disable" > /proc/asound/card0/pcm0c/oss
diff -Nru a/include/sound/asequencer.h b/include/sound/asequencer.h
--- a/include/sound/asequencer.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/asequencer.h	Thu Jul 31 23:16:39 2003
@@ -29,7 +29,7 @@
 #include <sound/asound.h>
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 0)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
 
 /**
  * definition of sequencer event types
@@ -604,6 +604,8 @@
 
 /* misc. conditioning flags */
 #define SNDRV_SEQ_PORT_FLG_GIVEN_PORT	(1<<0)
+#define SNDRV_SEQ_PORT_FLG_TIMESTAMP	(1<<1)
+#define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<1)
 
 struct sndrv_seq_port_info {
 	struct sndrv_seq_addr addr;	/* client/port numbers */
@@ -620,7 +622,8 @@
 
 	void *kernel;			/* reserved for kernel use (must be NULL) */
 	unsigned int flags;		/* misc. conditioning */
-	char reserved[60];		/* for future use */
+	unsigned char time_queue;	/* queue # for timestamping */
+	char reserved[59];		/* for future use */
 };
 
 
diff -Nru a/include/sound/asound.h b/include/sound/asound.h
--- a/include/sound/asound.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/asound.h	Thu Jul 31 23:16:39 2003
@@ -105,9 +105,10 @@
 	SNDRV_HWDEP_IFACE_ICS2115,	/* Wavetable synth */
 	SNDRV_HWDEP_IFACE_SSCAPE,	/* Ensoniq SoundScape ISA card (MC68EC000) */
 	SNDRV_HWDEP_IFACE_VX,		/* Digigram VX cards */
+	SNDRV_HWDEP_IFACE_MIXART,	/* Digigram miXart cards */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_VX,
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_MIXART,
 };
 
 struct sndrv_hwdep_info {
diff -Nru a/include/sound/emu10k1.h b/include/sound/emu10k1.h
--- a/include/sound/emu10k1.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/emu10k1.h	Thu Jul 31 23:16:39 2003
@@ -931,6 +931,7 @@
 	unsigned long port;			/* I/O port number */
 	struct resource *res_port;
 	int APS: 1,				/* APS flag */
+	    no_ac97: 1,				/* no AC'97 */
 	    tos_link: 1;			/* tos link detected */
 	unsigned int audigy;			/* is Audigy? */
 	unsigned int revision;			/* chip revision */
diff -Nru a/include/sound/pcm_oss.h b/include/sound/pcm_oss.h
--- a/include/sound/pcm_oss.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/pcm_oss.h	Thu Jul 31 23:16:39 2003
@@ -30,7 +30,9 @@
 	unsigned int disable:1,
 		     direct:1,
 		     block:1,
-		     nonblock:1;
+		     nonblock:1,
+		     wholefrag:1,
+		     nosilence:1;
 	unsigned int periods;
 	unsigned int period_size;
 	snd_pcm_oss_setup_t *next;
diff -Nru a/include/sound/soundfont.h b/include/sound/soundfont.h
--- a/include/sound/soundfont.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/soundfont.h	Thu Jul 31 23:16:39 2003
@@ -95,7 +95,6 @@
 	int zone_locked;	/* locked time for zone */
 	int sample_locked;	/* locked time for sample */
 	snd_sf_callback_t callback;	/* callback functions */
-	char sf_locked;		/* font lock flag */
 	struct semaphore presets_mutex;
 	spinlock_t lock;
 	snd_util_memhdr_t *memhdr;
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Thu Jul 31 23:16:39 2003
+++ b/include/sound/version.h	Thu Jul 31 23:16:39 2003
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated by configure.  */
-#define CONFIG_SND_VERSION "0.9.5"
-#define CONFIG_SND_DATE " (Mon Jul 21 08:59:59 2003 UTC)"
+#define CONFIG_SND_VERSION "0.9.6"
+#define CONFIG_SND_DATE " (Mon Jul 28 11:08:42 2003 UTC)"
diff -Nru a/sound/core/memalloc.c b/sound/core/memalloc.c
--- a/sound/core/memalloc.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/memalloc.c	Thu Jul 31 23:16:39 2003
@@ -946,6 +946,25 @@
 module_exit(snd_mem_exit)
 
 
+#ifndef MODULE
+
+/* format is: snd-page-alloc=enable */
+
+static int __init snd_mem_setup(char *str)
+{
+	static unsigned __initdata nr_dev = 0;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+	(void)(get_option(&str,&enable[nr_dev]) == 2);
+	nr_dev++;
+	return 1;
+}
+
+__setup("snd-page-alloc=", snd_mem_setup);
+
+#endif
+
 /*
  * exports
  */
diff -Nru a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/pcm_oss.c	Thu Jul 31 23:16:39 2003
@@ -454,8 +454,18 @@
 	sw_params->sleep_min = 0;
 	sw_params->avail_min = runtime->period_size;
 	sw_params->xfer_align = 1;
-	sw_params->silence_threshold = 0;
-	sw_params->silence_size = 0;
+	if (atomic_read(&runtime->mmap_count) ||
+	    (substream->oss.setup && substream->oss.setup->nosilence)) {
+		sw_params->silence_threshold = 0;
+		sw_params->silence_size = 0;
+	} else {
+		snd_pcm_uframes_t frames;
+		frames = runtime->period_size + 16;
+		if (frames > runtime->buffer_size)
+			frames = runtime->buffer_size;
+		sw_params->silence_threshold = frames;
+		sw_params->silence_size = frames;
+	}
 
 	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_SW_PARAMS, sw_params)) < 0) {
 		snd_printd("SW_PARAMS failed: %i\n", err);
@@ -581,7 +591,7 @@
 		if (err < 0)
 			break;
 		runtime = substream->runtime;
-		if (*delay <= runtime->buffer_size)
+		if (*delay <= (snd_pcm_sframes_t)runtime->buffer_size)
 			break;
 		/* in case of overrun, skip whole periods like OSS/Linux driver does */
 		/* until avail(delay) <= buffer_size */
@@ -802,8 +812,9 @@
 			buf += tmp;
 			bytes -= tmp;
 			xfer += tmp;
-			if (runtime->oss.buffer_used == runtime->oss.period_bytes) {
-				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
+			if (substream->oss.setup == NULL || !substream->oss.setup->wholefrag ||
+			    runtime->oss.buffer_used == runtime->oss.period_bytes) {
+				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.buffer_used, 1);
 				if (tmp <= 0)
 					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 				runtime->oss.bytes += tmp;
@@ -2108,14 +2119,16 @@
 	snd_pcm_oss_setup_t *setup = pstr->oss.setup_list;
 	down(&pstr->oss.setup_mutex);
 	while (setup) {
-		snd_iprintf(buffer, "%s %u %u%s%s%s%s\n",
+		snd_iprintf(buffer, "%s %u %u%s%s%s%s%s%s\n",
 			    setup->task_name,
 			    setup->periods,
 			    setup->period_size,
 			    setup->disable ? " disable" : "",
 			    setup->direct ? " direct" : "",
 			    setup->block ? " block" : "",
-			    setup->nonblock ? " non-block" : "");
+			    setup->nonblock ? " non-block" : "",
+			    setup->wholefrag ? " whole-frag" : "",
+			    setup->nosilence ? " no-silence" : "");
 		setup = setup->next;
 	}
 	up(&pstr->oss.setup_mutex);
@@ -2181,6 +2194,10 @@
 				template.block = 1;
 			} else if (!strcmp(str, "non-block")) {
 				template.nonblock = 1;
+			} else if (!strcmp(str, "whole-frag")) {
+				template.wholefrag = 1;
+			} else if (!strcmp(str, "no-silence")) {
+				template.nosilence = 1;
 			}
 		} while (*str);
 		if (setup == NULL) {
@@ -2372,3 +2389,24 @@
 
 module_init(alsa_pcm_oss_init)
 module_exit(alsa_pcm_oss_exit)
+
+#ifndef MODULE
+
+/* format is: snd-pcm-oss=dsp_map,adsp_map[,nonblock_open] */
+
+static int __init alsa_pcm_oss_setup(char *str)
+{
+	static unsigned __initdata nr_dev = 0;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+	(void)(get_option(&str,&dsp_map[nr_dev]) == 2 &&
+	       get_option(&str,&adsp_map[nr_dev]) == 2);
+	(void)(get_option(&str,&nonblock_open) == 2);
+	nr_dev++;
+	return 1;
+}
+
+__setup("snd-pcm-oss=", alsa_pcm_oss_setup);
+
+#endif /* !MODULE */
diff -Nru a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
--- a/sound/core/oss/pcm_plugin.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/pcm_plugin.c	Thu Jul 31 23:16:39 2003
@@ -56,6 +56,17 @@
 	return 0;
 }
 
+/*
+ *  because some cards might have rates "very close", we ignore
+ *  all "resampling" requests within +-5%
+ */
+static int rate_match(unsigned int src_rate, unsigned int dst_rate)
+{
+	unsigned int low = (src_rate * 95) / 100;
+	unsigned int high = (src_rate * 105) / 100;
+	return dst_rate >= low && dst_rate <= high;
+}
+
 static int snd_pcm_plugin_alloc(snd_pcm_plugin_t *plugin, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_format_t *format;
@@ -80,11 +91,14 @@
 		plugin->buf = vmalloc(size);
 		plugin->buf_frames = frames;
 	}
-	if (!plugin->buf)
+	if (!plugin->buf) {
+		plugin->buf_frames = 0;
 		return -ENOMEM;
+	}
 	c = plugin->buf_channels;
 	if (plugin->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED) {
 		for (channel = 0; channel < format->channels; channel++, c++) {
+			c->frames = frames;
 			c->enabled = 1;
 			c->wanted = 0;
 			c->area.addr = plugin->buf;
@@ -95,6 +109,7 @@
 		snd_assert((size % format->channels) == 0,);
 		size /= format->channels;
 		for (channel = 0; channel < format->channels; channel++, c++) {
+			c->frames = frames;
 			c->enabled = 1;
 			c->wanted = 0;
 			c->area.addr = plugin->buf + (channel * size);
@@ -420,7 +435,7 @@
 
 	/* Format change (linearization) */
 	if ((srcformat.format != dstformat.format ||
-	     srcformat.rate != dstformat.rate ||
+	     !rate_match(srcformat.rate, dstformat.rate) ||
 	     srcformat.channels != dstformat.channels) &&
 	    !snd_pcm_format_linear(srcformat.format)) {
 		if (snd_pcm_format_linear(dstformat.format))
@@ -468,7 +483,7 @@
 				ttable[v * sv + v] = FULL;
 		}
 		tmpformat.channels = dstformat.channels;
-		if (srcformat.rate == dstformat.rate &&
+		if (rate_match(srcformat.rate, dstformat.rate) &&
 		    snd_pcm_format_linear(dstformat.format))
 			tmpformat.format = dstformat.format;
 		err = snd_pcm_plugin_build_route(plug,
@@ -490,7 +505,7 @@
 	}
 
 	/* rate resampling */
-	if (srcformat.rate != dstformat.rate) {
+	if (!rate_match(srcformat.rate, dstformat.rate)) {
 		tmpformat.rate = dstformat.rate;
 		if (srcformat.channels == dstformat.channels &&
 		    snd_pcm_format_linear(dstformat.format))
diff -Nru a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
--- a/sound/core/oss/pcm_plugin.h	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/pcm_plugin.h	Thu Jul 31 23:16:39 2003
@@ -106,6 +106,7 @@
 typedef struct _snd_pcm_plugin_channel {
 	void *aptr;			/* pointer to the allocated area */
 	snd_pcm_channel_area_t area;
+	snd_pcm_uframes_t frames;	/* allocated frames */
 	unsigned int enabled:1;		/* channel need to be processed */
 	unsigned int wanted:1;		/* channel is wanted */
 } snd_pcm_plugin_channel_t;
diff -Nru a/sound/core/oss/plugin_ops.h b/sound/core/oss/plugin_ops.h
--- a/sound/core/oss/plugin_ops.h	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/plugin_ops.h	Thu Jul 31 23:16:39 2003
@@ -323,7 +323,7 @@
 
 #ifdef PUT_S16_LABELS
 /* dst_wid dst_endswap unsigned */
-static void *put_s16_labels[4 * 2 * 2 * 4 * 2] = {
+static void *put_s16_labels[4 * 2 * 2] = {
 	&&put_s16_xx12_xxx1,	 /* 16h ->  8h */
 	&&put_s16_xx12_xxx9,	 /* 16h ^>  8h */
 	&&put_s16_xx12_xxx1,	 /* 16h ->  8s */
diff -Nru a/sound/core/oss/rate.c b/sound/core/oss/rate.c
--- a/sound/core/oss/rate.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/rate.c	Thu Jul 31 23:16:39 2003
@@ -85,11 +85,7 @@
 #undef PUT_S16_LABELS
 	void *get = get_s16_labels[data->get];
 	void *put = put_s16_labels[data->put];
-	void *get_s16_end = 0;
 	signed short sample = 0;
-#define GET_S16_END *get_s16_end
-#include "plugin_ops.h"
-#undef GET_S16_END
 	
 	for (channel = 0; channel < plugin->src_format.channels; channel++) {
 		pos = data->pos;
@@ -108,24 +104,16 @@
 		dst_step = dst_channels[channel].area.step / 8;
 		src_frames1 = src_frames;
 		dst_frames1 = dst_frames;
-		if (pos & ~R_MASK) {
-			get_s16_end = &&after_get1;
-			goto *get;
-		after_get1:
-			pos &= R_MASK;
-			S1 = S2;
-			S2 = sample;
-			src += src_step;
-			src_frames1--;
-		}
 		while (dst_frames1-- > 0) {
 			if (pos & ~R_MASK) {
 				pos &= R_MASK;
 				S1 = S2;
 				if (src_frames1-- > 0) {
-					get_s16_end = &&after_get2;
 					goto *get;
-				after_get2:
+#define GET_S16_END after_get
+#include "plugin_ops.h"
+#undef GET_S16_END
+				after_get:
 					S2 = sample;
 					src += src_step;
 				}
@@ -318,6 +306,8 @@
 #endif
 
 	dst_frames = rate_dst_frames(plugin, frames);
+	if (dst_frames > dst_channels[0].frames)
+		dst_frames = dst_channels[0].frames;
 	data = (rate_t *)plugin->extra_data;
 	data->func(plugin, src_channels, dst_channels, frames, dst_frames);
 	return dst_frames;
diff -Nru a/sound/core/oss/route.c b/sound/core/oss/route.c
--- a/sound/core/oss/route.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/oss/route.c	Thu Jul 31 23:16:39 2003
@@ -518,6 +518,10 @@
 	int sign, width, endian;
 	sign = !snd_pcm_format_signed(format);
 	width = snd_pcm_format_width(format) / 8 - 1;
+	if (width < 0 || width > 3) {
+		snd_printk(KERN_ERR "snd-pcm-oss: invalid format %d\n", format);
+		width = 0;
+	}
 #ifdef SNDRV_LITTLE_ENDIAN
 	endian = snd_pcm_format_big_endian(format);
 #else
diff -Nru a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/pcm_lib.c	Thu Jul 31 23:16:39 2003
@@ -60,13 +60,11 @@
 			return;
 		snd_assert(runtime->silence_filled <= runtime->buffer_size, return);
 		noise_dist = snd_pcm_playback_hw_avail(runtime) + runtime->silence_filled;
-		if (noise_dist > (snd_pcm_sframes_t) runtime->silence_threshold)
+		if (noise_dist >= (snd_pcm_sframes_t) runtime->silence_threshold)
 			return;
 		frames = runtime->silence_threshold - noise_dist;
 		if (frames > runtime->silence_size)
 			frames = runtime->silence_size;
-		else
-			frames = runtime->silence_threshold;
 	} else {
 		if (new_hw_ptr == ULONG_MAX) {	/* initialization */
 			runtime->silence_filled = 0;
@@ -86,10 +84,9 @@
 			if ((snd_pcm_sframes_t)runtime->silence_start < 0)
 				runtime->silence_start += runtime->boundary;
 		}
-		frames = runtime->buffer_size;
+		frames = runtime->buffer_size - runtime->silence_filled;
 	}
-	snd_assert(frames >= runtime->silence_filled, return);
-	frames -= runtime->silence_filled;
+	snd_assert(frames <= runtime->buffer_size, return);
 	if (frames == 0)
 		return;
 	ofs = (runtime->silence_start + runtime->silence_filled) % runtime->buffer_size;
diff -Nru a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
--- a/sound/core/pcm_memory.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/pcm_memory.c	Thu Jul 31 23:16:39 2003
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -568,3 +569,18 @@
 }
 
 #endif /* CONFIG_PCI */
+
+#ifndef MODULE
+
+/* format is: snd-pcm=preallocate_dma,maximum_substreams */
+
+static int __init alsa_pcm_setup(char *str)
+{
+	(void)(get_option(&str,&preallocate_dma) == 2 &&
+	       get_option(&str,&maximum_substreams) == 2);
+	return 1;
+}
+
+__setup("snd-pcm=", alsa_pcm_setup);
+
+#endif /* ifndef MODULE */
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/pcm_native.c	Thu Jul 31 23:16:39 2003
@@ -461,9 +461,15 @@
 	if (params->xfer_align == 0 ||
 	    params->xfer_align % runtime->min_align != 0)
 		return -EINVAL;
-	if ((params->silence_threshold != 0 || params->silence_size < runtime->boundary) &&
-	    (params->silence_threshold + params->silence_size > runtime->buffer_size))
-		return -EINVAL;
+	if (params->silence_size >= runtime->boundary) {
+		if (params->silence_threshold != 0)
+			return -EINVAL;
+	} else {
+		if (params->silence_size > params->silence_threshold)
+			return -EINVAL;
+		if (params->silence_threshold > runtime->buffer_size)
+			return -EINVAL;
+	}
 	snd_pcm_stream_lock_irq(substream);
 	runtime->tstamp_mode = params->tstamp_mode;
 	runtime->sleep_min = params->sleep_min;
diff -Nru a/sound/core/rawmidi.c b/sound/core/rawmidi.c
--- a/sound/core/rawmidi.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/rawmidi.c	Thu Jul 31 23:16:39 2003
@@ -1630,6 +1630,26 @@
 module_init(alsa_rawmidi_init)
 module_exit(alsa_rawmidi_exit)
 
+#ifndef MODULE
+#ifdef CONFIG_SND_OSSEMUL
+/* format is: snd-rawmidi=midi_map,amidi_map */
+
+static int __init alsa_rawmidi_setup(char *str)
+{
+	static unsigned __initdata nr_dev = 0;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+	(void)(get_option(&str,&midi_map[nr_dev]) == 2 &&
+	       get_option(&str,&amidi_map[nr_dev]) == 2);
+	nr_dev++;
+	return 1;
+}
+
+__setup("snd-rawmidi=", alsa_rawmidi_setup);
+#endif /* CONFIG_SND_OSSEMUL */
+#endif /* ifndef MODULE */
+
 EXPORT_SYMBOL(snd_rawmidi_output_params);
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 EXPORT_SYMBOL(snd_rawmidi_drop_output);
diff -Nru a/sound/core/rtctimer.c b/sound/core/rtctimer.c
--- a/sound/core/rtctimer.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/rtctimer.c	Thu Jul 31 23:16:39 2003
@@ -57,7 +57,7 @@
 	.stop =		rtctimer_stop,
 };
 
-int rtctimer_freq = RTC_FREQ;		/* frequency */
+static int rtctimer_freq = RTC_FREQ;		/* frequency */
 static snd_timer_t *rtctimer;
 static atomic_t rtc_inc = ATOMIC_INIT(0);
 static rtc_task_t rtc_task;
@@ -181,5 +181,17 @@
 MODULE_PARM_DESC(rtctimer_freq, "timer frequency in Hz");
 
 MODULE_LICENSE("GPL");
+
+#ifndef MODULE
+/* format is: snd-rtctimer=freq */
+
+static int __init rtctimer_setup(char *str)
+{
+	(void)(get_option(&str,&rtctimer_freq) == 2);
+	return 1;
+}
+
+__setup("snd-rtctimer=", rtctimer_setup);
+#endif /* ifndef MODULE */
 
 #endif /* CONFIG_RTC || CONFIG_RTC_MODULE */
diff -Nru a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
--- a/sound/core/seq/seq_clientmgr.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/seq/seq_clientmgr.c	Thu Jul 31 23:16:39 2003
@@ -521,6 +521,32 @@
 
 
 /*
+ * rewrite the time-stamp of the event record with the curren time
+ * of the given queue.
+ * return non-zero if updated.
+ */
+static int update_timestamp_of_queue(snd_seq_event_t *event, int queue, int real_time)
+{
+	queue_t *q;
+
+	q = queueptr(queue);
+	if (! q)
+		return 0;
+	event->queue = queue;
+	event->flags &= ~SNDRV_SEQ_TIME_STAMP_MASK;
+	if (real_time) {
+		event->time.time = snd_seq_timer_get_cur_time(q->timer);
+		event->flags |= SNDRV_SEQ_TIME_STAMP_REAL;
+	} else {
+		event->time.tick = snd_seq_timer_get_cur_tick(q->timer);
+		event->flags |= SNDRV_SEQ_TIME_STAMP_TICK;
+	}
+	queuefree(q);
+	return 1;
+}
+
+
+/*
  * deliver an event to the specified destination.
  * if filter is non-zero, client filter bitmap is tested.
  *
@@ -551,6 +577,10 @@
 		goto __skip;
 	}
 		
+	if (dest_port->timestamping)
+		update_timestamp_of_queue(event, dest_port->time_queue,
+					  dest_port->time_real);
+
 	/* expand the quoted event */
 	if (event->type == SNDRV_SEQ_EVENT_KERNEL_QUOTE) {
 		quoted = 1;
@@ -597,27 +627,6 @@
 }
 
 
-static void snd_seq_subs_update_event_header(subscribers_t *subs, snd_seq_event_t *event)
-{
-	if (subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIMESTAMP) {
-		/* convert time according to flag with subscription */
-		queue_t *q;
-		q = queueptr(subs->info.queue);
-		if (q) {
-			event->queue = subs->info.queue;
-			event->flags &= ~SNDRV_SEQ_TIME_STAMP_MASK;
-			if (subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIME_REAL) {
-				event->time.time = snd_seq_timer_get_cur_time(q->timer);
-				event->flags |= SNDRV_SEQ_TIME_STAMP_REAL;
-			} else {
-				event->time.tick = snd_seq_timer_get_cur_tick(q->timer);
-				event->flags |= SNDRV_SEQ_TIME_STAMP_TICK;
-			}
-			queuefree(q);
-		}
-	}
-}
-
 /*
  * send the event to all subscribers:
  */
@@ -647,7 +656,10 @@
 	list_for_each(p, &grp->list_head) {
 		subs = list_entry(p, subscribers_t, src_list);
 		event->dest = subs->info.dest;
-		snd_seq_subs_update_event_header(subs, event);
+		if (subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIMESTAMP)
+			/* convert time according to flag with subscription */
+			update_timestamp_of_queue(event, subs->info.queue,
+						  subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIME_REAL);
 		err = snd_seq_deliver_single_event(client, event,
 						   0, atomic, hop);
 		if (err < 0)
diff -Nru a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
--- a/sound/core/seq/seq_ports.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/seq/seq_ports.c	Thu Jul 31 23:16:39 2003
@@ -352,6 +352,11 @@
 	port->midi_voices = info->midi_voices;
 	port->synth_voices = info->synth_voices;
 
+	/* timestamping */
+	port->timestamping = (info->flags & SNDRV_SEQ_PORT_FLG_TIMESTAMP) ? 1 : 0;
+	port->time_real = (info->flags & SNDRV_SEQ_PORT_FLG_TIME_REAL) ? 1 : 0;
+	port->time_queue = info->time_queue;
+
 	return 0;
 }
 
@@ -378,6 +383,15 @@
 	info->read_use = port->c_src.count;
 	info->write_use = port->c_dest.count;
 	
+	/* timestamping */
+	info->flags = 0;
+	if (port->timestamping) {
+		info->flags |= SNDRV_SEQ_PORT_FLG_TIMESTAMP;
+		if (port->time_real)
+			info->flags |= SNDRV_SEQ_PORT_FLG_TIME_REAL;
+		info->time_queue = port->time_queue;
+	}
+
 	return 0;
 }
 
diff -Nru a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
--- a/sound/core/seq/seq_ports.h	Thu Jul 31 23:16:39 2003
+++ b/sound/core/seq/seq_ports.h	Thu Jul 31 23:16:39 2003
@@ -74,6 +74,9 @@
 	void *private_data;
 	unsigned int callback_all : 1;
 	unsigned int closing : 1;
+	unsigned int timestamping: 1;
+	unsigned int time_real: 1;
+	int time_queue;
 	
 	/* capability, inport, output, sync */
 	unsigned int capability;	/* port capability bits */
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/sound.c	Thu Jul 31 23:16:39 2003
@@ -389,6 +389,24 @@
 module_init(alsa_sound_init)
 module_exit(alsa_sound_exit)
 
+#ifndef MODULE
+
+/* format is: snd=major,cards_limit[,device_mode] */
+
+static int __init alsa_sound_setup(char *str)
+{
+	(void)(get_option(&str,&major) == 2 &&
+	       get_option(&str,&cards_limit) == 2);
+#ifdef CONFIG_DEVFS_FS
+	(void)(get_option(&str,&device_mode) == 2);
+#endif
+	return 1;
+}
+
+__setup("snd=", alsa_sound_setup);
+
+#endif /* ifndef MODULE */
+
   /* sound.c */
 EXPORT_SYMBOL(snd_major);
 EXPORT_SYMBOL(snd_ecards_limit);
diff -Nru a/sound/core/timer.c b/sound/core/timer.c
--- a/sound/core/timer.c	Thu Jul 31 23:16:39 2003
+++ b/sound/core/timer.c	Thu Jul 31 23:16:39 2003
@@ -41,7 +41,7 @@
 #define DEFAULT_TIMER_LIMIT 2
 #endif
 
-int timer_limit = DEFAULT_TIMER_LIMIT;
+static int timer_limit = DEFAULT_TIMER_LIMIT;
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA timer interface");
 MODULE_LICENSE("GPL");
@@ -1805,6 +1805,18 @@
 
 module_init(alsa_timer_init)
 module_exit(alsa_timer_exit)
+
+#ifndef MODULE
+/* format is: snd-timer=timer_limit */
+
+static int __init alsa_timer_setup(char *str)
+{
+	(void)(get_option(&str,&timer_limit) == 2);
+	return 1;
+}
+
+__setup("snd-timer=", alsa_timer_setup);
+#endif /* ifndef MODULE */
 
 EXPORT_SYMBOL(snd_timer_open);
 EXPORT_SYMBOL(snd_timer_close);
diff -Nru a/sound/drivers/dummy.c b/sound/drivers/dummy.c
--- a/sound/drivers/dummy.c	Thu Jul 31 23:16:39 2003
+++ b/sound/drivers/dummy.c	Thu Jul 31 23:16:39 2003
@@ -69,6 +69,15 @@
 #define USE_PERIODS_MAX		255
 #endif
 
+#if 0 /* simple AC97 bridge (intel8x0) with 48kHz AC97 only codec */
+#define USE_FORMATS		SNDRV_PCM_FMTBIT_S16_LE
+#define USE_CHANNELS_MIN	2
+#define USE_CHANNELS_MAX	2
+#define USE_RATE		SNDRV_PCM_RATE_48000
+#define USE_RATE_MIN		48000
+#define USE_RATE_MAX		48000
+#endif
+
 
 /* defaults */
 #ifndef MAX_BUFFER_SIZE
@@ -77,6 +86,11 @@
 #ifndef USE_FORMATS
 #define USE_FORMATS 		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE)
 #endif
+#ifndef USE_RATE
+#define USE_RATE		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000
+#define USE_RATE_MIN		5500
+#define USE_RATE_MAX		48000
+#endif
 #ifndef USE_CHANNELS_MIN
 #define USE_CHANNELS_MIN 	1
 #endif
@@ -271,9 +285,9 @@
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		USE_FORMATS,
-	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	.rate_min =		5500,
-	.rate_max =		48000,
+	.rates =		USE_RATE,
+	.rate_min =		USE_RATE_MIN,
+	.rate_max =		USE_RATE_MAX,
 	.channels_min =		USE_CHANNELS_MIN,
 	.channels_max =		USE_CHANNELS_MAX,
 	.buffer_bytes_max =	MAX_BUFFER_SIZE,
@@ -289,9 +303,9 @@
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		USE_FORMATS,
-	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	.rate_min =		5500,
-	.rate_max =		48000,
+	.rates =		USE_RATE,
+	.rate_min =		USE_RATE_MIN,
+	.rate_max =		USE_RATE_MAX,
 	.channels_min =		USE_CHANNELS_MIN,
 	.channels_max =		USE_CHANNELS_MAX,
 	.buffer_bytes_max =	MAX_BUFFER_SIZE,
diff -Nru a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
--- a/sound/isa/sb/sb16.c	Thu Jul 31 23:16:39 2003
+++ b/sound/isa/sb/sb16.c	Thu Jul 31 23:16:39 2003
@@ -350,6 +350,18 @@
 
 #endif /* CONFIG_PNP */
 
+static void snd_sb16_free(snd_card_t *card)
+{
+	struct snd_card_sb16 *acard = (struct snd_card_sb16 *)card->private_data;
+        
+	if (acard == NULL)
+		return;
+	if (acard->fm_res) {
+		release_resource(acard->fm_res);
+		kfree_nocheck(acard->fm_res);
+	}
+}
+
 static int __init snd_sb16_probe(int dev,
 				 struct pnp_card_link *pcard,
 				 const struct pnp_card_device_id *pid)
@@ -374,6 +386,7 @@
 	if (card == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_sb16 *) card->private_data;
+	card->private_free = snd_sb16_free;
 #ifdef CONFIG_PNP
 	if (isapnp[dev]) {
 		if ((err = snd_card_sb16_pnp(dev, acard, pcard, pid))) {
@@ -464,7 +477,8 @@
 
 	if (fm_port[dev] > 0) {
 		if (snd_opl3_create(card, fm_port[dev], fm_port[dev] + 2,
-				    OPL3_HW_OPL3, fm_port[dev] == port[dev],
+				    OPL3_HW_OPL3,
+				    fm_port[dev] == port[dev] || fm_port[dev] == 0x388,
 				    &opl3) < 0) {
 			snd_printk(KERN_ERR PFX "no OPL device at 0x%lx-0x%lx\n",
 				   fm_port[dev], fm_port[dev] + 2);
diff -Nru a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
--- a/sound/pci/ac97/ac97_patch.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/ac97/ac97_patch.c	Thu Jul 31 23:16:39 2003
@@ -650,6 +650,26 @@
 	return 0;
 }
 
+static const snd_kcontrol_new_t snd_ac97_controls_ad1885[] = {
+	AC97_SINGLE("Digital Mono Direct", AC97_AD_MISC, 11, 1, 0),
+	AC97_SINGLE("Digital Audio Mode", AC97_AD_MISC, 12, 1, 0),
+	AC97_SINGLE("Low Power Mixer", AC97_AD_MISC, 14, 1, 0),
+	AC97_SINGLE("Zero Fill DAC", AC97_AD_MISC, 15, 1, 0),
+};
+
+static int patch_ad1885_specific(ac97_t * ac97)
+{
+	int err;
+
+	if ((err = patch_build_controls(ac97, snd_ac97_controls_ad1885, ARRAY_SIZE(snd_ac97_controls_ad1885))) < 0)
+		return err;
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_ad1885_build_ops = {
+	.build_specific = &patch_ad1885_specific
+};
+
 int patch_ad1885(ac97_t * ac97)
 {
 	unsigned short jack;
@@ -661,6 +681,8 @@
 	/* turn off jack sense bits D8 & D9 */
 	jack = snd_ac97_read(ac97, AC97_AD_JACK_SPDIF);
 	snd_ac97_write_cache(ac97, AC97_AD_JACK_SPDIF, jack | 0x0300);
+
+	ac97->build_ops = &patch_ad1885_build_ops;
 	return 0;
 }
 
diff -Nru a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
--- a/sound/pci/emu10k1/emu10k1.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/emu10k1/emu10k1.c	Thu Jul 31 23:16:39 2003
@@ -135,11 +135,9 @@
 		snd_card_free(card);
 		return err;
 	}		
-	if (!emu->APS) {	/* APS board has not an AC97 mixer */
-		if ((err = snd_emu10k1_mixer(emu)) < 0) {
-			snd_card_free(card);
-			return err;
-		}		
+	if ((err = snd_emu10k1_mixer(emu)) < 0) {
+		snd_card_free(card);
+		return err;
 	}
 	if (emu->audigy) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
diff -Nru a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
--- a/sound/pci/emu10k1/emu10k1_main.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/emu10k1/emu10k1_main.c	Thu Jul 31 23:16:39 2003
@@ -674,6 +674,14 @@
 	if (emu->serial == 0x40011102) {
 		emu->card_type = EMU10K1_CARD_EMUAPS;
 		emu->APS = 1;
+		emu->no_ac97 = 1; /* APS has no AC97 chip */
+	}
+	else if (emu->revision == 4 && emu->serial == 0x10051102) {
+		/* Audigy 2 EX has apparently no effective AC97 controls
+		 * (for both input and output), so we skip the AC97 detections
+		 */
+		snd_printdd(KERN_INFO "Audigy2 EX is detected. skpping ac97.\n");
+		emu->no_ac97 = 1;
 	}
 	
 	emu->fx8010.fxbus_mask = 0x303f;
diff -Nru a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
--- a/sound/pci/emu10k1/emufx.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/emu10k1/emufx.c	Thu Jul 31 23:16:39 2003
@@ -1238,7 +1238,10 @@
 
 static int __devinit _snd_emu10k1_audigy_init_efx(emu10k1_t *emu)
 {
-	int err, i, z, gpr, tmp, playback, capture, nctl;
+	int err, i, z, gpr, nctl;
+	const int playback = 10;
+	const int capture = playback + (SND_EMU10K1_PLAYBACK_CHANNELS * 2); /* we reserve 10 voices */
+	const int tmp = 0x88;
 	u32 ptr;
 	emu10k1_fx8010_code_t *icode;
 	emu10k1_fx8010_control_gpr_t *controls, *ctl;
@@ -1261,19 +1264,15 @@
 	strcpy(icode->name, "Audigy DSP code for ALSA");
 	ptr = 0;
 	nctl = 0;
-	playback = 10;
-	capture = playback + (SND_EMU10K1_PLAYBACK_CHANNELS * 2); /* we reserve 10 voices */
 	gpr = capture + 10;
-	tmp = 0x88;
 
 	/* stop FX processor */
 	snd_emu10k1_ptr_write(emu, A_DBG, 0, (emu->fx8010.dbg = 0) | A_DBG_SINGLE_STEP);
 
-	/* Wave Playback */
+	/* Wave Playback Volume */
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LEFT));
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1), A_C_00000000, A_GPR(gpr+1), A_FXBUS(FXBUS_PCM_RIGHT));
-	snd_emu10k1_init_stereo_control(&controls[nctl++], "Wave Playback Volume", gpr,
-					emu->revision == 4 ? 50 : 100);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "Wave Playback Volume", gpr, 100);
 	gpr += 2;
 
 	/* Wave Surround Playback */
@@ -1497,6 +1496,14 @@
 	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "Tone Control - Switch", gpr, 0);
 	gpr += 2;
 
+	/* Master volume for audigy2 */
+	if (emu->revision == 4) {
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr+1), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
+		snd_emu10k1_init_stereo_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
+		gpr += 2;
+	}
+
 	/* digital outputs */
 	A_PUT_STEREO_OUTPUT(A_EXTOUT_FRONT_L, A_EXTOUT_FRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
 	A_PUT_STEREO_OUTPUT(A_EXTOUT_REAR_L, A_EXTOUT_REAR_R, playback+2 + SND_EMU10K1_PLAYBACK_CHANNELS);
@@ -1504,7 +1511,7 @@
 	A_PUT_OUTPUT(A_EXTOUT_LFE, playback+5 + SND_EMU10K1_PLAYBACK_CHANNELS);
 
 	/* analog speakers */
-	if (emu->audigy && emu->revision == 4) { /* audigy2 */
+	if (emu->revision == 4) { /* audigy2 */
 		A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
 	} else {
 		A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
diff -Nru a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
--- a/sound/pci/emu10k1/emumixer.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/emu10k1/emumixer.c	Thu Jul 31 23:16:39 2003
@@ -423,6 +423,36 @@
 	emu->ac97 = NULL;
 }
 
+/*
+ */
+static int remove_ctl(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t id;
+	memset(&id, 0, sizeof(id));
+	strcpy(id.name, name);
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_remove_id(card, &id);
+}
+
+static snd_kcontrol_t *ctl_find(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t sid;
+	memset(&sid, 0, sizeof(sid));
+	strcpy(sid.name, name);
+	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_find_id(card, &sid);
+}
+
+static int rename_ctl(snd_card_t *card, const char *src, const char *dst)
+{
+	snd_kcontrol_t *kctl = ctl_find(card, src);
+	if (kctl) {
+		strcpy(kctl->id.name, dst);
+		return 0;
+	}
+	return -ENOENT;
+}
+
 int __devinit snd_emu10k1_mixer(emu10k1_t *emu)
 {
 	ac97_t ac97;
@@ -430,7 +460,7 @@
 	snd_kcontrol_t *kctl;
 	snd_card_t *card = emu->card;
 
-	if (!emu->APS) {
+	if (!emu->no_ac97) {
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.write = snd_emu10k1_ac97_write;
 		ac97.read = snd_emu10k1_ac97_read;
@@ -438,8 +468,33 @@
 		ac97.private_free = snd_emu10k1_mixer_free_ac97;
 		if ((err = snd_ac97_mixer(emu->card, &ac97, &emu->ac97)) < 0)
 			return err;
+		if (emu->audigy && emu->revision == 4) {
+			/* Master/PCM controls on ac97 of Audigy2 has no effect */
+			/* FIXME: keep master volume/switch to be sure.
+			 * once after we check that they play really no roles,
+			 * they shall be removed.
+			 */
+			rename_ctl(card, "Master Playback Switch", "AC97 Master Playback Switch");
+			rename_ctl(card, "Master Playback Volume", "AC97 Master Playback Volume");
+			/* pcm controls are removed */
+			remove_ctl(card, "PCM Playback Switch");
+			remove_ctl(card, "PCM Playback Volume");
+		}
 	} else {
-		strcpy(emu->card->mixername, "EMU APS");
+		if (emu->APS)
+			strcpy(emu->card->mixername, "EMU APS");
+		else if (emu->audigy)
+			strcpy(emu->card->mixername, "SB Audigy");
+		else
+			strcpy(emu->card->mixername, "Emu10k1");
+	}
+
+	if (emu->audigy && emu->revision == 4) {
+		/* Audigy2 and Audigy2 EX */
+		/* use the conventional names */
+		rename_ctl(card, "Wave Playback Volume", "PCM Playback Volume");
+		rename_ctl(card, "Wave Playback Volume", "PCM Capture Volume");
+		rename_ctl(card, "Wave Master Playback Volume", "Master Playback Volume");
 	}
 
 	if ((kctl = emu->ctl_send_routing = snd_ctl_new1(&snd_emu10k1_send_routing_control, emu)) == NULL)
@@ -455,6 +510,7 @@
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
 
+	/* intiailize the routing and volume table for each pcm playback stream */
 	for (pcm = 0; pcm < 32; pcm++) {
 		emu10k1_pcm_mixer_t *mix;
 		int v;
@@ -474,21 +530,25 @@
 		mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
 	}
 	
-	if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)
-		return -ENOMEM;
-	if ((err = snd_ctl_add(card, kctl)))
-		return err;
-	if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_control, emu)) == NULL)
-		return -ENOMEM;
-	if ((err = snd_ctl_add(card, kctl)))
-		return err;
+	if (! emu->APS) { /* FIXME: APS has these controls? */
+		/* sb live! and audigy */
+		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)
+			return -ENOMEM;
+		if ((err = snd_ctl_add(card, kctl)))
+			return err;
+		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_control, emu)) == NULL)
+			return -ENOMEM;
+		if ((err = snd_ctl_add(card, kctl)))
+			return err;
+	}
 
 	if (emu->audigy) {
 		if ((kctl = snd_ctl_new1(&snd_audigy_shared_spdif, emu)) == NULL)
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
-	} else {
+	} else if (! emu->APS) {
+		/* sb live! */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_shared_spdif, emu)) == NULL)
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
diff -Nru a/sound/pci/emu10k1/irq.c b/sound/pci/emu10k1/irq.c
--- a/sound/pci/emu10k1/irq.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/emu10k1/irq.c	Thu Jul 31 23:16:39 2003
@@ -55,15 +55,13 @@
 		if (status & IPR_CHANNELLOOP) {
 			int voice;
 			int voice_max = status & IPR_CHANNELNUMBERMASK;
-			int voice_max_l;
 			u32 val;
 			emu10k1_voice_t *pvoice = emu->voices;
 
 			val = snd_emu10k1_ptr_read(emu, CLIPL, 0);
-			voice_max_l = voice_max;
-			if (voice_max_l >= 0x20)
-				voice_max_l = 0x1f;
-			for (voice = 0; voice <= voice_max_l; voice++) {
+			for (voice = 0; voice <= voice_max; voice++) {
+				if (voice == 0x20)
+					val = snd_emu10k1_ptr_read(emu, CLIPH, 0);
 				if (val & 1) {
 					if (pvoice->use && pvoice->interrupt != NULL) {
 						pvoice->interrupt(emu, pvoice);
@@ -75,21 +73,6 @@
 				val >>= 1;
 				pvoice++;
 			}
-			if (voice_max > 0x1f) {
-				val = snd_emu10k1_ptr_read(emu, CLIPH, 0);
-				for (; voice <= voice_max; voice++) {
-					if(val & 1) {
-						if (pvoice->use && pvoice->interrupt != NULL) {
-							pvoice->interrupt(emu, pvoice);
-							snd_emu10k1_voice_intr_ack(emu, voice);
-						} else {
-							snd_emu10k1_voice_intr_disable(emu, voice);
-						}
-					}
-					val >>= 1;
-					pvoice++;
-				}
-			}
 			status &= ~IPR_CHANNELLOOP;
 		}
 		status &= ~IPR_CHANNELNUMBERMASK;
@@ -150,9 +133,27 @@
 			status &= ~IPR_FXDSP;
 		}
 		if (status) {
-			snd_printd(KERN_WARNING "emu10k1: unhandled interrupt: 0x%08x\n", status);
+			unsigned int bits;
+			snd_printk(KERN_ERR "emu10k1: unhandled interrupt: 0x%08x\n", status);
+			//make sure any interrupts we don't handle are disabled:
+			bits = INTE_FXDSPENABLE |
+				INTE_PCIERRORENABLE |
+				INTE_VOLINCRENABLE |
+				INTE_VOLDECRENABLE |
+				INTE_MUTEENABLE |
+				INTE_MICBUFENABLE |
+				INTE_ADCBUFENABLE |
+				INTE_EFXBUFENABLE |
+				INTE_GPSPDIFENABLE |
+				INTE_CDSPDIFENABLE |
+				INTE_INTERVALTIMERENB |
+				INTE_MIDITXENABLE |
+				INTE_MIDIRXENABLE;
+			if (emu->audigy)
+				bits |= INTE_A_MIDITXENABLE2 | INTE_A_MIDIRXENABLE2;
+			snd_emu10k1_intr_disable(emu, bits);
 		}
-		outl(orig_status, emu->port + IPR); /* ack */
+		outl(orig_status, emu->port + IPR); /* ack all */
 	}
 	return IRQ_RETVAL(handled);
 }
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/intel8x0.c	Thu Jul 31 23:16:39 2003
@@ -1002,7 +1002,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	static unsigned int i, rates[] = {
 		/* ATTENTION: these values depend on the definition in pcm.h! */
-		5512, 8000, 11025, 16000, 22050, 32000, 44100, 480000
+		5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000
 	};
 	int err;
 
@@ -1558,6 +1558,7 @@
 	{ 0x1028, 0x0126, "Dell Optiplex GX260", AC97_TUNE_HP_ONLY },
 	{ 0x1734, 0x0088, "Fujitsu-Siemens D1522", AC97_TUNE_HP_ONLY },
 	{ 0x10f1, 0x2665, "Fujitsu-Siemens Celcius", AC97_TUNE_HP_ONLY },
+	{ 0x110a, 0x0056, "Fujitsu-Siemens Scenic", AC97_TUNE_HP_ONLY },
 	{ 0x8086, 0x4d44, "Intel D850EMV2", AC97_TUNE_HP_ONLY },
 	/* { 0x4144, 0x5360, "AMD64 Motherboard", AC97_TUNE_HP_ONLY }, */ /* FIXME: this seems invalid */
 	{ 0x1043, 0x80b0, "ASUS P4PE Mobo", AC97_TUNE_SWAP_SURROUND },
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/maestro3.c	Thu Jul 31 23:16:39 2003
@@ -1535,9 +1535,14 @@
 snd_m3_pcm_pointer(snd_pcm_substream_t * subs)
 {
 	m3_t *chip = snd_pcm_substream_chip(subs);
+	unsigned int ptr;
 	m3_dma_t *s = (m3_dma_t*)subs->runtime->private_data;
 	snd_assert(s != NULL, return 0);
-	return bytes_to_frames(subs->runtime, snd_m3_get_pointer(chip, s, subs));
+
+	spin_lock(&chip->reg_lock);
+	ptr = snd_m3_get_pointer(chip, s, subs);
+	spin_unlock(&chip->reg_lock);
+	return bytes_to_frames(subs->runtime, ptr);
 }
 
 
diff -Nru a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	Thu Jul 31 23:16:39 2003
+++ b/sound/pci/via82xx.c	Thu Jul 31 23:16:39 2003
@@ -886,7 +886,7 @@
 		snd_ac97_set_rate(chip->ac97, AC97_PCM_LFE_DAC_RATE, runtime->rate);
 		snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);
 	}
-	if (chip->chip_type == TYPE_VIA8233A)
+	if (chip->revision == VIA_REV_8233A)
 		rbits = 0;
 	else
 		rbits = (0xfffff / 48000) * runtime->rate + ((0xfffff % 48000) * runtime->rate) / 48000;
@@ -928,7 +928,7 @@
 	fmt = (runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? VIA_REG_MULTPLAY_FMT_16BIT : VIA_REG_MULTPLAY_FMT_8BIT;
 	fmt |= runtime->channels << 4;
 	outb(fmt, VIADEV_REG(viadev, OFS_MULTPLAY_FORMAT));
-	if (chip->chip_type == TYPE_VIA8233A)
+	if (chip->revision == VIA_REV_8233A)
 		slots = 0;
 	else {
 		/* set sample number to slot 3, 4, 7, 8, 6, 9 (for VIA8233/C,8235) */
@@ -1108,7 +1108,7 @@
 	if ((err = snd_via82xx_pcm_open(chip, viadev, substream)) < 0)
 		return err;
 	substream->runtime->hw.channels_max = 6;
-	if (chip->chip_type == TYPE_VIA8233A)
+	if (chip->revision == VIA_REV_8233A)
 		snd_pcm_hw_constraint_list(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &hw_constraints_channels);
 	return 0;
 }
diff -Nru a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
--- a/sound/synth/emux/soundfont.c	Thu Jul 31 23:16:39 2003
+++ b/sound/synth/emux/soundfont.c	Thu Jul 31 23:16:39 2003
@@ -66,15 +66,11 @@
 static int
 lock_preset(snd_sf_list_t *sflist, int nonblock)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&sflist->lock, flags);
-	if (sflist->sf_locked && nonblock) {
-		spin_unlock_irqrestore(&sflist->lock, flags);
-		return -EBUSY;
-	}
-	spin_unlock_irqrestore(&sflist->lock, flags);
-	down(&sflist->presets_mutex);
-	sflist->sf_locked = 1;
+	if (nonblock) {
+		if (down_trylock(&sflist->presets_mutex))
+			return -EBUSY;
+	} else 
+		down(&sflist->presets_mutex);
 	return 0;
 }
 
@@ -86,7 +82,6 @@
 unlock_preset(snd_sf_list_t *sflist)
 {
 	up(&sflist->presets_mutex);
-	sflist->sf_locked = 0;
 }
 
 
@@ -1356,7 +1351,6 @@
 
 	init_MUTEX(&sflist->presets_mutex);
 	spin_lock_init(&sflist->lock);
-	sflist->sf_locked = 0;
 	sflist->memhdr = hdr;
 
 	if (callback)
@@ -1403,7 +1397,7 @@
 
 /*
  * Remove unlocked samples.
- * The soundcard should be silet before calling this function.
+ * The soundcard should be silent before calling this function.
  */
 int
 snd_soundfont_remove_unlocked(snd_sf_list_t *sflist)
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	Thu Jul 31 23:16:39 2003
+++ b/sound/usb/usbaudio.c	Thu Jul 31 23:16:39 2003
@@ -2297,6 +2297,14 @@
 			 */
 			fp->attributes &= ~EP_CS_ATTR_SAMPLE_RATE;
 		}
+
+		/* workaround for M-Audio Audiophile USB */
+		if (dev->descriptor.idVendor == 0x0763 &&
+		    dev->descriptor.idProduct == 0x2003) {
+			/* doesn't set the sample rate attribute, but supports it */
+			fp->attributes |= EP_CS_ATTR_SAMPLE_RATE;
+		}
+
 		/*
 		 * plantronics headset and Griffin iMic have set adaptive-in
 		 * although it's really not...
-
To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--==========1812539384==========--

