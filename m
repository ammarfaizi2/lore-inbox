Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbWJGTMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWJGTMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWJGTMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:12:32 -0400
Received: from soundwarez.org ([217.160.171.123]:64643 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932777AbWJGTMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:12:31 -0400
Date: Sat, 7 Oct 2006 21:12:28 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: sysfs & ALSA card
Message-ID: <20061007191228.GA31396@vrfy.org>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz> <20061007062458.GF23366@kroah.com> <20061007074440.GA9304@kroah.com> <1160225730.19302.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160225730.19302.1.camel@localhost>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 02:55:31PM +0200, Kay Sievers wrote:
> On Sat, 2006-10-07 at 00:44 -0700, Greg KH wrote: 
> >  $ tree /sys/class/sound/
> >  /sys/class/sound/
> >  |-- Audigy2 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2
> >  |-- admmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/admmidi1

> > Yeah, I picked the wrong name for the card, it should be "card1" instead
> > of "Audigy2" here, but you get the idea.
> 
> That looks nice. Yeah, it should something that matches to the C1 in the
> other names.

This works fine for me with two soundcards and connect/disconnect
module load/unload.

All devices are in a flat list in the class directory, also the card%i
ones:
  $ tree /sys/class/sound/
  /sys/class/sound/
  |-- adsp -> ../../devices/pci0000:00/0000:00:1e.2/card0/adsp
  |-- audio -> ../../devices/pci0000:00/0000:00:1e.2/card0/audio
  |-- audio1 -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1/audio1
  |-- card0 -> ../../devices/pci0000:00/0000:00:1e.2/card0
  |-- card1 -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1
  |-- controlC0 -> ../../devices/pci0000:00/0000:00:1e.2/card0/controlC0
  |-- controlC1 -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1/controlC1
  |-- dsp -> ../../devices/pci0000:00/0000:00:1e.2/card0/dsp
  |-- dsp1 -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1/dsp1
  |-- mixer -> ../../devices/pci0000:00/0000:00:1e.2/card0/mixer
  |-- mixer1 -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1/mixer1
  |-- pcmC0D0c -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D0c
  |-- pcmC0D0p -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D0p
  |-- pcmC0D1c -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D1c
  |-- pcmC0D2c -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D2c
  |-- pcmC0D3c -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D3c
  |-- pcmC0D4p -> ../../devices/pci0000:00/0000:00:1e.2/card0/pcmC0D4p
  |-- pcmC1D0p -> ../../devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/card1/pcmC1D0p
  |-- seq -> ../../devices/virtual/sound/seq
  `-- timer -> ../../devices/virtual/sound/timer

In the /sys/devices hierarchy all devices belonging to the same card are
nicely below the card device:
  $ ls -l /sys/devices/pci0000:00/0000:00:1e.2/card0
  total 0
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 0-0:AD1981B
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 adsp
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 audio
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 controlC0
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 dsp
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 mixer
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D0c
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D0p
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D1c
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D2c
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D3c
  drwxr-xr-x 3 root root    0 2006-10-07 21:09 pcmC0D4p
  drwxr-xr-x 2 root root    0 2006-10-07 21:09 power
  lrwxrwxrwx 1 root root    0 2006-10-07 21:01 subsystem -> ../../../../subsystem/sound
  --w------- 1 root root 4096 2006-10-07 21:01 uevent

Kay


From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver core: convert sound core to use struct device

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

It also makes the struct sound_card to show up as a "real" device
where all the different sound class devices are placed as childs
and different card attribute files can hang off of. /sys/class/sound is
still a flat directory, but the symlink targets of all devices belonging
to the same card, point the the /sys/devices tree below the new card
device object.

Thanks to Kay for the updates to this patch.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@novell.com>

---
 include/sound/core.h  |    7 ++++---
 sound/core/init.c     |    4 ++++
 sound/core/pcm.c      |    7 ++++---
 sound/core/sound.c    |   19 +++++++++----------
 sound/oss/soundcard.c |   16 ++++++++--------
 sound/sound_core.c    |    6 +++---
 6 files changed, 32 insertions(+), 27 deletions(-)

--- linux-2.6.orig/include/sound/core.h
+++ linux-2.6/include/sound/core.h
@@ -132,6 +132,7 @@ struct snd_card {
 	int shutdown;			/* this card is going down */
 	int free_on_last_close;		/* free in context of file_release */
 	wait_queue_head_t shutdown_sleep;
+	struct device *parent;
 	struct device *dev;
 
 #ifdef CONFIG_PM
@@ -187,7 +188,7 @@ struct snd_minor {
 	int device;			/* device number */
 	const struct file_operations *f_ops;	/* file operations */
 	void *private_data;		/* private data for f_ops->open */
-	struct class_device *class_dev;	/* class device for sysfs */
+	struct device *dev;		/* device for sysfs */
 };
 
 /* sound.c */
@@ -203,7 +204,7 @@ int snd_register_device(int type, struct
 int snd_unregister_device(int type, struct snd_card *card, int dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
 int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      const struct class_device_attribute *attr);
+			      struct device_attribute *attr);
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
@@ -255,7 +256,7 @@ int snd_card_file_add(struct snd_card *c
 int snd_card_file_remove(struct snd_card *card, struct file *file);
 
 #ifndef snd_card_set_dev
-#define snd_card_set_dev(card,devptr) ((card)->dev = (devptr))
+#define snd_card_set_dev(card,devptr) ((card)->parent = (devptr))
 #endif
 
 /* device.c */
--- linux-2.6.orig/sound/core/init.c
+++ linux-2.6/sound/core/init.c
@@ -49,6 +49,8 @@ int (*snd_mixer_oss_notify_callback)(str
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 #endif
 
+extern struct class *sound_class;
+
 #ifdef CONFIG_PROC_FS
 static void snd_card_id_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
@@ -361,6 +363,7 @@ static int snd_card_do_free(struct snd_c
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
+	device_unregister(card->dev);
 	kfree(card);
 	return 0;
 }
@@ -495,6 +498,7 @@ int snd_card_register(struct snd_card *c
 	int err;
 
 	snd_assert(card != NULL, return -EINVAL);
+	card->dev = device_create(sound_class, card->parent, 0, "card%i", card->number);
 	if ((err = snd_device_register_all(card)) < 0)
 		return err;
 	mutex_lock(&snd_card_mutex);
--- linux-2.6.orig/sound/core/pcm.c
+++ linux-2.6/sound/core/pcm.c
@@ -910,7 +910,8 @@ void snd_pcm_detach_substream(struct snd
 	substream->pstr->substream_opened--;
 }
 
-static ssize_t show_pcm_class(struct class_device *class_device, char *buf)
+static ssize_t show_pcm_class(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct snd_pcm *pcm;
 	const char *str;
@@ -921,7 +922,7 @@ static ssize_t show_pcm_class(struct cla
 		[SNDRV_PCM_CLASS_DIGITIZER] = "digitizer",
 	};
 
-	if (! (pcm = class_get_devdata(class_device)) ||
+	if (! (pcm = dev_get_drvdata(dev)) ||
 	    pcm->dev_class > SNDRV_PCM_CLASS_LAST)
 		str = "none";
 	else
@@ -929,7 +930,7 @@ static ssize_t show_pcm_class(struct cla
         return snprintf(buf, PAGE_SIZE, "%s\n", str);
 }
 
-static struct class_device_attribute pcm_attrs =
+static struct device_attribute pcm_attrs =
 	__ATTR(pcm_class, S_IRUGO, show_pcm_class, NULL);
 
 static int snd_pcm_dev_register(struct snd_device *device)
--- linux-2.6.orig/sound/core/sound.c
+++ linux-2.6/sound/core/sound.c
@@ -268,11 +268,10 @@ int snd_register_device(int type, struct
 	snd_minors[minor] = preg;
 	if (card)
 		device = card->dev;
-	preg->class_dev = class_device_create(sound_class, NULL,
-					      MKDEV(major, minor),
-					      device, "%s", name);
-	if (preg->class_dev)
-		class_set_devdata(preg->class_dev, private_data);
+	preg->dev = device_create(sound_class, device, MKDEV(major, minor),
+				  "%s", name);
+	if (preg->dev)
+		dev_get_drvdata(preg->dev);
 
 	mutex_unlock(&sound_mutex);
 	return 0;
@@ -320,7 +319,7 @@ int snd_unregister_device(int type, stru
 		return -EINVAL;
 	}
 
-	class_device_destroy(sound_class, MKDEV(major, minor));
+	device_destroy(sound_class, MKDEV(major, minor));
 
 	kfree(snd_minors[minor]);
 	snd_minors[minor] = NULL;
@@ -331,15 +330,15 @@ int snd_unregister_device(int type, stru
 EXPORT_SYMBOL(snd_unregister_device);
 
 int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      const struct class_device_attribute *attr)
+			      struct device_attribute *attr)
 {
 	int minor, ret = -EINVAL;
-	struct class_device *cdev;
+	struct device *d;
 
 	mutex_lock(&sound_mutex);
 	minor = find_snd_minor(type, card, dev);
-	if (minor >= 0 && (cdev = snd_minors[minor]->class_dev) != NULL)
-		ret = class_device_create_file(cdev, attr);
+	if (minor >= 0 && (d = snd_minors[minor]->dev) != NULL)
+		ret = device_create_file(d, attr);
 	mutex_unlock(&sound_mutex);
 	return ret;
 
--- linux-2.6.orig/sound/oss/soundcard.c
+++ linux-2.6/sound/oss/soundcard.c
@@ -557,17 +557,17 @@ static int __init oss_init(void)
 	sound_dmap_flag = (dmabuf > 0 ? 1 : 0);
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		class_device_create(sound_class, NULL,
-				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
-				    NULL, "%s", dev_list[i].name);
+		device_create(sound_class, NULL,
+			      MKDEV(SOUND_MAJOR, dev_list[i].minor),
+			      "%s", dev_list[i].name);
 
 		if (!dev_list[i].num)
 			continue;
 
 		for (j = 1; j < *dev_list[i].num; j++)
-			class_device_create(sound_class, NULL,
-					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
-					    NULL, "%s%d", dev_list[i].name, j);
+			device_create(sound_class, NULL,
+				      MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
+				      "%s%d", dev_list[i].name, j);
 	}
 
 	if (sound_nblocks >= 1024)
@@ -581,11 +581,11 @@ static void __exit oss_cleanup(void)
 	int i, j;
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
+		device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
 		for (j = 1; j < *dev_list[i].num; j++)
-			class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
+			device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
 	}
 	
 	unregister_sound_special(1);
--- linux-2.6.orig/sound/sound_core.c
+++ linux-2.6/sound/sound_core.c
@@ -170,8 +170,8 @@ static int sound_insert_unit(struct soun
 	else
 		sprintf(s->name, "sound/%s%d", name, r / SOUND_STEP);
 
-	class_device_create(sound_class, NULL, MKDEV(SOUND_MAJOR, s->unit_minor),
-			    dev, s->name+6);
+	device_create(sound_class, dev, MKDEV(SOUND_MAJOR, s->unit_minor),
+		      s->name+6);
 	return r;
 
  fail:
@@ -193,7 +193,7 @@ static void sound_remove_unit(struct sou
 	p = __sound_remove_unit(list, unit);
 	spin_unlock(&sound_loader_lock);
 	if (p) {
-		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
+		device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }

