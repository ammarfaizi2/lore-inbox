Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTAQPsY>; Fri, 17 Jan 2003 10:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTAQPsX>; Fri, 17 Jan 2003 10:48:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50430 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267535AbTAQPsE>; Fri, 17 Jan 2003 10:48:04 -0500
Date: Fri, 17 Jan 2003 16:56:55 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: perex@suse.cz, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] ALSA: remove #if'd kernel 2.2 code
Message-ID: <20030117155655.GE2333@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

the patch below removes #if'd code for kernel 2.2 (and in one place for 
kernel < 2.4.18) from ALSA.

I've tested the compilation with 2.5.59.

Please apply
Adrian

--- linux-2.5.59-full/sound/pci/trident/trident_main.c.old	2003-01-17 15:45:19.000000000 +0100
+++ linux-2.5.59-full/sound/pci/trident/trident_main.c	2003-01-17 15:46:04.000000000 +0100
@@ -40,9 +40,7 @@
 #include <sound/control.h>
 #include <sound/trident.h>
 #include <sound/asoundef.h>
-#ifndef LINUX_2_2
 #include <linux/gameport.h>
-#endif
 
 #include <asm/io.h>
 
@@ -2987,7 +2985,6 @@
 /*
  * gameport interface
  */
-#ifndef LINUX_2_2
 
 typedef struct snd_trident_gameport {
 	struct gameport info;
@@ -3072,11 +3069,6 @@
 	gameport_register_port(&gp->info);
 }
 
-#else
-void __devinit snd_trident_gameport(trident_t *chip)
-{
-}
-#endif
 
 /*
  *  SiS reset routine
@@ -3482,12 +3474,10 @@
 
 int snd_trident_free(trident_t *trident)
 {
-#ifndef LINUX_2_2
 	if (trident->gameport) {
 		gameport_unregister_port(&trident->gameport->info);
 		kfree(trident->gameport);
 	}
-#endif
 	snd_trident_disable_eso(trident);
 	// Disable S/PDIF out
 	if (trident->device == TRIDENT_DEVICE_ID_NX)
--- linux-2.5.59-full/sound/pci/cs46xx/cs46xx_lib.c.old	2003-01-17 15:46:36.000000000 +0100
+++ linux-2.5.59-full/sound/pci/cs46xx/cs46xx_lib.c	2003-01-17 15:47:10.000000000 +0100
@@ -57,9 +57,7 @@
 #include <sound/control.h>
 #include <sound/info.h>
 #include <sound/cs46xx.h>
-#ifndef LINUX_2_2
 #include <linux/gameport.h>
-#endif
 
 #include <asm/io.h>
 
@@ -2740,7 +2738,6 @@
  * gameport interface
  */
 
-#ifndef LINUX_2_2
 
 typedef struct snd_cs46xx_gameport {
 	struct gameport info;
@@ -2824,14 +2821,6 @@
 	gameport_register_port(&gp->info);
 }
 
-#else /* LINUX_2_2 */
-
-void __devinit snd_cs46xx_gameport(cs46xx_t *chip)
-{
-}
-
-#endif /* !LINUX_2_2 */
-
 /*
  *  proc interface
  */
@@ -2972,12 +2961,10 @@
 	if (chip->active_ctrl)
 		chip->active_ctrl(chip, 1);
 
-#ifndef LINUX_2_2
 	if (chip->gameport) {
 		gameport_unregister_port(&chip->gameport->info);
 		kfree(chip->gameport);
 	}
-#endif
 #ifdef CONFIG_PM
 	if (chip->pm_dev)
 		pm_unregister(chip->pm_dev);
--- linux-2.5.59-full/sound/pci/maestro3.c.old	2003-01-17 15:47:44.000000000 +0100
+++ linux-2.5.59-full/sound/pci/maestro3.c	2003-01-17 15:48:11.000000000 +0100
@@ -2548,13 +2548,8 @@
 	chip->pci = pci;
 	chip->irq = -1;
 
-#ifndef LINUX_2_2
 	subsystem_vendor = pci->subsystem_vendor;
 	subsystem_device = pci->subsystem_device;
