Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVLLXqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVLLXqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVLLXqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932266AbVLLXqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:38 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmmA009055@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 15/19] MUTEX: Second set of include changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the second half of the include files to use the new
mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-include-2-2615rc5.diff
 include/linux/sched.h             |    2 +-
 include/linux/seq_file.h          |    4 ++--
 include/linux/serial_core.h       |    2 +-
 include/linux/serio.h             |    2 +-
 include/linux/smb_fs_sb.h         |    2 +-
 include/linux/sunrpc/svcsock.h    |    2 +-
 include/linux/syscalls.h          |    2 +-
 include/linux/tty.h               |   12 ++++++------
 include/linux/udf_fs_sb.h         |    4 ++--
 include/linux/uinput.h            |    2 +-
 include/linux/usb.h               |    2 +-
 include/linux/videodev2.h         |    2 +-
 include/linux/vt_kern.h           |    2 +-
 include/media/saa7146.h           |    6 +++---
 include/media/video-buf-dvb.h     |    2 +-
 include/media/video-buf.h         |    2 +-
 include/net/af_unix.h             |    2 +-
 include/net/bluetooth/hci_core.h  |    2 +-
 include/net/xfrm.h                |    2 +-
 include/pcmcia/ss.h               |    2 +-
 include/scsi/scsi_host.h          |    2 +-
 include/scsi/scsi_transport_spi.h |    2 +-
 22 files changed, 31 insertions(+), 31 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/sched.h linux-2.6.15-rc5-mutex/include/linux/sched.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/sched.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/sched.h	2005-12-12 22:08:02.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/nodemask.h>
 
 #include <asm/system.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/seq_file.h linux-2.6.15-rc5-mutex/include/linux/seq_file.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/seq_file.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/seq_file.h	2005-12-12 22:12:49.000000000 +0000
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct seq_operations;
 struct file;
