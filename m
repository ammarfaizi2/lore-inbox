Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRBXQeZ>; Sat, 24 Feb 2001 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbRBXQeQ>; Sat, 24 Feb 2001 11:34:16 -0500
Received: from [195.228.216.122] ([195.228.216.122]:62220 "EHLO
	fw.kirowski.com") by vger.kernel.org with ESMTP id <S129429AbRBXQeG>;
	Sat, 24 Feb 2001 11:34:06 -0500
Date: Sat, 24 Feb 2001 17:39:32 +0100 (CET)
From: Pifko Krisztian <pifko@kirowski.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] philips rush usb support
Message-ID: <Pine.LNX.4.30.0102241730370.19866-100000@pifko.kirowski.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I've made a patch which adds usb support for the philips
rush mp3 player. The driver is mainly the rio500 driver
only the rush specific parts were modified.

The patch is against 2.4.2.

It uses char 180 65 at /dev/usb/rush.

Userspace stuff should be found at http://openrush.sourceforge.net
if you have a rush. It works for me on ia32 with the model sa125.


regards:

Krisztian Pifko


diff -urN -X dontdiff linux/Documentation/Configure.help linux-2.4.2-rush1/Documentation/Configure.help
--- linux/Documentation/Configure.help	Sat Feb 24 15:44:32 2001
+++ linux-2.4.2-rush1/Documentation/Configure.help	Sat Feb 24 15:49:02 2001
@@ -10727,6 +10727,17 @@
   The module will be called rio500.o. If you want to compile it as
   a module, say M here and read Documentation/modules.txt.

+USB Philips Rush support
+CONFIG_USB_RUSH
+  Say Y here if you want to connect a USB Philips Rush mp3 player to your
+  computer's USB port. Please read Documentation/usb/rush.txt
+  for more information.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called rush.o. If you want to compile it as
+  a module, say M here and read Documentation/modules.txt.
+
 D-Link DSB-R100 FM radio support
 CONFIG_USB_DSBR
   Say Y here if you want to connect this type of radio to your