-#else
-	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vendor);
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);
-#endif
 	for (quirk = m3_quirk_list; quirk->vendor; quirk++) {
 		if (subsystem_vendor == quirk->vendor &&
 		    subsystem_device == quirk->device) {
--- linux-2.5.59-full/sound/pci/es1938.c.old	2003-01-17 15:48:32.000000000 +0100
+++ linux-2.5.59-full/sound/pci/es1938.c	2003-01-17 15:49:01.000000000 +0100
@@ -59,9 +59,7 @@
 #include <sound/mpu401.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
-#ifndef LINUX_2_2
 #include <linux/gameport.h>
-#endif
 
 #include <asm/io.h>
 
@@ -248,9 +246,7 @@
 	spinlock_t mixer_lock;
         snd_info_entry_t *proc_entry;
 
-#ifndef LINUX_2_2
 	struct gameport gameport;
-#endif
 };
 
 static void snd_es1938_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -1328,10 +1324,8 @@
 
 static int snd_es1938_free(es1938_t *chip)
 {
-#ifndef LINUX_2_2
 	if (chip->gameport.io)
 		gameport_unregister_port(&chip->gameport);
-#endif
 	if (chip->res_io_port) {
 		release_resource(chip->res_io_port);
 		kfree_nocheck(chip->res_io_port);
@@ -1645,10 +1639,8 @@
 				chip->mpu_port, 1, chip->irq, 0, &chip->rmidi) < 0) {
 		printk(KERN_ERR "es1938: unable to initialize MPU-401\n");
 	}
-#ifndef LINUX_2_2
 	chip->gameport.io = chip->game_port;
 	gameport_register_port(&chip->gameport);
-#endif
 
 	strcpy(card->driver, "ES1938");
 	strcpy(card->shortname, "ESS ES1938 (Solo-1)");
--- linux-2.5.59-full/sound/pci/sonicvibes.c.old	2003-01-17 15:49:24.000000000 +0100
+++ linux-2.5.59-full/sound/pci/sonicvibes.c	2003-01-17 15:49:50.000000000 +0100
@@ -37,9 +37,7 @@
 #include <sound/opl3.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
-#ifndef LINUX_2_2
 #include <linux/gameport.h>
-#endif
 
 #include <asm/io.h>
 
@@ -257,9 +255,7 @@
 	snd_kcontrol_t *master_mute;
 	snd_kcontrol_t *master_volume;
 
-#ifndef LINUX_2_2
 	struct gameport gameport;
-#endif
 };
 
 static struct pci_device_id snd_sonic_ids[] __devinitdata = {
@@ -1208,10 +1204,8 @@
 
 static int snd_sonicvibes_free(sonicvibes_t *sonic)
 {
-#ifndef LINUX_2_2
 	if (sonic->gameport.io)
 		gameport_unregister_port(&sonic->gameport);
-#endif
 	snd_sonicvibes_proc_done(sonic);
 	pci_write_config_dword(sonic->pci, 0x40, sonic->dmaa_port);
 	pci_write_config_dword(sonic->pci, 0x48, sonic->dmac_port);
@@ -1512,10 +1506,8 @@
 		snd_card_free(card);
 		return err;
 	}
-#ifndef LINUX_2_2
 	sonic->gameport.io = sonic->game_port;
 	gameport_register_port(&sonic->gameport);
-#endif
 	strcpy(card->driver, "SonicVibes");
 	strcpy(card->shortname, "S3 SonicVibes");
 	sprintf(card->longname, "%s rev %i at 0x%lx, irq %i",
--- linux-2.5.59-full/sound/pci/cs4281.c.old	2003-01-17 15:50:12.000000000 +0100
+++ linux-2.5.59-full/sound/pci/cs4281.c	2003-01-17 15:51:23.000000000 +0100
@@ -35,9 +35,7 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
-#ifndef LINUX_2_2
 #include <linux/gameport.h>
-#endif
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Cirrus Logic CS4281");
@@ -1309,7 +1307,6 @@
  * joystick support
  */
 
-#ifndef LINUX_2_2
 
 typedef struct snd_cs4281_gameport {
 	struct gameport info;
@@ -1399,8 +1396,6 @@
 	gameport_register_port(&gp->info);
 }
 
-#endif /* !LINUX_2_2 */
-
 
 /*
 
@@ -1408,12 +1403,10 @@
 
 static int snd_cs4281_free(cs4281_t *chip)
 {
-#ifndef LINUX_2_2
 	if (chip->gameport) {
 		gameport_unregister_port(&chip->gameport->info);
 		kfree(chip->gameport);
 	}
-#endif
 	snd_cs4281_proc_done(chip);
 	if (chip->irq >= 0)
 		synchronize_irq(chip->irq);
@@ -2041,9 +2034,7 @@
 		snd_card_free(card);
 		return err;
 	}
-#ifndef LINUX_2_2
 	snd_cs4281_gameport(chip);
-#endif
 	strcpy(card->driver, "CS4281");
 	strcpy(card->shortname, "Cirrus Logic CS4281");
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
--- linux-2.5.59-full/sound/core/seq/oss/seq_oss_init.c.old	2003-01-17 15:51:56.000000000 +0100
+++ linux-2.5.59-full/sound/core/seq/oss/seq_oss_init.c	2003-01-17 15:52:17.000000000 +0100
@@ -275,9 +275,6 @@
 
 	client_table[dp->index] = dp;
 	num_clients++;
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 
 	debug_printk(("open done\n"));
 
@@ -434,9 +431,6 @@
 	if (dp->queue >= 0)
 		delete_seq_queue(dp);
 
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	debug_printk(("release done\n"));
 }
 
--- linux-2.5.59-full/sound/core/seq/oss/seq_oss.c.old	2003-01-17 15:52:43.000000000 +0100
+++ linux-2.5.59-full/sound/core/seq/oss/seq_oss.c	2003-01-17 15:52:57.000000000 +0100
@@ -194,9 +194,7 @@
 
 static struct file_operations seq_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		odev_read,
 	.write =	odev_write,
 	.open =		odev_open,
--- linux-2.5.59-full/sound/core/seq/seq_clientmgr.c.old	2003-01-17 15:53:38.000000000 +0100
+++ linux-2.5.59-full/sound/core/seq/seq_clientmgr.c	2003-01-17 15:54:03.000000000 +0100
@@ -339,10 +339,6 @@
 	/* make others aware this new client */
 	snd_seq_system_client_ev_client_start(c);
 
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
-
 	return 0;
 }
 
@@ -358,9 +354,6 @@
 		kfree(client);
 	}
 
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -2467,9 +2460,7 @@
 
 static struct file_operations snd_seq_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_seq_read,
 	.write =	snd_seq_write,
 	.open =		snd_seq_open,
