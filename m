Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVKEQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVKEQdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVKEQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:33:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63689 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751258AbVKEQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:26 -0500
Message-Id: <20051105162714.261619000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:59 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, mchehab@brturbo.com.br,
       video4linux-list@redhat.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/25] v4l: move ioctl32 handlers to drivers/media/
Content-Disposition: inline; filename=compat_vidio.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the 32 bit ioctl compatibility handlers for
Video4Linux into a new file and adds explicit calls to them
to each v4l device driver.

Unfortunately, there does not seem to be any code handling
the v4l2 ioctls, so quite often the code goes through two
separate conversions, first from 32 bit v4l to 64 bit v4l,
and from there to 64 bit v4l2. My patch does not change
that, so there is still much room for improvement.

Also, some drivers have additional ioctl numbers, for
which the conversion should be handled internally to
that driver.

CC: mchehab@brturbo.com.br
CC: video4linux-list@redhat.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/media/radio/miropcm20-radio.c
===================================================================
--- linux-cg.orig/drivers/media/radio/miropcm20-radio.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/miropcm20-radio.c	2005-11-05 14:22:34.000000000 +0100
@@ -220,6 +220,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= pcm20_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-aimslab.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-aimslab.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-aimslab.c	2005-11-05 14:22:34.000000000 +0100
@@ -299,6 +299,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl	        = rt_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-aztech.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-aztech.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-aztech.c	2005-11-05 14:22:34.000000000 +0100
@@ -256,6 +256,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= az_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-cadet.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-cadet.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-cadet.c	2005-11-05 14:22:34.000000000 +0100
@@ -490,6 +490,7 @@
 	.release       	= cadet_release,
 	.read		= cadet_read,
 	.ioctl		= cadet_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-gemtek-pci.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-gemtek-pci.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-gemtek-pci.c	2005-11-05 14:22:34.000000000 +0100
@@ -301,6 +301,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= gemtek_pci_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-gemtek.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-gemtek.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-gemtek.c	2005-11-05 14:22:34.000000000 +0100
@@ -233,6 +233,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= gemtek_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-maestro.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-maestro.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-maestro.c	2005-11-05 14:22:34.000000000 +0100
@@ -72,6 +72,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= radio_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-maxiradio.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-maxiradio.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-maxiradio.c	2005-11-05 14:22:34.000000000 +0100
@@ -80,6 +80,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl	        = radio_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 static struct video_device maxiradio_radio =
Index: linux-cg/drivers/media/radio/radio-rtrack2.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-rtrack2.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-rtrack2.c	2005-11-05 14:22:34.000000000 +0100
@@ -199,6 +199,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= rt_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-sf16fmi.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-sf16fmi.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-sf16fmi.c	2005-11-05 14:22:34.000000000 +0100
@@ -225,6 +225,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= fmi_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-sf16fmr2.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-sf16fmr2.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-sf16fmr2.c	2005-11-05 14:22:34.000000000 +0100
@@ -356,6 +356,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl          = fmr2_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-terratec.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-terratec.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-terratec.c	2005-11-05 14:22:34.000000000 +0100
@@ -276,6 +276,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= tt_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-trust.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-trust.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-trust.c	2005-11-05 14:22:34.000000000 +0100
@@ -255,6 +255,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= tr_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-typhoon.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-typhoon.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-typhoon.c	2005-11-05 14:22:34.000000000 +0100
@@ -261,6 +261,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= typhoon_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/radio/radio-zoltrix.c
===================================================================
--- linux-cg.orig/drivers/media/radio/radio-zoltrix.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/radio/radio-zoltrix.c	2005-11-05 14:22:34.000000000 +0100
@@ -313,6 +313,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl		= zol_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/video/Makefile
===================================================================
--- linux-cg.orig/drivers/media/video/Makefile	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/Makefile	2005-11-05 14:22:34.000000000 +0100
@@ -9,7 +9,7 @@
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
 tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
-obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
+obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o compat_ioctl.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
 	tda7432.o tda9875.o ir-kbd-i2c.o ir-kbd-gpio.o
Index: linux-cg/drivers/media/video/arv.c
===================================================================
--- linux-cg.orig/drivers/media/video/arv.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/arv.c	2005-11-05 14:22:34.000000000 +0100
@@ -750,6 +750,7 @@
 	.release	= video_exclusive_release,
 	.read		= ar_read,
 	.ioctl		= ar_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek		= no_llseek,
 };
 
