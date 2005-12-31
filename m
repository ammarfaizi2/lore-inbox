Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVLaQRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVLaQRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVLaQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:17:07 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:59856 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965011AbVLaQQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:16:59 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:16:35 +0100
In-reply-to: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: [PATCH 2/4] media-radio: Maestro radio Lindent
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, atlka@pg.gda.pl
Message-Id: <20051231161634.5124C1E330E@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maestro radio Lindent
[depends on mastro radio pci probing]

+some handwork

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f3f0d3e94b346e181a62de564506db1be00bb8ef
tree e52683bd644912b08905c2ce1dd719c9dea5b758
parent 91d2ae25f82de5c70a8051cf579bf28d46d6bd59
author <ku@bellona.(none)> Sat, 31 Dec 2005 17:00:05 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 17:00:05 +0100

 drivers/media/radio/radio-maestro.c |  210 ++++++++++++++++++-----------------
 1 files changed, 107 insertions(+), 103 deletions(-)

diff --git a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c
+++ b/drivers/media/radio/radio-maestro.c
@@ -29,28 +29,28 @@
 
 #define DRIVER_VERSION	"0.05"
 
-#define GPIO_DATA       0x60   /* port offset from ESS_IO_BASE */
+#define GPIO_DATA	0x60   /* port offset from ESS_IO_BASE */
 
 #define IO_MASK		4      /* mask      register offset from GPIO_DATA
 				bits 1=unmask write to given bit */
 #define IO_DIR		8      /* direction register offset from GPIO_DATA
 				bits 0/1=read/write direction */
 
-#define GPIO6           0x0040 /* mask bits for GPIO lines */
-#define GPIO7           0x0080
-#define GPIO8           0x0100
-#define GPIO9           0x0200
-
-#define STR_DATA        GPIO6  /* radio TEA5757 pins and GPIO bits */
-#define STR_CLK         GPIO7
-#define STR_WREN        GPIO8
-#define STR_MOST        GPIO9
+#define GPIO6		0x0040 /* mask bits for GPIO lines */
+#define GPIO7		0x0080
+#define GPIO8		0x0100
+#define GPIO9		0x0200
+
+#define STR_DATA	GPIO6  /* radio TEA5757 pins and GPIO bits */
+#define STR_CLK		GPIO7
+#define STR_WREN	GPIO8
+#define STR_MOST	GPIO9
 
 #define FREQ_LO		 50*16000
 #define FREQ_HI		150*16000
 
-#define FREQ_IF         171200 /* 10.7*16000   */
-#define FREQ_STEP       200    /* 12.5*16      */
+#define FREQ_IF		171200 /* 10.7*16000   */
+#define FREQ_STEP	200    /* 12.5*16      */
 
 #define FREQ2BITS(x)	((((unsigned int)(x)+FREQ_IF+(FREQ_STEP<<1))\
 			/(FREQ_STEP<<2))<<2) /* (x==fmhz*16*1000) -> bits */
@@ -61,7 +61,7 @@ static int radio_nr = -1;
 module_param(radio_nr, int, 0);
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg);
+	unsigned int cmd, unsigned long arg);
 static int maestro_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void maestro_remove(struct pci_dev *pdev);
 
@@ -85,11 +85,11 @@ static struct pci_driver maestro_r_drive
 
 static struct file_operations maestro_fops = {
 	.owner		= THIS_MODULE,
-	.open           = video_exclusive_open,
-	.release        = video_exclusive_release,
+	.open		= video_exclusive_open,
+	.release	= video_exclusive_release,
 	.ioctl		= radio_ioctl,
 	.compat_ioctl	= v4l_compat_ioctl32,
-	.llseek         = no_llseek,
+	.llseek		= no_llseek,
 };
 
 static struct video_device maestro_radio=
@@ -98,7 +98,7 @@ static struct video_device maestro_radio
 	.name		= "Maestro radio",
 	.type		= VID_TYPE_TUNER,
 	.hardware	= VID_HARDWARE_SF16MI,
-	.fops           = &maestro_fops,
+	.fops		= &maestro_fops,
 };
 
 struct radio_device
@@ -107,7 +107,7 @@ struct radio_device
 		muted,	/* VIDEO_AUDIO_MUTE */
 		stereo,	/* VIDEO_TUNER_STEREO_ON */	
 		tuned;	/* signal strength (0 or 0xffff) */
-	struct  semaphore lock;
+	struct	semaphore lock;
 };
 
 static __u32 radio_bits_get(struct radio_device *dev)