--- linux-2.5.59-full/sound/core/hwdep.c.old	2003-01-17 15:54:25.000000000 +0100
+++ linux-2.5.59-full/sound/core/hwdep.c	2003-01-17 15:54:35.000000000 +0100
@@ -237,9 +237,7 @@
 
 static struct file_operations snd_hwdep_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner = 	THIS_MODULE,
-#endif
 	.llseek =	snd_hwdep_llseek,
 	.read = 	snd_hwdep_read,
 	.write =	snd_hwdep_write,
--- linux-2.5.59-full/sound/core/oss/mixer_oss.c.old	2003-01-17 15:55:13.000000000 +0100
+++ linux-2.5.59-full/sound/core/oss/mixer_oss.c	2003-01-17 15:55:46.000000000 +0100
@@ -56,14 +56,8 @@
 	fmixer->card = card;
 	fmixer->mixer = card->mixer_oss;
 	file->private_data = fmixer;
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	if (!try_module_get(card->module)) {
 		kfree(fmixer);
-#ifdef LINUX_2_2
-		MOD_DEC_USE_COUNT;
-#endif
 		snd_card_file_remove(card, file);
 		return -EFAULT;
 	}
@@ -77,9 +71,6 @@
 	if (file->private_data) {
 		fmixer = (snd_mixer_oss_file_t *) file->private_data;
 		module_put(fmixer->card->module);
-#ifdef LINUX_2_2
-		MOD_DEC_USE_COUNT;
-#endif
 		snd_card_file_remove(fmixer->card, file);
 		kfree(fmixer);
 	}
@@ -384,9 +375,7 @@
 
 static struct file_operations snd_mixer_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_mixer_oss_open,
 	.release =	snd_mixer_oss_release,
 	.ioctl =	snd_mixer_oss_ioctl,
--- linux-2.5.59-full/sound/core/oss/pcm_oss.c.old	2003-01-17 15:56:08.000000000 +0100
+++ linux-2.5.59-full/sound/core/oss/pcm_oss.c	2003-01-17 15:57:55.000000000 +0100
@@ -1540,9 +1540,6 @@
 	device = SNDRV_MINOR_OSS_DEVICE(minor) == SNDRV_MINOR_OSS_PCM1 ?
 		adsp_map[cardnum] : dsp_map[cardnum];
 
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	pcm = snd_pcm_devices[(cardnum * SNDRV_PCM_DEVICES) + device];
 	if (pcm == NULL) {
 		err = -ENODEV;
@@ -1615,9 +1612,6 @@
       __error2:
       	snd_card_file_remove(pcm->card, file);
       __error1:
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return err;
 }
 
