Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVLLXvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVLLXvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLLXqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932262AbVLLXqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:36 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmPn009049@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 12/19] MUTEX: Drivers T-Z changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/t* thru drivers/z* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-TtoZ-2615rc5.diff
 drivers/usb/atm/cxacru.c                |    2 +-
 drivers/usb/atm/usbatm.h                |    4 ++--
 drivers/usb/class/usb-midi.c            |    2 +-
 drivers/usb/class/usblp.c               |    2 +-
 drivers/usb/core/hcd.h                  |    2 +-
 drivers/usb/core/hub.c                  |    2 +-
 drivers/usb/gadget/inode.c              |    2 +-
 drivers/usb/gadget/serial.c             |    8 ++++----
 drivers/usb/image/mdc800.c              |    2 +-
 drivers/usb/image/microtek.h            |    2 +-
 drivers/usb/media/dabusb.h              |    2 +-
 drivers/usb/media/ov511.c               |    2 +-
 drivers/usb/media/ov511.h               |   10 +++++-----
 drivers/usb/media/pwc/pwc.h             |    4 ++--
 drivers/usb/media/se401.h               |    2 +-
 drivers/usb/media/sn9c102.h             |    4 ++--
 drivers/usb/media/stv680.h              |    2 +-
 drivers/usb/media/usbvideo.h            |    4 ++--
 drivers/usb/media/vicam.c               |    2 +-
 drivers/usb/media/w9968cf.h             |    4 ++--
 drivers/usb/misc/auerswald.c            |    6 +++---
 drivers/usb/misc/idmouse.c              |    2 +-
 drivers/usb/misc/ldusb.c                |    2 +-
 drivers/usb/misc/legousbtower.c         |    2 +-
 drivers/usb/misc/rio500.c               |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.h     |    2 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c |    2 +-
 drivers/usb/misc/usbtest.c              |    2 +-
 drivers/usb/mon/mon_text.c              |    2 +-
 drivers/usb/mon/usb_mon.h               |    2 +-
 drivers/usb/net/kaweth.c                |    2 +-
 drivers/usb/serial/io_ti.c              |    6 +++---
 drivers/usb/serial/ti_usb_3410_5052.c   |    6 +++---
 drivers/usb/storage/usb.h               |    4 ++--
 drivers/video/pxafb.h                   |    2 +-
 drivers/video/sa1100fb.h                |    2 +-
 drivers/w1/w1.h                         |    4 ++--
 37 files changed, 57 insertions(+), 57 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/atm/cxacru.c linux-2.6.15-rc5-mutex/drivers/usb/atm/cxacru.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/atm/cxacru.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/atm/cxacru.c	2005-12-12 21:08:49.000000000 +0000