@@ -115,6 +115,7 @@ static __u32 radio_bits_get(struct radio
 	register __u16 io=dev->io, l, rdata;
 	register __u32 data=0;
 	__u16 omask;
+
 	omask = inw(io + IO_MASK);
 	outw(~(STR_CLK | STR_WREN), io + IO_MASK);
 	outw(0, io);
@@ -137,10 +138,13 @@ static __u32 radio_bits_get(struct radio
 				data++;
 		udelay(2);
 	}
+
 	if(dev->muted)
 		outw(STR_WREN, io);
+
 	udelay(4);
 	outw(omask, io + IO_MASK);
+
 	return data & 0x3ffe;
 }
 
@@ -148,6 +152,7 @@ static void radio_bits_set(struct radio_
 {
 	register __u16 io=dev->io, l, bits;
 	__u16 omask, odir;
+
 	omask = inw(io + IO_MASK);
 	odir  = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
 	outw(odir | STR_DATA, io + IO_DIR);
@@ -163,8 +168,10 @@ static void radio_bits_set(struct radio_
 		outw(bits, io);			/* LO level */
 		udelay(4);
 	}
+
 	if(!dev->muted)
 		outw(0, io);
+
 	udelay(4);
 	outw(omask, io + IO_MASK);
 	outw(odir, io + IO_DIR);
@@ -172,108 +179,103 @@ static void radio_bits_set(struct radio_
 }
 
 static inline int radio_function(struct inode *inode, struct file *file,
-				 unsigned int cmd, void *arg)
+	unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
-	struct radio_device *card=dev->priv;
-	
-	switch(cmd) {
-		case VIDIOCGCAP: {
-			struct video_capability *v = arg;
-			memset(v,0,sizeof(*v));
-			strcpy(v->name, "Maestro radio");
-			v->type=VID_TYPE_TUNER;
-			v->channels=v->audios=1;
-			return 0;
-		}
-		case VIDIOCGTUNER: {
-			struct video_tuner *v = arg;
-			if(v->tuner)
-				return -EINVAL;
-			(void)radio_bits_get(card);
-			v->flags = VIDEO_TUNER_LOW | card->stereo;
-			v->signal = card->tuned;
-			strcpy(v->name, "FM");
-			v->rangelow = FREQ_LO;
-			v->rangehigh = FREQ_HI;
-			v->mode = VIDEO_MODE_AUTO;
-		        return 0;
-		}
-		case VIDIOCSTUNER: {
-			struct video_tuner *v = arg;
-			if(v->tuner!=0)
-				return -EINVAL;
-			return 0;
-		}
-		case VIDIOCGFREQ: {
-			unsigned long *freq = arg;
-			*freq = BITS2FREQ(radio_bits_get(card));
-			return 0;
-		}
-		case VIDIOCSFREQ: {
-			unsigned long *freq = arg;
-			if (*freq<FREQ_LO || *freq>FREQ_HI )
-				return -EINVAL;
-			radio_bits_set(card, FREQ2BITS(*freq));
+	struct radio_device *card = dev->priv;
+
+	switch (cmd) {
+	case VIDIOCGCAP: {
+		struct video_capability *v = arg;
+		memset(v, 0, sizeof(*v));
+		strcpy(v->name, "Maestro radio");
+		v->type = VID_TYPE_TUNER;
+		v->channels = v->audios = 1;
+		return 0;
+	} case VIDIOCGTUNER: {
+		struct video_tuner *v = arg;
+		if (v->tuner)
+			return -EINVAL;
+		(void)radio_bits_get(card);
+		v->flags = VIDEO_TUNER_LOW | card->stereo;
+		v->signal = card->tuned;
+		strcpy(v->name, "FM");
+		v->rangelow = FREQ_LO;
+		v->rangehigh = FREQ_HI;
+		v->mode = VIDEO_MODE_AUTO;
+		return 0;
+	} case VIDIOCSTUNER: {
+		struct video_tuner *v = arg;
+		if (v->tuner != 0)
+			return -EINVAL;
+		return 0;
+	} case VIDIOCGFREQ: {
+		unsigned long *freq = arg;
+		*freq = BITS2FREQ(radio_bits_get(card));
+		return 0;
+	} case VIDIOCSFREQ: {
+		unsigned long *freq = arg;
+		if (*freq < FREQ_LO || *freq > FREQ_HI)
+			return -EINVAL;
+		radio_bits_set(card, FREQ2BITS(*freq));
+		return 0;
+	} case VIDIOCGAUDIO: {
+		struct video_audio *v = arg;
+		memset(v, 0, sizeof(*v));
+		strcpy(v->name, "Radio");
+		v->flags = VIDEO_AUDIO_MUTABLE | card->muted;
+		v->mode = VIDEO_SOUND_STEREO;
+		return 0;
+	} case VIDIOCSAUDIO: {
+		struct video_audio *v = arg;
+		if (v->audio)
+			return -EINVAL;
+		{
+			register __u16 io = card->io;
+			register __u16 omask = inw(io + IO_MASK);
+			outw(~STR_WREN, io + IO_MASK);
+			outw((card->muted = v->flags & VIDEO_AUDIO_MUTE) ?
+				STR_WREN : 0, io);
+			udelay(4);
+			outw(omask, io + IO_MASK);
+			msleep(125);
 			return 0;
 		}
-		case VIDIOCGAUDIO: {	
-			struct video_audio *v = arg;
-			memset(v,0,sizeof(*v));
-			strcpy(v->name, "Radio");
-			v->flags=VIDEO_AUDIO_MUTABLE | card->muted;
-			v->mode=VIDEO_SOUND_STEREO;
-			return 0;		
-		}
-		case VIDIOCSAUDIO: {
-			struct video_audio *v = arg;
-			if(v->audio)
-				return -EINVAL;
-			{
-				register __u16 io=card->io;
-				register __u16 omask = inw(io + IO_MASK);
-				outw(~STR_WREN, io + IO_MASK);
-				outw((card->muted = v->flags & VIDEO_AUDIO_MUTE)
-				     ? STR_WREN : 0, io);
-				udelay(4);
-				outw(omask, io + IO_MASK);
-				msleep(125);
-				return 0;
-			}
-		}
-		case VIDIOCGUNIT: {
-			struct video_unit *v = arg;
-			v->video=VIDEO_NO_UNIT;
-			v->vbi=VIDEO_NO_UNIT;
-			v->radio=dev->minor;
-			v->audio=0;
-			v->teletext=VIDEO_NO_UNIT;
-			return 0;		
-		}
-		default: return -ENOIOCTLCMD;
+	} case VIDIOCGUNIT: {
+		struct video_unit *v = arg;
+		v->video = VIDEO_NO_UNIT;
+		v->vbi = VIDEO_NO_UNIT;
+		v->radio = dev->minor;
+		v->audio = 0;
+		v->teletext = VIDEO_NO_UNIT;
+		return 0;
+	} default:
+		return -ENOIOCTLCMD;
 	}
 }
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+	unsigned int cmd, unsigned long arg)
 {
 	struct video_device *dev = video_devdata(file);
-	struct radio_device *card=dev->priv;
+	struct radio_device *card = dev->priv;
 	int ret;
 
 	down(&card->lock);
 	ret = video_usercopy(inode, file, cmd, arg, radio_function);
 	up(&card->lock);
+
 	return ret;
 }
 
 static __u16 __devinit radio_power_on(struct radio_device *dev)
 {
-	register __u16 io=dev->io;
+	register __u16 io = dev->io;
 	register __u32 ofreq;
 	__u16 omask, odir;
+
 	omask = inw(io + IO_MASK);
-	odir  = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
+	odir = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
 	outw(odir & ~STR_WREN, io + IO_DIR);
 	dev->muted = inw(io) & STR_WREN ? 0 : VIDEO_AUDIO_MUTE;
 	outw(odir, io + IO_DIR);
@@ -282,9 +284,11 @@ static __u16 __devinit radio_power_on(st
 	udelay(16);
 	outw(omask, io + IO_MASK);
 	ofreq = radio_bits_get(dev);
-	if((ofreq<FREQ2BITS(FREQ_LO)) || (ofreq>FREQ2BITS(FREQ_HI)))
+
+	if ((ofreq < FREQ2BITS(FREQ_LO)) || (ofreq > FREQ2BITS(FREQ_HI)))
 		ofreq = FREQ2BITS(FREQ_LO);
 	radio_bits_set(dev, ofreq);
+
 	return (ofreq == radio_bits_get(dev));
 }
 
@@ -335,7 +339,7 @@ static int __devinit maestro_probe(struc
 	}
 
 	dev_info(&pdev->dev, "version " DRIVER_VERSION " time " __TIME__ "  "
-		__DATE__ "\n");
+		 __DATE__ "\n");
 	dev_info(&pdev->dev, "radio chip initialized\n");
 
 	return 0;
@@ -355,10 +359,6 @@ static void __devexit maestro_remove(str
 	video_unregister_device(vdev);
 }
 
-MODULE_AUTHOR("Adam Tlalka, atlka@pg.gda.pl");
-MODULE_DESCRIPTION("Radio driver for the Maestro PCI sound card radio.");
-MODULE_LICENSE("GPL");
-
 static int __init maestro_radio_init(void)
 {
 	int retval = pci_register_driver(&maestro_r_driver);
@@ -376,3 +376,7 @@ static void __exit maestro_radio_exit(vo
 
 module_init(maestro_radio_init);
 module_exit(maestro_radio_exit);
+
+MODULE_AUTHOR("Adam Tlalka, atlka@pg.gda.pl");
+MODULE_DESCRIPTION("Radio driver for the Maestro PCI sound card radio.");
+MODULE_LICENSE("GPL");