@@ -1640,9 +1634,6 @@
 	wake_up(&pcm->open_wait);
 	module_put(pcm->card->module);
 	snd_card_file_remove(pcm->card, file);
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -1924,11 +1915,7 @@
 	if (runtime->oss.plugin_first != NULL)
 		return -EIO;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	if (area->vm_pgoff != 0)
-#else
-	if (area->vm_offset != 0)
-#endif
 		return -EINVAL;
 
 	err = snd_pcm_mmap_data(substream, file, area);
@@ -2091,9 +2078,7 @@
 
 static struct file_operations snd_pcm_oss_f_reg =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_oss_read,
 	.write =	snd_pcm_oss_write,
 	.open =		snd_pcm_oss_open,
--- linux-2.5.59-full/sound/core/rawmidi.c.old	2003-01-17 15:58:44.000000000 +0100
+++ linux-2.5.59-full/sound/core/rawmidi.c	2003-01-17 15:59:11.000000000 +0100
@@ -181,9 +181,6 @@
 
 	if (rfile)
 		rfile->input = rfile->output = NULL;
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	rmidi = snd_rawmidi_devices[(cardnum * SNDRV_RAWMIDI_DEVICES) + device];
 	if (rmidi == NULL) {
 		err = -ENODEV;
@@ -342,9 +339,6 @@
 	module_put(rmidi->card->module);
 	up(&rmidi->open_mutex);
       __error1:
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return err;
 }
 
@@ -499,9 +493,6 @@
 	}
 	up(&rmidi->open_mutex);
 	module_put(rmidi->card->module);
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -1273,9 +1264,7 @@
 
 static struct file_operations snd_rawmidi_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_rawmidi_read,
 	.write =	snd_rawmidi_write,
 	.open =		snd_rawmidi_open,
--- linux-2.5.59-full/sound/core/control.c.old	2003-01-17 15:59:35.000000000 +0100
+++ linux-2.5.59-full/sound/core/control.c	2003-01-17 16:00:05.000000000 +0100
@@ -48,9 +48,6 @@
 	snd_ctl_file_t *ctl;
 	int err;
 
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	card = snd_cards[cardnum];
 	if (!card) {
 		err = -ENODEV;
@@ -86,9 +83,6 @@
       __error2:
 	snd_card_file_remove(card, file);
       __error1:
-#ifdef LINUX_2_2
-      	MOD_DEC_USE_COUNT;
-#endif
       	return err;
 }
 
@@ -131,9 +125,6 @@
 	snd_magic_kfree(ctl);
 	module_put(card->module);
 	snd_card_file_remove(card, file);
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -789,9 +780,7 @@
 
 static struct file_operations snd_ctl_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
--- linux-2.5.59-full/sound/core/init.c.old	2003-01-17 16:00:38.000000000 +0100
+++ linux-2.5.59-full/sound/core/init.c	2003-01-17 16:00:54.000000000 +0100
@@ -181,9 +181,7 @@
 		f_ops = &s_f_ops->f_ops;
 
 		memset(f_ops, 0, sizeof(*f_ops));
-#ifndef LINUX_2_2
 		f_ops->owner = file->f_op->owner;
-#endif
 		f_ops->release = file->f_op->release;
 		f_ops->poll = snd_disconnect_poll;
 
--- linux-2.5.59-full/sound/core/pcm_native.c.old	2003-01-17 16:01:13.000000000 +0100
+++ linux-2.5.59-full/sound/core/pcm_native.c	2003-01-17 16:04:41.000000000 +0100
@@ -1779,9 +1779,6 @@
 	snd_pcm_file_t *pcm_file;
 	wait_queue_t wait;
 
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	snd_runtime_check(device >= SNDRV_MINOR_PCM_PLAYBACK && device < SNDRV_MINOR_DEVICES, return -ENXIO);
 	pcm = snd_pcm_devices[(cardnum * SNDRV_PCM_DEVICES) + (device % SNDRV_MINOR_PCMS)];
 	if (pcm == NULL) {
@@ -1829,9 +1826,6 @@
       __error2:
       	snd_card_file_remove(pcm->card, file);
       __error1:
-#ifdef LINUX_2_2
-      	MOD_DEC_USE_COUNT;
-#endif
       	return err;
 }
 
@@ -1857,9 +1851,6 @@
 	wake_up(&pcm->open_wait);
 	module_put(pcm->card->module);
 	snd_card_file_remove(pcm->card, file);
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -2323,9 +2314,6 @@
 	snd_pcm_runtime_t *runtime;
 	snd_pcm_sframes_t result;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	up(&file->f_dentry->d_inode->i_sem);