Index: linux-cg/drivers/media/video/bttv-driver.c
===================================================================
--- linux-cg.orig/drivers/media/video/bttv-driver.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/bttv-driver.c	2005-11-05 14:22:34.000000000 +0100
@@ -3083,6 +3083,7 @@
 	.open	  = bttv_open,
 	.release  = bttv_release,
 	.ioctl	  = bttv_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek	  = no_llseek,
 	.read	  = bttv_read,
 	.mmap	  = bttv_mmap,
Index: linux-cg/drivers/media/video/bw-qcam.c
===================================================================
--- linux-cg.orig/drivers/media/video/bw-qcam.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/bw-qcam.c	2005-11-05 14:22:34.000000000 +0100
@@ -875,6 +875,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl          = qcam_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.read		= qcam_read,
 	.llseek         = no_llseek,
 };
Index: linux-cg/drivers/media/video/c-qcam.c
===================================================================
--- linux-cg.orig/drivers/media/video/c-qcam.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/c-qcam.c	2005-11-05 14:22:34.000000000 +0100
@@ -687,6 +687,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl          = qcam_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.read		= qcam_read,
 	.llseek         = no_llseek,
 };
Index: linux-cg/drivers/media/video/compat_ioctl.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/drivers/media/video/compat_ioctl.c	2005-11-05 15:43:27.000000000 +0100
@@ -0,0 +1,318 @@
+#include <linux/config.h>
+#include <linux/compat.h>
+#include <linux/videodev.h>
+
+#ifdef CONFIG_COMPAT
+struct video_tuner32 {
+	compat_int_t tuner;
+	char name[32];
+	compat_ulong_t rangelow, rangehigh;
+	u32 flags;	/* It is really u32 in videodev.h */
+	u16 mode, signal;
+};
+
+static int get_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
+{
+	int i;
+
+	if(get_user(kp->tuner, &up->tuner))
+		return -EFAULT;
+	for(i = 0; i < 32; i++)
+		__get_user(kp->name[i], &up->name[i]);
+	__get_user(kp->rangelow, &up->rangelow);
+	__get_user(kp->rangehigh, &up->rangehigh);
+	__get_user(kp->flags, &up->flags);
+	__get_user(kp->mode, &up->mode);
+	__get_user(kp->signal, &up->signal);
+	return 0;
+}
+
+static int put_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
+{
+	int i;
+
+	if(put_user(kp->tuner, &up->tuner))
+		return -EFAULT;
+	for(i = 0; i < 32; i++)
+		__put_user(kp->name[i], &up->name[i]);
+	__put_user(kp->rangelow, &up->rangelow);
+	__put_user(kp->rangehigh, &up->rangehigh);
+	__put_user(kp->flags, &up->flags);
+	__put_user(kp->mode, &up->mode);
+	__put_user(kp->signal, &up->signal);
+	return 0;
+}
+
+struct video_buffer32 {
+	compat_caddr_t base;
+	compat_int_t height, width, depth, bytesperline;
+};
+
+static int get_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
+{
+	u32 tmp;
+
+	if (get_user(tmp, &up->base))
+		return -EFAULT;
+
+	/* This is actually a physical address stored
+	 * as a void pointer.
+	 */
+	kp->base = (void *)(unsigned long) tmp;
+
+	__get_user(kp->height, &up->height);
+	__get_user(kp->width, &up->width);
+	__get_user(kp->depth, &up->depth);
+	__get_user(kp->bytesperline, &up->bytesperline);
+	return 0;
+}
+
+static int put_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
+{
+	u32 tmp = (u32)((unsigned long)kp->base);
+
+	if(put_user(tmp, &up->base))
+		return -EFAULT;
+	__put_user(kp->height, &up->height);
+	__put_user(kp->width, &up->width);
+	__put_user(kp->depth, &up->depth);
+	__put_user(kp->bytesperline, &up->bytesperline);
+	return 0;
+}
+
+struct video_clip32 {
+	s32 x, y, width, height;	/* Its really s32 in videodev.h */
+	compat_caddr_t next;
+};
+
+struct video_window32 {
+	u32 x, y, width, height, chromakey, flags;
+	compat_caddr_t clips;
+	compat_int_t clipcount;
+};
+
+static int native_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+
+	if (file->f_ops->unlocked_ioctl)
+		ret = file->f_ops->unlocked_ioctl(file, cmd, arg);
+	else if (file->f_ops->ioctl) {
+		lock_kernel();
+		ret = file->f_ops->ioctl(file->f_dentry->d_inode, file, cmd, arg);
+		unlock_kernel();
+	}
+
+	return ret;
+}
+
+
+/* You get back everything except the clips... */
+static int put_video_window32(struct video_window *kp, struct video_window32 __user *up)
+{
+	if(put_user(kp->x, &up->x))
+		return -EFAULT;
+	__put_user(kp->y, &up->y);
+	__put_user(kp->width, &up->width);
+	__put_user(kp->height, &up->height);
+	__put_user(kp->chromakey, &up->chromakey);
+	__put_user(kp->flags, &up->flags);
+	__put_user(kp->clipcount, &up->clipcount);
+	return 0;
+}
+
+#define VIDIOCGTUNER32		_IOWR('v',4, struct video_tuner32)
+#define VIDIOCSTUNER32		_IOW('v',5, struct video_tuner32)
+#define VIDIOCGWIN32		_IOR('v',9, struct video_window32)
+#define VIDIOCSWIN32		_IOW('v',10, struct video_window32)
+#define VIDIOCGFBUF32		_IOR('v',11, struct video_buffer32)
+#define VIDIOCSFBUF32		_IOW('v',12, struct video_buffer32)
+#define VIDIOCGFREQ32		_IOR('v',14, u32)
+#define VIDIOCSFREQ32		_IOW('v',15, u32)
+
+enum {
+	MaxClips = (~0U-sizeof(struct video_window))/sizeof(struct video_clip)
+};
+
+static int do_set_window(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct video_window32 __user *up = compat_ptr(arg);
+	struct video_window __user *vw;
+	struct video_clip __user *p;
+	int nclips;
+	u32 n;
+
+	if (get_user(nclips, &up->clipcount))
+		return -EFAULT;
+
+	/* Peculiar interface... */
+	if (nclips < 0)
+		nclips = VIDEO_CLIPMAP_SIZE;
+
+	if (nclips > MaxClips)
+		return -ENOMEM;
+
+	vw = compat_alloc_user_space(sizeof(struct video_window) +
+				    nclips * sizeof(struct video_clip));
+
+	p = nclips ? (struct video_clip __user *)(vw + 1) : NULL;
+
+	if (get_user(n, &up->x) || put_user(n, &vw->x) ||
+	    get_user(n, &up->y) || put_user(n, &vw->y) ||
+	    get_user(n, &up->width) || put_user(n, &vw->width) ||
+	    get_user(n, &up->height) || put_user(n, &vw->height) ||
+	    get_user(n, &up->chromakey) || put_user(n, &vw->chromakey) ||
+	    get_user(n, &up->flags) || put_user(n, &vw->flags) ||
+	    get_user(n, &up->clipcount) || put_user(n, &vw->clipcount) ||
+	    get_user(n, &up->clips) || put_user(p, &vw->clips))
+		return -EFAULT;
+
+	if (nclips) {
+		struct video_clip32 __user *u = compat_ptr(n);
+		int i;
+		if (!u)
+			return -EINVAL;
+		for (i = 0; i < nclips; i++, u++, p++) {
+			s32 v;
+			if (get_user(v, &u->x) ||
+			    put_user(v, &p->x) ||
+			    get_user(v, &u->y) ||
+			    put_user(v, &p->y) ||
+			    get_user(v, &u->width) ||
+			    put_user(v, &p->width) ||
+			    get_user(v, &u->height) ||
+			    put_user(v, &p->height) ||
+			    put_user(NULL, &p->next))
+				return -EFAULT;
+		}
+	}
+
+	return native_ioctl(file, VIDIOCSWIN, (unsigned long)p);
+}
+
+static int do_video_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	union {
+		struct video_tuner vt;
+		struct video_buffer vb;
+		struct video_window vw;
+		unsigned long vx;
+	} karg;
+	mm_segment_t old_fs = get_fs();
+	void __user *up = compat_ptr(arg);
+	int err = 0;
+
+	/* First, convert the command. */
+	switch(cmd) {
+	case VIDIOCGTUNER32: cmd = VIDIOCGTUNER; break;
+	case VIDIOCSTUNER32: cmd = VIDIOCSTUNER; break;
+	case VIDIOCGWIN32: cmd = VIDIOCGWIN; break;
+	case VIDIOCGFBUF32: cmd = VIDIOCGFBUF; break;
+	case VIDIOCSFBUF32: cmd = VIDIOCSFBUF; break;
+	case VIDIOCGFREQ32: cmd = VIDIOCGFREQ; break;
+	case VIDIOCSFREQ32: cmd = VIDIOCSFREQ; break;
+	};
+
+	switch(cmd) {
+	case VIDIOCSTUNER:
+	case VIDIOCGTUNER:
+		err = get_video_tuner32(&karg.vt, up);
+		break;
+
+	case VIDIOCSFBUF:
+		err = get_video_buffer32(&karg.vb, up);
+		break;
+
+	case VIDIOCSFREQ:
+		err = get_user(karg.vx, (u32 __user *)up);
+		break;
+	};
+	if(err)
+		goto out;
+
+	set_fs(KERNEL_DS);
+	err = native_ioctl(file, cmd, (unsigned long)&karg);
+	set_fs(old_fs);
+
+	if(err == 0) {
+		switch(cmd) {
+		case VIDIOCGTUNER:
+			err = put_video_tuner32(&karg.vt, up);
+			break;
+
+		case VIDIOCGWIN:
+			err = put_video_window32(&karg.vw, up);
+			break;
+
+		case VIDIOCGFBUF:
+			err = put_video_buffer32(&karg.vb, up);
+			break;
+
+		case VIDIOCGFREQ:
+			err = put_user(((u32)karg.vx), (u32 __user *)up);
+			break;
+		};
+	}
+out:
+	return err;
+}
+
+long v4l_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+
+	if (!file->f_ops->ioctl)
+		return ret;
+
+	switch (cmd) {
+	case VIDIOCSWIN32:
+		ret = do_set_window(file, cmd, arg);
+		break;
+	case VIDIOCGTUNER32:
+	case VIDIOCSTUNER32:
+	case VIDIOCGWIN32:
+	case VIDIOCGFBUF32:
+	case VIDIOCSFBUF32:
+	case VIDIOCGFREQ32:
+	case VIDIOCSFREQ32
+		ret = do_video_ioctl(file, cmd, arg);
+		break;
+
+	/* Little v, the video4linux ioctls (conflict?) */
+	case VIDIOCGCAP:
+	case VIDIOCGCHAN:
+	case VIDIOCSCHAN:
+	case VIDIOCGPICT:
+	case VIDIOCSPICT:
+	case VIDIOCCAPTURE:
+	case VIDIOCKEY:
+	case VIDIOCGAUDIO:
+	case VIDIOCSAUDIO:
+	case VIDIOCSYNC:
+	case VIDIOCMCAPTURE:
+	case VIDIOCGMBUF:
+	case VIDIOCGUNIT:
+	case VIDIOCGCAPTURE:
+	case VIDIOCSCAPTURE:
+
+	/* BTTV specific... */
+	case _IOW('v',  BASE_VIDIOCPRIVATE+0, char [256]):
+	case _IOR('v',  BASE_VIDIOCPRIVATE+1, char [256]):
+	case _IOR('v' , BASE_VIDIOCPRIVATE+2, unsigned int):
+	case _IOW('v' , BASE_VIDIOCPRIVATE+3, char [16]): /* struct bttv_pll_info */
+	case _IOR('v' , BASE_VIDIOCPRIVATE+4, int):
+	case _IOR('v' , BASE_VIDIOCPRIVATE+5, int):
+	case _IOR('v' , BASE_VIDIOCPRIVATE+6, int):
+	case _IOR('v' , BASE_VIDIOCPRIVATE+7, int):
+		ret = native_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+		break;
+
+	return ret;
+}
+#else
+long v4l_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+#endif
+EXPORT_SYMBOL_GPL(v4l_compat_ioctl);
Index: linux-cg/drivers/media/video/cpia.c
===================================================================
--- linux-cg.orig/drivers/media/video/cpia.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/cpia.c	2005-11-05 14:22:34.000000000 +0100
@@ -3807,6 +3807,7 @@
 	.read		= cpia_read,
 	.mmap		= cpia_mmap,
 	.ioctl          = cpia_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-cg.orig/drivers/media/video/cx88/cx88-video.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/cx88/cx88-video.c	2005-11-05 14:22:34.000000000 +0100
