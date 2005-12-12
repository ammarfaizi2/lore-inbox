Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVLLXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVLLXqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLLXqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932264AbVLLXqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:37 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjm3w009047@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 11/19] MUTEX: Drivers Q-S changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/q* thru drivers/s* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-QtoS-2615rc5.diff
 drivers/s390/char/sclp_cpi.c           |   16 ++++++++--------
 drivers/s390/char/vmcp.h               |    4 ++--
 drivers/s390/cio/ccwgroup.c            |    2 +-
 drivers/s390/cio/qdio.c                |    2 +-
 drivers/s390/cio/qdio.h                |    2 +-
 drivers/s390/net/ctctty.c              |    2 +-
 drivers/s390/net/qeth_main.c           |    2 +-
 drivers/s390/s390mach.c                |    6 +++---
 drivers/s390/scsi/zfcp_aux.c           |    2 +-
 drivers/s390/scsi/zfcp_def.h           |    4 ++--
 drivers/s390/scsi/zfcp_erp.c           |   12 ++++++------
 drivers/sbus/char/vfc.h                |    2 +-
 drivers/scsi/3w-9xxx.h                 |    2 +-
 drivers/scsi/3w-xxxx.h                 |    2 +-
 drivers/scsi/aacraid/aachba.c          |    2 +-
 drivers/scsi/aacraid/aacraid.h         |    4 ++--
 drivers/scsi/aacraid/commctrl.c        |    2 +-
 drivers/scsi/aacraid/comminit.c        |    2 +-
 drivers/scsi/aacraid/commsup.c         |    2 +-
 drivers/scsi/aacraid/dpcsup.c          |    2 +-
 drivers/scsi/aacraid/linit.c           |    2 +-
 drivers/scsi/aacraid/rkt.c             |    2 +-
 drivers/scsi/aacraid/rx.c              |    2 +-
 drivers/scsi/aacraid/sa.c              |    2 +-
 drivers/scsi/aha152x.c                 |    8 ++++----
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 +-
 drivers/scsi/ch.c                      |    2 +-
 drivers/scsi/dpt/dpti_i2o.h            |    2 +-
 drivers/scsi/iscsi_tcp.h               |    2 +-
 drivers/scsi/libata-core.c             |    2 +-
 drivers/scsi/megaraid.h                |    2 +-
 drivers/scsi/megaraid/mega_common.h    |    2 +-
 drivers/scsi/megaraid/megaraid_ioctl.h |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c  |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.h  |    2 +-
 drivers/scsi/megaraid/megaraid_mm.c    |    6 +++---
 drivers/scsi/megaraid/megaraid_sas.c   |    6 +++---
 drivers/scsi/megaraid/megaraid_sas.h   |    2 +-
 drivers/scsi/osst.h                    |    2 +-
 drivers/scsi/qla2xxx/qla_def.h         |    8 ++++----
 drivers/scsi/qla2xxx/qla_gbl.h         |    2 +-
 drivers/scsi/qla2xxx/qla_mbx.c         |    2 +-
 drivers/scsi/qla2xxx/qla_os.c          |    2 +-
 drivers/scsi/scsi_scan.c               |    2 +-
 drivers/scsi/scsi_transport_spi.c      |    2 +-
 drivers/scsi/st.h                      |    2 +-
 drivers/serial/crisv10.c               |    2 +-
 drivers/serial/mcfserial.c             |    2 +-
 drivers/serial/pmac_zilog.c            |    2 +-
 50 files changed, 77 insertions(+), 77 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/char/sclp_cpi.c linux-2.6.15-rc5-mutex/drivers/s390/char/sclp_cpi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/char/sclp_cpi.c	2005-03-02 12:08:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/char/sclp_cpi.c	2005-12-12 22:08:48.000000000 +0000
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <asm/ebcdic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "sclp.h"
 #include "sclp_rw.h"