-#endif
 	pcm_file = snd_magic_cast(snd_pcm_file_t, file->private_data, result = -ENXIO; goto end);
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
@@ -2343,13 +2331,9 @@
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
  end:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	down(&file->f_dentry->d_inode->i_sem);
-#endif
 	return result;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 static ssize_t snd_pcm_readv(struct file *file, const struct iovec *_vector,
 			     unsigned long count, loff_t * offset)
 
@@ -2396,9 +2380,6 @@
 	void **bufs;
 	snd_pcm_uframes_t frames;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	up(&file->f_dentry->d_inode->i_sem);
-#endif
 	pcm_file = snd_magic_cast(snd_pcm_file_t, file->private_data, result = -ENXIO; goto end);
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
@@ -2423,12 +2404,8 @@
 		result = frames_to_bytes(runtime, result);
 	kfree(bufs);
  end:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	down(&file->f_dentry->d_inode->i_sem);
-#endif
 	return result;
 }
-#endif
 
 unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 {
@@ -2511,21 +2488,13 @@
 }
 
 #ifndef VM_RESERVED
-#ifndef LINUX_2_2
 static int snd_pcm_mmap_swapout(struct page * page, struct file * file)
-#else
-static int snd_pcm_mmap_swapout(struct vm_area_struct * area, struct page * page)
-#endif
 {
 	return 0;
 }
 #endif
 
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2536,11 +2505,7 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_status =
@@ -2564,22 +2529,14 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
 	return 0;
 }
 
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2590,11 +2547,7 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_control =
@@ -2618,11 +2571,7 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_control_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_control;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
@@ -2641,11 +2590,7 @@
 	atomic_dec(&substream->runtime->mmap_count);
 }
 
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2657,11 +2602,7 @@
 	if (substream == NULL)
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	offset += address - area->vm_start;
 	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
@@ -2676,11 +2617,7 @@
 		page = virt_to_page(vaddr);
 	}
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_data =
@@ -2718,11 +2655,7 @@
 	    runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (size > dma_bytes)
 		return -EINVAL;
@@ -2730,11 +2663,7 @@
 		return -EINVAL;
 
 	area->vm_ops = &snd_pcm_vm_ops_data;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
@@ -2752,11 +2681,7 @@
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, return -ENXIO);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
 		return snd_pcm_mmap_status(substream, file, area);
@@ -2864,13 +2789,9 @@
  */
 
 static struct file_operations snd_pcm_f_ops_playback = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.write =	snd_pcm_write,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.writev =	snd_pcm_writev,
-#endif
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_playback_poll,
@@ -2880,13 +2801,9 @@
 };
 
 static struct file_operations snd_pcm_f_ops_capture = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_read,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.readv =	snd_pcm_readv,
-#endif
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_capture_poll,
--- linux-2.5.59-full/sound/core/timer.c.old	2003-01-17 16:05:36.000000000 +0100
+++ linux-2.5.59-full/sound/core/timer.c	2003-01-17 16:06:06.000000000 +0100
@@ -942,9 +942,6 @@
 		return -ENOMEM;
 	}
 	file->private_data = tu;
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -961,9 +958,6 @@
 			kfree(tu->queue);
 		snd_magic_kfree(tu);
 	}
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
@@ -1324,9 +1318,7 @@
 
 static struct file_operations snd_timer_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
--- linux-2.5.59-full/sound/core/sound.c.old	2003-01-17 16:06:28.000000000 +0100
+++ linux-2.5.59-full/sound/core/sound.c	2003-01-17 16:07:04.000000000 +0100
@@ -155,9 +155,7 @@
 
 struct file_operations snd_fops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_open
 };
 
@@ -312,12 +310,8 @@
 		return err;
 #endif
 #ifdef CONFIG_DEVFS_FS
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-	devfs_handle = devfs_mk_dir(NULL, "snd", 3, NULL);
-#else
 	devfs_handle = devfs_mk_dir(NULL, "snd", NULL);
 #endif
-#endif
 	if (register_chrdev(major, "alsa", &snd_fops)) {
 		snd_printk(KERN_ERR "unable to register native major device number %d\n", major);
 		return -EIO;
@@ -345,9 +339,6 @@
 #ifndef MODULE
 	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
 #endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) && defined(CONFIG_APM)
-	pm_init();
-#endif
 	return 0;
 }
 
@@ -362,9 +353,6 @@
 	snd_info_minor_unregister();
 #endif
 	snd_info_done();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) && defined(CONFIG_APM)
-	pm_done();
-#endif
 #ifdef CONFIG_SND_DEBUG_MEMORY
 	snd_memory_done();
 #endif