@@ -1736,6 +1736,7 @@
 	.poll          = video_poll,
 	.mmap	       = video_mmap,
 	.ioctl	       = video_ioctl,
+	.compat_ioctl  = v4l_compat_ioctl,
 	.llseek        = no_llseek,
 };
 
@@ -1763,6 +1764,7 @@
 	.open          = video_open,
 	.release       = video_release,
 	.ioctl         = radio_ioctl,
+	.compat_ioctl  = v4l_compat_ioctl,
 	.llseek        = no_llseek,
 };
 
Index: linux-cg/drivers/media/video/meye.c
===================================================================
--- linux-cg.orig/drivers/media/video/meye.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/meye.c	2005-11-05 14:22:34.000000000 +0100
@@ -1754,6 +1754,7 @@
 	.release	= meye_release,
 	.mmap		= meye_mmap,
 	.ioctl		= meye_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.poll		= meye_poll,
 	.llseek		= no_llseek,
 };
Index: linux-cg/drivers/media/video/pms.c
===================================================================
--- linux-cg.orig/drivers/media/video/pms.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/pms.c	2005-11-05 14:22:34.000000000 +0100
@@ -883,6 +883,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl          = pms_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.read           = pms_read,
 	.llseek         = no_llseek,
 };
Index: linux-cg/drivers/media/video/saa7134/saa7134-video.c
===================================================================
--- linux-cg.orig/drivers/media/video/saa7134/saa7134-video.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/saa7134/saa7134-video.c	2005-11-05 14:22:34.000000000 +0100
@@ -2214,6 +2214,7 @@
 	.poll     = video_poll,
 	.mmap	  = video_mmap,
 	.ioctl	  = video_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek   = no_llseek,
 };
 
