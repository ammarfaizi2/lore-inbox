Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbTCGMje>; Fri, 7 Mar 2003 07:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCGMje>; Fri, 7 Mar 2003 07:39:34 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:35471 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261558AbTCGMj0> convert rfc822-to-8bit; Fri, 7 Mar 2003 07:39:26 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (5/7): kmalloc arguments.
Date: Fri, 7 Mar 2003 13:38:11 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303071338.11611.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing GFP_KERNEL to kmallocs with GFP_DMA.

diffstat:
 cio/css.c        |    4 ++--
 cio/device.c     |    5 +++--
 cio/device_ops.c |    2 +-
 cio/qdio.c       |    6 +++---
 net/netiucv.c    |   12 +++++++-----
 5 files changed, 16 insertions(+), 13 deletions(-)

diff -urN linux-2.5.64/drivers/s390/cio/css.c linux-2.5.64-s390/drivers/s390/cio/css.c
--- linux-2.5.64/drivers/s390/cio/css.c	Wed Mar  5 04:28:59 2003
+++ linux-2.5.64-s390/drivers/s390/cio/css.c	Fri Mar  7 11:40:48 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.40 $
+ *   $Revision: 1.41 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -41,7 +41,7 @@
 		/* There already is a struct subchannel for this irq. */
 		return -EBUSY;
 
-	sch = kmalloc (sizeof (*sch), GFP_DMA);
+	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
 	if (sch == NULL)
 		return -ENOMEM;
 	ret = cio_validate_subchannel (sch, irq);
diff -urN linux-2.5.64/drivers/s390/cio/device.c linux-2.5.64-s390/drivers/s390/cio/device.c
--- linux-2.5.64/drivers/s390/cio/device.c	Wed Mar  5 04:29:32 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device.c	Fri Mar  7 11:40:48 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.50 $
+ *   $Revision: 1.51 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -452,7 +452,8 @@
 	if (!cdev)
 		return -ENOMEM;
 	memset(cdev, 0, sizeof(struct ccw_device));
-	cdev->private = kmalloc(sizeof(struct ccw_device_private), GFP_DMA);
+	cdev->private = kmalloc(sizeof(struct ccw_device_private), 
+				GFP_KERNEL | GFP_DMA);
 	if (!cdev->private) {
 		kfree(cdev);
 		return -ENOMEM;
diff -urN linux-2.5.64/drivers/s390/cio/device_ops.c linux-2.5.64-s390/drivers/s390/cio/device_ops.c
--- linux-2.5.64/drivers/s390/cio/device_ops.c	Wed Mar  5 04:29:32 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device_ops.c	Fri Mar  7 11:40:48 2003
@@ -300,7 +300,7 @@
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
-	rcd_buf = kmalloc(ciw->count, GFP_DMA);
+	rcd_buf = kmalloc(ciw->count, GFP_KERNEL | GFP_DMA);
  	if (!rcd_buf)
 		return -ENOMEM;
  	memset (rcd_buf, 0, ciw->count);
diff -urN linux-2.5.64/drivers/s390/cio/qdio.c linux-2.5.64-s390/drivers/s390/cio/qdio.c
--- linux-2.5.64/drivers/s390/cio/qdio.c	Wed Mar  5 04:29:23 2003
+++ linux-2.5.64-s390/drivers/s390/cio/qdio.c	Fri Mar  7 11:40:48 2003
@@ -55,7 +55,7 @@
 #include "qdio.h"
 #include "ioasm.h"
 
-#define VERSION_QDIO_C "$Revision: 1.34 $"
+#define VERSION_QDIO_C "$Revision: 1.35 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -2334,7 +2334,7 @@
 	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
-	irq_ptr=kmalloc(sizeof(struct qdio_irq),GFP_DMA);
+	irq_ptr=kmalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
 
 	QDIO_DBF_TEXT0(0,setup,"irq_ptr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
@@ -2347,7 +2347,7 @@
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
         /* wipes qib.ac, required by ar7063 */
 
-	irq_ptr->qdr=kmalloc(sizeof(struct qdr),GFP_DMA);
+	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
    		kfree(irq_ptr->qdr);
    		kfree(irq_ptr);
diff -urN linux-2.5.64/drivers/s390/net/netiucv.c linux-2.5.64-s390/drivers/s390/net/netiucv.c
--- linux-2.5.64/drivers/s390/net/netiucv.c	Wed Mar  5 04:29:22 2003
+++ linux-2.5.64-s390/drivers/s390/net/netiucv.c	Fri Mar  7 11:40:48 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.16 2003/02/18 09:15:14 mschwide Exp $
+ * $Id: netiucv.c,v 1.17 2003/02/28 14:00:41 aberg Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.16 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.17 $
  *
  */
 
@@ -1517,12 +1517,14 @@
 		conn->max_buffsize = NETIUCV_BUFSIZE_DEFAULT;
 		conn->netdev = dev;
 
-		conn->rx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT, GFP_DMA);
+		conn->rx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT,
+					  GFP_KERNEL | GFP_DMA);
 		if (!conn->rx_buff) {
 			kfree(conn);
 			return NULL;
 		}
-		conn->tx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT, GFP_DMA);
+		conn->tx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT,
+					  GFP_KERNEL | GFP_DMA);
 		if (!conn->tx_buff) {
 			kfree_skb(conn->rx_buff);
 			kfree(conn);
@@ -1717,7 +1719,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.16 $";
+	char vbuf[] = "$Revision: 1.17 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {

