Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbUKQMGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUKQMGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUKQMGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:06:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262284AbUKQMD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:03:57 -0500
Date: Wed, 17 Nov 2004 13:01:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: LinuxTV.org@stusta.de, Project@stusta.de
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill dvb_ksyms.c
Message-ID: <20041117120117.GM4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes drivers/media/dvb/dvb-core/dvb_ksyms.c and moves 
the EXPORT_SYMBOL's to the files where the functions are.

In drivers/media/dvb/dvb-core/dvbdev.c, I've also fixed the wromg 
indention in the second half of the function dvb_unregister_device
(no code changes).


diffstat output:
 drivers/media/dvb/dvb-core/Makefile         |    2 
 drivers/media/dvb/dvb-core/dmxdev.c         |    3 -
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c |    5 +
 drivers/media/dvb/dvb-core/dvb_demux.c      |    9 +++
 drivers/media/dvb/dvb-core/dvb_filter.c     |    3 +
 drivers/media/dvb/dvb-core/dvb_frontend.c   |    6 ++
 drivers/media/dvb/dvb-core/dvb_ksyms.c      |   52 --------------------
 drivers/media/dvb/dvb-core/dvb_net.c        |    3 +
 drivers/media/dvb/dvb-core/dvbdev.c         |   17 ++++--
 9 files changed, 41 insertions(+), 59 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/Makefile.old	2004-11-17 00:59:29.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/Makefile	2004-11-17 01:00:00.000000000 +0100
@@ -4,6 +4,6 @@
 
 dvb-core-objs = dvbdev.o dmxdev.o dvb_demux.o dvb_filter.o \
 	        dvb_ca_en50221.o dvb_frontend.o \
-		dvb_net.o dvb_ksyms.o dvb_ringbuffer.o
+		dvb_net.o dvb_ringbuffer.o
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dmxdev.c.old	2004-11-17 00:59:05.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dmxdev.c	2004-11-17 01:00:52.000000000 +0100
@@ -1122,6 +1122,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_dmxdev_init);
 
 void 
 dvb_dmxdev_release(struct dmxdev *dmxdev)
@@ -1138,5 +1139,5 @@
 	}
 	dmxdev->demux->close(dmxdev->demux);
 }
-
+EXPORT_SYMBOL(dvb_dmxdev_release);
 
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_demux.c.old	2004-11-17 01:01:03.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_demux.c	2004-11-17 01:02:25.000000000 +0100
@@ -424,6 +424,7 @@
 			feed->cb.ts(buf, 188, NULL, 0, &feed->feed.ts, DMX_OK);
 	}
 }
+EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
 
 
 void dvb_dmx_swfilter_packets(struct dvb_demux *demux, const u8 *buf, size_t count)
@@ -439,6 +440,7 @@
 
 	spin_unlock(&demux->lock);
 }
+EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
 
 
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count)
@@ -478,6 +480,7 @@
 bailout:
 	spin_unlock(&demux->lock);
 }
+EXPORT_SYMBOL(dvb_dmx_swfilter);
 
 void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count)
 {
@@ -522,6 +525,7 @@
 bailout:
 	spin_unlock(&demux->lock);
 }
+EXPORT_SYMBOL(dvb_dmx_swfilter_204);
 
 
 static struct dvb_demux_filter * dvb_dmx_filter_alloc(struct dvb_demux *demux)
@@ -1163,6 +1167,7 @@
 	up(&dvbdemux->mutex);
 	return 0;
 }
+EXPORT_SYMBOL(dvbdmx_connect_frontend);
 
 
 int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
@@ -1176,6 +1181,7 @@
 	up(&dvbdemux->mutex);
 	return 0;
 }
+EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 
 static int dvbdmx_get_pes_pids(struct dmx_demux *demux, u16 *pids)
@@ -1256,6 +1262,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_dmx_init);
 
 
 int dvb_dmx_release(struct dvb_demux *dvbdemux)
@@ -1269,3 +1276,5 @@
 		vfree(dvbdemux->feed);
 	return 0;
 }
+EXPORT_SYMBOL(dvb_dmx_release);
+
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_frontend.c.old	2004-11-17 01:02:40.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-11-17 01:03:49.000000000 +0100
@@ -950,6 +950,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_add_frontend_ioctls);
 
 
 void
@@ -998,6 +999,7 @@
 
 	up (&frontend_mutex);
 }
+EXPORT_SYMBOL(dvb_remove_frontend_ioctls);
 
 
 int
@@ -1043,6 +1045,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_add_frontend_notifier);
 
 
 void
@@ -1085,6 +1088,7 @@
 
 	up (&frontend_mutex);
 }
+EXPORT_SYMBOL(dvb_remove_frontend_notifier);
 
 
 static struct file_operations dvb_frontend_fops = {
@@ -1186,6 +1190,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_register_frontend);
 
 int dvb_unregister_frontend (int (*ioctl) (struct dvb_frontend *frontend,
 					   unsigned int cmd, void *arg),
@@ -1215,4 +1220,5 @@
 	up (&frontend_mutex);
 	return -EINVAL;
 }
+EXPORT_SYMBOL(dvb_unregister_frontend);
 
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_net.c.old	2004-11-17 01:04:04.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_net.c	2004-11-17 01:04:37.000000000 +0100
@@ -30,6 +30,7 @@
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -1193,6 +1194,7 @@
 		dvb_net_remove_if(dvbnet, i);
 	}
 }
+EXPORT_SYMBOL(dvb_net_release);
 
 
 int dvb_net_init (struct dvb_adapter *adap, struct dvb_net *dvbnet,
@@ -1210,4 +1212,5 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_net_init);
 
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvbdev.c.old	2004-11-17 01:04:54.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvbdev.c	2004-11-17 01:07:49.000000000 +0100
@@ -132,6 +132,7 @@
 	dvbdev->users--;
 	return 0;
 }
+EXPORT_SYMBOL(dvb_generic_open);
 
 
 int dvb_generic_release(struct inode *inode, struct file *file)
@@ -150,6 +151,7 @@
 	dvbdev->users++;
 	return 0;
 }
+EXPORT_SYMBOL(dvb_generic_release);
 
 
 int dvb_generic_ioctl(struct inode *inode, struct file *file,
@@ -165,6 +167,7 @@
 
 	return dvb_usercopy (inode, file, cmd, arg, dvbdev->kernel_ioctl);
 }
+EXPORT_SYMBOL(dvb_generic_ioctl);
 
 
 static int dvbdev_get_free_id (struct dvb_adapter *adap, int type)
@@ -235,6 +238,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_register_device);
 
 
 void dvb_unregister_device(struct dvb_device *dvbdev)
@@ -242,15 +246,16 @@
 	if (!dvbdev)
 		return;
 
-		devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
-				dnames[dvbdev->type], dvbdev->id);
+	devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
+			dnames[dvbdev->type], dvbdev->id);
 
 	class_simple_device_remove(MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num,
 					dvbdev->type, dvbdev->id)));
 
-		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
-	}
+	list_del(&dvbdev->list_head);
+	kfree(dvbdev);
+}
+EXPORT_SYMBOL(dvb_unregister_device);
 
 
 static int dvbdev_get_free_adapter_num (void)
@@ -309,6 +314,7 @@
 
 	return num;
 }
+EXPORT_SYMBOL(dvb_register_adapter);
 
 
 int dvb_unregister_adapter(struct dvb_adapter *adap)
@@ -322,6 +328,7 @@
 	kfree (adap);
 	return 0;
 }