@@ -2223,6 +2224,7 @@
 	.open	  = video_open,
 	.release  = video_release,
 	.ioctl	  = radio_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek   = no_llseek,
 };
 
Index: linux-cg/drivers/media/video/stradis.c
===================================================================
--- linux-cg.orig/drivers/media/video/stradis.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/stradis.c	2005-11-05 14:22:34.000000000 +0100
@@ -1974,6 +1974,7 @@
 	.open		= saa_open,
 	.release	= saa_release,
 	.ioctl		= saa_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.read		= saa_read,
 	.llseek		= no_llseek,
 	.write		= saa_write,
Index: linux-cg/drivers/media/video/w9966.c
===================================================================
--- linux-cg.orig/drivers/media/video/w9966.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/w9966.c	2005-11-05 14:22:34.000000000 +0100
@@ -187,6 +187,7 @@
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
 	.ioctl          = w9966_v4l_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.read           = w9966_v4l_read,
 	.llseek         = no_llseek,
 };
Index: linux-cg/drivers/media/video/zoran_driver.c
===================================================================
--- linux-cg.orig/drivers/media/video/zoran_driver.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/zoran_driver.c	2005-11-05 14:22:34.000000000 +0100
@@ -4678,6 +4678,7 @@
 	.open = zoran_open,
 	.release = zoran_close,
 	.ioctl = zoran_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek = no_llseek,
 	.read = zoran_read,
 	.write = zoran_write,