--- linux-2.5.59-full/sound/core/info.c.old	2003-01-17 16:07:25.000000000 +0100
+++ linux-2.5.59-full/sound/core/info.c	2003-01-17 16:09:23.000000000 +0100
@@ -119,27 +119,6 @@
 snd_info_entry_t *snd_oss_root = NULL;
 #endif
 
-#ifdef LINUX_2_2
-static void snd_info_fill_inode(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-
-static inline void snd_info_entry_prepare(struct proc_dir_entry *de)
-{
-	de->fill_inode = snd_info_fill_inode;
-}
-
-void snd_remove_proc_entry(struct proc_dir_entry *parent,
-			   struct proc_dir_entry *de)
-{
-	if (parent && de)
-		proc_unregister(parent, de->low_ino);
-}
-#else
 static inline void snd_info_entry_prepare(struct proc_dir_entry *de)
 {
 	de->owner = THIS_MODULE;
@@ -151,7 +130,6 @@
 	if (de)
 		remove_proc_entry(de->name, parent);
 }
-#endif
 
 static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 {
@@ -293,9 +271,6 @@
 		up(&info_mutex);
 		return -ENODEV;
 	}
-#ifdef LINUX_2_2
-	MOD_INC_USE_COUNT;
-#endif
 	if (!try_module_get(entry->module)) {
 		err = -EFAULT;
 		goto __error1;
@@ -403,9 +378,6 @@
       __error:
 	module_put(entry->module);
       __error1:
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	up(&info_mutex);
 	return err;
 }
@@ -445,9 +417,6 @@
 		break;
 	}
 	module_put(entry->module);
-#ifdef LINUX_2_2
-	MOD_DEC_USE_COUNT;
-#endif
 	snd_magic_kfree(data);
 	return 0;
 }
@@ -522,9 +491,7 @@
 
 static struct file_operations snd_info_entry_operations =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.llseek =	snd_info_entry_llseek,
 	.read =		snd_info_entry_read,
 	.write =	snd_info_entry_write,
@@ -535,67 +502,22 @@
 	.release =	snd_info_entry_release,
 };
 
-#ifdef LINUX_2_2
-static struct inode_operations snd_info_entry_inode_operations =
-{
-	&snd_info_entry_operations,	/* default sound info directory file-ops */
-};
-
-static struct inode_operations snd_info_device_inode_operations =
-{
-	&snd_fops,		/* default sound info directory file-ops */
-};
-#endif	/* LINUX_2_2 */
-
 static int snd_info_card_readlink(struct dentry *dentry,
 				  char *buffer, int buflen)
 {
         char *s = PDE(dentry->d_inode)->data;
-#ifndef LINUX_2_2
 	return vfs_readlink(dentry, buffer, buflen, s);
-#else
-	int len;
-	
-	if (s == NULL)
-		return -EIO;
-	len = strlen(s);
-	if (len > buflen)
-		len = buflen;
-	if (copy_to_user(buffer, s, len))
-		return -EFAULT;
-	return len;
-#endif
 }
 
-#ifndef LINUX_2_2
 static int snd_info_card_followlink(struct dentry *dentry,
 				    struct nameidata *nd)
 {
         char *s = PDE(dentry->d_inode)->data;
         return vfs_follow_link(nd, s);
 }
-#else
-static struct dentry *snd_info_card_followlink(struct dentry *dentry,
-					       struct dentry *base,
-					       unsigned int follow)
-{
-	char *s = PDE(dentry->d_inode)->data;
-	return lookup_dentry(s, base, follow);
-}
-#endif
-
-#ifdef LINUX_2_2
-static struct file_operations snd_info_card_link_operations =
-{
-	NULL
-};
-#endif
 
 struct inode_operations snd_info_card_link_inode_operations =
 {
-#ifdef LINUX_2_2
-	.default_file_ops =	&snd_info_card_link_operations,
-#endif
 	.readlink =		snd_info_card_readlink,
 	.follow_link =		snd_info_card_followlink,
 };
@@ -727,12 +649,8 @@
 	if (p == NULL)
 		return -ENOMEM;
 	p->data = s;
-#ifndef LINUX_2_2
 	p->owner = card->module;
 	p->proc_iops = &snd_info_card_link_inode_operations;
-#else
-	p->ops = &snd_info_card_link_inode_operations;
-#endif
 	card->proc_root_link = p;
 	return 0;
 }
@@ -867,39 +785,11 @@
 	kfree(entry);
 }
 
