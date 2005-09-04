Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVICVF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVICVF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 17:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVICVF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 17:05:57 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:8121 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751267AbVICVF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 17:05:56 -0400
Date: Sun, 4 Sep 2005 12:12:18 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050904101218.GM4415@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pDtNmxPr5KTxcQ6Z"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pDtNmxPr5KTxcQ6Z
Content-Type: multipart/mixed; boundary="+mSjbC2tVdWE/Wop"
Content-Disposition: inline


--+mSjbC2tVdWE/Wop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
Smartcard Reader. =20

It's based on some source code originally made available by the vendor
(as BSD/GPL dual licensed code), but has undergone significant changes
to make it more compliant with the general kernel community coding
practise.

As this is the first PCMCIA driver that I'm involved in, please let me
know if I missed something.

If there are no objections, I'd like to see it included in mainline.
Thanks!

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--+mSjbC2tVdWE/Wop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cm4040-driver.patch"
Content-Transfer-Encoding: quoted-printable

Omnikey CardMan 4040 PCMCIA Smartcard reader driver

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 04ec3ca3e3c6fd6d88c508b6ebe32726ef109367
tree e27a5ccafbcebda6ebfe90036016f0e76dd93137
parent c4ab879b6ef599bf88d19b9b145878ef73400ce7
author Harald Welte <laforge@netfilter.org> So, 04 Sep 2005 11:59:37 +0200
committer Harald Welte <laforge@netfilter.org> So, 04 Sep 2005 11:59:37 +02=
00

 MAINTAINERS                     |    5=20
 drivers/char/pcmcia/Kconfig     |   13 +
 drivers/char/pcmcia/Makefile    |    1=20
 drivers/char/pcmcia/cm4040_cs.c |  900 +++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 919 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1737,6 +1737,11 @@ L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
=20
+OMNIKEY CARDMAN 4040 DRIVER
+P:	Harald Welte
+M:	laforge@gnumonks.org
+S:	Maintained
+
 ONSTREAM SCSI TAPE DRIVER
 P:	Willem Riede
 M:	osst@riede.org
diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -18,5 +18,18 @@ config SYNCLINK_CS
 	  The module will be called synclinkmp.  If you want to do that, say M
 	  here.
=20
+config CARDMAN_4040
+	tristate "Omnikey CardMan 4040 support"
+	depends on PCMCIA
+	help
+	  Enable support for the Omnikey CardMan 4040 PCMCIA Smartcard
+	  reader.
+	 =20
+	  This card is basically a USB CCID device connected to a FIFO
+	  in I/O space.  To use the kernel driver, you will need either the
+	  PC/SC ifdhandler provided from the Omnikey homepage
+	  (http://www.omnikey.com/), or a current development version of OpenCT
+	  (http://www.opensc.org/).
+
 endmenu
=20
diff --git a/drivers/char/pcmcia/Makefile b/drivers/char/pcmcia/Makefile
--- a/drivers/char/pcmcia/Makefile
+++ b/drivers/char/pcmcia/Makefile
@@ -5,3 +5,4 @@
 #
=20
 obj-$(CONFIG_SYNCLINK_CS) +=3D synclink_cs.o
+obj-$(CONFIG_CARDMAN_4040) +=3D cm4040_cs.o
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_c=
s.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -0,0 +1,900 @@
+ /*
+ * A driver for the Omnikey PCMCIA smartcard reader CardMan 4040
+ *
+ * (c) 2000-2004 Omnikey AG (http://www.omnikey.com/)
+ *
+ * (C) 2005 Harald Welte <laforge@gnumonks.org>
+ * 	- add support for poll()
+ * 	- driver cleanup
+ * 	- add waitqueues
+ * 	- adhere to linux kenrel coding style and policies
+ * 	- support 2.6.13 "new style" pcmcia interface
+ *
+ * All rights reserved, Dual BSD/GPL Licensed.
+ */
+
+/* #define PCMCIA_DEBUG 6 */
+
+#include <linux/config.h>
+#include <linux/version.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/poll.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/cisreg.h>
+#include <pcmcia/ciscode.h>
+#include <pcmcia/ds.h>
+
+#include "cm4040_cs.h"
+
+static atomic_t cmx_num_devices_open;
+
+#ifdef PCMCIA_DEBUG
+static int pc_debug =3D PCMCIA_DEBUG;
+module_param(pc_debug, int, 0600);
+#define DEBUG(n, x, args...) do { if (pc_debug >=3D (n)) 			    \
+				  printk(KERN_DEBUG "%s:%s:" x, MODULE_NAME, \
+					 __FUNCTION__, ##args); } while (0)
+#else
+#define DEBUG(n, args...)
+#endif
+
+static volatile char *version =3D
+"OMNIKEY CardMan 4040 v1.1.0gm3 - All bugs added by Harald Welte";
+
+#define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
+#define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
+#define	CCID_DRIVER_MINIMUM_TIMEOUT 		(3*HZ)
+#define READ_WRITE_BUFFER_SIZE 512
+#define POLL_LOOP_COUNT				1000
+
+/* how often to poll for fifo status change */
+#define POLL_PERIOD 				(HZ/100)
+
+static void reader_release(u_long arg);
+static void reader_detach(dev_link_t *link);
+
+static int major;=09
+
+#define		BS_READABLE	0x01
+#define		BS_WRITABLE	0x02
+
+typedef struct reader_dev_t {
+	dev_link_t		link;	=09
+	dev_node_t		node;	=09
+	wait_queue_head_t	devq;=09
+
+	wait_queue_head_t	poll_wait;
+	wait_queue_head_t	read_wait;
+	wait_queue_head_t	write_wait;
+
+	unsigned int 	  	buffer_status;
+                               =20
+	unsigned int      	fTimerExpired;
+	struct timer_list	timer;
+	unsigned long     	timeout;
+	unsigned char     	sBuf[READ_WRITE_BUFFER_SIZE];
+	unsigned char     	rBuf[READ_WRITE_BUFFER_SIZE];
+	struct task_struct 	*owner;=09
+} reader_dev_t;
+
+static dev_info_t dev_info =3D MODULE_NAME;
+static dev_link_t *dev_table[CM_MAX_DEV] =3D { NULL, };
+
+static struct timer_list cmx_poll_timer;
+
+#if (!defined PCMCIA_DEBUG) || (PCMCIA_DEBUG < 7)
+#define	xoutb	outb
+#define	xinb	inb
+#else
+static inline void xoutb(unsigned char val,unsigned short port)
+{
+	DEBUG(7, "outb(val=3D%.2x,port=3D%.4x)\n", val, port);
+	outb(val,port);
+}
+
+static unsigned char xinb(unsigned short port)
+{
+	unsigned char val;
+
+	val =3D inb(port);
+	DEBUG(7, "%.2x=3Dinb(%.4x)\n", val, port);
+	return val;
+}
+#endif
+
+/* poll the device fifo status register.  not to be confused with
+ * the poll syscall. */
+static void cmx_do_poll(unsigned long dummy)
+{
+	unsigned int i;
+	/* walk through all devices */=09
+	for (i =3D 0; dev_table[i]; i++) {
+		dev_link_t *dl =3D dev_table[i];
+		reader_dev_t *dev =3D dl->priv;
+		unsigned int obs =3D xinb(dl->io.BasePort1
+					+ REG_OFFSET_BUFFER_STATUS);
+
+		dev->buffer_status =3D 0;
+
+		if ((obs & BSR_BULK_IN_FULL) =3D=3D BSR_BULK_IN_FULL) {
+			dev->buffer_status |=3D BS_READABLE;
+			DEBUG(4, "waking up read_wait\n");
+			wake_up_interruptible(&dev->read_wait);
+		}
+
+		if ((obs & BSR_BULK_OUT_FULL) =3D=3D 0) {
+			dev->buffer_status |=3D BS_WRITABLE;
+			DEBUG(4, "waking up write_wait\n");
+			wake_up_interruptible(&dev->write_wait);
+		}
+
+		if (dev->buffer_status)
+			wake_up_interruptible(&dev->poll_wait);
+	}
+
+	if (atomic_read(&cmx_num_devices_open))
+		mod_timer(&cmx_poll_timer, jiffies + POLL_PERIOD);
+}
+
+static loff_t cmx_llseek(struct file * filp, loff_t off, int whence)
+{
+	return -ESPIPE;
+}
+
+static inline int cmx_waitForBulkOutReady(reader_dev_t *dev)
+{
+        register int i;
+	register int iobase =3D dev->link.io.BasePort1;
+
+	for (i=3D0; i < POLL_LOOP_COUNT; i++) {
+		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
+		    & BSR_BULK_OUT_FULL) =3D=3D 0) {
+			DEBUG(4, "BulkOut empty\n");
+			return 1;
+		}
+	}
+
+	interruptible_sleep_on_timeout(&dev->write_wait, dev->timeout);
+	if (dev->buffer_status & BS_WRITABLE) {
+		DEBUG(4, "woke up: BulkOut empty\n");
+		return 1;
+	}
+
+	DEBUG(4, "woke up: BulkOut full, returning 0 :(\n");
+	return 0;
+}
+
+/* Write to Sync Control Register */
+static inline int cmx_writeSync(unsigned char val,reader_dev_t *dev)
+{
+	register int iobase =3D dev->link.io.BasePort1;
+	int rc;
+
+	rc =3D cmx_waitForBulkOutReady(dev);
+        if (rc !=3D 1)
+		return 0;
+
+	xoutb(val,iobase + REG_OFFSET_SYNC_CONTROL);
+	rc =3D cmx_waitForBulkOutReady(dev);
+        if (rc !=3D 1)
+		return 0;
+
+	return 1;
+}
+
+static inline int cmx_waitForBulkInReady(reader_dev_t *dev)
+{
+        register int i;
+	register int iobase =3D dev->link.io.BasePort1;
+
+	for (i=3D0; i < POLL_LOOP_COUNT; i++) {
+		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
+		    & BSR_BULK_IN_FULL) =3D=3D BSR_BULK_IN_FULL) {
+			DEBUG(3, "BulkIn full\n");
+			return 1;
+		}
+	}
+
+	DEBUG(4, "interruptible_sleep_on_timeout(read_wait, timeout=3D%ld\n", dev=
->timeout);
+	interruptible_sleep_on_timeout(&dev->read_wait, dev->timeout);
+	if (dev->buffer_status & BS_READABLE) {
+		DEBUG(4, "woke up: BulkIn full\n");
+		return 1;
+	}
+
+	DEBUG(4, "woke up: BulkIn not full, returning 0 :(\n");
+	return 0;
+}
+
+static ssize_t cmx_read(struct file *filp,char *buf,size_t count,loff_t *p=
pos)
+{
+	register reader_dev_t *dev=3D(reader_dev_t *)filp->private_data;
+	register int iobase=3Ddev->link.io.BasePort1;
+	unsigned long ulBytesToRead;
+	unsigned long i;
+	unsigned long ulMin;
+	int rc;
+	unsigned char uc;
+
+	DEBUG(2, "-> cmx_read(%s,%d)\n", current->comm,current->pid);
+
+	if (count=3D=3D0)
+		return 0;
+
+        if (count < 10)
+		return -EFAULT;
+
+	if (filp->f_flags & O_NONBLOCK) {=20
+		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
+		DEBUG(4, "<- cmx_read (failure)\n");
+		return -EAGAIN;
+	}
+
+	if ((dev->link.state & DEV_PRESENT)=3D=3D0)=09
+		return -ENODEV;
+
+	for (i=3D0; i<5; i++) {
+		rc =3D cmx_waitForBulkInReady(dev);
+		if (rc !=3D 1) {
+			DEBUG(5,"cmx_waitForBulkInReady rc=3D%.2x\n",rc);
+			DEBUG(2, "<- cmx_read (failed)\n");
+			return -EIO;
+		}
+	  	dev->rBuf[i] =3D xinb(iobase + REG_OFFSET_BULK_IN);
+#ifdef PCMCIA_DEBUG
+		if (pc_debug >=3D 6)
+			printk(KERN_DEBUG "%lu:%2x ", i, dev->rBuf[i]);
+	}
+	printk("\n");
+#else
+	}
+#endif
+
+	ulBytesToRead =3D 5 +=20
+			(0x000000FF&((char)dev->rBuf[1])) +=20
+			(0x0000FF00&((char)dev->rBuf[2] << 8)) +=20
+			(0x00FF0000&((char)dev->rBuf[3] << 16)) +=20
+			(0xFF000000&((char)dev->rBuf[4] << 24));
+
+	DEBUG(6, "BytesToRead=3D%lu\n", ulBytesToRead);
+
+	ulMin =3D (count < (ulBytesToRead+5))?count:(ulBytesToRead+5);
+
+	DEBUG(6, "Min=3D%lu\n", ulMin);
+
+	for (i=3D0; i < (ulMin-5); i++) {
+		rc =3D cmx_waitForBulkInReady(dev);
+		if (rc !=3D 1) {
+			DEBUG(5,"cmx_waitForBulkInReady rc=3D%.2x\n",rc);
+			DEBUG(2, "<- cmx_read (failed)\n");
+			return -EIO;
+		}
+		dev->rBuf[i+5] =3D xinb(iobase + REG_OFFSET_BULK_IN);
+		DEBUG(6, "%lu:%2x ", i, dev->rBuf[i]);
+	}
+	DEBUG(6, "\n");
+
+	*ppos =3D ulMin;
+	copy_to_user(buf, dev->rBuf, ulMin);
+
+
+	rc =3D cmx_waitForBulkInReady(dev);
+	if (rc !=3D 1) {
+		DEBUG(5,"cmx_waitForBulkInReady rc=3D%.2x\n",rc);
+		DEBUG(2, "<- cmx_read (failed)\n");
+		return -EIO;
+	}
+
+	rc =3D cmx_writeSync(SCR_READER_TO_HOST_DONE, dev);
+
+	if (rc !=3D 1) {
+		DEBUG(5,"cmx_writeSync c=3D%.2x\n",rc);
+		DEBUG(2, "<- cmx_read (failed)\n");
+		return -EIO;
+	}
+
+	uc =3D xinb(iobase + REG_OFFSET_BULK_IN);
+
+	DEBUG(2,"<- cmx_read (successfully)\n");
+	return ulMin;
+}
+
+static ssize_t cmx_write(struct file *filp,const char *buf,size_t count,
+			 loff_t *ppos)
+{
+	register reader_dev_t *dev=3D(reader_dev_t *)filp->private_data;
+	register int iobase=3Ddev->link.io.BasePort1;
+	ssize_t rc;
+	int i;
+	unsigned int uiBytesToWrite;=20
+
+	DEBUG(2, "-> cmx_write(%s,%d)\n", current->comm, current->pid);
+
+	if (count =3D=3D 0) {
+		DEBUG(2, "<- cmx_write nothing to do (successfully)\n");
+		return 0;
+	}
+
+	if (count < 5) {
+		DEBUG(2, "<- cmx_write buffersize=3D%Zd < 5\n", count);
+		return -EIO;
+	}
+
+	if (filp->f_flags & O_NONBLOCK) {=20
+		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
+		DEBUG(4, "<- cmx_write (failure)\n");
+		return -EAGAIN;
+        }
+
+	if ((dev->link.state & DEV_PRESENT) =3D=3D 0)=09
+		return -ENODEV;
+
+	uiBytesToWrite =3D count;
+	copy_from_user(dev->sBuf, buf, uiBytesToWrite);
+
+	switch (dev->sBuf[0]) {
+		case CMD_PC_TO_RDR_XFRBLOCK:
+		case CMD_PC_TO_RDR_SECURE:
+		case CMD_PC_TO_RDR_TEST_SECURE:
+		case CMD_PC_TO_RDR_OK_SECURE:
+			dev->timeout =3D CCID_DRIVER_BULK_DEFAULT_TIMEOUT;
+			break;
+
+		case CMD_PC_TO_RDR_ICCPOWERON:
+			dev->timeout =3D CCID_DRIVER_ASYNC_POWERUP_TIMEOUT;
+			break;
+
+		case CMD_PC_TO_RDR_GETSLOTSTATUS:
+		case CMD_PC_TO_RDR_ICCPOWEROFF:
+		case CMD_PC_TO_RDR_GETPARAMETERS:
+		case CMD_PC_TO_RDR_RESETPARAMETERS: =20
+		case CMD_PC_TO_RDR_SETPARAMETERS:
+		case CMD_PC_TO_RDR_ESCAPE:
+		case CMD_PC_TO_RDR_ICCCLOCK:
+		default:
+			dev->timeout =3D CCID_DRIVER_MINIMUM_TIMEOUT;
+			break;
+	}
+
+	rc =3D cmx_writeSync(SCR_HOST_TO_READER_START, dev);
+
+	DEBUG(4, "start \n");
+
+	for (i=3D0; i < uiBytesToWrite; i++) {
+		rc =3D cmx_waitForBulkOutReady(dev);
+		if (rc !=3D 1) {
+			DEBUG(5, "cmx_waitForBulkOutReady rc=3D%.2Zx\n", rc);
+			DEBUG(2, "<- cmx_write (failed)\n");
+			return -EIO;
+          	}
+	=20
+		xoutb(dev->sBuf[i],iobase + REG_OFFSET_BULK_OUT);
+		DEBUG(4, "%.2x ", dev->sBuf[i]);
+	}
+	DEBUG(4, "end\n");
+
+	rc =3D cmx_writeSync(SCR_HOST_TO_READER_DONE, dev);
+
+	if (rc !=3D 1) {
+		DEBUG(5, "cmx_writeSync c=3D%.2Zx\n", rc);
+		DEBUG(2, "<- cmx_write (failed)\n");
+		return -EIO;
+	}
+
+	DEBUG(2, "<- cmx_write (successfully)\n");
+	return count;
+}
+
+static unsigned int cmx_poll(struct file *filp, poll_table *wait)
+{
+	reader_dev_t *dev=3D(reader_dev_t *)filp->private_data;
+	unsigned int mask =3D 0;
+
+	poll_wait(filp, &dev->poll_wait, wait);
+
+	if (dev->buffer_status & BS_READABLE)
+		mask |=3D POLLIN | POLLRDNORM;
+	if (dev->buffer_status & BS_WRITABLE)
+		mask |=3D POLLOUT | POLLWRNORM;
+
+	return mask;
+}
+
+static int cmx_ioctl(struct inode *inode,struct file *filp,unsigned int cm=
d,
+			unsigned long arg)
+{
+	dev_link_t *link;
+	int rc, size;
+
+	link=3Ddev_table[MINOR(inode->i_rdev)];
+	if (!(DEV_OK(link))) {
+		DEBUG(4, "DEV_OK false\n");
+		return -ENODEV;
+	}
+	if (_IOC_TYPE(cmd)!=3DCM_IOC_MAGIC) {
+		DEBUG(4,"ioctype mismatch\n");
+		return -EINVAL;
+	}
+	if (_IOC_NR(cmd)>CM_IOC_MAXNR) {
+		DEBUG(4,"iocnr mismatch\n");
+		return -EINVAL;
+	}=20
+	size =3D _IOC_SIZE(cmd);
+	rc =3D 0;
+	DEBUG(4,"iocdir=3D%.4x iocr=3D%.4x iocw=3D%.4x iocsize=3D%d cmd=3D%.4x\n",
+		_IOC_DIR(cmd),_IOC_READ,_IOC_WRITE,size,cmd);
+
+	if (_IOC_DIR(cmd)&_IOC_READ) {
+		if (!access_ok(VERIFY_WRITE, (void *)arg, size))
+			return -EFAULT;
+	}
+	if (_IOC_DIR(cmd)&_IOC_WRITE) {
+		if (!access_ok(VERIFY_READ, (void *)arg, size))
+			return -EFAULT;
+	}
+
+	return rc;
+}
+
+static int cmx_open (struct inode *inode, struct file *filp)
+{
+	reader_dev_t *dev;
+	dev_link_t *link;
+	int i;
+
+	DEBUG(2, "-> cmx_open(device=3D%d.%d process=3D%s,%d)\n",
+		MAJOR(inode->i_rdev), MINOR(inode->i_rdev),
+		current->comm, current->pid);
+
+	i =3D MINOR(inode->i_rdev);
+	if (i >=3D CM_MAX_DEV) {
+		DEBUG(4, "MAX_DEV reached\n");
+		DEBUG(4, "<- cmx_open (failure)\n");
+		return -ENODEV;
+	}
+	link =3D dev_table[MINOR(inode->i_rdev)];
+	if (link =3D=3D NULL || !(DEV_OK(link))) {
+		DEBUG(4, "link=3D=3D NULL || DEV_OK false\n");
+		DEBUG(4, "<- cmx_open (failure)\n");
+		return -ENODEV;
+	}
+	if (link->open) {
+		DEBUG(4, "DEVICE BUSY\n");
+		DEBUG(4, "<- cmx_open (failure)\n");
+		return -EBUSY;
+	}
+
+	dev =3D (reader_dev_t *)link->priv;
+	filp->private_data =3D dev;
+
+	if (filp->f_flags & O_NONBLOCK) {=20
+		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
+		DEBUG(4, "<- cmx_open (failure)\n");
+		return -EAGAIN;
+        }
+
+	dev->owner =3D current;
+	link->open =3D 1;	=09
+
+	atomic_inc(&cmx_num_devices_open);
+	mod_timer(&cmx_poll_timer, jiffies + POLL_PERIOD);
+
+	DEBUG(2, "<- cmx_open (successfully)\n");
+	return 0;
+}
+
+static int cmx_close(struct inode *inode,struct file *filp)
+{
+	reader_dev_t *dev;
+	dev_link_t *link;
+	int i;
+
+	DEBUG(2, "-> cmx_close(maj/min=3D%d.%d)\n",
+		MAJOR(inode->i_rdev), MINOR(inode->i_rdev));
+
+	i =3D MINOR(inode->i_rdev);
+	if (i >=3D CM_MAX_DEV)
+		return -ENODEV;
+
+	link =3D dev_table[MINOR(inode->i_rdev)];
+	if (link =3D=3D NULL)
+		return -ENODEV;
+
+	dev =3D (reader_dev_t *)link->priv;
+
+	link->open =3D 0;
+	wake_up(&dev->devq);=09
+
+	atomic_dec(&cmx_num_devices_open);
+
+	DEBUG(2, "<- cmx_close\n");
+	return 0;
+}
+
+static void cmx_reader_release(dev_link_t *link)
+{
+	reader_dev_t *dev =3D (reader_dev_t *)link->priv;
+
+	DEBUG(3, "-> cmx_reader_release\n");=20
+	while (link->open) {
+		DEBUG(3, KERN_INFO MODULE_NAME ": delaying release until "
+		      "process '%s', pid %d has terminated\n",
+		      dev->owner->comm,dev->owner->pid);
+ 		wait_event(dev->devq, (link->open =3D=3D 0));
+	}
+	DEBUG(3, "<- cmx_reader_release\n");=20
+	return;
+}
+
+static void reader_config(dev_link_t *link, int devno)
+{
+	client_handle_t handle;
+	reader_dev_t *dev;
+	tuple_t tuple;
+	cisparse_t parse;
+	config_info_t conf;
+	u_char buf[64];
+	int fail_fn,fail_rc;
+	int rc;
+
+	DEBUG(2, "-> reader_config\n");
+
+	handle =3D link->handle;
+
+	tuple.DesiredTuple =3D CISTPL_CONFIG;
+	tuple.Attributes =3D 0;
+	tuple.TupleData =3D buf;
+	tuple.TupleDataMax =3D sizeof(buf);
+ 	tuple.TupleOffset =3D 0;
+
+	if ((fail_rc =3D pcmcia_get_first_tuple(handle,&tuple)) !=3D CS_SUCCESS) {
+		fail_fn =3D GetFirstTuple;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_get_tuple_data(handle,&tuple)) !=3D CS_SUCCESS) {
+		fail_fn =3D GetTupleData;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_parse_tuple(handle,&tuple,&parse))
+							!=3D CS_SUCCESS) {
+		fail_fn =3D ParseTuple;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_get_configuration_info(handle,&conf))
+							!=3D CS_SUCCESS) {
+		fail_fn =3D GetConfigurationInfo;
+		goto cs_failed;
+	}
+
+	link->state |=3D DEV_CONFIG;
+	link->conf.ConfigBase =3D parse.config.base;
+	link->conf.Present =3D parse.config.rmask[0];
+	link->conf.Vcc =3D conf.Vcc;
+	DEBUG(2, "link->conf.Vcc=3D%d\n", link->conf.Vcc);
+
+	link->io.BasePort2 =3D 0;
+	link->io.NumPorts2 =3D 0;
+	link->io.Attributes2 =3D 0;
+	tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
+	for (rc =3D pcmcia_get_first_tuple(handle, &tuple);
+	     rc =3D=3D CS_SUCCESS;
+	     rc =3D pcmcia_get_next_tuple(handle, &tuple)) {
+ 		DEBUG(2, "Examing CIS Tuple!\n");
+		rc =3D pcmcia_get_tuple_data(handle, &tuple);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+		rc =3D pcmcia_parse_tuple(handle, &tuple, &parse);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+
+		DEBUG(2, "tupleIndex=3D%d\n", parse.cftable_entry.index);
+		link->conf.ConfigIndex =3D parse.cftable_entry.index;
+	=09
+		if (parse.cftable_entry.io.nwin) {
+			link->io.BasePort1 =3D parse.cftable_entry.io.win[0].base;
+			link->io.NumPorts1 =3D parse.cftable_entry.io.win[0].len;
+			link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;
+			if(!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
+				link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_16;
+			if(!(parse.cftable_entry.io.flags & CISTPL_IO_16BIT))
+				link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
+			link->io.IOAddrLines =3D parse.cftable_entry.io.flags
+						& CISTPL_IO_LINES_MASK;
+			DEBUG(2,"io.BasePort1=3D%.4x\n", link->io.BasePort1);
+			DEBUG(2,"io.NumPorts1=3D%.4x\n", link->io.NumPorts1);
+			DEBUG(2,"io.BasePort2=3D%.4x\n", link->io.BasePort2);
+			DEBUG(2,"io.NumPorts2=3D%.4x\n", link->io.NumPorts2);
+			DEBUG(2,"io.IOAddrLines=3D%.4x\n",=20
+			      link->io.IOAddrLines);
+			rc =3D pcmcia_request_io(handle, &link->io);
+			if (rc =3D=3D CS_SUCCESS) {
+				DEBUG(2, "RequestIO OK\n");
+				break;=20
+			} else=20
+				DEBUG(2, "RequestIO failed\n");
+		}
+	}
+	if (rc !=3D CS_SUCCESS) {
+		DEBUG(2, "Couldn't configure reader\n");
+		goto cs_release;
+	}
+
+        link->conf.IntType =3D 00000002;
+
+	if ((fail_rc =3D pcmcia_request_configuration(handle,&link->conf))
+								!=3DCS_SUCCESS) {
+		fail_fn =3D RequestConfiguration;
+		DEBUG(1, "pcmcia_request_configuration failed 0x%x\n", fail_rc);
+		goto cs_release;
+	}
+
+	DEBUG(2, "RequestConfiguration OK\n");
+
+	dev =3D link->priv;
+	sprintf(dev->node.dev_name, DEVICE_NAME "%d", devno);
+	dev->node.major =3D major;
+	dev->node.minor =3D devno;
+	dev->node.next =3D NULL;
+	link->dev =3D &dev->node;
+	link->state &=3D ~DEV_CONFIG_PENDING;
+
+	DEBUG(2, "device " DEVICE_NAME "%d at 0x%.4x-0x%.4x\n", devno,
+	      link->io.BasePort1, link->io.BasePort1+link->io.NumPorts1);
+	DEBUG(2, "<- reader_config (succ)\n");
+
+	return;
+
+cs_failed:
+	cs_error(handle, fail_fn, fail_rc);
+cs_release:
+	reader_release((u_long)link);
+	link->state &=3D ~DEV_CONFIG_PENDING;
+	DEBUG(2, "<- reader_config (failure)\n");
+}
+
+static int reader_event(event_t event, int priority,
+			event_callback_args_t *args)
+{
+	dev_link_t *link;
+	reader_dev_t *dev;
+	int devno;
+
+	DEBUG(3,"-> reader_event\n");
+	link =3D args->client_data;
+	dev =3D link->priv;
+	for (devno =3D 0; devno < CM_MAX_DEV; devno++) {
+		if (dev_table[devno]=3D=3Dlink)
+			break;
+	}
+	if (devno =3D=3D CM_MAX_DEV)
+		return CS_BAD_ADAPTER;
+
+	switch (event) {
+		case CS_EVENT_CARD_INSERTION:
+			DEBUG(5, "CS_EVENT_CARD_INSERTION\n");
+			link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
+			reader_config(link,devno);
+			break;
+		case CS_EVENT_CARD_REMOVAL:
+			DEBUG(5, "CS_EVENT_CARD_REMOVAL\n");
+			link->state &=3D ~DEV_PRESENT;
+			break;
+		case CS_EVENT_PM_SUSPEND:
+			DEBUG(5, "CS_EVENT_PM_SUSPEND "
+			      "(fall-through to CS_EVENT_RESET_PHYSICAL)\n");
+			link->state |=3D DEV_SUSPEND;
+	=09
+		case CS_EVENT_RESET_PHYSICAL:
+			DEBUG(5, "CS_EVENT_RESET_PHYSICAL\n");
+			if (link->state & DEV_CONFIG) {
+		  		DEBUG(5, "ReleaseConfiguration\n");
+		  		pcmcia_release_configuration(link->handle);
+			}
+			break;
+		case CS_EVENT_PM_RESUME:
+			DEBUG(5, "CS_EVENT_PM_RESUME "
+			      "(fall-through to CS_EVENT_CARD_RESET)\n");
+			link->state &=3D ~DEV_SUSPEND;
+	=09
+		case CS_EVENT_CARD_RESET:
+	        	DEBUG(5, "CS_EVENT_CARD_RESET\n");
+			if ((link->state & DEV_CONFIG)) {
+				DEBUG(5, "cmx: RequestConfiguration\n");
+		  		pcmcia_request_configuration(link->handle,
+							     &link->conf);
+			}
+			break;
+		default:
+			DEBUG(5, "reader_event: unknown event %.2x\n", event);
+			break;
+	}
+	DEBUG(3, "<- reader_event\n");
+	return CS_SUCCESS;
+}
+
+static void reader_release(u_long arg)
+{
+	dev_link_t *link;
+	int rc;
+
+	DEBUG(3, "-> reader_release\n");
+	link =3D (dev_link_t *)arg;
+	cmx_reader_release(link->priv);=20
+	rc =3D pcmcia_release_configuration(link->handle);
+	if (rc !=3D CS_SUCCESS)
+		DEBUG(5, "couldn't ReleaseConfiguration "
+		      "reasoncode=3D%.2x\n", rc);
+	rc =3D pcmcia_release_io(link->handle, &link->io);
+	if (rc !=3D CS_SUCCESS)
+		DEBUG(5, "couldn't ReleaseIO reasoncode=3D%.2x\n", rc);
+
+	DEBUG(3, "<- reader_release\n");
+}
+
+static dev_link_t *reader_attach(void)
+{
+	reader_dev_t *dev;
+	dev_link_t *link;
+	client_reg_t client_reg;
+	int i;
+
+	DEBUG(3, "reader_attach\n");
+	for (i=3D0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i] =3D=3D NULL)
+			break;
+	}
+
+	if (i =3D=3D CM_MAX_DEV) {
+		printk(KERN_NOTICE "all devices in use\n");
+		return NULL;
+	}
+=09
+	DEBUG(5, "create reader device instance\n");
+	dev =3D kmalloc(sizeof(reader_dev_t), GFP_KERNEL);
+	if (dev =3D=3D NULL)
+		return NULL;
+
+	memset(dev, 0, sizeof(reader_dev_t));
+	dev->timeout =3D CCID_DRIVER_MINIMUM_TIMEOUT;
+	dev->fTimerExpired =3D 0;
+
+	link =3D &dev->link;
+	link->priv =3D dev;
+
+	link->conf.IntType =3D INT_MEMORY_AND_IO;
+	dev_table[i] =3D link;
+
+=09
+	DEBUG(5, "Register with Card Services\n");
+	client_reg.dev_info =3D &dev_info;
+	client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
+	client_reg.EventMask=3D
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.Version =3D 0x0210;
+	client_reg.event_callback_args.client_data =3D link;
+	i =3D pcmcia_register_client(&link->handle, &client_reg);
+	if (i) {
+		cs_error(link->handle, RegisterClient, i);
+		reader_detach(link);
+		return NULL;
+	}
+	init_waitqueue_head(&dev->devq);
+	init_waitqueue_head(&dev->poll_wait);
+	init_waitqueue_head(&dev->read_wait);
+	init_waitqueue_head(&dev->write_wait);
+	init_timer(&cmx_poll_timer);
+	cmx_poll_timer.function =3D &cmx_do_poll;
+
+	return link;
+}
+
+static void reader_detach_by_devno(int devno,dev_link_t *link)
+{
+	reader_dev_t *dev=3Dlink->priv;
+
+	DEBUG(3, "-> detach_by_devno(devno=3D%d)\n", devno);
+	if (link->state & DEV_CONFIG) {
+		DEBUG(5, "device still configured (try to release it)\n");
+		reader_release((u_long)link);
+	}
+
+	pcmcia_deregister_client(link->handle);
+	dev_table[devno] =3D NULL;
+	DEBUG(5, "freeing dev=3D%p\n", dev);
+	kfree(dev);
+	DEBUG(3, "<- detach_by-devno\n");
+	return;
+}
+
+static void reader_detach(dev_link_t *link)
+{
+	int i;
+	DEBUG(3, "-> reader_detach(link=3D%p\n", link);
+	/* find device */
+	for(i=3D0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i] =3D=3D link)
+			break;
+	}
+	if (i =3D=3D CM_MAX_DEV) {
+		printk(KERN_WARNING MODULE_NAME=20
+			": detach for unkown device aborted\n");
+		return;
+	}
+	reader_detach_by_devno(i, link);
+	DEBUG(3, "<- reader_detach\n");
+	return;
+}
+
+static struct file_operations reader_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.llseek		=3D cmx_llseek,
+	.read		=3D cmx_read,
+	.write		=3D cmx_write,
+	.ioctl		=3D cmx_ioctl,
+	.open		=3D cmx_open,
+	.release	=3D cmx_close,
+	.poll		=3D cmx_poll,
+};
+
+static struct pcmcia_device_id cm4040_ids[] =3D {
+	PCMCIA_DEVICE_MANF_CARD(0x0223, 0x0200),
+	PCMCIA_DEVICE_PROD_ID12("OMNIKEY", "CardMan 4040",=20
+				0xE32CDD8C, 0x8F23318B),
+	PCMCIA_DEVICE_NULL,
+};
+MODULE_DEVICE_TABLE(pcmcia, cm4040_ids);
+
+static struct pcmcia_driver reader_driver =3D {
+  	.owner		=3D THIS_MODULE,
+  	.drv		=3D {
+		.name	=3D "cm4040_cs",
+	},
+	.attach		=3D reader_attach,
+	.detach		=3D reader_detach,
+	.event		=3D reader_event,
+	.id_table	=3D cm4040_ids,
+};
+
+static int __init cmx_init(void)
+{
+	printk(KERN_INFO "%s\n", version);
+	pcmcia_register_driver(&reader_driver);
+	major =3D register_chrdev(0, DEVICE_NAME, &reader_fops);
+	if (major < 0) {
+		printk(KERN_WARNING MODULE_NAME
+			": could not get major number\n");
+		return -1;
+	}
+	return 0;
+}
+
+static void __exit cmx_exit(void)
+{
+	int i;
+
+	printk(KERN_INFO MODULE_NAME ": unloading\n");
+	pcmcia_unregister_driver(&reader_driver); =20
+	for (i=3D0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i])
+			reader_detach_by_devno(i, dev_table[i]);
+	}
+	unregister_chrdev(major, DEVICE_NAME);
+}
+
+module_init(cmx_init);
+module_exit(cmx_exit);
+MODULE_LICENSE("Dual BSD/GPL");

--+mSjbC2tVdWE/Wop--

--pDtNmxPr5KTxcQ6Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGsiCXaXGVTD0i/8RAtAhAJ0Q3EzZydb2K/8CynwjkbKL2vSwngCfTnr5
v++/W+Yu0fxVKda7oZDMfqo=
=mE35
-----END PGP SIGNATURE-----

--pDtNmxPr5KTxcQ6Z--