Index: linux-cg/drivers/media/video/zr36120.c
===================================================================
--- linux-cg.orig/drivers/media/video/zr36120.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/zr36120.c	2005-11-05 14:22:34.000000000 +0100
@@ -1490,6 +1490,7 @@
 	.write		= zoran_write,
 	.poll		= zoran_poll,
 	.ioctl		= zoran_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.mmap		= zoran_mmap,
 	.minor		= -1,
 };
Index: linux-cg/drivers/usb/media/dsbr100.c
===================================================================
--- linux-cg.orig/drivers/usb/media/dsbr100.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/dsbr100.c	2005-11-05 14:22:34.000000000 +0100
@@ -127,6 +127,7 @@
 	.open =		usb_dsbr100_open,
 	.release =     	usb_dsbr100_close,
 	.ioctl =        usb_dsbr100_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek =       no_llseek,
 };
 
Index: linux-cg/drivers/usb/media/ov511.c
===================================================================
--- linux-cg.orig/drivers/usb/media/ov511.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/ov511.c	2005-11-05 14:22:34.000000000 +0100
@@ -4774,6 +4774,7 @@
 	.read =		ov51x_v4l1_read,
 	.mmap =		ov51x_v4l1_mmap,
 	.ioctl =	ov51x_v4l1_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek =	no_llseek,
 };
 