diff -urN -X dontdiff linux/Documentation/usb/rush.txt linux-2.4.2-rush1/Documentation/usb/rush.txt
--- linux/Documentation/usb/rush.txt	Wed Dec 31 19:00:00 1969
+++ linux-2.4.2-rush1/Documentation/usb/rush.txt	Sat Feb 24 15:49:02 2001
@@ -0,0 +1,113 @@
+Copyright (C) 2001 Krisztian Pifko
+Based on rio.txt
+
+Feb. 25, 2001
+
+CHANGES
+
+- Initial Release
+
+
+OVERVIEW
+
+This README will address issues regarding how to configure the kernel
+to access a Philips Rush mp3 player.
+Before I explain how to use this to access the Rush please be warned:
+
+W A R N I N G:
+--------------
+
+Please note that this software is still under development.  The authors
+are in no way responsible for any damage that may occur, no matter how
+inconsequential.
+
+Contact information:
+--------------------
+
+   The main page for the project is hosted at sourceforge.net in the following
+   address: http://rush.sourceforge.net You can also go to the sourceforge
+   project page at: http://sourceforge.net/projects/openrush/ There is
+   also a mailing list: openrush-users@lists.sourceforge.net
+
+Authors:
+-------
+
+Kernel code based on the rio500 driver. Modified by Krisztian Pifko
+<monsta@users.sourceforge.net> to suit the needs of Rush.
+
+
+ADDITIONAL INFORMATION and Userspace tools
+
+http://openrush.sourceforge.net/
+
+
+REQUIREMENTS
+
+A host with a USB port.  Ideally, either a UHCI (Intel) or OHCI
+(Compaq and others) hardware port should work.
+
+A Linux development kernel (2.3.x) with USB support enabled or a
+backported version to linux-2.2.x.  See http://www.linux-usb.org for
+more information on accomplishing this.
+
+A Linux kernel with Rush support enabled.
+
+'lspci' which is only needed to determine the type of USB hardware
+available in your machine.
+
+CONFIGURATION
+
+Using `lspci -v`, determine the type of USB hardware available.
+
+  If you see something like:
+
+    USB Controller: ......
+    Flags: .....
+    I/O ports at ....
+
+  Then you have a UHCI based controller.
+
+  If you see something like:
+
+     USB Controller: .....
+     Flags: ....
+     Memory at .....
+
+  Then you have a OHCI based controller.
+
+Using `make menuconfig` or your preferred method for configuring the
+kernel, select 'Support for USB', 'OHCI/UHCI' depending on your
+hardware (determined from the steps above), 'USB Philips Rush support', and
+'Preliminary USB device filesystem'.  Compile and install the modules
+(you may need to execute `depmod -a` to update the module
+dependencies).
+
+Add a device for the USB rush:
+  `mknod /dev/usb/rush c 180 65
+
+Set appropriate permissions for /dev/usb/rush (don't forget about
+group and world permissions).  Both read and write permissions are
+required for proper operation.
+
+Load the appropriate modules (if compiled as modules):
+
+  OHCI:
+    modprobe usbcore
+    modprobe usb-ohci
+    modprobe rush
+
+  UHCI:
+    modprobe usbcore
+    modprobe usb-uhci  (or uhci)
+    modprobe rush
+
+That's it.  The OpenRUSH utilities at: http://openrush.sourceforge.net should
+be able to access the rush.
+
+BUGS
+
+If you encounter any problems please contact me.
+
+Krisztian Pifko
+monsta@users.sourceforge.net
+
diff -urN -X dontdiff linux/MAINTAINERS linux-2.4.2-rush1/MAINTAINERS
--- linux/MAINTAINERS	Sat Feb 24 15:44:32 2001
+++ linux-2.4.2-rush1/MAINTAINERS	Sat Feb 24 15:49:02 2001
@@ -1423,6 +1423,13 @@
 W:	http://rio500.sourceforge.net
 S:	Maintained

+USB PHILIPS RUSH DRIVER
+P:	Krisztian Pifko
+M:	monsta@users.sourceforge.net
+L:	openrush-users@lists.sourceforge.net
+W:	http://openrush.sourceforge.net
+S:	Maintained
+
 VIDEO FOR LINUX
 P:	Alan Cox
 M:	Alan.Cox@linux.org
diff -urN -X dontdiff linux/Makefile linux-2.4.2-rush1/Makefile
--- linux/Makefile	Sat Feb 24 15:44:32 2001
+++ linux-2.4.2-rush1/Makefile	Sat Feb 24 15:50:12 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 2
-EXTRAVERSION =
+EXTRAVERSION = -rush1

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

diff -urN -X dontdiff linux/arch/arm/def-configs/footbridge linux-2.4.2-rush1/arch/arm/def-configs/footbridge
--- linux/arch/arm/def-configs/footbridge	Sat Feb 24 14:00:08 2001
+++ linux-2.4.2-rush1/arch/arm/def-configs/footbridge	Sat Feb 24 15:49:02 2001
@@ -870,6 +870,7 @@
 # CONFIG_USB_PLUSB is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_RUSH is not set
 # CONFIG_USB_DSBR is not set
 # CONFIG_USB_BLUETOOTH is not set
 # CONFIG_USB_NET1080 is not set
diff -urN -X dontdiff linux/arch/arm/defconfig linux-2.4.2-rush1/arch/arm/defconfig
--- linux/arch/arm/defconfig	Sat Feb 24 13:50:08 2001
+++ linux-2.4.2-rush1/arch/arm/defconfig	Sat Feb 24 15:49:02 2001
@@ -277,6 +277,7 @@
 # CONFIG_USB_PLUSB is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_RUSH is not set
 # CONFIG_USB_DSBR is not set

 #
diff -urN -X dontdiff linux/arch/i386/defconfig linux-2.4.2-rush1/arch/i386/defconfig
--- linux/arch/i386/defconfig	Sat Feb 24 15:44:33 2001
+++ linux-2.4.2-rush1/arch/i386/defconfig	Sat Feb 24 15:49:02 2001
@@ -717,6 +717,7 @@
 # USB misc drivers
 #
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_RUSH is not set

 #
 # Kernel hacking
diff -urN -X dontdiff linux/arch/ppc/configs/common_defconfig linux-2.4.2-rush1/arch/ppc/configs/common_defconfig
--- linux/arch/ppc/configs/common_defconfig	Sat Feb 24 14:04:09 2001
+++ linux-2.4.2-rush1/arch/ppc/configs/common_defconfig	Sat Feb 24 15:49:02 2001
@@ -831,6 +831,7 @@
 # USB misc drivers
 #
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_RUSH is not set

 #
 # Kernel hacking
diff -urN -X dontdiff linux/arch/ppc/defconfig linux-2.4.2-rush1/arch/ppc/defconfig
--- linux/arch/ppc/defconfig	Sat Feb 24 14:04:09 2001
+++ linux-2.4.2-rush1/arch/ppc/defconfig	Sat Feb 24 15:49:02 2001
@@ -831,6 +831,7 @@
 # USB misc drivers
 #
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_RUSH is not set

 #
 # Kernel hacking
diff -urN -X dontdiff linux/drivers/usb/Config.in linux-2.4.2-rush1/drivers/usb/Config.in
--- linux/drivers/usb/Config.in	Sat Feb 24 14:00:28 2001
+++ linux-2.4.2-rush1/drivers/usb/Config.in	Sat Feb 24 15:49:02 2001
@@ -71,6 +71,7 @@

    comment 'USB misc drivers'
    dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate '  USB Philips Rush support (EXPERIMENTAL)' CONFIG_USB_RUSH $CONFIG_USB $CONFIG_EXPERIMENTAL
 fi

 endmenu
diff -urN -X dontdiff linux/drivers/usb/Makefile linux-2.4.2-rush1/drivers/usb/Makefile
--- linux/drivers/usb/Makefile	Sat Feb 24 14:03:03 2001
+++ linux-2.4.2-rush1/drivers/usb/Makefile	Sat Feb 24 15:49:02 2001
@@ -59,6 +59,7 @@
 obj-$(CONFIG_USB_MICROTEK)	+= microtek.o
 obj-$(CONFIG_USB_BLUETOOTH)	+= bluetooth.o
 obj-$(CONFIG_USB_NET1080)	+= net1080.o
+obj-$(CONFIG_USB_RUSH)		+= rush.o

 # Object files in subdirectories

diff -urN -X dontdiff linux/drivers/usb/rush.c linux-2.4.2-rush1/drivers/usb/rush.c
--- linux/drivers/usb/rush.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.2-rush1/drivers/usb/rush.c	Sat Feb 24 15:49:02 2001
@@ -0,0 +1,504 @@
+/* -*- linux-c -*- */
+
+/*
+ * Driver for USB Philips Rush
+ *
+ * Krisztian Pifko (monsta@users.sourceforge.net)
+ *
+ * based on rio500.c by Cesar Miquel (miquel@df.uba.ar)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/random.h>
+#include <linux/poll.h>
+#include <linux/init.h>
+#include <linux/malloc.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include <linux/smp_lock.h>
+
+#include "rush_usb.h"
+
+#define RUSH_MINOR   65
+
+/* stall/wait timeout for rush */
+#define NAK_TIMEOUT (HZ)
+
+#define IBUF_SIZE 0x1000
+
+/* Size of the rush buffer */
+#define OBUF_SIZE 0x10000
+
+struct rush_usb_data {
+        struct usb_device *rush_dev;    /* init: probe_rush */
+        unsigned int ifnum;             /* Interface number of the USB device */
+        int isopen;                     /* nz if open */
+        int present;                    /* Device is present on the bus */
+        char *obuf, *ibuf;              /* transfer buffers */
+        char bulk_in_ep, bulk_out_ep;   /* Endpoint assignments */
+        wait_queue_head_t wait_q;       /* for timeouts */
+	struct semaphore lock;          /* general race avoidance */
+};
+
+static struct rush_usb_data rush_instance;
+
+static int open_rush(struct inode *inode, struct file *file)
+{
+	struct rush_usb_data *rush = &rush_instance;
+
+	lock_kernel();
+
+	if (rush->isopen || !rush->present) {
+		unlock_kernel();
+		return -EBUSY;
+	}
+	rush->isopen = 1;
+
+	init_waitqueue_head(&rush->wait_q);
+
+	MOD_INC_USE_COUNT;
+
+	unlock_kernel();
+
+	info("Rush opened.");
+
+	return 0;
+}
+
+static int close_rush(struct inode *inode, struct file *file)
+{
+	struct rush_usb_data *rush = &rush_instance;
+
+	rush->isopen = 0;
+
+	MOD_DEC_USE_COUNT;
+
+	info("Rush closed.");
+	return 0;
+}
+
+static int
+ioctl_rush(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	struct RushCommand rush_cmd;
+	struct rush_usb_data *rush = &rush_instance;
+	void *data;
+	unsigned char *buffer;
+	int result, requesttype;
+	int retries;
+	int retval;
+
+        /* Sanity check to make sure rush is connected, powered, etc */
+        if ( rush == NULL ||
+             rush->present == 0 ||
+             rush->rush_dev == NULL )
+          return -1;
+
+	switch (cmd) {
+	case RUSH_RECV_COMMAND:
+		data = (void *) arg;
+		if (data == NULL)
+			break;
+		if (copy_from_user(&rush_cmd, data, sizeof(struct RushCommand))) {
+			retval = -EFAULT;
+			goto err_out;
+		}
+		if (rush_cmd.length > PAGE_SIZE) {
+			retval = -EINVAL;
+			goto err_out;
+		}
+		buffer = (unsigned char *) __get_free_page(GFP_KERNEL);
+		if (buffer == NULL)
+			return -ENOMEM;
+		if (copy_from_user(buffer, rush_cmd.buffer, rush_cmd.length)) {
+			retval = -EFAULT;
+			free_page((unsigned long) buffer);
+			goto err_out;
+		}
+
+		requesttype = rush_cmd.requesttype | USB_DIR_IN |
+		    USB_TYPE_VENDOR | USB_RECIP_DEVICE;
+		dbg
+		    ("sending command:reqtype=%0x req=%0x value=%0x index=%0x len=%0x",
+		     requesttype, rush_cmd.request, rush_cmd.value,
+		     rush_cmd.index, rush_cmd.length);
+		/* Send rush control message */
+		retries = 3;
+		down(&(rush->lock));
+		while (retries) {
+			result = usb_control_msg(rush->rush_dev,
+						 usb_rcvctrlpipe(rush-> rush_dev, 0),
+						 rush_cmd.request,
+						 requesttype,
+						 rush_cmd.value,
+						 rush_cmd.index, buffer,
+						 rush_cmd.length,
+						 rush_cmd.timeout);
+			if (result == -ETIMEDOUT)
+				retries--;
+			else if (result < 0) {
+				err("Error executing ioctrl. code = %d",
+				     le32_to_cpu(result));
+				retries = 0;
+			} else {
+				dbg("Executed ioctl. Result = %d (data=%04x)",
+				     le32_to_cpu(result),
+				     le32_to_cpu(*((long *) buffer)));
+				if (copy_to_user(rush_cmd.buffer, buffer,
+						 rush_cmd.length)) {
+					up(&(rush->lock));
+					free_page((unsigned long) buffer);
+					retval = -EFAULT;
+					goto err_out;
+				}
+				retries = 0;
+			}
+
+			/* rush_cmd.buffer contains a raw stream of single byte
+			   data which has been returned from rush.  Data is
+			   interpreted at application level.  For data that
+			   will be cast to data types longer than 1 byte, data
+			   will be little_endian and will potentially need to
+			   be swapped at the app level */
+
+		}
+		up(&(rush->lock));
+		free_page((unsigned long) buffer);
+		break;
+
+	case RUSH_SEND_COMMAND:
+		data = (void *) arg;
+		if (data == NULL)
+			break;
+		if (copy_from_user(&rush_cmd, data, sizeof(struct RushCommand)))
+			return -EFAULT;
+		if (rush_cmd.length > PAGE_SIZE)
+			return -EINVAL;
+		buffer = (unsigned char *) __get_free_page(GFP_KERNEL);
+		if (buffer == NULL)
+			return -ENOMEM;
+		if (copy_from_user(buffer, rush_cmd.buffer, rush_cmd.length)) {
+			free_page((unsigned long)buffer);
+			return -EFAULT;
+		}
+
+		requesttype = rush_cmd.requesttype | USB_DIR_OUT |
+		    USB_TYPE_VENDOR | USB_RECIP_DEVICE;
+		dbg("sending command: reqtype=%0x req=%0x value=%0x index=%0x len=%0x",
+		     requesttype, rush_cmd.request, rush_cmd.value,
+		     rush_cmd.index, rush_cmd.length);
+		/* Send rush control message */
+		retries = 3;
+		down(&(rush->lock));
+		while (retries) {
+			result = usb_control_msg(rush->rush_dev,
+						 usb_sndctrlpipe(rush-> rush_dev, 0),
+						 rush_cmd.request,
+						 requesttype,
+						 rush_cmd.value,
+						 rush_cmd.index, buffer,
+						 rush_cmd.length,
+						 rush_cmd.timeout);
+			if (result == -ETIMEDOUT)
+				retries--;
+			else if (result < 0) {
+				err("Error executing ioctrl. code = %d",
+				     le32_to_cpu(result));
+				retries = 0;
+			} else {
+				dbg("Executed ioctl. Result = %d",
+				       le32_to_cpu(result));
+				retries = 0;
+
+			}
+
+		}
+		up(&(rush->lock));
+		free_page((unsigned long) buffer);
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+		break;
+	}
+
+	return 0;
+
+err_out:
+	up(&(rush->lock));
+	return retval;
+}
+
+static ssize_t
+write_rush(struct file *file, const char *buffer,
+	  size_t count, loff_t * ppos)
+{
+	struct rush_usb_data *rush = &rush_instance;
+
+	unsigned long copy_size;
+	unsigned long bytes_written = 0;
+	unsigned int partial;
+
+	int result = 0;
+	int maxretry;
+	int errn = 0;
+
+        /* Sanity check to make sure rush is connected, powered, etc */
+        if ( rush == NULL ||
+             rush->present == 0 ||
+             rush->rush_dev == NULL )
+          return -1;
+
+	down(&(rush->lock));
+
+	do {
+		unsigned long thistime;
+		char *obuf = rush->obuf;
+
+		thistime = copy_size =
+		    (count >= OBUF_SIZE) ? OBUF_SIZE : count;
+		if (copy_from_user(rush->obuf, buffer, copy_size)) {
+			errn = -EFAULT;
+			goto error;
+		}
+		maxretry = 5;
+		while (thistime) {
+			if (!rush->rush_dev) {
+				errn = -ENODEV;
+				goto error;
+			}
+			if (signal_pending(current)) {
+				up(&(rush->lock));
+				return bytes_written ? bytes_written : -EINTR;
+			}
+
+			result = usb_bulk_msg(rush->rush_dev,
+					 usb_sndbulkpipe(rush->rush_dev, 1),
+					 obuf, thistime, &partial, 5 * HZ);
+
+			dbg("write stats: result:%d thistime:%lu partial:%u",
+			     result, thistime, partial);
+
+			if (result == USB_ST_TIMEOUT) {	/* NAK - so hold for a while */
+				if (!maxretry--) {
+					errn = -ETIME;
+					goto error;
+				}
+				interruptible_sleep_on_timeout(&rush-> wait_q, NAK_TIMEOUT);
+				continue;
+			} else if (!result & partial) {
+				obuf += partial;
+				thistime -= partial;
+			} else
+				break;
+		};
+		if (result) {
+			err("Write Whoops - %x", result);
+			errn = -EIO;
+			goto error;
+		}
+		bytes_written += copy_size;
+		count -= copy_size;
+		buffer += copy_size;
+	} while (count > 0);
+
+	up(&(rush->lock));
+
+	return bytes_written ? bytes_written : -EIO;
+
+error:
+	up(&(rush->lock));
+	return errn;
+}
+
+static ssize_t
+read_rush(struct file *file, char *buffer, size_t count, loff_t * ppos)
+{
+	struct rush_usb_data *rush = &rush_instance;
+	ssize_t read_count;
+	unsigned int partial;
+	int this_read;
+	int result;
+	int maxretry = 10;
+	char *ibuf = rush->ibuf;
+
+        /* Sanity check to make sure rush is connected, powered, etc */
+        if ( rush == NULL ||
+             rush->present == 0 ||
+             rush->rush_dev == NULL )
+          return -1;
+
+	read_count = 0;
+
+	down(&(rush->lock));
+
+	while (count > 0) {
+		if (signal_pending(current)) {
+			up(&(rush->lock));
+			return read_count ? read_count : -EINTR;
+		}
+		if (!rush->rush_dev) {
+			up(&(rush->lock));
+			return -ENODEV;
+		}
+		this_read = (count >= IBUF_SIZE) ? IBUF_SIZE : count;
+
+		result = usb_bulk_msg(rush->rush_dev,
+				      usb_rcvbulkpipe(rush->rush_dev, 2),
+				      ibuf, this_read, &partial,
+				      (int) (HZ * 8));
+
+		dbg(KERN_DEBUG "read stats: result:%d this_read:%u partial:%u",
+		       result, this_read, partial);
+
+		if (partial) {
+			count = this_read = partial;
+		} else if (result == USB_ST_TIMEOUT || result == 15) {	/* FIXME: 15 ??? */
+			if (!maxretry--) {
+				up(&(rush->lock));
+				err("read_rush: maxretry timeout");
+				return -ETIME;
+			}
+			interruptible_sleep_on_timeout(&rush->wait_q,
+						       NAK_TIMEOUT);
+			continue;
+		} else if (result != USB_ST_DATAUNDERRUN) {
+			up(&(rush->lock));
+			err("Read Whoops - result:%u partial:%u this_read:%u",
+			     result, partial, this_read);
+			return -EIO;
+		} else {
+			up(&(rush->lock));
+			return (0);
+		}
+
+		if (this_read) {
+			if (copy_to_user(buffer, ibuf, this_read)) {
+				up(&(rush->lock));
+				return -EFAULT;
+			}
+			count -= this_read;
+			read_count += this_read;
+			buffer += this_read;
+		}
+	}
+	up(&(rush->lock));
+	return read_count;
+}
+
+static void *probe_rush(struct usb_device *dev, unsigned int ifnum,
+		       const struct usb_device_id *id)
+{
+	struct rush_usb_data *rush = &rush_instance;
+
+	info("USB Rush found at address %d", dev->devnum);
+
+	rush->present = 1;
+	rush->rush_dev = dev;
+
+	if (!(rush->obuf = (char *) kmalloc(OBUF_SIZE, GFP_KERNEL))) {
+		err("probe_rush: Not enough memory for the output buffer");
+		return NULL;
+	}
+	dbg("probe_rush: obuf address:%p", rush->obuf);
+
+	if (!(rush->ibuf = (char *) kmalloc(IBUF_SIZE, GFP_KERNEL))) {
+		err("probe_rush: Not enough memory for the input buffer");
+		kfree(rush->obuf);
+		return NULL;
+	}
+	dbg("probe_rush: ibuf address:%p", rush->ibuf);
+
+	init_MUTEX(&(rush->lock));
+
+	return rush;
+}
+
+static void disconnect_rush(struct usb_device *dev, void *ptr)
+{
+	struct rush_usb_data *rush = (struct rush_usb_data *) ptr;
+
+	if (rush->isopen) {
+		rush->isopen = 0;
+		/* better let it finish - the release will do whats needed */
+		rush->rush_dev = NULL;
+		return;
+	}
+	kfree(rush->ibuf);
+	kfree(rush->obuf);
+
+	info("USB Rush disconnected.");
+
+	rush->present = 0;
+}
+
+static struct
+file_operations usb_rush_fops = {
+	read:		read_rush,
+	write:		write_rush,
+	ioctl:		ioctl_rush,
+	open:		open_rush,
+	release:	close_rush,
+};
+
+static struct usb_device_id rush_table [] = {
+	{ USB_DEVICE(0x04e8, 0x5600) }, 	/* Rush */
+	{ }					/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, rush_table);
+
+static struct usb_driver rush_driver = {
+	name:		"Philips Rush",
+	probe:		probe_rush,
+	disconnect:	disconnect_rush,
+	fops:		&usb_rush_fops,
+	minor:		RUSH_MINOR,
+	id_table:	rush_table,
+};
+
+int usb_rush_init(void)
+{
+	if (usb_register(&rush_driver) < 0)
+		return -1;
+
+	info("USB Rush support registered.");
+	return 0;
+}
+
+
+void usb_rush_cleanup(void)
+{
+	struct rush_usb_data *rush = &rush_instance;
+
+	rush->present = 0;
+	usb_deregister(&rush_driver);
+
+
+}
+
+module_init(usb_rush_init);
+module_exit(usb_rush_cleanup);
+
+MODULE_AUTHOR("Krisztian Pifko <monsta@users.sourceforge.net>");
+MODULE_DESCRIPTION("USB Philips Rush driver");
diff -urN -X dontdiff linux/drivers/usb/rush_usb.h linux-2.4.2-rush1/drivers/usb/rush_usb.h
--- linux/drivers/usb/rush_usb.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.2-rush1/drivers/usb/rush_usb.h	Sat Feb 24 15:49:02 2001
@@ -0,0 +1,38 @@
+/*  ----------------------------------------------------------------------
+
+    Copyright (C) 2001  Krisztian Pifko  (monsta@users.sourceforge.net)
+    Copyright (C) 2000  Cesar Miquel  (miquel@df.uba.ar)
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    ---------------------------------------------------------------------- */
+
+
+
+#define RUSH_SEND_COMMAND			0x1
+#define RUSH_RECV_COMMAND			0x2
+
+#define RUSH_DIR_OUT               	        0x0
+#define RUSH_DIR_IN				0x1
+
+struct RushCommand {
+	short length;
+	int request;
+	int requesttype;
+	int value;
+	int index;
+	void *buffer;
+	int timeout;
+};

