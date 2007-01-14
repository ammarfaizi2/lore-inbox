Return-Path: <linux-kernel-owner+w=401wt.eu-S1750962AbXANBDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXANBDL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXANBDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:03:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52780 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXANBC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:02:59 -0500
Subject: [patch 09/12] mark struct file_operations const 9
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:57:03 -0800
Message-Id: <1168736223.3123.335.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 09/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/security/inode.c
===================================================================
--- linux-2.6.orig/security/inode.c
+++ linux-2.6/security/inode.c
@@ -50,7 +50,7 @@ static int default_open(struct inode *in
 	return 0;
 }
 
-static struct file_operations default_file_ops = {
+static const struct file_operations default_file_ops = {
 	.read =		default_read_file,
 	.write =	default_write_file,
 	.open =		default_open,
@@ -215,7 +215,7 @@ static int create_by_name(const char *na
  */
 struct dentry *securityfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
-				   struct file_operations *fops)
+				   const struct file_operations *fops)
 {
 	struct dentry *dentry = NULL;
 	int error;
Index: linux-2.6/security/keys/proc.c
===================================================================
--- linux-2.6.orig/security/keys/proc.c
+++ linux-2.6/security/keys/proc.c
@@ -33,7 +33,7 @@ static struct seq_operations proc_keys_o
 	.show	= proc_keys_show,
 };
 
-static struct file_operations proc_keys_fops = {
+static const struct file_operations proc_keys_fops = {
 	.open		= proc_keys_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -54,7 +54,7 @@ static struct seq_operations proc_key_us
 	.show	= proc_key_users_show,
 };
 
-static struct file_operations proc_key_users_fops = {
+static const struct file_operations proc_key_users_fops = {
 	.open		= proc_key_users_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.orig/security/selinux/selinuxfs.c
+++ linux-2.6/security/selinux/selinuxfs.c
@@ -161,7 +161,7 @@ out:
 #define sel_write_enforce NULL
 #endif
 
-static struct file_operations sel_enforce_ops = {
+static const struct file_operations sel_enforce_ops = {
 	.read		= sel_read_enforce,
 	.write		= sel_write_enforce,
 };
@@ -211,7 +211,7 @@ out:
 #define sel_write_disable NULL
 #endif
 
-static struct file_operations sel_disable_ops = {
+static const struct file_operations sel_disable_ops = {
 	.write		= sel_write_disable,
 };
 
@@ -225,7 +225,7 @@ static ssize_t sel_read_policyvers(struc
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
-static struct file_operations sel_policyvers_ops = {
+static const struct file_operations sel_policyvers_ops = {
 	.read		= sel_read_policyvers,
 };
 
@@ -242,7 +242,7 @@ static ssize_t sel_read_mls(struct file 
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
-static struct file_operations sel_mls_ops = {
+static const struct file_operations sel_mls_ops = {
 	.read		= sel_read_mls,
 };
 
@@ -294,7 +294,7 @@ out:
 	return length;
 }
 
-static struct file_operations sel_load_ops = {
+static const struct file_operations sel_load_ops = {
 	.write		= sel_write_load,
 };
 
@@ -374,7 +374,7 @@ out:
 	free_page((unsigned long) page);
 	return length;
 }
-static struct file_operations sel_checkreqprot_ops = {
+static const struct file_operations sel_checkreqprot_ops = {
 	.read		= sel_read_checkreqprot,
 	.write		= sel_write_checkreqprot,
 };
@@ -423,7 +423,7 @@ out:
 	free_page((unsigned long) page);
 	return length;
 }
-static struct file_operations sel_compat_net_ops = {
+static const struct file_operations sel_compat_net_ops = {
 	.read		= sel_read_compat_net,
 	.write		= sel_write_compat_net,
 };
@@ -467,7 +467,7 @@ static ssize_t selinux_transaction_write
 	return rv;
 }
 
-static struct file_operations transaction_ops = {
+static const struct file_operations transaction_ops = {
 	.write		= selinux_transaction_write,
 	.read		= simple_transaction_read,
 	.release	= simple_transaction_release,
@@ -875,7 +875,7 @@ out:
 	return length;
 }
 
-static struct file_operations sel_bool_ops = {
+static const struct file_operations sel_bool_ops = {
 	.read           = sel_read_bool,
 	.write          = sel_write_bool,
 };
@@ -932,7 +932,7 @@ out:
 	return length;
 }
 
-static struct file_operations sel_commit_bools_ops = {
+static const struct file_operations sel_commit_bools_ops = {
 	.write          = sel_commit_bools_write,
 };
 
@@ -1131,12 +1131,12 @@ out:
 	return ret;
 }
 
-static struct file_operations sel_avc_cache_threshold_ops = {
+static const struct file_operations sel_avc_cache_threshold_ops = {
 	.read		= sel_read_avc_cache_threshold,
 	.write		= sel_write_avc_cache_threshold,
 };
 
-static struct file_operations sel_avc_hash_stats_ops = {
+static const struct file_operations sel_avc_hash_stats_ops = {
 	.read		= sel_read_avc_hash_stats,
 };
 
@@ -1198,7 +1198,7 @@ static int sel_open_avc_cache_stats(stru
 	return seq_open(file, &sel_avc_cache_stats_seq_ops);
 }
 
-static struct file_operations sel_avc_cache_stats_ops = {
+static const struct file_operations sel_avc_cache_stats_ops = {
 	.open		= sel_open_avc_cache_stats,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/sound/core/control.c
===================================================================
--- linux-2.6.orig/sound/core/control.c
+++ linux-2.6/sound/core/control.c
@@ -1416,7 +1416,7 @@ static int snd_ctl_fasync(int fd, struct
  *  INIT PART
  */
 
-static struct file_operations snd_ctl_f_ops =
+static const struct file_operations snd_ctl_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.read =		snd_ctl_read,
Index: linux-2.6/sound/core/hwdep.c
===================================================================
--- linux-2.6.orig/sound/core/hwdep.c
+++ linux-2.6/sound/core/hwdep.c
@@ -319,7 +319,7 @@ static int snd_hwdep_control_ioctl(struc
 
  */
 
-static struct file_operations snd_hwdep_f_ops =
+static const struct file_operations snd_hwdep_f_ops =
 {
 	.owner = 	THIS_MODULE,
 	.llseek =	snd_hwdep_llseek,
Index: linux-2.6/sound/core/info.c
===================================================================
--- linux-2.6.orig/sound/core/info.c
+++ linux-2.6/sound/core/info.c
@@ -507,7 +507,7 @@ static int snd_info_entry_mmap(struct fi
 	return -ENXIO;
 }
 
-static struct file_operations snd_info_entry_operations =
+static const struct file_operations snd_info_entry_operations =
 {
 	.owner =		THIS_MODULE,
 	.llseek =		snd_info_entry_llseek,
Index: linux-2.6/sound/core/init.c
===================================================================
--- linux-2.6.orig/sound/core/init.c
+++ linux-2.6/sound/core/init.c
@@ -36,7 +36,7 @@
 static DEFINE_SPINLOCK(shutdown_lock);
 static LIST_HEAD(shutdown_files);
 
-static struct file_operations snd_shutdown_f_ops;
+static const struct file_operations snd_shutdown_f_ops;
 
 static unsigned int snd_cards_lock;	/* locked for registering/using */
 struct snd_card *snd_cards[SNDRV_CARDS];
@@ -238,7 +238,7 @@ static int snd_disconnect_fasync(int fd,
 	return -ENODEV;
 }
 
-static struct file_operations snd_shutdown_f_ops =
+static const struct file_operations snd_shutdown_f_ops =
 {
 	.owner = 	THIS_MODULE,
 	.llseek =	snd_disconnect_llseek,
Index: linux-2.6/sound/core/oss/mixer_oss.c
===================================================================
--- linux-2.6.orig/sound/core/oss/mixer_oss.c
+++ linux-2.6/sound/core/oss/mixer_oss.c
@@ -390,7 +390,7 @@ int snd_mixer_oss_ioctl_card(struct snd_
  *  REGISTRATION PART
  */
 
-static struct file_operations snd_mixer_oss_f_ops =
+static const struct file_operations snd_mixer_oss_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.open =		snd_mixer_oss_open,
Index: linux-2.6/sound/core/oss/pcm_oss.c
===================================================================
--- linux-2.6.orig/sound/core/oss/pcm_oss.c
+++ linux-2.6/sound/core/oss/pcm_oss.c
@@ -2889,7 +2889,7 @@ static void snd_pcm_oss_proc_done(struct
  *  ENTRY functions
  */
 
-static struct file_operations snd_pcm_oss_f_reg =
+static const struct file_operations snd_pcm_oss_f_reg =
 {
 	.owner =	THIS_MODULE,
 	.read =		snd_pcm_oss_read,
Index: linux-2.6/sound/core/pcm_native.c
===================================================================
--- linux-2.6.orig/sound/core/pcm_native.c
+++ linux-2.6/sound/core/pcm_native.c
@@ -3424,7 +3424,7 @@ out:
  *  Register section
  */
 
-struct file_operations snd_pcm_f_ops[2] = {
+const struct file_operations snd_pcm_f_ops[2] = {
 	{
 		.owner =		THIS_MODULE,
 		.write =		snd_pcm_write,
Index: linux-2.6/sound/core/rawmidi.c
===================================================================
--- linux-2.6.orig/sound/core/rawmidi.c
+++ linux-2.6/sound/core/rawmidi.c
@@ -1365,7 +1365,7 @@ static void snd_rawmidi_proc_info_read(s
  *  Register functions
  */
 
-static struct file_operations snd_rawmidi_f_ops =
+static const struct file_operations snd_rawmidi_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.read =		snd_rawmidi_read,
Index: linux-2.6/sound/core/seq/oss/seq_oss.c
===================================================================
--- linux-2.6.orig/sound/core/seq/oss/seq_oss.c
+++ linux-2.6/sound/core/seq/oss/seq_oss.c
@@ -208,7 +208,7 @@ odev_poll(struct file *file, poll_table 
  * registration of sequencer minor device
  */
 
-static struct file_operations seq_oss_f_ops =
+static const struct file_operations seq_oss_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.read =		odev_read,
Index: linux-2.6/sound/core/seq/seq_clientmgr.c
===================================================================
--- linux-2.6.orig/sound/core/seq/seq_clientmgr.c
+++ linux-2.6/sound/core/seq/seq_clientmgr.c
@@ -2542,7 +2542,7 @@ void snd_seq_info_clients_read(struct sn
  *  REGISTRATION PART
  */
 
-static struct file_operations snd_seq_f_ops =
+static const struct file_operations snd_seq_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.read =		snd_seq_read,
Index: linux-2.6/sound/core/sound.c
===================================================================
--- linux-2.6.orig/sound/core/sound.c
+++ linux-2.6/sound/core/sound.c
@@ -168,7 +168,7 @@ static int snd_open(struct inode *inode,
 	return err;
 }
 
-static struct file_operations snd_fops =
+static const struct file_operations snd_fops =
 {
 	.owner =	THIS_MODULE,
 	.open =		snd_open
Index: linux-2.6/sound/core/timer.c
===================================================================
--- linux-2.6.orig/sound/core/timer.c
+++ linux-2.6/sound/core/timer.c
@@ -1931,7 +1931,7 @@ static unsigned int snd_timer_user_poll(
 #define snd_timer_user_ioctl_compat	NULL
 #endif
 
-static struct file_operations snd_timer_f_ops =
+static const struct file_operations snd_timer_f_ops =
 {
 	.owner =	THIS_MODULE,
 	.read =		snd_timer_user_read,
Index: linux-2.6/sound/oss/ad1889.c
===================================================================
--- linux-2.6.orig/sound/oss/ad1889.c
+++ linux-2.6/sound/oss/ad1889.c
@@ -778,7 +778,7 @@ static int ad1889_release(struct inode *
 	return 0;
 }
 
-static struct file_operations ad1889_fops = {
+static const struct file_operations ad1889_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= ad1889_read,
@@ -812,7 +812,7 @@ static int ad1889_mixer_ioctl(struct ino
 	return codec->mixer_ioctl(codec, cmd, arg);
 }
 
-static struct file_operations ad1889_mixer_fops = {
+static const struct file_operations ad1889_mixer_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= ad1889_mixer_ioctl,
Index: linux-2.6/sound/oss/btaudio.c
===================================================================
--- linux-2.6.orig/sound/oss/btaudio.c
+++ linux-2.6/sound/oss/btaudio.c
@@ -429,7 +429,7 @@ static int btaudio_mixer_ioctl(struct in
 	return 0;
 }
 
-static struct file_operations btaudio_mixer_fops = {
+static const struct file_operations btaudio_mixer_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.open		= btaudio_mixer_open,
@@ -796,7 +796,7 @@ static unsigned int btaudio_dsp_poll(str
 	return mask;
 }
 
-static struct file_operations btaudio_digital_dsp_fops = {
+static const struct file_operations btaudio_digital_dsp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.open		= btaudio_dsp_open_digital,
@@ -807,7 +807,7 @@ static struct file_operations btaudio_di
 	.poll		= btaudio_dsp_poll,
 };
 
-static struct file_operations btaudio_analog_dsp_fops = {
+static const struct file_operations btaudio_analog_dsp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.open		= btaudio_dsp_open_analog,
Index: linux-2.6/sound/oss/dmasound/dmasound_core.c
===================================================================
--- linux-2.6.orig/sound/oss/dmasound/dmasound_core.c
+++ linux-2.6/sound/oss/dmasound/dmasound_core.c
@@ -371,7 +371,7 @@ static int mixer_ioctl(struct inode *ino
 	return -EINVAL;
 }
 
-static struct file_operations mixer_fops =
+static const struct file_operations mixer_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -1337,7 +1337,7 @@ static int sq_ioctl(struct inode *inode,
 	return -EINVAL;
 }
 
-static struct file_operations sq_fops =
+static const struct file_operations sq_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -1561,7 +1561,7 @@ static ssize_t state_read(struct file *f
 	return n;
 }
 
-static struct file_operations state_fops = {
+static const struct file_operations state_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= state_read,
Index: linux-2.6/sound/oss/emu10k1/audio.c
===================================================================
--- linux-2.6.orig/sound/oss/emu10k1/audio.c
+++ linux-2.6/sound/oss/emu10k1/audio.c
@@ -1582,7 +1582,7 @@ static void emu10k1_waveout_bh(unsigned 
 	return;
 }
 
-struct file_operations emu10k1_audio_fops = {
+const struct file_operations emu10k1_audio_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= emu10k1_audio_read,
Index: linux-2.6/sound/oss/emu10k1/midi.c
===================================================================
--- linux-2.6.orig/sound/oss/emu10k1/midi.c
+++ linux-2.6/sound/oss/emu10k1/midi.c
@@ -458,7 +458,7 @@ int emu10k1_midi_callback(unsigned long 
 }
 
 /* MIDI file operations */
-struct file_operations emu10k1_midi_fops = {
+const struct file_operations emu10k1_midi_fops = {
 	.owner		= THIS_MODULE,
 	.read		= emu10k1_midi_read,
 	.write		= emu10k1_midi_write,
Index: linux-2.6/sound/oss/emu10k1/mixer.c
===================================================================
--- linux-2.6.orig/sound/oss/emu10k1/mixer.c
+++ linux-2.6/sound/oss/emu10k1/mixer.c
@@ -681,7 +681,7 @@ static int emu10k1_mixer_release(struct 
 	return 0;
 }
 
-struct file_operations emu10k1_mixer_fops = {
+const struct file_operations emu10k1_mixer_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= emu10k1_mixer_ioctl,
Index: linux-2.6/sound/oss/hal2.c
===================================================================
--- linux-2.6.orig/sound/oss/hal2.c
+++ linux-2.6/sound/oss/hal2.c
@@ -1377,7 +1377,7 @@ static int hal2_release(struct inode *in
 	return 0;
 }
 
-static struct file_operations hal2_audio_fops = {
+static const struct file_operations hal2_audio_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= hal2_read,
@@ -1388,7 +1388,7 @@ static struct file_operations hal2_audio
 	.release	= hal2_release,
 };
 
-static struct file_operations hal2_mixer_fops = {
+static const struct file_operations hal2_mixer_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= hal2_ioctl_mixdev,
Index: linux-2.6/sound/oss/msnd_pinnacle.c
===================================================================
--- linux-2.6.orig/sound/oss/msnd_pinnacle.c
+++ linux-2.6/sound/oss/msnd_pinnacle.c
@@ -1106,7 +1106,7 @@ static irqreturn_t intr(int irq, void *d
 	return IRQ_HANDLED;
 }
 
-static struct file_operations dev_fileops = {
+static const struct file_operations dev_fileops = {
 	.owner		= THIS_MODULE,
 	.read		= dev_read,
 	.write		= dev_write,
Index: linux-2.6/sound/oss/os.h
===================================================================
--- linux-2.6.orig/sound/oss/os.h
+++ linux-2.6/sound/oss/os.h
@@ -43,4 +43,4 @@ extern int sound_nblocks;
 #undef PSEUDO_DMA_AUTOINIT
 #define ALLOW_BUFFER_MAPPING
 
-extern struct file_operations oss_sound_fops;
+extern const struct file_operations oss_sound_fops;
Index: linux-2.6/sound/oss/sh_dac_audio.c
===================================================================
--- linux-2.6.orig/sound/oss/sh_dac_audio.c
+++ linux-2.6/sound/oss/sh_dac_audio.c
@@ -255,7 +255,7 @@ static int dac_audio_release(struct inod
 	return 0;
 }
 
-struct file_operations dac_audio_fops = {
+const struct file_operations dac_audio_fops = {
       .read =		dac_audio_read,
       .write =	dac_audio_write,
       .ioctl =	dac_audio_ioctl,
Index: linux-2.6/sound/oss/soundcard.c
===================================================================
--- linux-2.6.orig/sound/oss/soundcard.c
+++ linux-2.6/sound/oss/soundcard.c
@@ -482,7 +482,7 @@ static int sound_mmap(struct file *file,
 	return 0;
 }
 
-struct file_operations oss_sound_fops = {
+const struct file_operations oss_sound_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= sound_read,
Index: linux-2.6/sound/oss/via82cxxx_audio.c
===================================================================
--- linux-2.6.orig/sound/oss/via82cxxx_audio.c
+++ linux-2.6/sound/oss/via82cxxx_audio.c
@@ -1619,7 +1619,7 @@ out:
 }
 
 
-static struct file_operations via_mixer_fops = {
+static const struct file_operations via_mixer_fops = {
 	.owner		= THIS_MODULE,
 	.open		= via_mixer_open,
 	.llseek		= no_llseek,
@@ -2042,7 +2042,7 @@ static int via_interrupt_init (struct vi
  *
  */
 
-static struct file_operations via_dsp_fops = {
+static const struct file_operations via_dsp_fops = {
 	.owner		= THIS_MODULE,
 	.open		= via_dsp_open,
 	.release	= via_dsp_release,
Index: linux-2.6/sound/oss/vwsnd.c
===================================================================
--- linux-2.6.orig/sound/oss/vwsnd.c
+++ linux-2.6/sound/oss/vwsnd.c
@@ -3035,7 +3035,7 @@ static int vwsnd_audio_release(struct in
 	return err;
 }
 
-static struct file_operations vwsnd_audio_fops = {
+static const struct file_operations vwsnd_audio_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.read =		vwsnd_audio_read,
@@ -3225,7 +3225,7 @@ static int vwsnd_mixer_ioctl(struct inod
 	return retval;
 }
 
-static struct file_operations vwsnd_mixer_fops = {
+static const struct file_operations vwsnd_mixer_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.ioctl =	vwsnd_mixer_ioctl,
Index: linux-2.6/sound/sound_core.c
===================================================================
--- linux-2.6.orig/sound/sound_core.c
+++ linux-2.6/sound/sound_core.c
@@ -436,7 +436,7 @@ EXPORT_SYMBOL(unregister_sound_dsp);
 
 static int soundcore_open(struct inode *, struct file *);
 
-static struct file_operations soundcore_fops=
+static const struct file_operations soundcore_fops=
 {
 	/* We must have an owner or the module locking fails */
 	.owner	= THIS_MODULE,
Index: linux-2.6/drivers/s390/char/tape_class.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_class.c
+++ linux-2.6/drivers/s390/char/tape_class.c
@@ -36,7 +36,7 @@ static struct class *tape_class;
 struct tape_class_device *register_tape_dev(
 	struct device *		device,
 	dev_t			dev,
-	struct file_operations *fops,
+	const struct file_operations *fops,
 	char *			device_name,
 	char *			mode_name)
 {
Index: linux-2.6/drivers/s390/char/tape_class.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_class.h
+++ linux-2.6/drivers/s390/char/tape_class.h
@@ -52,7 +52,7 @@ struct tape_class_device {
 struct tape_class_device *register_tape_dev(
 	struct device *		device,
 	dev_t			dev,
-	struct file_operations *fops,
+	const struct file_operations *fops,
 	char *			device_name,
 	char *			node_name
 );
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -149,7 +149,7 @@ long spufs_run_spu(struct file *file,
 		   struct spu_context *ctx, u32 *npc, u32 *status);
 long spufs_create(struct nameidata *nd,
 			 unsigned int flags, mode_t mode);
-extern struct file_operations spufs_context_fops;
+extern const struct file_operations spufs_context_fops;
 
 /* gang management */
 struct spu_gang *alloc_spu_gang(void);