Index: linux-cg/drivers/usb/media/pwc/pwc-if.c
===================================================================
--- linux-cg.orig/drivers/usb/media/pwc/pwc-if.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/pwc/pwc-if.c	2005-11-05 14:22:34.000000000 +0100
@@ -154,6 +154,7 @@
 	.poll =		pwc_video_poll,
 	.mmap =		pwc_video_mmap,
 	.ioctl =        pwc_video_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek =       no_llseek,
 };
 static struct video_device pwc_template = {
Index: linux-cg/drivers/usb/media/se401.c
===================================================================
--- linux-cg.orig/drivers/usb/media/se401.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/se401.c	2005-11-05 14:22:34.000000000 +0100
@@ -1193,6 +1193,7 @@
         .read =         se401_read,
         .mmap =         se401_mmap,
 	.ioctl =        se401_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek =       no_llseek,
 };
 static struct video_device se401_template = {
Index: linux-cg/drivers/usb/media/stv680.c
===================================================================
--- linux-cg.orig/drivers/usb/media/stv680.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/stv680.c	2005-11-05 14:22:34.000000000 +0100
@@ -1343,6 +1343,7 @@
 	.read =		stv680_read,
 	.mmap =		stv680_mmap,
 	.ioctl =        stv680_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek =       no_llseek,
 };
 static struct video_device stv680_template = {
Index: linux-cg/drivers/usb/media/usbvideo.c
===================================================================
--- linux-cg.orig/drivers/usb/media/usbvideo.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/usbvideo.c	2005-11-05 14:22:34.000000000 +0100
@@ -953,6 +953,7 @@
 	.read =   usbvideo_v4l_read,
 	.mmap =   usbvideo_v4l_mmap,
 	.ioctl =  usbvideo_v4l_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.llseek = no_llseek,
 };
 static struct video_device usbvideo_template = {
Index: linux-cg/drivers/usb/media/vicam.c
===================================================================
--- linux-cg.orig/drivers/usb/media/vicam.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/vicam.c	2005-11-05 14:22:34.000000000 +0100
@@ -1236,6 +1236,7 @@
 	.read		= vicam_read,
 	.mmap		= vicam_mmap,
 	.ioctl		= vicam_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek		= no_llseek,
 };
 
Index: linux-cg/drivers/usb/media/w9968cf.c
===================================================================
--- linux-cg.orig/drivers/usb/media/w9968cf.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/usb/media/w9968cf.c	2005-11-05 14:22:34.000000000 +0100
@@ -3491,6 +3491,7 @@
 	.release = w9968cf_release,
 	.read =    w9968cf_read,
 	.ioctl =   w9968cf_ioctl,
+	.compat_ioctl = v4l_compat_ioctl,
 	.mmap =    w9968cf_mmap,
 	.llseek =  no_llseek,
 };
Index: linux-cg/drivers/media/video/saa5249.c
===================================================================
--- linux-cg.orig/drivers/media/video/saa5249.c	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/drivers/media/video/saa5249.c	2005-11-05 14:22:34.000000000 +0100
@@ -709,6 +709,7 @@
 	.open		= saa5249_open,
 	.release       	= saa5249_release,
 	.ioctl          = saa5249_ioctl,
+	.compat_ioctl	= v4l_compat_ioctl,
 	.llseek         = no_llseek,
 };
 
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 15:47:39.000000000 +0100
@@ -175,244 +175,6 @@
 	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
 }
 