@@ -19,7 +19,7 @@ struct seq_file {
 	size_t count;
 	loff_t index;
 	loff_t version;
-	struct semaphore sem;
+	struct mutex sem;
 	struct seq_operations *op;
 	void *private;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/serial_core.h linux-2.6.15-rc5-mutex/include/linux/serial_core.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/serial_core.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/serial_core.h	2005-12-12 18:04:24.000000000 +0000
@@ -281,7 +281,7 @@ struct uart_state {
 	struct uart_info	*info;
 	struct uart_port	*port;
 
-	struct semaphore	sem;
+	struct mutex		sem;
 };
 
 #define UART_XMIT_SIZE	PAGE_SIZE
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/serio.h linux-2.6.15-rc5-mutex/include/linux/serio.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/serio.h	2005-08-30 13:56:37.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/serio.h	2005-12-12 17:52:34.000000000 +0000
@@ -42,7 +42,7 @@ struct serio {
 	struct serio *parent, *child;
 
 	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
-	struct semaphore drv_sem;	/* protects serio->drv so attributes can pin driver */
+	struct mutex drv_sem;		/* protects serio->drv so attributes can pin driver */
 
 	struct device dev;
 	unsigned int registered;	/* port has been fully registered with driver core */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/smb_fs_sb.h linux-2.6.15-rc5-mutex/include/linux/smb_fs_sb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/smb_fs_sb.h	2004-09-16 12:06:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/smb_fs_sb.h	2005-12-12 19:33:38.000000000 +0000
@@ -59,7 +59,7 @@ struct smb_sb_info {
 	struct smb_conn_opt opt;
 	wait_queue_head_t conn_wq;
 	int conn_complete;
-	struct semaphore sem;
+	struct mutex sem;
 
 	unsigned char      header[SMB_HEADER_LEN + 20*2 + 2];
 	u32                header_len;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/sunrpc/svcsock.h linux-2.6.15-rc5-mutex/include/linux/sunrpc/svcsock.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/sunrpc/svcsock.h	2004-06-18 13:42:15.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/sunrpc/svcsock.h	2005-12-12 17:57:41.000000000 +0000
@@ -36,7 +36,7 @@ struct svc_sock {
 
 	struct list_head	sk_deferred;	/* deferred requests that need to
 						 * be revisted */
-	struct semaphore        sk_sem;		/* to serialize sending data */
+	struct mutex		sk_sem;		/* to serialize sending data */
 
 	int			(*sk_recvfrom)(struct svc_rqst *rqstp);
 	int			(*sk_sendto)(struct svc_rqst *rqstp);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/syscalls.h linux-2.6.15-rc5-mutex/include/linux/syscalls.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/syscalls.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/syscalls.h	2005-12-12 22:12:49.000000000 +0000
@@ -57,7 +57,7 @@ struct mq_attr;
 #include <linux/capability.h>
 #include <linux/list.h>
 #include <linux/sem.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 #include <linux/quota.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/tty.h linux-2.6.15-rc5-mutex/include/linux/tty.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/tty.h	2005-11-01 13:19:21.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/tty.h	2005-12-12 17:49:23.000000000 +0000
@@ -123,7 +123,7 @@ extern struct screen_info screen_info;
 
 struct tty_flip_buffer {
 	struct work_struct		work;
-	struct semaphore pty_sem;
+	struct mutex	pty_sem;
 	char		*char_buf_ptr;
 	unsigned char	*flag_buf_ptr;
 	int		count;
@@ -245,7 +245,7 @@ struct tty_struct {
 	struct tty_driver *driver;
 	int index;
 	struct tty_ldisc ldisc;
-	struct semaphore termios_sem;
+	struct mutex termios_sem;
 	struct termios *termios, *termios_locked;
 	char name[64];
 	int pgrp;
@@ -290,8 +290,8 @@ struct tty_struct {
 	int canon_data;
 	unsigned long canon_head;
 	unsigned int canon_column;
-	struct semaphore atomic_read;
-	struct semaphore atomic_write;
+	struct mutex atomic_read;
+	struct mutex atomic_write;
 	unsigned char *write_buf;
 	int write_cnt;
 	spinlock_t read_lock;
@@ -378,8 +378,8 @@ extern void tty_ldisc_put(int);
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
-struct semaphore;
-extern struct semaphore tty_sem;
+struct mutex;
+extern struct mutex tty_sem;
 
 /* n_tty.c */
 extern struct tty_ldisc tty_ldisc_N_TTY;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/udf_fs_sb.h linux-2.6.15-rc5-mutex/include/linux/udf_fs_sb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/udf_fs_sb.h	2005-03-02 12:08:59.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/udf_fs_sb.h	2005-12-12 22:12:49.000000000 +0000
@@ -18,7 +18,7 @@
 #ifndef _UDF_FS_SB_H
 #define _UDF_FS_SB_H 1
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #pragma pack(1)
 
@@ -116,7 +116,7 @@ struct udf_sb_info
 	/* VAT inode */
 	struct inode		*s_vat;
 
-	struct semaphore	s_alloc_sem;
+	struct mutex		s_alloc_sem;
 };
 
 #endif /* _UDF_FS_SB_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/uinput.h linux-2.6.15-rc5-mutex/include/linux/uinput.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/uinput.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/uinput.h	2005-12-12 19:34:11.000000000 +0000
@@ -51,7 +51,7 @@ struct uinput_request {
 
 struct uinput_device {
 	struct input_dev	*dev;
-	struct semaphore	sem;
+	struct mutex		sem;
 	enum uinput_state	state;
 	wait_queue_head_t	waitq;
 	unsigned char		ready;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/usb.h linux-2.6.15-rc5-mutex/include/linux/usb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/usb.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/usb.h	2005-12-12 19:41:15.000000000 +0000
@@ -329,7 +329,7 @@ struct usb_device {
 	struct usb_tt	*tt; 		/* low/full speed dev, highspeed hub */
 	int		ttport;		/* device port on that tt hub */
 
-	struct semaphore serialize;
+	struct mutex	serialize;
 
 	unsigned int toggle[2];		/* one bit for each endpoint
 					 * ([0] = IN, [1] = OUT) */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/videodev2.h linux-2.6.15-rc5-mutex/include/linux/videodev2.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/videodev2.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/videodev2.h	2005-12-12 19:34:27.000000000 +0000
@@ -80,7 +80,7 @@ struct video_device
 
 	/* for videodev.c intenal usage -- please don't touch */
 	int users;                     /* video_exclusive_{open|close} ... */
-	struct semaphore lock;         /* ... helper function uses these   */
+	struct mutex lock;             /* ... helper function uses these   */
 	char devfs_name[64];           /* devfs */
 	struct class_device class_dev; /* sysfs */
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/vt_kern.h linux-2.6.15-rc5-mutex/include/linux/vt_kern.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/vt_kern.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/vt_kern.h	2005-12-12 17:46:56.000000000 +0000
@@ -81,6 +81,6 @@ void reset_vc(struct vc_data *vc);
 
 #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
 extern char con_buf[CON_BUF_SIZE];
-extern struct semaphore con_buf_sem;
+extern struct mutex con_buf_sem;
 
 #endif /* _VT_KERN_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/media/saa7146.h linux-2.6.15-rc5-mutex/include/media/saa7146.h
--- /warthog/kernels/linux-2.6.15-rc5/include/media/saa7146.h	2005-11-01 13:19:21.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/media/saa7146.h	2005-12-12 19:36:26.000000000 +0000
@@ -112,7 +112,7 @@ struct saa7146_dev
 
 	/* different device locks */
 	spinlock_t			slock;
-        struct semaphore		lock;
+        struct mutex			lock;
 
 	unsigned char			__iomem *mem;		/* pointer to mapped IO memory */
 	int				revision;	/* chip revision; needed for bug-workarounds*/
@@ -133,7 +133,7 @@ struct saa7146_dev
 	void (*vv_callback)(struct saa7146_dev *dev, unsigned long status);
 
 	/* i2c-stuff */
-        struct semaphore	i2c_lock;
+        struct mutex		i2c_lock;
 	u32			i2c_bitrate;
 	struct saa7146_dma	d_i2c;	/* pointer to i2c memory */
 	wait_queue_head_t	i2c_wq;
@@ -150,7 +150,7 @@ int saa7146_i2c_transfer(struct saa7146_
 
 /* from saa7146_core.c */
 extern struct list_head saa7146_devices;
-extern struct semaphore saa7146_devices_lock;
+extern struct mutex saa7146_devices_lock;
 int saa7146_register_extension(struct saa7146_extension*);
 int saa7146_unregister_extension(struct saa7146_extension*);
 struct saa7146_format* format_by_fourcc(struct saa7146_dev *dev, int fourcc);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/media/video-buf-dvb.h linux-2.6.15-rc5-mutex/include/media/video-buf-dvb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/media/video-buf-dvb.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/media/video-buf-dvb.h	2005-12-12 19:36:11.000000000 +0000
@@ -11,7 +11,7 @@ struct videobuf_dvb {
 	struct videobuf_queue      dvbq;
 
 	/* video-buf-dvb state info */
-	struct semaphore           lock;
+	struct mutex               lock;
 	struct task_struct         *thread;
 	int                        nfeeds;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/media/video-buf.h linux-2.6.15-rc5-mutex/include/media/video-buf.h
--- /warthog/kernels/linux-2.6.15-rc5/include/media/video-buf.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/media/video-buf.h	2005-12-12 19:36:51.000000000 +0000
@@ -177,7 +177,7 @@ struct videobuf_queue_ops {
 };
 
 struct videobuf_queue {
-	struct semaphore           lock;
+	struct mutex               lock;
 	spinlock_t                 *irqlock;
 	struct pci_dev             *pci;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/net/af_unix.h linux-2.6.15-rc5-mutex/include/net/af_unix.h
--- /warthog/kernels/linux-2.6.15-rc5/include/net/af_unix.h	2005-11-01 13:19:21.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/net/af_unix.h	2005-12-12 17:58:01.000000000 +0000
@@ -71,7 +71,7 @@ struct unix_sock {
         struct unix_address     *addr;
         struct dentry		*dentry;
         struct vfsmount		*mnt;
-        struct semaphore        readsem;
+        struct mutex		readsem;
         struct sock		*peer;
         struct sock		*other;
         struct sock		*gc_tree;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/net/bluetooth/hci_core.h linux-2.6.15-rc5-mutex/include/net/bluetooth/hci_core.h
--- /warthog/kernels/linux-2.6.15-rc5/include/net/bluetooth/hci_core.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/net/bluetooth/hci_core.h	2005-12-12 19:46:23.000000000 +0000
@@ -106,7 +106,7 @@ struct hci_dev {
 
 	struct sk_buff		*sent_cmd;
 
-	struct semaphore	req_lock;
+	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
 	__u32			req_status;
 	__u32			req_result;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/net/xfrm.h linux-2.6.15-rc5-mutex/include/net/xfrm.h
--- /warthog/kernels/linux-2.6.15-rc5/include/net/xfrm.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/net/xfrm.h	2005-12-12 19:45:48.000000000 +0000
@@ -19,7 +19,7 @@
 
 #define XFRM_ALIGN8(len)	(((len) + 7) & ~7)
 
-extern struct semaphore xfrm_cfg_sem;
+extern struct mutex xfrm_cfg_sem;
 
 /* Organization of SPD aka "XFRM rules"
    ------------------------------------
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/pcmcia/ss.h linux-2.6.15-rc5-mutex/include/pcmcia/ss.h
--- /warthog/kernels/linux-2.6.15-rc5/include/pcmcia/ss.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/pcmcia/ss.h	2005-12-12 19:47:19.000000000 +0000
@@ -243,7 +243,7 @@ struct pcmcia_socket {
 #endif
 
 	/* state thread */
-	struct semaphore		skt_sem;	/* protects socket h/w state */
+	struct mutex			skt_sem;	/* protects socket h/w state */
 
 	struct task_struct		*thread;
 	struct completion		thread_done;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/scsi/scsi_host.h linux-2.6.15-rc5-mutex/include/scsi/scsi_host.h
--- /warthog/kernels/linux-2.6.15-rc5/include/scsi/scsi_host.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/scsi/scsi_host.h	2005-12-12 19:46:43.000000000 +0000
@@ -464,7 +464,7 @@ struct Scsi_Host {
 	spinlock_t		default_lock;
 	spinlock_t		*host_lock;
 
-	struct semaphore	scan_mutex;/* serialize scanning activity */
+	struct mutex		scan_mutex;/* serialize scanning activity */
 
 	struct list_head	eh_cmd_q;
 	struct task_struct    * ehandler;  /* Error recovery thread. */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/scsi/scsi_transport_spi.h linux-2.6.15-rc5-mutex/include/scsi/scsi_transport_spi.h
--- /warthog/kernels/linux-2.6.15-rc5/include/scsi/scsi_transport_spi.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/scsi/scsi_transport_spi.h	2005-12-12 19:46:50.000000000 +0000
@@ -51,7 +51,7 @@ struct spi_transport_attrs {
 	unsigned int support_qas; /* supports quick arbitration and selection */
 	/* Private Fields */
 	unsigned int dv_pending:1; /* Internal flag */
-	struct semaphore dv_sem; /* semaphore to serialise dv */
+	struct mutex dv_sem; /* semaphore to serialise dv */
 };
 
 enum spi_signal_type {