@@ -160,7 +160,7 @@ struct cxacru_data {
 	struct work_struct poll_work;
 
 	/* contol handles */
-	struct semaphore cm_serialize;
+	struct mutex cm_serialize;
 	u8 *rcv_buf;
 	u8 *snd_buf;
 	struct urb *rcv_urb;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/atm/usbatm.h linux-2.6.15-rc5-mutex/drivers/usb/atm/usbatm.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/atm/usbatm.h	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/atm/usbatm.h	2005-12-12 22:12:49.000000000 +0000
@@ -30,7 +30,7 @@
 #define VERBOSE_DEBUG
 */
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <linux/completion.h>
@@ -157,7 +157,7 @@ struct usbatm_data {
         ********************************/
 
 	struct kref refcount;
-	struct semaphore serialize;
+	struct mutex serialize;
 
 	/* heavy init */
 	int thread_pid;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/class/usblp.c linux-2.6.15-rc5-mutex/drivers/usb/class/usblp.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/class/usblp.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/usblp.c	2005-12-12 21:12:27.000000000 +0000
@@ -128,7 +128,7 @@ MFG:HEWLETT-PACKARD;MDL:DESKJET 970C;CMD
 
 struct usblp {
 	struct usb_device 	*dev;			/* USB device */
-	struct semaphore	sem;			/* locks this struct, especially "dev" */
+	struct mutex		sem;			/* locks this struct, especially "dev" */
 	char			*writebuf;		/* write transfer_buffer */
 	char			*readbuf;		/* read transfer_buffer */
 	char			*statusbuf;		/* status transfer_buffer */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/class/usb-midi.c linux-2.6.15-rc5-mutex/drivers/usb/class/usb-midi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/class/usb-midi.c	2005-06-22 13:52:04.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/usb-midi.c	2005-12-12 22:12:49.000000000 +0000
@@ -37,7 +37,7 @@
 #include <linux/poll.h>
 #include <linux/sound.h>
 #include <linux/init.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "usb-midi.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/core/hcd.h linux-2.6.15-rc5-mutex/drivers/usb/core/hcd.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/core/hcd.h	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/core/hcd.h	2005-12-12 21:12:43.000000000 +0000
@@ -364,7 +364,7 @@ extern void usb_set_device_state(struct 
 /* exported only within usbcore */
 
 extern struct list_head usb_bus_list;
-extern struct semaphore usb_bus_list_lock;
+extern struct mutex usb_bus_list_lock;
 extern wait_queue_head_t usb_kill_urb_queue;
 
 extern struct usb_bus *usb_bus_get (struct usb_bus *bus);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/core/hub.c linux-2.6.15-rc5-mutex/drivers/usb/core/hub.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/core/hub.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/core/hub.c	2005-12-12 22:12:49.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/usbdevice_fs.h>
 #include <linux/kthread.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/gadget/inode.c linux-2.6.15-rc5-mutex/drivers/usb/gadget/inode.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/gadget/inode.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/gadget/inode.c	2005-12-12 21:45:18.000000000 +0000
@@ -193,7 +193,7 @@ enum ep_state {
 };
 
 struct ep_data {
-	struct semaphore		lock;
+	struct mutex			lock;
 	enum ep_state			state;
 	atomic_t			count;
 	struct dev_data			*dev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/gadget/serial.c linux-2.6.15-rc5-mutex/drivers/usb/gadget/serial.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/gadget/serial.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/gadget/serial.c	2005-12-12 21:08:36.000000000 +0000
@@ -333,7 +333,7 @@ static const char *EP_IN_NAME;
 static const char *EP_OUT_NAME;
 static const char *EP_NOTIFY_NAME;
 
-static struct semaphore	gs_open_close_sem[GS_NUM_PORTS];
+static struct mutex gs_open_close_sem[GS_NUM_PORTS];
 
 static unsigned int read_q_size = GS_DEFAULT_READ_Q_SIZE;
 static unsigned int write_q_size = GS_DEFAULT_WRITE_Q_SIZE;
@@ -674,7 +674,7 @@ static int __init gs_module_init(void)
 	tty_set_operations(gs_tty_driver, &gs_tty_ops);
 
 	for (i=0; i < GS_NUM_PORTS; i++)
-		sema_init(&gs_open_close_sem[i], 1);
+		init_MUTEX(&gs_open_close_sem[i]);
 
 	retval = tty_register_driver(gs_tty_driver);
 	if (retval) {
@@ -714,7 +714,7 @@ static int gs_open(struct tty_struct *tt
 	struct gs_port *port;
 	struct gs_dev *dev;
 	struct gs_buf *buf;
-	struct semaphore *sem;
+	struct mutex *sem;
 	int ret;
 
 	port_num = tty->index;
@@ -850,7 +850,7 @@ static void gs_close(struct tty_struct *
 {
 	unsigned long flags;
 	struct gs_port *port = tty->driver_data;
-	struct semaphore *sem;
+	struct mutex *sem;
 
 	if (port == NULL) {
 		printk(KERN_ERR "gs_close: NULL port pointer\n");
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/image/mdc800.c linux-2.6.15-rc5-mutex/drivers/usb/image/mdc800.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/image/mdc800.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/image/mdc800.c	2005-12-12 21:12:56.000000000 +0000
@@ -169,7 +169,7 @@ struct mdc800_data
 	int			out_count;	// Bytes in the buffer
 
 	int			open;		// Camera device open ?
-	struct semaphore	io_lock;	// IO -lock
+	struct mutex		io_lock;	// IO -lock
 
 	char 			in [8];		// Command Input Buffer
 	int  			in_count;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/image/microtek.h linux-2.6.15-rc5-mutex/drivers/usb/image/microtek.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/image/microtek.h	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/image/microtek.h	2005-12-12 21:13:03.000000000 +0000
@@ -39,7 +39,7 @@ struct mts_desc {
 	u8 ep_image;
 
 	struct Scsi_Host * host;
-	struct semaphore lock;
+	struct mutex lock;
 
 	struct urb *urb;
 	struct mts_transfer_context context;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/dabusb.h linux-2.6.15-rc5-mutex/drivers/usb/media/dabusb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/dabusb.h	2004-06-18 13:41:51.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/dabusb.h	2005-12-12 21:10:38.000000000 +0000
@@ -18,7 +18,7 @@ typedef enum { _stopped=0, _started } dr
 
 typedef struct
 {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct usb_device *usbdev;
 	wait_queue_head_t wait;
 	wait_queue_head_t remove_ok;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/ov511.c linux-2.6.15-rc5-mutex/drivers/usb/media/ov511.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/ov511.c	2005-06-22 13:52:05.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/ov511.c	2005-12-12 22:12:49.000000000 +0000
@@ -42,7 +42,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/pagemap.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/processor.h>
 #include <linux/mm.h>
 #include <linux/device.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/ov511.h linux-2.6.15-rc5-mutex/drivers/usb/media/ov511.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/ov511.h	2004-09-16 12:06:09.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/ov511.h	2005-12-12 21:09:15.000000000 +0000
@@ -435,7 +435,7 @@ struct usb_ov511 {
 
 	int led_policy;		/* LED: off|on|auto; OV511+ only */
 
-	struct semaphore lock;	/* Serializes user-accessible operations */
+	struct mutex lock;	/* Serializes user-accessible operations */
 	int user;		/* user count for exclusive use */
 
 	int streaming;		/* Are we streaming Isochronous? */
@@ -473,11 +473,11 @@ struct usb_ov511 {
 	int packet_size;	/* Frame size per isoc desc */
 	int packet_numbering;	/* Is ISO frame numbering enabled? */
 
-	struct semaphore param_lock;	/* params lock for this camera */
+	struct mutex param_lock;	/* params lock for this camera */
 
 	/* Framebuffer/sbuf management */
 	int buf_state;
-	struct semaphore buf_lock;
+	struct mutex buf_lock;
 
 	struct ov51x_decomp_ops *decomp_ops;
 
@@ -494,12 +494,12 @@ struct usb_ov511 {
 	int pal;		/* Device is designed for PAL resolution */
 
 	/* I2C interface */
-	struct semaphore i2c_lock;	  /* Protect I2C controller regs */
+	struct mutex i2c_lock;	  /* Protect I2C controller regs */
 	unsigned char primary_i2c_slave;  /* I2C write id of sensor */
 
 	/* Control transaction stuff */
 	unsigned char *cbuf;		/* Buffer for payload */
-	struct semaphore cbuf_lock;
+	struct mutex cbuf_lock;
 };
 
 /* Used to represent a list of values and their respective symbolic names */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/pwc/pwc.h linux-2.6.15-rc5-mutex/drivers/usb/media/pwc/pwc.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/pwc/pwc.h	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/pwc/pwc.h	2005-12-12 22:12:49.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/videodev.h>
 #include <linux/wait.h>
 #include <linux/smp_lock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/errno.h>
 
 #include "pwc-uncompress.h"
@@ -204,7 +204,7 @@ struct pwc_device
    int image_read_pos;			/* In case we read data in pieces, keep track of were we are in the imagebuffer */
    int image_used[MAX_IMAGES];		/* For MCAPTURE and SYNC */
 
-   struct semaphore modlock;		/* to prevent races in video_open(), etc */
+   struct mutex modlock;		/* to prevent races in video_open(), etc */
    spinlock_t ptrlock;			/* for manipulating the buffer pointers */
 
    /*** motorized pan/tilt feature */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/se401.h linux-2.6.15-rc5-mutex/drivers/usb/media/se401.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/se401.h	2004-06-18 13:41:51.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/se401.h	2005-12-12 21:09:27.000000000 +0000
@@ -189,7 +189,7 @@ struct usb_se401 {
 	int maxframesize;
 	int cframesize;		/* current framesize */
 
-	struct semaphore lock;
+	struct mutex lock;
 	int user;		/* user count for exclusive use */
 	int removed;		/* device disconnected */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/sn9c102.h linux-2.6.15-rc5-mutex/drivers/usb/media/sn9c102.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/sn9c102.h	2005-08-30 13:56:27.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/sn9c102.h	2005-12-12 22:12:49.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/types.h>
 #include <linux/param.h>
 #include <linux/rwsem.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "sn9c102_sensor.h"
 
@@ -148,7 +148,7 @@ struct sn9c102_device {
 	enum sn9c102_dev_state state;
 	u8 users;
 
-	struct semaphore dev_sem, fileop_sem;
+	struct mutex dev_sem, fileop_sem;
 	spinlock_t queue_lock;
 	wait_queue_head_t open, wait_frame, wait_stream;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/stv680.h linux-2.6.15-rc5-mutex/drivers/usb/media/stv680.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/stv680.h	2005-08-30 13:56:27.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/stv680.h	2005-12-12 21:10:23.000000000 +0000
@@ -118,7 +118,7 @@ struct usb_stv {
 	int origGain;
 	int origMode;		/* original camera mode */
 
-	struct semaphore lock;	/* to lock the structure */
+	struct mutex lock;	/* to lock the structure */
 	int user;		/* user count for exclusive use */
 	int removed;		/* device disconnected */
 	int streaming;		/* Are we streaming video? */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/usbvideo.h linux-2.6.15-rc5-mutex/drivers/usb/media/usbvideo.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/usbvideo.h	2004-06-18 13:41:51.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/usbvideo.h	2005-12-12 21:10:11.000000000 +0000
@@ -213,7 +213,7 @@ struct uvd {
 	unsigned long flags;		/* FLAGS_USBVIDEO_xxx */
 	unsigned long paletteBits;	/* Which palettes we accept? */
 	unsigned short defaultPalette;	/* What palette to use for read() */
-	struct semaphore lock;
+	struct mutex lock;
 	int user;		/* user count for exclusive use */
 
 	videosize_t videosize;	/* Current setting */
@@ -272,7 +272,7 @@ struct usbvideo {
 	int num_cameras;		/* As allocated */
 	struct usb_driver usbdrv;	/* Interface to the USB stack */
 	char drvName[80];		/* Driver name */
-	struct semaphore lock;		/* Mutex protecting camera structures */
+	struct mutex lock;		/* Mutex protecting camera structures */
 	struct usbvideo_cb cb;		/* Table of callbacks (virtual methods) */
 	struct video_device vdt;	/* Video device template */
 	struct uvd *cam;			/* Array of camera structures */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/vicam.c linux-2.6.15-rc5-mutex/drivers/usb/media/vicam.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/vicam.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/vicam.c	2005-12-12 21:10:31.000000000 +0000
@@ -407,7 +407,7 @@ struct vicam_camera {
 	struct usb_device *udev;	// usb device
 
 	/* guard against simultaneous accesses to the camera */
-	struct semaphore cam_lock;
+	struct mutex cam_lock;
 
 	int is_initialized;
 	u8 open_count;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/w9968cf.h linux-2.6.15-rc5-mutex/drivers/usb/media/w9968cf.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/media/w9968cf.h	2005-06-22 13:52:05.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/w9968cf.h	2005-12-12 22:12:49.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/param.h>
 #include <linux/types.h>
 #include <linux/rwsem.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <media/ovcamchip.h>
 
@@ -278,7 +278,7 @@ struct w9968cf_device {
 	struct i2c_client* sensor_client;
 
 	/* Locks */
-	struct semaphore dev_sem,    /* for probe, disconnect,open and close */
+	struct mutex dev_sem,    /* for probe, disconnect,open and close */
 	                 fileop_sem; /* for read and ioctl */
 	spinlock_t urb_lock,   /* for submit_urb() and unlink_urb() */
 	           flist_lock; /* for requested frame list accesses */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/auerswald.c linux-2.6.15-rc5-mutex/drivers/usb/misc/auerswald.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/auerswald.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/auerswald.c	2005-12-12 21:11:34.000000000 +0000
@@ -232,7 +232,7 @@ typedef struct auerscon
 /* USB device context */
 typedef struct
 {
-	struct semaphore 	mutex;         	    /* protection in user context */
+	struct mutex		mutex;         	    /* protection in user context */
 	char 			name[20];	    /* name of the /dev/usb entry */
 	unsigned int		dtindex;	    /* index in the device table */
 	struct usb_device *	usbdev;      	    /* USB device handle */
@@ -253,12 +253,12 @@ typedef struct
 /* character device context */
 typedef struct
 {
-	struct semaphore mutex;         /* protection in user context */
+	struct mutex mutex;             /* protection in user context */
 	pauerswald_t auerdev;           /* context pointer of assigned device */
         auerbufctl_t bufctl;            /* controls the buffer chain */
         auerscon_t scontext;            /* service context */
 	wait_queue_head_t readwait;     /* for synchronous reading */
-	struct semaphore readmutex;     /* protection against multiple reads */
+	struct mutex readmutex;         /* protection against multiple reads */
 	pauerbuf_t readbuf;		/* buffer held for partial reading */
 	unsigned int readoffset;	/* current offset in readbuf */
 	unsigned int removed;		/* is != 0 if device is removed */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/idmouse.c linux-2.6.15-rc5-mutex/drivers/usb/misc/idmouse.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/idmouse.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/idmouse.c	2005-12-12 21:11:59.000000000 +0000
@@ -81,7 +81,7 @@ struct usb_idmouse {
 
 	int open; /* if the port is open or not */
 	int present; /* if the device is not disconnected */
-	struct semaphore sem; /* locks this structure */
+	struct mutex sem; /* locks this structure */
 
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/ldusb.c linux-2.6.15-rc5-mutex/drivers/usb/misc/ldusb.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/ldusb.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/ldusb.c	2005-12-12 21:11:21.000000000 +0000
@@ -136,7 +136,7 @@ MODULE_PARM_DESC(min_interrupt_out_inter
 
 /* Structure to hold all of our device specific stuff */
 struct ld_usb {
-	struct semaphore	sem;		/* locks this structure */
+	struct mutex		sem;		/* locks this structure */
 	struct usb_interface*	intf;		/* save off the usb interface pointer */
 
 	int			open_count;	/* number of times this port has been opened */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/legousbtower.c linux-2.6.15-rc5-mutex/drivers/usb/misc/legousbtower.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/legousbtower.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/legousbtower.c	2005-12-12 21:11:42.000000000 +0000
@@ -205,7 +205,7 @@ MODULE_DEVICE_TABLE (usb, tower_table);
 
 /* Structure to hold all of our device specific stuff */
 struct lego_usb_tower {
-	struct semaphore	sem;		/* locks this structure */
+	struct mutex		sem;		/* locks this structure */
 	struct usb_device*	udev;		/* save off the usb device pointer */
 	unsigned char		minor;		/* the starting minor number for this device */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/rio500.c linux-2.6.15-rc5-mutex/drivers/usb/misc/rio500.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/rio500.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/rio500.c	2005-12-12 21:11:15.000000000 +0000
@@ -69,7 +69,7 @@ struct rio_usb_data {
         char *obuf, *ibuf;              /* transfer buffers */
         char bulk_in_ep, bulk_out_ep;   /* Endpoint assignments */
         wait_queue_head_t wait_q;       /* for timeouts */
-	struct semaphore lock;          /* general race avoidance */
+	struct mutex lock;              /* general race avoidance */
 };
 
 static struct rio_usb_data rio_instance;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb_con.c linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb_con.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb_con.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb_con.c	2005-12-12 21:11:53.000000000 +0000
@@ -102,7 +102,7 @@ static struct sisusb_usb_data *mysisusbs
 /* Forward declaration */
 static const struct consw sisusb_con;
 
-extern struct semaphore disconnect_sem;
+extern struct mutex disconnect_sem;
 
 static inline void
 sisusbcon_memsetw(u16 *s, u16 c, unsigned int count)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb.h linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb.h	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb.h	2005-12-12 21:11:45.000000000 +0000
@@ -124,7 +124,7 @@ struct sisusb_usb_data {
 	struct usb_interface *interface;
 	struct kref kref;
 	wait_queue_head_t wait_q;	/* for syncind and timeouts */
-	struct semaphore lock;		/* general race avoidance */
+	struct mutex lock;		/* general race avoidance */
 	unsigned int ifnum;		/* interface number of the USB device */
 	int minor;			/* minor (for logging clarity) */
 	int isopen;			/* !=0 if open */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/usbtest.c linux-2.6.15-rc5-mutex/drivers/usb/misc/usbtest.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/misc/usbtest.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/usbtest.c	2005-12-12 21:12:07.000000000 +0000
@@ -65,7 +65,7 @@ struct usbtest_dev {
 	int			in_iso_pipe;
 	int			out_iso_pipe;
 	struct usb_endpoint_descriptor	*iso_in, *iso_out;
-	struct semaphore	sem;
+	struct mutex		sem;
 
 #define TBUF_SIZE	256
 	u8			*buf;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/mon/mon_text.c linux-2.6.15-rc5-mutex/drivers/usb/mon/mon_text.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/mon/mon_text.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/mon/mon_text.c	2005-12-12 21:10:57.000000000 +0000
@@ -54,7 +54,7 @@ struct mon_reader_text {
 	wait_queue_head_t wait;
 	int printf_size;
 	char *printf_buf;
-	struct semaphore printf_lock;
+	struct mutex printf_lock;
 
 	char slab_name[SLAB_NAME_SZ];
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/mon/usb_mon.h linux-2.6.15-rc5-mutex/drivers/usb/mon/usb_mon.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/mon/usb_mon.h	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/mon/usb_mon.h	2005-12-12 21:10:53.000000000 +0000
@@ -49,7 +49,7 @@ void mon_reader_del(struct mon_bus *mbus
  */
 extern char mon_dmapeek(unsigned char *dst, dma_addr_t dma_addr, int len);
 
-extern struct semaphore mon_lock;
+extern struct mutex mon_lock;
 
 extern struct file_operations mon_fops_text;
 extern struct file_operations mon_fops_stat;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/net/kaweth.c linux-2.6.15-rc5-mutex/drivers/usb/net/kaweth.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/net/kaweth.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/net/kaweth.c	2005-12-12 22:12:49.000000000 +0000
@@ -60,7 +60,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/wait.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 
 #undef DEBUG
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/serial/io_ti.c linux-2.6.15-rc5-mutex/drivers/usb/serial/io_ti.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/serial/io_ti.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/serial/io_ti.c	2005-12-12 22:12:49.000000000 +0000
@@ -38,7 +38,7 @@
 #include <linux/serial.h>
 #include <linux/ioctl.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/usb.h>
 
 #include "usb-serial.h"
@@ -134,7 +134,7 @@ struct edgeport_serial {
 	struct product_info product_info;
 	u8 TI_I2C_Type;			// Type of I2C in UMP
 	u8 TiReadI2C;			// Set to TRUE if we have read the I2c in Boot Mode
-	struct semaphore es_sem;
+	struct mutex es_sem;
 	int num_ports_open;
 	struct usb_serial *serial;
 };
@@ -2739,7 +2739,7 @@ static int edge_startup (struct usb_seri
 		return -ENOMEM;
 	}
 	memset (edge_serial, 0, sizeof(struct edgeport_serial));
-	sema_init(&edge_serial->es_sem, 1);
+	init_MUTEX(&edge_serial->es_sem);
 	edge_serial->serial = serial;
 	usb_set_serial_data(serial, edge_serial);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/serial/ti_usb_3410_5052.c linux-2.6.15-rc5-mutex/drivers/usb/serial/ti_usb_3410_5052.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/serial/ti_usb_3410_5052.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/serial/ti_usb_3410_5052.c	2005-12-12 22:12:49.000000000 +0000
@@ -82,7 +82,7 @@
 #include <linux/serial.h>
 #include <linux/circ_buf.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/usb.h>
 
 #include "usb-serial.h"
@@ -140,7 +140,7 @@ struct ti_port {
 };
 
 struct ti_device {
-	struct semaphore	td_open_close_sem;
+	struct mutex		td_open_close_sem;
 	int			td_open_port_count;
 	struct usb_serial	*td_serial;
 	int			td_is_3410;
@@ -425,7 +425,7 @@ static int ti_startup(struct usb_serial 
 		return -ENOMEM;
 	}
 	memset(tdev, 0, sizeof(struct ti_device));
-	sema_init(&tdev->td_open_close_sem, 1);
+	init_MUTEX(&tdev->td_open_close_sem);
 	tdev->td_serial = serial;
 	usb_set_serial_data(serial, tdev);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/usb/storage/usb.h linux-2.6.15-rc5-mutex/drivers/usb/storage/usb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/usb/storage/usb.h	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/storage/usb.h	2005-12-12 21:07:47.000000000 +0000
@@ -130,7 +130,7 @@ struct us_data {
 	 * It's important to note:
 	 *    (o) you must hold dev_semaphore to change pusb_dev
 	 */
-	struct semaphore	dev_semaphore;	 /* protect pusb_dev */
+	struct mutex		dev_semaphore;	 /* protect pusb_dev */
 	struct usb_device	*pusb_dev;	 /* this usb_device */
 	struct usb_interface	*pusb_intf;	 /* this interface */
 	struct us_unusual_dev   *unusual_dev;	 /* device-filter entry     */
@@ -171,7 +171,7 @@ struct us_data {
 	dma_addr_t		iobuf_dma;
 
 	/* mutual exclusion and synchronization structures */
-	struct semaphore	sema;		 /* to sleep thread on	    */
+	struct mutex		sema;		 /* to sleep thread on	    */
 	struct completion	notify;		 /* thread begin/end	    */
 	wait_queue_head_t	delay_wait;	 /* wait during scan, reset */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/video/pxafb.h linux-2.6.15-rc5-mutex/drivers/video/pxafb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/video/pxafb.h	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/video/pxafb.h	2005-12-12 21:43:47.000000000 +0000
@@ -87,7 +87,7 @@ struct pxafb_info {
 
 	volatile u_char		state;
 	volatile u_char		task_state;
-	struct semaphore	ctrlr_sem;
+	struct mutex		ctrlr_sem;
 	wait_queue_head_t	ctrlr_wait;
 	struct work_struct	task;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/video/sa1100fb.h linux-2.6.15-rc5-mutex/drivers/video/sa1100fb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/video/sa1100fb.h	2004-06-18 13:41:30.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/video/sa1100fb.h	2005-12-12 21:43:53.000000000 +0000
@@ -100,7 +100,7 @@ struct sa1100fb_info {
 
 	volatile u_char		state;
 	volatile u_char		task_state;
-	struct semaphore	ctrlr_sem;
+	struct mutex		ctrlr_sem;
 	wait_queue_head_t	ctrlr_wait;
 	struct work_struct	task;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/w1/w1.h linux-2.6.15-rc5-mutex/drivers/w1/w1.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/w1/w1.h	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/w1/w1.h	2005-12-12 22:12:50.000000000 +0000
@@ -44,7 +44,7 @@ struct w1_reg_num
 
 #include <net/sock.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "w1_family.h"
 
@@ -173,7 +173,7 @@ struct w1_master
 	long			flags;
 
 	pid_t			kpid;
-	struct semaphore	mutex;
+	struct mutex		mutex;
 
 	struct device_driver	*driver;
 	struct device		dev;