-#ifdef LINUX_2_2
-static void snd_info_device_fill_inode(struct inode *inode, int fill)
-{
-	struct proc_dir_entry *de;
-	snd_info_entry_t *entry;
-
-	if (!fill) {
-		MOD_DEC_USE_COUNT;
-		return;
-	}
-	MOD_INC_USE_COUNT;
-	de = PDE(inode);
-	if (de == NULL)
-		return;
-	entry = (snd_info_entry_t *) de->data;
-	if (entry == NULL)
-		return;
-	inode->i_gid = device_gid;
-	inode->i_uid = device_uid;
-	inode->i_rdev = MKDEV(entry->c.device.major, entry->c.device.minor);
-}
-
-static inline void snd_info_device_entry_prepare(struct proc_dir_entry *de, snd_info_entry_t *entry)
-{
-	de->fill_inode = snd_info_device_fill_inode;
-}
-#else
 static inline void snd_info_device_entry_prepare(struct proc_dir_entry *de, snd_info_entry_t *entry)
 {
 	de->rdev = mk_kdev(entry->c.device.major, entry->c.device.minor);
 	de->owner = THIS_MODULE;
 }
-#endif /* LINUX_2_2 */
 
 snd_info_entry_t *snd_info_create_device(const char *name, unsigned int number, unsigned int mode)
 {
@@ -927,9 +817,6 @@
 	p = create_proc_entry(entry->name, entry->mode, snd_proc_dev);
 	if (p) {
 		snd_info_device_entry_prepare(p, entry);
-#ifdef LINUX_2_2
-		p->ops = &snd_info_device_inode_operations;
-#endif
 	} else {
 		up(&info_mutex);
 		snd_info_free_entry(entry);
@@ -974,15 +861,9 @@
 		up(&info_mutex);
 		return -ENOMEM;
 	}
-#ifndef LINUX_2_2
 	p->owner = entry->module;
-#endif
 	if (!S_ISDIR(entry->mode)) {
-#ifndef LINUX_2_2
 		p->proc_fops = &snd_info_entry_operations;
-#else
-		p->ops = &snd_info_entry_inode_operations;
-#endif
 	}
 	p->size = entry->size;
 	p->data = entry;
--- linux-2.5.59-full/sound/core/seq/seq_memory.c.old	2003-01-17 16:10:38.000000000 +0100
+++ linux-2.5.59-full/sound/core/seq/seq_memory.c	2003-01-17 16:11:01.000000000 +0100
@@ -235,18 +235,7 @@
 	while (pool->free == NULL && ! nonblock && ! pool->closing) {
 
 		spin_unlock(&pool->lock);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-		/* change semaphore to allow other clients
-		   to access device file */
-		if (file)
-			up(&semaphore_of(file));
-#endif
 		interruptible_sleep_on(&pool->output_sleep);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-		/* restore semaphore again */
-		if (file)
-			down(&semaphore_of(file));
-#endif
 		spin_lock(&pool->lock);
 		/* interrupted? */
 		if (signal_pending(current)) {
--- linux-2.5.59-full/sound/core/wrappers.c.old	2003-01-17 16:11:33.000000000 +0100
+++ linux-2.5.59-full/sound/core/wrappers.c	2003-01-17 16:13:03.000000000 +0100
@@ -51,7 +51,6 @@
 
 
 /* check the condition in <sound/core.h> !! */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
 #if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
 
 #include <linux/pci.h>
@@ -104,4 +103,3 @@
 }
 
 #endif
-#endif
--- linux-2.5.59-full/sound/core/rtctimer.c.old	2003-01-17 16:13:30.000000000 +0100
+++ linux-2.5.59-full/sound/core/rtctimer.c	2003-01-17 16:13:56.000000000 +0100
@@ -31,11 +31,7 @@
 
 #if defined(CONFIG_RTC) || defined(CONFIG_RTC_MODULE)
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 2, 12)	/* FIXME: which 2.2.x kernel? */
-#include <linux/rtc.h>
-#else
 #include <linux/mc146818rtc.h>
-#endif
 
 /* use tasklet for interrupt handling */
 #define USE_TASKLET
--- linux-2.5.59-full/sound/pci/rme9652/hammerfall_mem.c.old	2003-01-17 16:14:35.000000000 +0100
+++ linux-2.5.59-full/sound/pci/rme9652/hammerfall_mem.c	2003-01-17 16:15:03.000000000 +0100
@@ -98,15 +98,7 @@
 {
 	void *res;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 3, 0)
 	res = (void *) pci_alloc_consistent(pci, size, dmaaddr);
-#else
-	int pg;
-	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-	res = (void *)__get_free_pages(GFP_KERNEL, pg);
-	if (res != NULL)
-		*dmaaddr = virt_to_bus(res);
-#endif
 	if (res != NULL) {
 		struct page *page = virt_to_page(res);
 		struct page *last_page = page + (size + PAGE_SIZE - 1) / PAGE_SIZE;
@@ -127,19 +119,7 @@
 	last_page = virt_to_page(ptr) + (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	while (page < last_page)
 		clear_bit(PG_reserved, &(page++)->flags);
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 3, 0)
 	pci_free_consistent(pci, size, ptr, dmaaddr);
-#else
-	{
-		int pg;
-		for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-		if (bus_to_virt(dmaaddr) != ptr) {
-			printk(KERN_ERR "hammerfall_free_pages: dmaaddr != ptr\n");
-			return;
-		}
-		free_pages((unsigned long)ptr, pg);
-	}
-#endif
 }
 
 void *snd_hammerfall_get_buffer (struct pci_dev *pcidev, dma_addr_t *dmaaddr)
--- linux-2.5.59-full/sound/ppc/awacs.c.old	2003-01-17 16:15:25.000000000 +0100
+++ linux-2.5.59-full/sound/ppc/awacs.c	2003-01-17 16:17:22.000000000 +0100
@@ -32,7 +32,7 @@
 #define chip_t pmac_t
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) || defined(CONFIG_ADB_CUDA)
+#ifdef CONFIG_ADB_CUDA
 #define PMAC_AMP_AVAIL
 #endif
 