-struct video_tuner32 {
-	compat_int_t tuner;
-	char name[32];
-	compat_ulong_t rangelow, rangehigh;
-	u32 flags;	/* It is really u32 in videodev.h */
-	u16 mode, signal;
-};
-
-static int get_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
-{
-	int i;
-
-	if(get_user(kp->tuner, &up->tuner))
-		return -EFAULT;
-	for(i = 0; i < 32; i++)
-		__get_user(kp->name[i], &up->name[i]);
-	__get_user(kp->rangelow, &up->rangelow);
-	__get_user(kp->rangehigh, &up->rangehigh);
-	__get_user(kp->flags, &up->flags);
-	__get_user(kp->mode, &up->mode);
-	__get_user(kp->signal, &up->signal);
-	return 0;
-}
-
-static int put_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
-{
-	int i;
-
-	if(put_user(kp->tuner, &up->tuner))
-		return -EFAULT;
-	for(i = 0; i < 32; i++)
-		__put_user(kp->name[i], &up->name[i]);
-	__put_user(kp->rangelow, &up->rangelow);
-	__put_user(kp->rangehigh, &up->rangehigh);
-	__put_user(kp->flags, &up->flags);
-	__put_user(kp->mode, &up->mode);
-	__put_user(kp->signal, &up->signal);
-	return 0;
-}
-
-struct video_buffer32 {
-	compat_caddr_t base;
-	compat_int_t height, width, depth, bytesperline;
-};
-
-static int get_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
-{
-	u32 tmp;
-
-	if (get_user(tmp, &up->base))
-		return -EFAULT;
-
-	/* This is actually a physical address stored
-	 * as a void pointer.
-	 */
-	kp->base = (void *)(unsigned long) tmp;
-
-	__get_user(kp->height, &up->height);
-	__get_user(kp->width, &up->width);
-	__get_user(kp->depth, &up->depth);
-	__get_user(kp->bytesperline, &up->bytesperline);
-	return 0;
-}
-
-static int put_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
-{
-	u32 tmp = (u32)((unsigned long)kp->base);
-
-	if(put_user(tmp, &up->base))
-		return -EFAULT;
-	__put_user(kp->height, &up->height);
-	__put_user(kp->width, &up->width);
-	__put_user(kp->depth, &up->depth);
-	__put_user(kp->bytesperline, &up->bytesperline);
-	return 0;
-}
-
-struct video_clip32 {
-	s32 x, y, width, height;	/* Its really s32 in videodev.h */
-	compat_caddr_t next;
-};
-
-struct video_window32 {
-	u32 x, y, width, height, chromakey, flags;
-	compat_caddr_t clips;
-	compat_int_t clipcount;
-};
-
-/* You get back everything except the clips... */
-static int put_video_window32(struct video_window *kp, struct video_window32 __user *up)
-{
-	if(put_user(kp->x, &up->x))
-		return -EFAULT;
-	__put_user(kp->y, &up->y);
-	__put_user(kp->width, &up->width);
-	__put_user(kp->height, &up->height);
-	__put_user(kp->chromakey, &up->chromakey);
-	__put_user(kp->flags, &up->flags);
-	__put_user(kp->clipcount, &up->clipcount);
-	return 0;
-}
-
-#define VIDIOCGTUNER32		_IOWR('v',4, struct video_tuner32)
-#define VIDIOCSTUNER32		_IOW('v',5, struct video_tuner32)
-#define VIDIOCGWIN32		_IOR('v',9, struct video_window32)
-#define VIDIOCSWIN32		_IOW('v',10, struct video_window32)
-#define VIDIOCGFBUF32		_IOR('v',11, struct video_buffer32)
-#define VIDIOCSFBUF32		_IOW('v',12, struct video_buffer32)
-#define VIDIOCGFREQ32		_IOR('v',14, u32)
-#define VIDIOCSFREQ32		_IOW('v',15, u32)
-
-enum {
-	MaxClips = (~0U-sizeof(struct video_window))/sizeof(struct video_clip)
-};
-
-static int do_set_window(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct video_window32 __user *up = compat_ptr(arg);
-	struct video_window __user *vw;
-	struct video_clip __user *p;
-	int nclips;
-	u32 n;
-
-	if (get_user(nclips, &up->clipcount))
-		return -EFAULT;
-
-	/* Peculiar interface... */
-	if (nclips < 0)
-		nclips = VIDEO_CLIPMAP_SIZE;
-
-	if (nclips > MaxClips)
-		return -ENOMEM;
-
-	vw = compat_alloc_user_space(sizeof(struct video_window) +
-				    nclips * sizeof(struct video_clip));
-
-	p = nclips ? (struct video_clip __user *)(vw + 1) : NULL;
-
-	if (get_user(n, &up->x) || put_user(n, &vw->x) ||
-	    get_user(n, &up->y) || put_user(n, &vw->y) ||
-	    get_user(n, &up->width) || put_user(n, &vw->width) ||
-	    get_user(n, &up->height) || put_user(n, &vw->height) ||
-	    get_user(n, &up->chromakey) || put_user(n, &vw->chromakey) ||
-	    get_user(n, &up->flags) || put_user(n, &vw->flags) ||
-	    get_user(n, &up->clipcount) || put_user(n, &vw->clipcount) ||
-	    get_user(n, &up->clips) || put_user(p, &vw->clips))
-		return -EFAULT;
-
-	if (nclips) {
-		struct video_clip32 __user *u = compat_ptr(n);
-		int i;
-		if (!u)
-			return -EINVAL;
-		for (i = 0; i < nclips; i++, u++, p++) {
-			s32 v;
-			if (get_user(v, &u->x) ||
-			    put_user(v, &p->x) ||
-			    get_user(v, &u->y) ||
-			    put_user(v, &p->y) ||
-			    get_user(v, &u->width) ||
-			    put_user(v, &p->width) ||
-			    get_user(v, &u->height) ||
-			    put_user(v, &p->height) ||
-			    put_user(NULL, &p->next))
-				return -EFAULT;
-		}
-	}
-
-	return sys_ioctl(fd, VIDIOCSWIN, (unsigned long)p);
-}
-
-static int do_video_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	union {
-		struct video_tuner vt;
-		struct video_buffer vb;
-		struct video_window vw;
-		unsigned long vx;
-	} karg;
-	mm_segment_t old_fs = get_fs();
-	void __user *up = compat_ptr(arg);
-	int err = 0;
-
-	/* First, convert the command. */
-	switch(cmd) {
-	case VIDIOCGTUNER32: cmd = VIDIOCGTUNER; break;
-	case VIDIOCSTUNER32: cmd = VIDIOCSTUNER; break;
-	case VIDIOCGWIN32: cmd = VIDIOCGWIN; break;
-	case VIDIOCGFBUF32: cmd = VIDIOCGFBUF; break;
-	case VIDIOCSFBUF32: cmd = VIDIOCSFBUF; break;
-	case VIDIOCGFREQ32: cmd = VIDIOCGFREQ; break;
-	case VIDIOCSFREQ32: cmd = VIDIOCSFREQ; break;
-	};
-
-	switch(cmd) {
-	case VIDIOCSTUNER:
-	case VIDIOCGTUNER:
-		err = get_video_tuner32(&karg.vt, up);
-		break;
-
-	case VIDIOCSFBUF:
-		err = get_video_buffer32(&karg.vb, up);
-		break;
-
-	case VIDIOCSFREQ:
-		err = get_user(karg.vx, (u32 __user *)up);
-		break;
-	};
-	if(err)
-		goto out;
-
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)&karg);
-	set_fs(old_fs);
-
-	if(err == 0) {
-		switch(cmd) {
-		case VIDIOCGTUNER:
-			err = put_video_tuner32(&karg.vt, up);
-			break;
-
-		case VIDIOCGWIN:
-			err = put_video_window32(&karg.vw, up);
-			break;
-
-		case VIDIOCGFBUF:
-			err = put_video_buffer32(&karg.vb, up);
-			break;
-
-		case VIDIOCGFREQ:
-			err = put_user(((u32)karg.vx), (u32 __user *)up);
-			break;
-		};
-	}
-out:
-	return err;
-}
-
 struct fb_fix_screeninfo32 {
 	char			id[16];
         compat_caddr_t	smem_start;
@@ -1555,14 +1317,6 @@
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
-HANDLE_IOCTL(VIDIOCGTUNER32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCSTUNER32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCGWIN32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCSWIN32, do_set_window)
-HANDLE_IOCTL(VIDIOCGFBUF32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCSFBUF32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCGFREQ32, do_video_ioctl)
-HANDLE_IOCTL(VIDIOCSFREQ32, do_video_ioctl)
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 15:47:39.000000000 +0100
@@ -100,32 +100,6 @@
 COMPATIBLE_IOCTL(TUNSETDEBUG)
 COMPATIBLE_IOCTL(TUNSETPERSIST)
 COMPATIBLE_IOCTL(TUNSETOWNER)
-/* Little v */
-/* Little v, the video4linux ioctls (conflict?) */
-COMPATIBLE_IOCTL(VIDIOCGCAP)
-COMPATIBLE_IOCTL(VIDIOCGCHAN)
-COMPATIBLE_IOCTL(VIDIOCSCHAN)
-COMPATIBLE_IOCTL(VIDIOCGPICT)
-COMPATIBLE_IOCTL(VIDIOCSPICT)
-COMPATIBLE_IOCTL(VIDIOCCAPTURE)
-COMPATIBLE_IOCTL(VIDIOCKEY)
-COMPATIBLE_IOCTL(VIDIOCGAUDIO)
-COMPATIBLE_IOCTL(VIDIOCSAUDIO)
-COMPATIBLE_IOCTL(VIDIOCSYNC)
-COMPATIBLE_IOCTL(VIDIOCMCAPTURE)
-COMPATIBLE_IOCTL(VIDIOCGMBUF)
-COMPATIBLE_IOCTL(VIDIOCGUNIT)
-COMPATIBLE_IOCTL(VIDIOCGCAPTURE)
-COMPATIBLE_IOCTL(VIDIOCSCAPTURE)
-/* BTTV specific... */
-COMPATIBLE_IOCTL(_IOW('v',  BASE_VIDIOCPRIVATE+0, char [256]))
-COMPATIBLE_IOCTL(_IOR('v',  BASE_VIDIOCPRIVATE+1, char [256]))
-COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+2, unsigned int))
-COMPATIBLE_IOCTL(_IOW('v' , BASE_VIDIOCPRIVATE+3, char [16])) /* struct bttv_pll_info */
-COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+4, int))
-COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+5, int))
-COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+6, int))
-COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+7, int))
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(RTC_AIE_ON)
 COMPATIBLE_IOCTL(RTC_AIE_OFF)
Index: linux-cg/include/linux/videodev.h
===================================================================
--- linux-cg.orig/include/linux/videodev.h	2005-11-05 14:19:14.000000000 +0100
+++ linux-cg/include/linux/videodev.h	2005-11-05 14:22:34.000000000 +0100
@@ -90,6 +90,8 @@
 			  unsigned int cmd, unsigned long arg,
 			  int (*func)(struct inode *inode, struct file *file,
 				      unsigned int cmd, void *arg));
+extern long v4l_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg);
 #endif /* __KERNEL__ */
 
 #define VID_TYPE_CAPTURE	1	/* Can capture */

--

