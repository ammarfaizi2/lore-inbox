Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVFLIqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVFLIqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 04:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVFLIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 04:46:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:34797 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261912AbVFLIoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 04:44:16 -0400
Date: Sun, 12 Jun 2005 10:44:04 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
To: Greg K-H <greg@kroah.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
In-Reply-To: <11184761113499@kroah.com>
Message-ID: <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
References: <11184761113499@kroah.com>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It didn't follow the development, is devfs now obsolete in kernel?
If not, these funktions still makes sense.

Armin


On Sat, 11 Jun 2005, Greg KH wrote:
> Removes the devfs_mk_cdev() function and all callers of it.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  arch/sparc64/solaris/socksys.c          |    2 -
>  drivers/block/acsi_slm.c                |    6 ----
>  drivers/block/paride/pg.c               |   11 --------
>  drivers/block/paride/pt.c               |   16 -----------
>  drivers/char/dsp56k.c                   |    8 -----
>  drivers/char/dtlk.c                     |    3 --
>  drivers/char/ftape/zftape/zftape-init.c |   18 -------------
>  drivers/char/ip2main.c                  |   17 ------------
>  drivers/char/ipmi/ipmi_devintf.c        |    3 --
>  drivers/char/istallion.c                |    6 ----
>  drivers/char/lp.c                       |    2 -
>  drivers/char/mem.c                      |    7 +----
>  drivers/char/misc.c                     |    9 ------
>  drivers/char/ppdev.c                    |    4 --
>  drivers/char/raw.c                      |    8 -----
>  drivers/char/stallion.c                 |    6 ----
>  drivers/char/tipar.c                    |   10 -------
>  drivers/char/tty_io.c                   |    7 -----
>  drivers/char/vc_screen.c                |    8 -----
>  drivers/char/viotape.c                  |    4 --
>  drivers/i2c/i2c-dev.c                   |    2 -
>  drivers/ide/ide-tape.c                  |    7 -----
>  drivers/ieee1394/amdtp.c                |    3 --
>  drivers/ieee1394/dv1394.c               |   12 --------
>  drivers/ieee1394/raw1394.c              |    4 --
>  drivers/ieee1394/video1394.c            |    3 --
>  drivers/input/evdev.c                   |    2 -
>  drivers/input/joydev.c                  |    2 -
>  drivers/input/mousedev.c                |    4 --
>  drivers/input/tsdev.c                   |    4 --
>  drivers/isdn/capi/capi.c                |    2 -
>  drivers/isdn/hardware/eicon/divamnt.c   |    1 
>  drivers/isdn/hardware/eicon/divasi.c    |    1 
>  drivers/isdn/hardware/eicon/divasmain.c |    1 
>  drivers/macintosh/adb.c                 |    2 -
>  drivers/media/dvb/dvb-core/dvbdev.c     |    4 --
>  drivers/media/video/videodev.c          |    6 +---
>  drivers/mtd/mtdchar.c                   |   44 --------------------------------
>  drivers/net/ppp_generic.c               |    7 -----
>  drivers/net/wan/cosa.c                  |    7 -----
>  drivers/sbus/char/bpp.c                 |    4 --
>  drivers/sbus/char/vfc_dev.c             |    4 --
>  drivers/scsi/osst.c                     |   13 ---------
>  drivers/scsi/sg.c                       |    3 --
>  drivers/scsi/st.c                       |   13 ---------
>  drivers/telephony/phonedev.c            |    2 -
>  drivers/usb/core/file.c                 |    1 
>  drivers/video/fbmem.c                   |    2 -
>  fs/coda/psdev.c                         |   11 --------
>  include/linux/devfs_fs_kernel.h         |    4 --
>  sound/core/sound.c                      |   10 -------
>  sound/oss/soundcard.c                   |   10 -------
>  sound/sound_core.c                      |    2 -
>  53 files changed, 11 insertions(+), 341 deletions(-)
> 
> --- gregkh-2.6.orig/drivers/block/acsi_slm.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/block/acsi_slm.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1,5 +1,3 @@
> -/*
> - * acsi_slm.c -- Device driver for the Atari SLM laser printer
>   *
>   * Copyright 1995 Roman Hodek <Roman.Hodek@informatik.uni-erlangen.de>
>   *
> @@ -1007,10 +1005,6 @@
>  	BufferP = SLMBuffer;
>  	SLMState = IDLE;
>  	
> -	for (i = 0; i < MAX_SLM; i++) {
> -		devfs_mk_cdev(MKDEV(ACSI_MAJOR, i),
> -				S_IFCHR|S_IRUSR|S_IWUSR, "slm/%d", i);
> -	}
>  	return 0;
>  }
>  
> --- gregkh-2.6.orig/drivers/block/paride/pg.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/block/paride/pg.c	2005-06-10 23:48:51.000000000 -0700
> @@ -673,22 +673,13 @@
>  	}
>  	for (unit = 0; unit < PG_UNITS; unit++) {
>  		struct pg *dev = &devices[unit];
> -		if (dev->present) {
> +		if (dev->present)
>  			class_device_create(pg_class, MKDEV(major, unit),
>  					NULL, "pg%u", unit);
> -			err = devfs_mk_cdev(MKDEV(major, unit),
> -				      S_IFCHR | S_IRUSR | S_IWUSR, "pg/%u",
> -				      unit);
> -			if (err) 
> -				goto out_class;
> -		}
>  	}
>  	err = 0;
>  	goto out;
>  
> -out_class:
> -	class_device_destroy(pg_class, MKDEV(major, unit));
> -	class_destroy(pg_class);
>  out_chrdev:
>  	unregister_chrdev(major, "pg");
>  out:
> --- gregkh-2.6.orig/drivers/block/paride/pt.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/block/paride/pt.c	2005-06-10 23:48:51.000000000 -0700
> @@ -973,27 +973,11 @@
>  		if (pt[unit].present) {
>  			class_device_create(pt_class, MKDEV(major, unit),
>  					NULL, "pt%d", unit);
> -			err = devfs_mk_cdev(MKDEV(major, unit),
> -				      S_IFCHR | S_IRUSR | S_IWUSR,
> -				      "pt/%d", unit);
> -			if (err) {
> -				class_device_destroy(pt_class, MKDEV(major, unit));
> -				goto out_class;
> -			}
>  			class_device_create(pt_class, MKDEV(major, unit + 128),
>  					NULL, "pt%dn", unit);
> -			err = devfs_mk_cdev(MKDEV(major, unit + 128),
> -				      S_IFCHR | S_IRUSR | S_IWUSR,
> -				      "pt/%dn", unit);
> -			if (err) {
> -				class_device_destroy(pt_class, MKDEV(major, unit + 128));
> -				goto out_class;
> -			}
>  		}
>  	goto out;
>  
> -out_class:
> -	class_destroy(pt_class);
>  out_chrdev:
>  	unregister_chrdev(major, "pt");
>  out:
> --- gregkh-2.6.orig/drivers/ide/ide-tape.c	2005-06-10 23:48:37.000000000 -0700
> +++ gregkh-2.6/drivers/ide/ide-tape.c	2005-06-10 23:48:51.000000000 -0700
> @@ -4878,13 +4878,6 @@
>  
>  	idetape_setup(drive, tape, minor);
>  
> -	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
> -			S_IFCHR | S_IRUGO | S_IWUGO,
> -			"%s/mt", drive->devfs_name);
> -	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor + 128),
> -			S_IFCHR | S_IRUGO | S_IWUGO,
> -			"%s/mtn", drive->devfs_name);
> -
>  	g->number = -1;
>  	g->fops = &idetape_block_ops;
>  	ide_register_region(g);
> --- gregkh-2.6.orig/drivers/ieee1394/amdtp.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/ieee1394/amdtp.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1238,9 +1238,6 @@
>  
>  	INIT_LIST_HEAD(&ah->stream_list);
>  	spin_lock_init(&ah->stream_list_lock);
> -
> -	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
> -			S_IFCHR|S_IRUSR|S_IWUSR, "amdtp/%d", ah->host->id);
>  }
>  
>  static void amdtp_remove_host(struct hpsb_host *host)
> --- gregkh-2.6.orig/drivers/ieee1394/dv1394.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/ieee1394/dv1394.c	2005-06-10 23:48:51.000000000 -0700
> @@ -2278,21 +2278,9 @@
>  	list_add_tail(&video->list, &dv1394_cards);
>  	spin_unlock_irqrestore(&dv1394_cards_lock, flags);
>  
> -	if (devfs_mk_cdev(MKDEV(IEEE1394_MAJOR,
> -				IEEE1394_MINOR_BLOCK_DV1394*16 + video->id),
> -			S_IFCHR|S_IRUGO|S_IWUGO,
> -			 "ieee1394/dv/host%d/%s/%s",
> -			 (video->id>>2),
> -			 (video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"),
> -			 (video->mode == MODE_RECEIVE ? "in" : "out")) < 0)
> -			goto err_free;
> -
>  	debug_printk("dv1394: dv1394_init() OK on ID %d\n", video->id);
>  
>  	return 0;
> -
> - err_free:
> -	kfree(video);
>   err:
>  	return -1;
>  }
> --- gregkh-2.6.orig/drivers/ieee1394/raw1394.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/ieee1394/raw1394.c	2005-06-10 23:48:51.000000000 -0700
> @@ -2907,10 +2907,6 @@
>  		ret = -EFAULT;
>  		goto out_unreg;
>  	}
> -	
> -	devfs_mk_cdev(MKDEV(
> -		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16),
> -		S_IFCHR | S_IRUSR | S_IWUSR, RAW1394_DEVICE_NAME);
>  
>  	cdev_init(&raw1394_cdev, &raw1394_fops);
>  	raw1394_cdev.owner = THIS_MODULE;
> --- gregkh-2.6.orig/drivers/ieee1394/video1394.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/ieee1394/video1394.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1373,9 +1373,6 @@
>  	class_device_create(hpsb_protocol_class, MKDEV(
>  		IEEE1394_MAJOR,	minor), 
>  		NULL, "%s-%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
> -	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
> -		       S_IFCHR | S_IRUSR | S_IWUSR,
> -		       "%s/%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
>  }
>  
>  
> --- gregkh-2.6.orig/drivers/input/evdev.c	2005-06-10 23:45:20.000000000 -0700
> +++ gregkh-2.6/drivers/input/evdev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -429,8 +429,6 @@
>  
>  	evdev_table[minor] = evdev;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
>  	class_device_create(input_class,
>  			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
>  			dev->dev, "event%d", minor);
> --- gregkh-2.6.orig/drivers/input/joydev.c	2005-06-10 23:45:20.000000000 -0700
> +++ gregkh-2.6/drivers/input/joydev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -450,8 +450,6 @@
>  
>  	joydev_table[minor] = joydev;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
>  	class_device_create(input_class,
>  			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
>  			dev->dev, "js%d", minor);
> --- gregkh-2.6.orig/drivers/input/mousedev.c	2005-06-10 23:45:20.000000000 -0700
> +++ gregkh-2.6/drivers/input/mousedev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -645,8 +645,6 @@
>  
>  	mousedev_table[minor] = mousedev;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
>  	class_device_create(input_class,
>  			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
>  			dev->dev, "mouse%d", minor);
> @@ -734,8 +732,6 @@
>  	mousedev_mix.exist = 1;
>  	mousedev_mix.minor = MOUSEDEV_MIX;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
>  	class_device_create(input_class,
>  			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
>  
> --- gregkh-2.6.orig/drivers/input/tsdev.c	2005-06-10 23:45:20.000000000 -0700
> +++ gregkh-2.6/drivers/input/tsdev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -410,10 +410,6 @@
>  
>  	tsdev_table[minor] = tsdev;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
>  	class_device_create(input_class,
>  			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
>  			dev->dev, "ts%d", minor);
> --- gregkh-2.6.orig/drivers/macintosh/adb.c	2005-06-10 23:45:24.000000000 -0700
> +++ gregkh-2.6/drivers/macintosh/adb.c	2005-06-10 23:48:51.000000000 -0700
> @@ -900,8 +900,6 @@
>  		return;
>  	}
>  
> -	devfs_mk_cdev(MKDEV(ADB_MAJOR, 0), S_IFCHR | S_IRUSR | S_IWUSR, "adb");
> -
>  	adb_dev_class = class_create(THIS_MODULE, "adb");
>  	if (IS_ERR(adb_dev_class))
>  		return;
> --- gregkh-2.6.orig/drivers/sbus/char/bpp.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/sbus/char/bpp.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1048,10 +1048,6 @@
>  		instances[idx].opened = 0;
>  		probeLptPort(idx);
>  	}
> -	for (idx = 0; idx < BPP_NO; idx++) {
> -		devfs_mk_cdev(MKDEV(BPP_MAJOR, idx),
> -				S_IFCHR | S_IRUSR | S_IWUSR, "bpp/%d", idx);
> -	}
>  
>  	return 0;
>  }
> --- gregkh-2.6.orig/drivers/sbus/char/vfc_dev.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/sbus/char/vfc_dev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -165,10 +165,6 @@
>  		return -EINVAL;
>  	if (init_vfc_hw(dev))
>  		return -EIO;
> -
> -	devfs_mk_cdev(MKDEV(VFC_MAJOR, instance),
> -			S_IFCHR | S_IRUSR | S_IWUSR,
> -			"vfc/%d", instance);
>  	return 0;
>  }
>  
> --- gregkh-2.6.orig/drivers/telephony/phonedev.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/telephony/phonedev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -105,8 +105,6 @@
>  		if (phone_device[i] == NULL) {
>  			phone_device[i] = p;
>  			p->minor = i;
> -			devfs_mk_cdev(MKDEV(PHONE_MAJOR,i),
> -				S_IFCHR|S_IRUSR|S_IWUSR, "phone/%d", i);
>  			up(&phone_lock);
>  			return 0;
>  		}
> --- gregkh-2.6.orig/sound/core/sound.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/sound/core/sound.c	2005-06-10 23:48:51.000000000 -0700
> @@ -39,7 +39,6 @@
>  static int major = CONFIG_SND_MAJOR;
>  int snd_major;
>  static int cards_limit = 1;
> -static int device_mode = S_IFCHR | S_IRUGO | S_IWUGO;
>  
>  MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
>  MODULE_DESCRIPTION("Advanced Linux Sound Architecture driver for soundcards.");
> @@ -48,10 +47,6 @@
>  MODULE_PARM_DESC(major, "Major # for sound driver.");
>  module_param(cards_limit, int, 0444);
>  MODULE_PARM_DESC(cards_limit, "Count of auto-loadable soundcards.");
> -#ifdef CONFIG_DEVFS_FS
> -module_param(device_mode, int, 0444);
> -MODULE_PARM_DESC(device_mode, "Device file permission mask for devfs.");
> -#endif
>  MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
>  
>  /* this one holds the actual max. card number currently available.
> @@ -227,8 +222,6 @@
>  		return -EBUSY;
>  	}
>  	list_add_tail(&preg->list, &snd_minors_hash[SNDRV_MINOR_CARD(minor)]);
> -	if (strncmp(name, "controlC", 8) || card->number >= cards_limit)
> -		devfs_mk_cdev(MKDEV(major, minor), S_IFCHR | device_mode, "snd/%s", name);
>  	if (card)
>  		device = card->dev;
>  	class_device_create(sound_class, MKDEV(major, minor), device, "%s", name);
> @@ -330,7 +323,6 @@
>  
>  static int __init alsa_sound_init(void)
>  {
> -	short controlnum;
>  	int err;
>  	int card;
>  
> @@ -353,8 +345,6 @@
>  		return -ENOMEM;
>  	}
>  	snd_info_minor_register();
> -	for (controlnum = 0; controlnum < cards_limit; controlnum++)
> -		devfs_mk_cdev(MKDEV(major, controlnum<<5), S_IFCHR | device_mode, "snd/controlC%d", controlnum);
>  #ifndef MODULE
>  	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
>  #endif
> --- gregkh-2.6.orig/sound/oss/soundcard.c	2005-06-10 23:45:21.000000000 -0700
> +++ gregkh-2.6/sound/oss/soundcard.c	2005-06-10 23:48:51.000000000 -0700
> @@ -564,9 +564,6 @@
>  	sound_dmap_flag = (dmabuf > 0 ? 1 : 0);
>  
>  	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
> -		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
> -				S_IFCHR | dev_list[i].mode,
> -				"sound/%s", dev_list[i].name);
>  		class_device_create(sound_class,
>  				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
>  				    NULL, "%s", dev_list[i].name);
> @@ -574,15 +571,10 @@
>  		if (!dev_list[i].num)
>  			continue;
>  
> -		for (j = 1; j < *dev_list[i].num; j++) {
> -			devfs_mk_cdev(MKDEV(SOUND_MAJOR,
> -						dev_list[i].minor + (j*0x10)),
> -					S_IFCHR | dev_list[i].mode,
> -					"sound/%s%d", dev_list[i].name, j);
> +		for (j = 1; j < *dev_list[i].num; j++)
>  			class_device_create(sound_class,
>  					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
>  					    NULL, "%s%d", dev_list[i].name, j);
> -		}
>  	}
>  
>  	if (sound_nblocks >= 1024)
> --- gregkh-2.6.orig/sound/sound_core.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/sound/sound_core.c	2005-06-10 23:48:51.000000000 -0700
> @@ -172,8 +172,6 @@
>  	else
>  		sprintf(s->name, "sound/%s%d", name, r / SOUND_STEP);
>  
> -	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
> -			S_IFCHR | mode, s->name);
>  	class_device_create(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
>  				NULL, s->name+6);
>  	return r;
> --- gregkh-2.6.orig/drivers/char/ftape/zftape/zftape-init.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/ftape/zftape/zftape-init.c	2005-06-10 23:48:51.000000000 -0700
> @@ -332,29 +332,11 @@
>  	zft_class = class_create(THIS_MODULE, "zft");
>  	for (i = 0; i < 4; i++) {
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"qft%i", i);
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 4),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"nqft%i", i);
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 16),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"zqft%i", i);
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 20),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"nzqft%i", i);
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 32),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"rawqft%i", i);
>  		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
> -		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 36),
> -				S_IFCHR | S_IRUSR | S_IWUSR,
> -				"nrawqft%i", i);
>  	}
>  
>  #ifdef CONFIG_ZFT_COMPRESSOR
> --- gregkh-2.6.orig/drivers/char/ip2main.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/ip2main.c	2005-06-10 23:48:51.000000000 -0700
> @@ -724,25 +724,8 @@
>  			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
>  				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
>  						4 * i), NULL, "ipl%d", i);
> -				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
> -						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> -						"ip2/ipl%d", i);
> -				if (err) {
> -					class_device_destroy(ip2_class,
> -						MKDEV(IP2_IPL_MAJOR, 4 * i));
> -					goto out_class;
> -				}
> -
>  				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
>  						4 * i + 1), NULL, "stat%d", i);
> -				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
> -						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> -						"ip2/stat%d", i);
> -				if (err) {
> -					class_device_destroy(ip2_class,
> -						MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
> -					goto out_class;
> -				}
>  
>  			    for ( box = 0; box < ABS_MAX_BOXES; ++box )
>  			    {
> --- gregkh-2.6.orig/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:48:51.000000000 -0700
> @@ -526,9 +526,6 @@
>  {
>  	dev_t dev = MKDEV(ipmi_major, if_num);
>  
> -	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
> -		      "ipmidev/%d", if_num);
> -
>  	class_device_create(ipmi_class, dev, NULL, "ipmi%d", if_num);
>  }
>  
> --- gregkh-2.6.orig/drivers/char/istallion.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/istallion.c	2005-06-10 23:48:51.000000000 -0700
> @@ -5242,13 +5242,9 @@
>  				"device\n");
>  
>  	istallion_class = class_create(THIS_MODULE, "staliomem");
> -	for (i = 0; i < 4; i++) {
> -		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
> -			       S_IFCHR | S_IRUSR | S_IWUSR,
> -			       "staliomem/%d", i);
> +	for (i = 0; i < 4; i++)
>  		class_device_create(istallion_class, MKDEV(STL_SIOMEMMAJOR, i),
>  				NULL, "staliomem%d", i);
> -	}
>  
>  /*
>   *	Set up the tty driver structure and register us as a driver.
> --- gregkh-2.6.orig/drivers/char/misc.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/misc.c	2005-06-10 23:48:51.000000000 -0700
> @@ -208,7 +208,7 @@
>  {
>  	struct miscdevice *c;
>  	dev_t dev;
> -	int err;
> +	int err = 0;
>  
>  	down(&misc_sem);
>  	list_for_each_entry(c, &misc_list, list) {
> @@ -245,13 +245,6 @@
>  		goto out;
>  	}
>  
> -	err = devfs_mk_cdev(dev, S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, 
> -			    misc->devfs_name);
> -	if (err) {
> -		class_device_destroy(misc_class, dev);
> -		goto out;
> -	}
> -
>  	/*
>  	 * Add it to the front, so that later devices can "override"
>  	 * earlier defaults
> --- gregkh-2.6.orig/drivers/char/ppdev.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/ppdev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -781,10 +781,6 @@
>  		err = PTR_ERR(ppdev_class);
>  		goto out_chrdev;
>  	}
> -	for (i = 0; i < PARPORT_MAX; i++) {
> -		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
> -				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
> -	}
>  	if (parport_register_driver(&pp_driver)) {
>  		printk (KERN_WARNING CHRDEV ": unable to register with parport\n");
>  		goto out_class;
> --- gregkh-2.6.orig/drivers/char/raw.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/raw.c	2005-06-10 23:48:51.000000000 -0700
> @@ -287,7 +287,6 @@
>  
>  static int __init raw_init(void)
>  {
> -	int i;
>  	dev_t dev = MKDEV(RAW_MAJOR, 0);
>  
>  	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
> @@ -309,13 +308,6 @@
>  	}
>  	class_device_create(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
>  
> -	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
> -		      S_IFCHR | S_IRUGO | S_IWUGO,
> -		      "raw/rawctl");
> -	for (i = 1; i < MAX_RAW_MINORS; i++)
> -		devfs_mk_cdev(MKDEV(RAW_MAJOR, i),
> -			      S_IFCHR | S_IRUGO | S_IWUGO,
> -			      "raw/raw%d", i);
>  	return 0;
>  
>  error:
> --- gregkh-2.6.orig/drivers/char/stallion.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/stallion.c	2005-06-10 23:48:51.000000000 -0700
> @@ -3090,12 +3090,8 @@
>  		printk("STALLION: failed to register serial board device\n");
>  
>  	stallion_class = class_create(THIS_MODULE, "staliomem");
> -	for (i = 0; i < 4; i++) {
> -		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
> -				S_IFCHR|S_IRUSR|S_IWUSR,
> -				"staliomem/%d", i);
> +	for (i = 0; i < 4; i++)
>  		class_device_create(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
> -	}
>  
>  	stl_serial->owner = THIS_MODULE;
>  	stl_serial->driver_name = stl_drvname;
> --- gregkh-2.6.orig/drivers/char/tipar.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/tipar.c	2005-06-10 23:48:51.000000000 -0700
> @@ -438,12 +438,6 @@
>  
>  	class_device_create(tipar_class, MKDEV(TIPAR_MAJOR,
>  			TIPAR_MINOR + nr), NULL, "par%d", nr);
> -	/* Use devfs, tree: /dev/ticables/par/[0..2] */
> -	err = devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
> -			S_IFCHR | S_IRUGO | S_IWUGO,
> -			"ticables/par/%d", nr);
> -	if (err)
> -		goto out_class;
>  
>  	/* Display informations */
>  	pr_info("tipar%d: using %s (%s)\n", nr, port->name, (port->irq ==
> @@ -455,11 +449,7 @@
>  		pr_info("tipar%d: link cable not found\n", nr);
>  
>  	err = 0;
> -	goto out;
>  
> -out_class:
> -	class_device_destroy(tipar_class, MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr));
> -	class_destroy(tipar_class);
>  out:
>  	return err;
>  }
> --- gregkh-2.6.orig/drivers/char/viotape.c	2005-06-10 23:48:37.000000000 -0700
> +++ gregkh-2.6/drivers/char/viotape.c	2005-06-10 23:48:51.000000000 -0700
> @@ -959,10 +959,6 @@
>  			"iseries!vt%d", i);
>  	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
>  			NULL, "iseries!nvt%d", i);
> -	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
> -			"iseries/vt%d", i);
> -	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
> -			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
>  	sprintf(tapename, "iseries/vt%d", i);
>  	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
>  			"resource %10.10s type %4.4s, model %3.3s\n",
> --- gregkh-2.6.orig/drivers/char/dsp56k.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/dsp56k.c	2005-06-10 23:48:51.000000000 -0700
> @@ -517,17 +517,9 @@
>  	}
>  	class_device_create(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
>  
> -	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
> -		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
> -	if(err)
> -		goto out_class;
> -
>  	printk(banner);
>  	goto out;
>  
> -out_class:
> -	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
> -	class_destroy(dsp56k_class);
>  out_chrdev:
>  	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
>  out:
> --- gregkh-2.6.orig/drivers/char/dtlk.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/char/dtlk.c	2005-06-10 23:48:51.000000000 -0700
> @@ -337,9 +337,6 @@
>  	if (dtlk_dev_probe() == 0)
>  		printk(", MAJOR %d\n", dtlk_major);
>  
> -	devfs_mk_cdev(MKDEV(dtlk_major, DTLK_MINOR),
> -		       S_IFCHR | S_IRUSR | S_IWUSR, "dtlk");
> -
>  	init_timer(&dtlk_timer);
>  	dtlk_timer.function = dtlk_timer_tick;
>  	init_waitqueue_head(&dtlk_process_list);
> --- gregkh-2.6.orig/drivers/char/mem.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/mem.c	2005-06-10 23:48:51.000000000 -0700
> @@ -866,13 +866,10 @@
>  		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
>  
>  	mem_class = class_create(THIS_MODULE, "mem");
> -	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
> +	for (i = 0; i < ARRAY_SIZE(devlist); i++)
>  		class_device_create(mem_class, MKDEV(MEM_MAJOR, devlist[i].minor),
>  					NULL, devlist[i].name);
> -		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
> -				S_IFCHR | devlist[i].mode, devlist[i].name);
> -	}
> -	
> +
>  	return 0;
>  }
>  
> --- gregkh-2.6.orig/drivers/char/tty_io.c	2005-06-10 23:45:19.000000000 -0700
> +++ gregkh-2.6/drivers/char/tty_io.c	2005-06-10 23:48:51.000000000 -0700
> @@ -2680,9 +2680,6 @@
>  		return;
>  	}
>  
> -	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
> -			"%s%d", driver->devfs_name, index + driver->name_base);
> -
>  	if (driver->type == TTY_DRIVER_TYPE_PTY)
>  		pty_line_name(driver, index, name);
>  	else
> @@ -2946,14 +2943,12 @@
>  	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
>  	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
>  		panic("Couldn't register /dev/tty driver\n");
> -	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
>  	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
>  
>  	cdev_init(&console_cdev, &console_fops);
>  	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
>  	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
>  		panic("Couldn't register /dev/console driver\n");
> -	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
>  	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
>  
>  #ifdef CONFIG_UNIX98_PTYS
> @@ -2961,7 +2956,6 @@
>  	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
>  	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
>  		panic("Couldn't register /dev/ptmx driver\n");
> -	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
>  	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
>  #endif
>  
> @@ -2970,7 +2964,6 @@
>  	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
>  	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
>  		panic("Couldn't register /dev/tty0 driver\n");
> -	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
>  	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
>  
>  	vty_init();
> --- gregkh-2.6.orig/drivers/char/vc_screen.c	2005-06-10 23:45:22.000000000 -0700
> +++ gregkh-2.6/drivers/char/vc_screen.c	2005-06-10 23:48:51.000000000 -0700
> @@ -478,12 +478,6 @@
>  
>  void vcs_make_devfs(struct tty_struct *tty)
>  {
> -	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 1),
> -			S_IFCHR|S_IRUSR|S_IWUSR,
> -			"vcc/%u", tty->index + 1);
> -	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
> -			S_IFCHR|S_IRUSR|S_IWUSR,
> -			"vcc/a%u", tty->index + 1);
>  	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
>  	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
>  }
> @@ -501,8 +495,6 @@
>  		panic("unable to get major %d for vcs device", VCS_MAJOR);
>  	vc_class = class_create(THIS_MODULE, "vc");
>  
> -	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
> -	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
>  	class_device_create(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
>  	class_device_create(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
>  	return 0;
> --- gregkh-2.6.orig/drivers/isdn/capi/capi.c	2005-06-10 23:45:24.000000000 -0700
> +++ gregkh-2.6/drivers/isdn/capi/capi.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1506,8 +1506,6 @@
>  	}
>  
>  	class_device_create(capi_class, MKDEV(capi_major, 0), NULL, "capi");
> -	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
> -			"isdn/capi20");
>  
>  #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
>  	if (capinc_tty_init() < 0) {
> --- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divamnt.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/isdn/hardware/eicon/divamnt.c	2005-06-10 23:48:51.000000000 -0700
> @@ -190,7 +190,6 @@
>  		       DRIVERLNAME);
>  		return (0);
>  	}
> -	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
>  
>  	return (1);
>  }
> --- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divasi.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/isdn/hardware/eicon/divasi.c	2005-06-10 23:48:51.000000000 -0700
> @@ -157,7 +157,6 @@
>  		       DRIVERLNAME);
>  		return (0);
>  	}
> -	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
>  
>  	return (1);
>  }
> --- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divasmain.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/isdn/hardware/eicon/divasmain.c	2005-06-10 23:48:51.000000000 -0700
> @@ -690,7 +690,6 @@
>  		       DRIVERLNAME);
>  		return (0);
>  	}
> -	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
>  
>  	return (1);
>  }
> --- gregkh-2.6.orig/drivers/mtd/mtdchar.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/mtd/mtdchar.c	2005-06-10 23:48:51.000000000 -0700
> @@ -15,48 +15,6 @@
>  #include <linux/fs.h>
>  #include <asm/uaccess.h>
>  
> -#ifdef CONFIG_DEVFS_FS
> -#include <linux/devfs_fs_kernel.h>
> -
> -static void mtd_notify_add(struct mtd_info* mtd)
> -{
> -	if (!mtd)
> -		return;
> -
> -	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
> -		      S_IFCHR | S_IRUGO | S_IWUGO, "mtd/%d", mtd->index);
> -		
> -	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1),
> -		      S_IFCHR | S_IRUGO, "mtd/%dro", mtd->index);
> -}
> -
> -static void mtd_notify_remove(struct mtd_info* mtd)
> -{
> -	if (!mtd)
> -		return;
> -	devfs_remove("mtd/%d", mtd->index);
> -	devfs_remove("mtd/%dro", mtd->index);
> -}
> -
> -static struct mtd_notifier notifier = {
> -	.add	= mtd_notify_add,
> -	.remove	= mtd_notify_remove,
> -};
> -
> -static inline void mtdchar_devfs_init(void)
> -{
> -	register_mtd_user(&notifier);
> -}
> -
> -static inline void mtdchar_devfs_exit(void)
> -{
> -	unregister_mtd_user(&notifier);
> -	devfs_remove("mtd");
> -}
> -#else /* !DEVFS */
> -#define mtdchar_devfs_init() do { } while(0)
> -#define mtdchar_devfs_exit() do { } while(0)
> -#endif
>  
>  static loff_t mtd_lseek (struct file *file, loff_t offset, int orig)
>  {
> @@ -542,13 +500,11 @@
>  		return -EAGAIN;
>  	}
>  
> -	mtdchar_devfs_init();
>  	return 0;
>  }
>  
>  static void __exit cleanup_mtdchar(void)
>  {
> -	mtdchar_devfs_exit();
>  	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
>  }
>  
> --- gregkh-2.6.orig/drivers/scsi/osst.c	2005-06-10 23:48:37.000000000 -0700
> +++ gregkh-2.6/drivers/scsi/osst.c	2005-06-10 23:48:51.000000000 -0700
> @@ -5668,7 +5668,7 @@
>  	struct st_partstat * STps;
>  	struct osst_buffer * buffer;
>  	struct gendisk	   * drive;
> -	int		     i, mode, dev_num;
> +	int		     i, dev_num;
>  
>  	if (SDp->type != TYPE_TAPE || !osst_supports(SDp))
>  		return -ENODEV;
> @@ -5804,17 +5804,6 @@
>  		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
>  		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
>  	}
> -	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
> -		/*  Rewind entry  */
> -		devfs_mk_cdev(MKDEV(OSST_MAJOR, dev_num + (mode << 5)),
> -				S_IFCHR | S_IRUGO | S_IWUGO,
> -				"%s/ot%s", SDp->devfs_name, osst_formats[mode]);
> -
> -		/*  No-rewind entry  */
> -		devfs_mk_cdev(MKDEV(OSST_MAJOR, dev_num + (mode << 5) + 128),
> -				S_IFCHR | S_IRUGO | S_IWUGO,
> -				"%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
> -	}
>  	drive->number = -1;
>  
>  	printk(KERN_INFO
> --- gregkh-2.6.orig/drivers/scsi/sg.c	2005-06-10 23:45:23.000000000 -0700
> +++ gregkh-2.6/drivers/scsi/sg.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1539,9 +1539,6 @@
>  	k = error;
>  	sdp = sg_dev_arr[k];
>  
> -	devfs_mk_cdev(MKDEV(SCSI_GENERIC_MAJOR, k),
> -			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
> -			"%s/generic", scsidp->devfs_name);
>  	error = cdev_add(cdev, MKDEV(SCSI_GENERIC_MAJOR, k), 1);
>  	if (error) {
>  		devfs_remove("%s/generic", scsidp->devfs_name);
> --- gregkh-2.6.orig/drivers/scsi/st.c	2005-06-10 23:48:37.000000000 -0700
> +++ gregkh-2.6/drivers/scsi/st.c	2005-06-10 23:48:51.000000000 -0700
> @@ -3984,19 +3984,6 @@
>  		do_create_class_files(tpnt, dev_num, mode);
>  	}
>  
> -	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
> -		/* Make sure that the minor numbers corresponding to the four
> -		   first modes always get the same names */
> -		i = mode << (4 - ST_NBR_MODE_BITS);
> -		/*  Rewind entry  */
> -		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, mode, 0)),
> -			      S_IFCHR | S_IRUGO | S_IWUGO,
> -			      "%s/mt%s", SDp->devfs_name, st_formats[i]);
> -		/*  No-rewind entry  */
> -		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, mode, 1)),
> -			      S_IFCHR | S_IRUGO | S_IWUGO,
> -			      "%s/mt%sn", SDp->devfs_name, st_formats[i]);
> -	}
>  	disk->number = -1;
>  
>  	printk(KERN_WARNING
> --- gregkh-2.6.orig/arch/sparc64/solaris/socksys.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/arch/sparc64/solaris/socksys.c	2005-06-10 23:48:51.000000000 -0700
> @@ -190,8 +190,6 @@
>  		return ret;
>  	}
>  
> -	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUSR|S_IWUSR, "socksys");
> -
>  	file = fcheck(ret);
>  	/* N.B. Is this valid? Suppose the f_ops are in a module ... */
>  	socksys_file_ops = *file->f_op;
> --- gregkh-2.6.orig/drivers/char/lp.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/char/lp.c	2005-06-10 23:48:51.000000000 -0700
> @@ -806,8 +806,6 @@
>  
>  	class_device_create(lp_class, MKDEV(LP_MAJOR, nr), NULL,
>  				"lp%d", nr);
> -	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
> -			"printers/%d", nr);
>  
>  	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name, 
>  	       (port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
> --- gregkh-2.6.orig/drivers/i2c/i2c-dev.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/i2c/i2c-dev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -432,8 +432,6 @@
>  	if (IS_ERR(i2c_dev))
>  		return PTR_ERR(i2c_dev);
>  
> -	devfs_mk_cdev(MKDEV(I2C_MAJOR, i2c_dev->minor),
> -			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i2c_dev->minor);
>  	dev_dbg(&adap->dev, "Registered as minor %d\n", i2c_dev->minor);
>  
>  	/* register this i2c device with the driver core */
> --- gregkh-2.6.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/media/dvb/dvb-core/dvbdev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -231,10 +231,6 @@
>  
>  	list_add_tail (&dvbdev->list_head, &adap->device_list);
>  
> -	devfs_mk_cdev(MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
> -			S_IFCHR | S_IRUSR | S_IWUSR,
> -			"dvb/adapter%d/%s%d", adap->num, dnames[type], id);
> -
>  	class_device_create(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
>  			    NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
>  
> --- gregkh-2.6.orig/drivers/media/video/videodev.c	2005-06-10 23:42:30.000000000 -0700
> +++ gregkh-2.6/drivers/media/video/videodev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -329,9 +329,6 @@
>  	vfd->minor=i;
>  	up(&videodev_lock);
>  
> -	sprintf(vfd->devfs_name, "v4l/%s%d", name_base, i - base);
> -	devfs_mk_cdev(MKDEV(VIDEO_MAJOR, vfd->minor),
> -			S_IFCHR | S_IRUSR | S_IWUSR, vfd->devfs_name);
>  	init_MUTEX(&vfd->lock);
>  
>  	/* sysfs class */
> @@ -340,7 +337,8 @@
>  		vfd->class_dev.dev = vfd->dev;
>  	vfd->class_dev.class       = &video_class;
>  	vfd->class_dev.devt       = MKDEV(VIDEO_MAJOR, vfd->minor);
> -	strlcpy(vfd->class_dev.class_id, vfd->devfs_name + 4, BUS_ID_SIZE);
> +	sprintf(vfd->devfs_name, "%s%d", name_base, i - base);
> +	strlcpy(vfd->class_dev.class_id, vfd->devfs_name, BUS_ID_SIZE);
>  	class_device_register(&vfd->class_dev);
>  	class_device_create_file(&vfd->class_dev,
>  				 &class_device_attr_name);
> --- gregkh-2.6.orig/drivers/net/ppp_generic.c	2005-06-10 23:45:24.000000000 -0700
> +++ gregkh-2.6/drivers/net/ppp_generic.c	2005-06-10 23:48:51.000000000 -0700
> @@ -864,10 +864,6 @@
>  			goto out_chrdev;
>  		}
>  		class_device_create(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
> -		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
> -				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
> -		if (err)
> -			goto out_class;
>  	}
>  
>  out:
> @@ -875,9 +871,6 @@
>  		printk(KERN_ERR "failed to register PPP device (%d)\n", err);
>  	return err;
>  
> -out_class:
> -	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR,0));
> -	class_destroy(ppp_class);
>  out_chrdev:
>  	unregister_chrdev(PPP_MAJOR, "ppp");
>  	goto out;
> --- gregkh-2.6.orig/drivers/net/wan/cosa.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/net/wan/cosa.c	2005-06-10 23:48:51.000000000 -0700
> @@ -401,13 +401,6 @@
>  	for (i=0; i<nr_cards; i++) {
>  		class_device_create(cosa_class, MKDEV(cosa_major, i),
>  				NULL, "cosa%d", i);
> -		err = devfs_mk_cdev(MKDEV(cosa_major, i),
> -				S_IFCHR|S_IRUSR|S_IWUSR,
> -				"cosa/%d", i);
> -		if (err) {
> -			class_device_destroy(cosa_class, MKDEV(cosa_major, i));
> -			goto out_chrdev;		
> -		}
>  	}
>  	err = 0;
>  	goto out;
> --- gregkh-2.6.orig/drivers/video/fbmem.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/video/fbmem.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1099,8 +1099,6 @@
>  
>  	registered_fb[i] = fb_info;
>  
> -	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
> -			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
>  	event.info = fb_info;
>  	notifier_call_chain(&fb_notifier_list,
>  			    FB_EVENT_FB_REGISTERED, &event);
> --- gregkh-2.6.orig/drivers/usb/core/file.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/usb/core/file.c	2005-06-10 23:48:51.000000000 -0700
> @@ -162,7 +162,6 @@
>  
>  	/* handle the devfs registration */
>  	snprintf(name, BUS_ID_SIZE, class_driver->name, minor - minor_base);
> -	devfs_mk_cdev(MKDEV(USB_MAJOR, minor), class_driver->mode, name);
>  
>  	/* create a usb class device for this usb interface */
>  	temp = strrchr(name, '/');
> --- gregkh-2.6.orig/fs/coda/psdev.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/fs/coda/psdev.c	2005-06-10 23:48:51.000000000 -0700
> @@ -368,21 +368,12 @@
>  		err = PTR_ERR(coda_psdev_class);
>  		goto out_chrdev;
>  	}		
> -	for (i = 0; i < MAX_CODADEVS; i++) {
> +	for (i = 0; i < MAX_CODADEVS; i++)
>  		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
>  				NULL, "cfs%d", i);
> -		err = devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
> -				S_IFCHR|S_IRUSR|S_IWUSR, "coda/%d", i);
> -		if (err)
> -			goto out_class;
> -	}
>  	coda_sysctl_init();
>  	goto out;
>  
> -out_class:
> -	for (i = 0; i < MAX_CODADEVS; i++) 
> -		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
> -	class_destroy(coda_psdev_class);
>  out_chrdev:
>  	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
>  out:
> --- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:48:42.000000000 -0700
> +++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:48:51.000000000 -0700
> @@ -7,10 +7,6 @@
>  #include <linux/types.h>
>  #include <asm/semaphore.h>
>  
> -static inline int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
> -{
> -	return 0;
> -}
>  static inline void devfs_remove(const char *fmt, ...)
>  {
>  }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