@@ -43,12 +43,6 @@
 	unsigned char amp_tone[2];
 } awacs_amp_t;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define CHECK_CUDA_AMP() (adb_hardware == ADB_VIACUDA)
-#else
-#define CHECK_CUDA_AMP() (sys_ctrler == SYS_CTRLER_CUDA)
-#endif
-
 #endif /* PMAC_AMP_AVAIL */
 
 
@@ -752,7 +746,7 @@
 
 	chip->revision = (in_le32(&chip->awacs->codec_stat) >> 12) & 0xf;
 #ifdef PMAC_AMP_AVAIL
-	if (chip->revision == 3 && chip->has_iic && CHECK_CUDA_AMP()) {
+	if (chip->revision == 3 && chip->has_iic && sys_ctrler == SYS_CTRLER_CUDA) {
 		awacs_amp_t *amp = kmalloc(sizeof(*amp), GFP_KERNEL);
 		if (! amp)
 			return -ENOMEM;
--- linux-2.5.59-full/sound/ppc/pmac.h.old	2003-01-17 16:17:53.000000000 +0100
+++ linux-2.5.59-full/sound/ppc/pmac.h	2003-01-17 16:18:23.000000000 +0100
@@ -26,11 +26,6 @@
 #include <sound/pcm.h>
 #include "awacs.h"
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#include <asm/adb.h>
-#include <asm/cuda.h>
-#include <asm/pmu.h>
-#else /* 2.4.0 kernel */
 #include <linux/adb.h>
 #ifdef CONFIG_ADB_CUDA
 #include <linux/cuda.h>
@@ -38,7 +33,6 @@
 #ifdef CONFIG_ADB_PMU
 #include <linux/pmu.h>
 #endif
-#endif
 #include <linux/nvram.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
--- linux-2.5.59-full/sound/ppc/pmac.c.old	2003-01-17 16:19:08.000000000 +0100
+++ linux-2.5.59-full/sound/ppc/pmac.c	2003-01-17 16:19:35.000000000 +0100
@@ -35,16 +35,6 @@
 #include <asm/feature.h>
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define pmu_suspend()	/**/
-#define pmu_resume()	/**/
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
-#define request_OF_resource(io,num,str)  1
-#define release_OF_resource(io,num) /**/
-#endif
-
 
 #define chip_t pmac_t
 
--- linux-2.5.59-full/include/sound/driver.h.old	2003-01-17 16:20:09.000000000 +0100
+++ linux-2.5.59-full/include/sound/driver.h	2003-01-17 16:20:31.000000000 +0100
@@ -49,7 +49,6 @@
  *  ==========================================================================
  */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
 #if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
 /*
  * Here a dirty hack for 2.4 kernels.. See sound/core/memory.c.
@@ -61,7 +60,6 @@
 #undef pci_alloc_consistent
 #define pci_alloc_consistent snd_pci_hack_alloc_consistent
 #endif /* i386 or ppc */
-#endif /* 2.4.0 */
 
 #ifdef CONFIG_SND_DEBUG_MEMORY
 #include <linux/slab.h>