+EXPORT_SYMBOL(dvb_unregister_adapter);
 
 /* if the miracle happens and "generic_usercopy()" is included into
    the kernel, then this can vanish. please don't make the mistake and
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_filter.c.old	2004-11-17 01:08:07.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_filter.c	2004-11-17 01:08:58.000000000 +0100
@@ -389,6 +389,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(dvb_filter_get_ac3info);
 
 
 #if 0
@@ -563,6 +564,7 @@
 	p2ts->cb=cb;
 	p2ts->priv=priv;
 }
+EXPORT_SYMBOL(dvb_filter_pes2ts_init);
 
 int dvb_filter_pes2ts(struct dvb_filter_pes2ts *p2ts, unsigned char *pes,
 		      int len, int payload_start)
@@ -597,4 +599,5 @@
 	memcpy(buf+5+rest, pes, len);
 	return p2ts->cb(p2ts->priv, buf);
 }
+EXPORT_SYMBOL(dvb_filter_pes2ts);
 
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_ca_en50221.c.old	2004-11-17 01:09:17.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-11-17 01:10:06.000000000 +0100
@@ -771,6 +771,7 @@
         atomic_inc(&ca->slot_info[slot].camchange_count);
         dvb_ca_en50221_thread_wakeup(ca);
 }
+EXPORT_SYMBOL(dvb_ca_en50221_camchange_irq);
 
 
 /**
@@ -790,6 +791,7 @@
                 dvb_ca_en50221_thread_wakeup(ca);
         }
 }
+EXPORT_SYMBOL(dvb_ca_en50221_camready_irq);
 
 
 /**
@@ -819,6 +821,7 @@
                 break;
         }
 }
+EXPORT_SYMBOL(dvb_ca_en50221_frda_irq);
 
 
 
@@ -1591,6 +1594,7 @@
         pubca->private = NULL;
         return ret;
 }
+EXPORT_SYMBOL(dvb_ca_en50221_init);
 
 
 
@@ -1627,4 +1631,5 @@
         kfree(ca);
         pubca->private = NULL;
 }
+EXPORT_SYMBOL(dvb_ca_en50221_release);
 
--- linux-2.6.10-rc2-mm1-full/drivers/media/dvb/dvb-core/dvb_ksyms.c	2004-11-16 18:56:35.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,52 +0,0 @@
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/ioctl.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <asm/uaccess.h>
-
-#include "dmxdev.h"
-#include "dvb_demux.h"
-#include "dvb_frontend.h"
-#include "dvb_net.h"
-#include "dvb_filter.h"
-#include "dvb_ca_en50221.h"
-
-EXPORT_SYMBOL(dvb_dmxdev_init);
-EXPORT_SYMBOL(dvb_dmxdev_release);
-EXPORT_SYMBOL(dvb_dmx_init);
-EXPORT_SYMBOL(dvb_dmx_release);
-EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
-EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
-EXPORT_SYMBOL(dvb_dmx_swfilter);
-EXPORT_SYMBOL(dvb_dmx_swfilter_204);
-EXPORT_SYMBOL(dvbdmx_connect_frontend);
-EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
-
-EXPORT_SYMBOL(dvb_register_frontend);
-EXPORT_SYMBOL(dvb_unregister_frontend);
-EXPORT_SYMBOL(dvb_add_frontend_ioctls);
-EXPORT_SYMBOL(dvb_remove_frontend_ioctls);
-EXPORT_SYMBOL(dvb_add_frontend_notifier);
-EXPORT_SYMBOL(dvb_remove_frontend_notifier);
-
-EXPORT_SYMBOL(dvb_net_init);
-EXPORT_SYMBOL(dvb_net_release);
-
-EXPORT_SYMBOL(dvb_register_adapter);
-EXPORT_SYMBOL(dvb_unregister_adapter);
-EXPORT_SYMBOL(dvb_register_device);
-EXPORT_SYMBOL(dvb_unregister_device);
-EXPORT_SYMBOL(dvb_generic_ioctl);
-EXPORT_SYMBOL(dvb_generic_open);
-EXPORT_SYMBOL(dvb_generic_release);
-
-EXPORT_SYMBOL(dvb_filter_pes2ts_init);
-EXPORT_SYMBOL(dvb_filter_pes2ts);
-EXPORT_SYMBOL(dvb_filter_get_ac3info);
-
-EXPORT_SYMBOL(dvb_ca_en50221_init);
-EXPORT_SYMBOL(dvb_ca_en50221_release);
-EXPORT_SYMBOL(dvb_ca_en50221_frda_irq);
-EXPORT_SYMBOL(dvb_ca_en50221_camchange_irq);
-EXPORT_SYMBOL(dvb_ca_en50221_camready_irq);