@@ -115,10 +115,10 @@ cpi_check_parms(void)
 static void
 cpi_callback(struct sclp_req *req, void *data)
 {
-	struct semaphore *sem;
+	struct completion *cpl;
 
-	sem = (struct semaphore *) data;
-	up(sem);
+	cpl = data;
+	complete(cpl);
 }
 
 static struct sclp_req *
@@ -185,7 +185,7 @@ cpi_free_req(struct sclp_req *req)
 static int __init
 cpi_module_init(void)
 {
-	struct semaphore sem;
+	struct completion cpl;
 	struct sclp_req *req;
 	int rc;
 
@@ -215,8 +215,8 @@ cpi_module_init(void)
 	}
 
 	/* Prepare semaphore */
-	sema_init(&sem, 0);
-	req->callback_data = &sem;
+	init_completion(&cpl);
+	req->callback_data = &cpl;
 	/* Add request to sclp queue */
 	rc = sclp_add_request(req);
 	if (rc) {
@@ -226,7 +226,7 @@ cpi_module_init(void)
 		return rc;
 	}
 	/* make "insmod" sleep until callback arrives */
-	down(&sem);
+	wait_for_completion(&cpl);
 
 	rc = ((struct cpi_sccb *) req->sccb)->header.response_code;
 	if (rc != 0x0020) {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/char/vmcp.h linux-2.6.15-rc5-mutex/drivers/s390/char/vmcp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/char/vmcp.h	2005-08-30 13:56:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/s390/char/vmcp.h	2005-12-12 22:08:48.000000000 +0000
@@ -12,7 +12,7 @@
  * The idea of this driver is based on cpint from Neale Ferguson
  */
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/ioctl.h>
 
 #define VMCP_GETCODE _IOR(0x10, 1, int)
@@ -26,5 +26,5 @@ struct vmcp_session {
 	int resp_code;
 	/* As we use copy_from/to_user, which might     *
 	 * sleep and cannot use a spinlock              */
-	struct semaphore mutex;
+	struct mutex mutex;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/ccwgroup.c linux-2.6.15-rc5-mutex/drivers/s390/cio/ccwgroup.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/ccwgroup.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/cio/ccwgroup.c	2005-12-12 22:08:48.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/ctype.h>
 #include <linux/dcache.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/qdio.c linux-2.6.15-rc5-mutex/drivers/s390/cio/qdio.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/qdio.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/cio/qdio.c	2005-12-12 22:08:48.000000000 +0000
@@ -42,7 +42,7 @@
 #include <asm/ccwdev.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/timex.h>
 
 #include <asm/debug.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/qdio.h linux-2.6.15-rc5-mutex/drivers/s390/cio/qdio.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/cio/qdio.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/cio/qdio.h	2005-12-12 21:40:46.000000000 +0000
@@ -645,6 +645,6 @@ struct qdio_irq {
 	struct qdr *qdr;
 	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
 	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
-	struct semaphore setting_up_sema;
+	struct mutex setting_up_sema;
 };
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/net/ctctty.c linux-2.6.15-rc5-mutex/drivers/s390/net/ctctty.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/net/ctctty.c	2005-08-30 13:56:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/s390/net/ctctty.c	2005-12-12 21:40:26.000000000 +0000
@@ -65,7 +65,7 @@ typedef struct {
   struct tty_struct 	*tty;            /* Pointer to corresponding tty   */
   wait_queue_head_t	open_wait;
   wait_queue_head_t	close_wait;
-  struct semaphore      write_sem;
+  struct mutex          write_sem;
   struct tasklet_struct tasklet;
   struct timer_list     stoptimer;
 } ctc_tty_info;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/net/qeth_main.c linux-2.6.15-rc5-mutex/drivers/s390/net/qeth_main.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/net/qeth_main.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/net/qeth_main.c	2005-12-12 22:08:48.000000000 +0000
@@ -63,7 +63,7 @@
 #include <asm/io.h>
 #include <asm/qeth.h>
 #include <asm/timex.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include "qeth.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/s390mach.c linux-2.6.15-rc5-mutex/drivers/s390/s390mach.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/s390mach.c	2005-11-01 13:19:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/s390mach.c	2005-12-12 21:40:07.000000000 +0000
@@ -21,7 +21,7 @@
 #define DBG printk
 // #define DBG(args,...) do {} while (0);
 
-static struct semaphore m_sem;
+static struct mutex m_sem;
 
 extern int css_process_crw(int);
 extern int chsc_process_crw(void);
@@ -51,9 +51,9 @@ s390_collect_crw_info(void *param)
 {
 	struct crw crw;
 	int ccode, ret, slow;
-	struct semaphore *sem;
+	struct mutex *sem;
 
-	sem = (struct semaphore *)param;
+	sem = param;
 	/* Set a nice name. */
 	daemonize("kmcheck");
 repeat:
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_aux.c linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_aux.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_aux.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_aux.c	2005-12-12 20:22:18.000000000 +0000
@@ -233,7 +233,7 @@ zfcp_module_init(void)
 		       ZFCP_CFDC_DEV_MAJOR, zfcp_cfdc_misc.minor);
 
 	/* Initialise proc semaphores */
-	sema_init(&zfcp_data.config_sema, 1);
+	init_MUTEX(&zfcp_data.config_sema, 1);
 
 	/* initialise configuration rw lock */
 	rwlock_init(&zfcp_data.config_lock);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_def.h linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_def.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_def.h	2005-11-01 13:19:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_def.h	2005-12-12 20:22:06.000000000 +0000
@@ -1065,13 +1065,13 @@ struct zfcp_data {
         rwlock_t                status_read_lock;   /* for status read thread */
         struct list_head        status_read_receive_head;
         struct list_head        status_read_send_head;
-        struct semaphore        status_read_sema;
+        struct mutex		status_read_sema;
 	wait_queue_head_t	status_read_thread_wqh;
 	u32			adapters;	    /* # of adapters in list */
 	rwlock_t                config_lock;        /* serialises changes
 						       to adapter/port/unit
 						       lists */
-	struct semaphore        config_sema;        /* serialises configuration
+	struct mutex		config_sema;        /* serialises configuration
 						       changes */
 	atomic_t		loglevel;            /* current loglevel */
 	char                    init_busid[BUS_ID_SIZE];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_erp.c linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_erp.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/s390/scsi/zfcp_erp.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/scsi/zfcp_erp.c	2005-12-12 20:24:22.000000000 +0000
@@ -830,7 +830,7 @@ zfcp_erp_action_ready(struct zfcp_erp_ac
 	debug_event(adapter->erp_dbf, 4, &erp_action->action, sizeof (int));
 
 	zfcp_erp_action_to_ready(erp_action);
-	up(&adapter->erp_ready_sem);
+	up_sem(&adapter->erp_ready_sem);
 }
 
 /*
@@ -1107,7 +1107,7 @@ zfcp_erp_thread_kill(struct zfcp_adapter
 	int retval = 0;
 
 	atomic_set_mask(ZFCP_STATUS_ADAPTER_ERP_THREAD_KILL, &adapter->status);
-	up(&adapter->erp_ready_sem);
+	up_sem(&adapter->erp_ready_sem);
 
 	wait_event(adapter->erp_thread_wqh,
 		   !atomic_test_mask(ZFCP_STATUS_ADAPTER_ERP_THREAD_UP,
@@ -1165,7 +1165,7 @@ zfcp_erp_thread(void *data)
 		 * no action in 'ready' queue to be processed and
 		 * thread is not to be killed
 		 */
-		down_interruptible(&adapter->erp_ready_sem);
+		down_sem_interruptible(&adapter->erp_ready_sem);
 		debug_text_event(adapter->erp_dbf, 5, "a_th_woken");
 	}
 
@@ -2318,7 +2318,7 @@ zfcp_erp_adapter_strategy_open_fsf_xconf
 		 * _must_ be the one belonging to the 'exchange config
 		 * data' request.
 		 */
-		down(&adapter->erp_ready_sem);
+		down_sem(&adapter->erp_ready_sem);
 		if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
 			ZFCP_LOG_INFO("error: exchange of configuration data "
 				      "for adapter %s timed out\n",
@@ -2374,7 +2374,7 @@ zfcp_erp_adapter_strategy_open_fsf_xport
 		}
 		debug_text_event(adapter->erp_dbf, 6, "a_xport_ok");
 
-		down(&adapter->erp_ready_sem);
+		down_sem(&adapter->erp_ready_sem);
 		if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
 			ZFCP_LOG_INFO("error: exchange of port data "
 				      "for adapter %s timed out\n",
@@ -3351,7 +3351,7 @@ zfcp_erp_action_enqueue(int action,
 
 	/* finally put it into 'ready' queue and kick erp thread */
 	list_add(&erp_action->list, &adapter->erp_ready_head);
-	up(&adapter->erp_ready_sem);
+	up_sem(&adapter->erp_ready_sem);
 	retval = 0;
  out:
 	return retval;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/sbus/char/vfc.h linux-2.6.15-rc5-mutex/drivers/sbus/char/vfc.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/sbus/char/vfc.h	2005-08-30 13:56:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/sbus/char/vfc.h	2005-12-12 21:18:51.000000000 +0000
@@ -128,7 +128,7 @@ struct vfc_dev {
 	volatile struct vfc_regs *regs;
 	struct vfc_regs *phys_regs;
 	unsigned int control_reg;
-	struct semaphore device_lock_sem;
+	struct mutex device_lock_sem;
 	int instance;
 	int busy;
 	unsigned long which_io;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/3w-9xxx.h linux-2.6.15-rc5-mutex/drivers/scsi/3w-9xxx.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/3w-9xxx.h	2005-11-01 13:19:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/3w-9xxx.h	2005-12-12 21:23:51.000000000 +0000
@@ -672,7 +672,7 @@ typedef struct TAG_TW_Device_Extension {
 	u32                     ioctl_msec;
 	int			chrdev_request_id;
 	wait_queue_head_t	ioctl_wqueue;
-	struct semaphore	ioctl_sem;
+	struct mutex		ioctl_sem;
 	char			aen_clobber;
 	unsigned short		working_srl;
 	unsigned short		working_branch;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/3w-xxxx.h linux-2.6.15-rc5-mutex/drivers/scsi/3w-xxxx.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/3w-xxxx.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/3w-xxxx.h	2005-12-12 21:24:35.000000000 +0000
@@ -420,7 +420,7 @@ typedef struct TAG_TW_Device_Extension {
 	u32			max_sector_count;
 	u32			aen_count;
 	struct Scsi_Host	*host;
-	struct semaphore	ioctl_sem;
+	struct mutex		ioctl_sem;
 	unsigned short		aen_queue[TW_Q_LENGTH];
 	unsigned char		aen_head;
 	unsigned char		aen_tail;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/aachba.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/aachba.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/aachba.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/aachba.c	2005-12-12 22:08:48.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/aacraid.h linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/aacraid.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/aacraid.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/aacraid.h	2005-12-12 21:25:15.000000000 +0000
@@ -735,7 +735,7 @@ struct aac_fib_context {
 	u32			unique;		// unique value representing this context
 	ulong			jiffies;	// used for cleanup - dmb changed to ulong
 	struct list_head	next;		// used to link context's into a linked list
-	struct semaphore 	wait_sem;	// this is used to wait for the next fib to arrive.
+	struct mutex		wait_sem;	// this is used to wait for the next fib to arrive.
 	int			wait;		// Set to true when thread is in WaitForSingleObject
 	unsigned long		count;		// total number of FIBs on FibList
 	struct list_head	fib_list;	// this holds fibs and their attachd hw_fibs
@@ -804,7 +804,7 @@ struct fib {
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
 	 */
-	struct semaphore 	event_wait;
+	struct mutex		event_wait;
 	spinlock_t		event_lock;
 
 	u32			done;	/* gets set to 1 when fib is complete */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/commctrl.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/commctrl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/commctrl.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/commctrl.c	2005-12-12 22:08:48.000000000 +0000
@@ -38,7 +38,7 @@
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include "aacraid.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/comminit.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/comminit.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/comminit.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/comminit.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/completion.h>
 #include <linux/mm.h>
 #include <scsi/scsi_host.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "aacraid.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/commsup.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/commsup.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/commsup.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/commsup.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/blkdev.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/delay.h>
 
 #include "aacraid.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/dpcsup.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/dpcsup.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/dpcsup.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/dpcsup.c	2005-12-12 22:08:48.000000000 +0000
@@ -38,7 +38,7 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "aacraid.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/linit.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/linit.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/linit.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/linit.c	2005-12-12 22:08:48.000000000 +0000
@@ -49,7 +49,7 @@
 #include <linux/ioctl32.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/rkt.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/rkt.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/rkt.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/rkt.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/completion.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi_host.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/rx.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/rx.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/rx.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/rx.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/completion.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi_host.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/sa.c linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/sa.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aacraid/sa.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aacraid/sa.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/completion.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi_host.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aha152x.c linux-2.6.15-rc5-mutex/drivers/scsi/aha152x.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aha152x.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aha152x.c	2005-12-12 22:08:48.000000000 +0000
@@ -253,7 +253,7 @@
 #include <linux/isapnp.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <scsi/scsicam.h>
 
 #include "scsi.h"
@@ -549,7 +549,7 @@ struct aha152x_hostdata {
  */
 struct aha152x_scdata {
 	Scsi_Cmnd *next;	/* next sc in queue */
-	struct semaphore *sem;	/* semaphore to block on */
+	struct mutex *sem;	/* semaphore to block on */
 };
 
 
@@ -978,7 +978,7 @@ static int setup_expected_interrupts(str
 /* 
  *  Queue a command and setup interrupts for a free bus.
  */
-static int aha152x_internal_queue(Scsi_Cmnd *SCpnt, struct semaphore *sem, int phase, void (*done)(Scsi_Cmnd *))
+static int aha152x_internal_queue(Scsi_Cmnd *SCpnt, struct mutex *sem, int phase, void (*done)(Scsi_Cmnd *))
 {
 	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
@@ -1142,7 +1142,7 @@ static int aha152x_abort(Scsi_Cmnd *SCpn
 static void timer_expired(unsigned long p)
 {
 	Scsi_Cmnd	 *SCp   = (Scsi_Cmnd *)p;
-	struct semaphore *sem   = SCSEM(SCp);
+	struct mutex     *sem   = SCSEM(SCp);
 	struct Scsi_Host *shpnt = SCp->device->host;
 	unsigned long flags;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aic7xxx/aic79xx_osm.h linux-2.6.15-rc5-mutex/drivers/scsi/aic7xxx/aic79xx_osm.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aic7xxx/aic79xx_osm.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aic7xxx/aic79xx_osm.h	2005-12-12 21:20:02.000000000 +0000
@@ -390,7 +390,7 @@ struct ahd_platform_data {
 	spinlock_t		 spin_lock;
 	u_int			 qfrozen;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
+	struct mutex		 eh_sem;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHD_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.6.15-rc5-mutex/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-12-12 21:45:18.000000000 +0000
@@ -394,7 +394,7 @@ struct ahc_platform_data {
 	spinlock_t		 spin_lock;
 	u_int			 qfrozen;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
+	struct mutex		 eh_sem;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/ch.c linux-2.6.15-rc5-mutex/drivers/scsi/ch.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/ch.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/ch.c	2005-12-12 21:23:01.000000000 +0000
@@ -112,7 +112,7 @@ typedef struct {
 	u_int               counts[CH_TYPES];
 	u_int               unit_attention;
 	u_int		    voltags;
-	struct semaphore    lock;
+	struct mutex        lock;
 } scsi_changer;
 
 static LIST_HEAD(ch_devlist);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/dpt/dpti_i2o.h linux-2.6.15-rc5-mutex/drivers/scsi/dpt/dpti_i2o.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/dpt/dpti_i2o.h	2004-06-18 13:41:50.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/scsi/dpt/dpti_i2o.h	2005-12-12 22:08:48.000000000 +0000
@@ -21,7 +21,7 @@
 
 #include <linux/i2o-dev.h>
 
-#include <asm/semaphore.h> /* Needed for MUTEX init macros */
+#include <linux/semaphore.h> /* Needed for MUTEX init macros */
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/notifier.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/iscsi_tcp.h linux-2.6.15-rc5-mutex/drivers/scsi/iscsi_tcp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/iscsi_tcp.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/iscsi_tcp.h	2005-12-12 21:24:13.000000000 +0000
@@ -157,7 +157,7 @@ struct iscsi_conn {
 	struct kfifo		*mgmtqueue;	/* mgmt (control) xmit queue */
 	struct kfifo		*xmitqueue;	/* data-path cmd queue */
 	struct work_struct	xmitwork;	/* per-conn. xmit workqueue */
-	struct semaphore	xmitsema;	/* serializes connection xmit,
+	struct mutex		xmitsema;	/* serializes connection xmit,
 						 * access to kfifos:	  *
 						 * xmitqueue, writequeue, *
 						 * immqueue, mgmtqueue    */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/libata-core.c linux-2.6.15-rc5-mutex/drivers/scsi/libata-core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/libata-core.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/libata-core.c	2005-12-12 22:08:48.000000000 +0000
@@ -56,7 +56,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 
 #include "libata.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/mega_common.h linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/mega_common.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/mega_common.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/mega_common.h	2005-12-12 22:08:48.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/dma-mapping.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_ioctl.h linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_ioctl.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_ioctl.h	2005-03-02 12:08:25.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_ioctl.h	2005-12-12 22:08:48.000000000 +0000
@@ -18,7 +18,7 @@
 #define _MEGARAID_IOCTL_H_
 
 #include <linux/types.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "mbox_defs.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mbox.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mbox.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mbox.c	2005-12-12 20:14:16.000000000 +0000
@@ -3870,7 +3870,7 @@ megaraid_sysfs_alloc_resources(adapter_t
 		megaraid_sysfs_free_resources(adapter);
 	}
 
-	sema_init(&raid_dev->sysfs_sem, 1);
+	init_MUTEX(&raid_dev->sysfs_sem);
 
 	init_waitqueue_head(&raid_dev->sysfs_wait_q);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mbox.h linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mbox.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mbox.h	2005-08-30 13:56:25.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mbox.h	2005-12-12 20:14:29.000000000 +0000
@@ -205,7 +205,7 @@ typedef struct {
 	int				hw_error;
 	int				fast_load;
 	uint8_t				channel_class;
-	struct semaphore		sysfs_sem;
+	struct mutex			sysfs_sem;
 	uioc_t				*sysfs_uioc;
 	mbox64_t			*sysfs_mbox64;
 	caddr_t				sysfs_buffer;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mm.c linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mm.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mm.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_mm.c	2005-12-12 20:34:30.000000000 +0000
@@ -571,14 +571,14 @@ mraid_mm_alloc_kioc(mraid_mmadp_t *adp)
 	struct list_head*	head;
 	unsigned long		flags;
 
-	down(&adp->kioc_semaphore);
+	down_sem(&adp->kioc_semaphore);
 
 	spin_lock_irqsave(&adp->kioc_pool_lock, flags);
 
 	head = &adp->kioc_pool;
 
 	if (list_empty(head)) {
-		up(&adp->kioc_semaphore);
+		up_sem(&adp->kioc_semaphore);
 		spin_unlock_irqrestore(&adp->kioc_pool_lock, flags);
 
 		con_log(CL_ANN, ("megaraid cmm: kioc list empty!\n"));
@@ -645,7 +645,7 @@ mraid_mm_dealloc_kioc(mraid_mmadp_t *adp
 	spin_unlock_irqrestore(&adp->kioc_pool_lock, flags);
 
 	/* increment the free kioc count */
-	up(&adp->kioc_semaphore);
+	up_sem(&adp->kioc_semaphore);
 
 	return;
 }
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.c	2005-12-12 20:35:15.000000000 +0000
@@ -2100,7 +2100,7 @@ megasas_probe_one(struct pci_dev *pdev, 
 	spin_lock_init(&instance->cmd_pool_lock);
 	spin_lock_init(&instance->instance_lock);
 
-	sema_init(&instance->aen_mutex, 1);
+	init_MUTEX(&instance->aen_mutex);
 	sema_init(&instance->ioctl_sem, MEGASAS_INT_CMDS);
 
 	/*
@@ -2579,12 +2579,12 @@ static int megasas_mgmt_ioctl_fw(struct 
 	/*
 	 * We will allow only MEGASAS_INT_CMDS number of parallel ioctl cmds
 	 */
-	if (down_interruptible(&instance->ioctl_sem)) {
+	if (down_sem_interruptible(&instance->ioctl_sem)) {
 		error = -ERESTARTSYS;
 		goto out_kfree_ioc;
 	}
 	error = megasas_mgmt_fw_ioctl(instance, user_ioc, ioc);
-	up(&instance->ioctl_sem);
+	up_sem(&instance->ioctl_sem);
 
       out_kfree_ioc:
 	kfree(ioc);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.h linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.h	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.h	2005-12-12 20:14:04.000000000 +0000
@@ -1042,7 +1042,7 @@ struct megasas_instance {
 	struct megasas_evt_detail *evt_detail;
 	dma_addr_t evt_detail_h;
 	struct megasas_cmd *aen_cmd;
-	struct semaphore aen_mutex;
+	struct mutex aen_mutex;
 	struct semaphore ioctl_sem;
 
 	struct Scsi_Host *host;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid.h linux-2.6.15-rc5-mutex/drivers/scsi/megaraid.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/megaraid.h	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid.h	2005-12-12 21:23:40.000000000 +0000
@@ -889,7 +889,7 @@ typedef struct {
 
 	scb_t			int_scb;
 	Scsi_Cmnd		int_scmd;
-	struct semaphore	int_mtx;	/* To synchronize the internal
+	struct mutex		int_mtx;	/* To synchronize the internal
 						commands */
 	struct completion	int_waitq;	/* wait queue for internal
 						 cmds */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/osst.h linux-2.6.15-rc5-mutex/drivers/scsi/osst.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/osst.h	2005-03-02 12:08:25.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/osst.h	2005-12-12 21:23:13.000000000 +0000
@@ -532,7 +532,7 @@ struct osst_tape {
   struct scsi_driver *driver;
   unsigned capacity;
   struct scsi_device *device;
-  struct semaphore lock;       /* for serialization */
+  struct mutex lock;           /* for serialization */
   struct completion wait;      /* for SCSI commands */
   struct osst_buffer * buffer;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_def.h linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_def.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_def.h	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_def.h	2005-12-12 22:08:48.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
@@ -2370,7 +2370,7 @@ typedef struct scsi_qla_host {
 	int			dpc_should_die;
 	struct completion	dpc_inited;
 	struct completion	dpc_exited;
-	struct semaphore	*dpc_wait;
+	struct mutex		*dpc_wait;
 	uint8_t dpc_active;                  /* DPC routine is active */
 
 	/* Timeout timers. */
@@ -2410,8 +2410,8 @@ typedef struct scsi_qla_host {
 
 	spinlock_t	mbx_reg_lock;   /* Mbx Cmd Register Lock */
 
-	struct semaphore mbx_cmd_sem;	/* Serialialize mbx access */
-	struct semaphore mbx_intr_sem;  /* Used for completion notification */
+	struct mutex mbx_cmd_sem;	/* Serialialize mbx access */
+	struct mutex mbx_intr_sem;	/* Used for completion notification */
 
 	uint32_t	mbx_flags;
 #define  MBX_IN_PROGRESS	BIT_0
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_gbl.h linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_gbl.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_gbl.h	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_gbl.h	2005-12-12 21:20:49.000000000 +0000
@@ -74,7 +74,7 @@ extern void qla2x00_mark_all_devices_los
 
 extern void qla2x00_blink_led(scsi_qla_host_t *);
 
-extern int qla2x00_down_timeout(struct semaphore *, unsigned long);
+extern int qla2x00_down_timeout(struct mutex *, unsigned long);
 
 /*
  * Global Function Prototypes in qla_iocb.c source file.
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_mbx.c linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_mbx.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_mbx.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_mbx.c	2005-12-12 21:46:06.000000000 +0000
@@ -12,7 +12,7 @@
 static void
 qla2x00_mbx_sem_timeout(unsigned long data)
 {
-	struct semaphore	*sem_ptr = (struct semaphore *)data;
+	struct mutex	*sem_ptr = (struct mutex *)data;
 
 	DEBUG11(printk("qla2x00_sem_timeout: entered.\n");)
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_os.c linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_os.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_os.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_os.c	2005-12-12 21:21:00.000000000 +0000
@@ -2468,7 +2468,7 @@ qla2x00_timer(scsi_qla_host_t *ha)
 
 /* XXX(hch): crude hack to emulate a down_timeout() */
 int
-qla2x00_down_timeout(struct semaphore *sema, unsigned long timeout)
+qla2x00_down_timeout(struct mutex *sema, unsigned long timeout)
 {
 	const unsigned int step = 100; /* msecs */
 	unsigned int iterations = jiffies_to_msecs(timeout)/100;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/scsi_scan.c linux-2.6.15-rc5-mutex/drivers/scsi/scsi_scan.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/scsi_scan.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/scsi_scan.c	2005-12-12 22:08:48.000000000 +0000
@@ -30,7 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/scsi_transport_spi.c linux-2.6.15-rc5-mutex/drivers/scsi/scsi_transport_spi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/scsi_transport_spi.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/scsi_transport_spi.c	2005-12-12 22:08:48.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <scsi/scsi.h>
 #include "scsi_priv.h"
 #include <scsi/scsi_device.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/st.h linux-2.6.15-rc5-mutex/drivers/scsi/st.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/scsi/st.h	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/st.h	2005-12-12 21:23:22.000000000 +0000
@@ -87,7 +87,7 @@ struct st_partstat {
 struct scsi_tape {
 	struct scsi_driver *driver;
 	struct scsi_device *device;
-	struct semaphore lock;	/* For serialization */
+	struct mutex lock;	/* For serialization */
 	struct completion wait;	/* For SCSI commands */
 	struct st_buffer *buffer;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/serial/crisv10.c linux-2.6.15-rc5-mutex/drivers/serial/crisv10.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/serial/crisv10.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/crisv10.c	2005-12-12 21:37:16.000000000 +0000
@@ -1318,7 +1318,7 @@ static unsigned char *tmp_buf;
 #ifdef DECLARE_MUTEX
 static DECLARE_MUTEX(tmp_buf_sem);
 #else
-static struct semaphore tmp_buf_sem = MUTEX;
+static struct mutex tmp_buf_sem = MUTEX;
 #endif
 
 /* Calculate the chartime depending on baudrate, numbor of bits etc. */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/serial/mcfserial.c linux-2.6.15-rc5-mutex/drivers/serial/mcfserial.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/serial/mcfserial.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/mcfserial.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/delay.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/serial/pmac_zilog.c linux-2.6.15-rc5-mutex/drivers/serial/pmac_zilog.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/serial/pmac_zilog.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/pmac_zilog.c	2005-12-12 22:08:48.000000000 +0000
@@ -68,7 +68,7 @@
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
 #include <asm/macio.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
