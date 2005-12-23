Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbVLWG3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbVLWG3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 01:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbVLWG3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 01:29:20 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:14252 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030446AbVLWG3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 01:29:17 -0500
Date: Fri, 23 Dec 2005 07:31:59 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND patch 3/3] s390: remove redundant and useless code in qeth
Message-ID: <20051223073159.773896d0@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/3] s390: remove redundant and useless code in qeth

From: Frank Pavlic <fpavlic@de.ibm.com>
	- remove redundant and useless code in qeth for 
	  procfs operations.
	- update Revision numbers 	  
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_main.c |    6 -
 qeth_mpc.c  |    2 
 qeth_mpc.h  |    2 
 qeth_proc.c |  250 ++++++------------------------------------------------------
 qeth_sys.c  |    4 
 qeth_tso.h  |    4 
 6 files changed, 38 insertions(+), 230 deletions(-)

diff -Naupr linux-orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- linux-orig/drivers/s390/net/qeth_main.c	2005-12-12 19:01:34.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-12-12 19:13:30.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.246 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.251 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.242 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.251 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.246 $"
+#define VERSION_QETH_C "$Revision: 1.251 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
diff -Naupr linux-orig/drivers/s390/net/qeth_mpc.c linux-patched/drivers/s390/net/qeth_mpc.c
--- linux-orig/drivers/s390/net/qeth_mpc.c	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_mpc.c	2005-12-12 19:13:41.000000000 +0100
@@ -11,7 +11,7 @@
 #include <asm/cio.h>
 #include "qeth_mpc.h"
 
-const char *VERSION_QETH_MPC_C = "$Revision: 1.12 $";
+const char *VERSION_QETH_MPC_C = "$Revision: 1.13 $";
 
 unsigned char IDX_ACTIVATE_READ[]={
 	0x00,0x00,0x80,0x00, 0x00,0x00,0x00,0x00,
diff -Naupr linux-orig/drivers/s390/net/qeth_mpc.h linux-patched/drivers/s390/net/qeth_mpc.h
--- linux-orig/drivers/s390/net/qeth_mpc.h	2005-12-12 19:01:34.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_mpc.h	2005-12-12 19:13:54.000000000 +0100
@@ -14,7 +14,7 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.44 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.46 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
diff -Naupr linux-orig/drivers/s390/net/qeth_proc.c linux-patched/drivers/s390/net/qeth_proc.c
--- linux-orig/drivers/s390/net/qeth_proc.c	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_proc.c	2005-12-12 19:03:53.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.13 $)
+ * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.16 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,7 +21,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_PROC_C = "$Revision: 1.13 $";
+const char *VERSION_QETH_PROC_C = "$Revision: 1.16 $";
 
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
@@ -30,30 +30,26 @@ static struct proc_dir_entry *qeth_procf
 static int
 qeth_procfile_seq_match(struct device *dev, void *data)
 {
-	return 1;
+	return(dev ? 1 : 0);
 }
 
 static void *
 qeth_procfile_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct device *dev;
-	loff_t nr;
-
+	struct device *dev = NULL;
+	loff_t nr = 0;
+	
 	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	nr = *offset;
-	if (nr == 0)
+	if (*offset == 0)
 		return SEQ_START_TOKEN;
-
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL,
-				 NULL, qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
+	while (1) {
 		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
 					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
+		if (++nr == *offset)
+			break;
+		put_device(dev);
+	}
+	return dev;
 }
 
 static void
@@ -66,19 +62,14 @@ static void *
 qeth_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
 	struct device *prev, *next;
-
-	if (it == SEQ_START_TOKEN) {
-		next = driver_find_device(&qeth_ccwgroup_driver.driver,
-					  NULL, NULL, qeth_procfile_seq_match);
-		if (next)
-			(*offset)++;
-		return (void *) next;
-	}
-	prev = (struct device *) it;
+	
+	if (it == SEQ_START_TOKEN) 
+		prev = NULL;
+	else
+		prev = (struct device *) it;
 	next = driver_find_device(&qeth_ccwgroup_driver.driver,
 				  prev, NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
+	(*offset)++;
 	return (void *) next;
 }
 
@@ -87,7 +78,7 @@ qeth_get_router_str(struct qeth_card *ca
 {
 	int routing_type = 0;
 
-	if (ipv == 4){
+	if (ipv == 4) {
 		routing_type = card->options.route4.type;
 	} else {
 #ifdef CONFIG_QETH_IPV6
@@ -154,6 +145,7 @@ qeth_procfile_seq_show(struct seq_file *
 					card->qdio.in_buf_pool.buf_count);
 		else
 			seq_printf(s, "  +++ LAN OFFLINE +++\n");
+		put_device(device);
 	}
 	return 0;
 }
@@ -184,51 +176,16 @@ static struct file_operations qeth_procf
 static struct proc_dir_entry *qeth_perf_procfile;
 
 #ifdef CONFIG_QETH_PERF_STATS
-
-static void *
-qeth_perf_procfile_seq_start(struct seq_file *s, loff_t *offset)
-{
-	struct device *dev = NULL;
-	int nr;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-	/* get card at pos *offset */
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-				 qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
-		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
-					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
-}
-
-static void
-qeth_perf_procfile_seq_stop(struct seq_file *s, void* it)
-{
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void *
-qeth_perf_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
-{
-	struct device *prev, *next;
-
-	prev = (struct device *) it;
-	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
-				  NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
-	return (void *) next;
-}
-
 static int
 qeth_perf_procfile_seq_show(struct seq_file *s, void *it)
 {
 	struct device *device;
 	struct qeth_card *card;
 
+	
+	if (it == SEQ_START_TOKEN)
+		return 0;
+
 	device = (struct device *) it;
 	card = device->driver_data;
 	seq_printf(s, "For card with devnos %s/%s/%s (%s):\n",
@@ -295,13 +252,14 @@ qeth_perf_procfile_seq_show(struct seq_f
 		        card->perf_stats.outbound_do_qdio_time,
 			card->perf_stats.outbound_do_qdio_cnt
 		  );
+	put_device(device);
 	return 0;
 }
 
 static struct seq_operations qeth_perf_procfile_seq_ops = {
-	.start = qeth_perf_procfile_seq_start,
-	.stop  = qeth_perf_procfile_seq_stop,
-	.next  = qeth_perf_procfile_seq_next,
+	.start = qeth_procfile_seq_start,
+	.stop  = qeth_procfile_seq_stop,
+	.next  = qeth_procfile_seq_next,
 	.show  = qeth_perf_procfile_seq_show,
 };
 
@@ -324,93 +282,6 @@ static struct file_operations qeth_perf_
 #define qeth_perf_procfile_created 1
 #endif /* CONFIG_QETH_PERF_STATS */
 
-/***** /proc/qeth_ipa_takeover *****/
-#define QETH_IPATO_PROCFILE_NAME "qeth_ipa_takeover"
-static struct proc_dir_entry *qeth_ipato_procfile;
-
-static void *
-qeth_ipato_procfile_seq_start(struct seq_file *s, loff_t *offset)
-{
-	struct device *dev;
-	loff_t nr;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-	/* TODO: finish this */
-	/*
-	 * maybe SEQ_SATRT_TOKEN can be returned for offset 0
-	 * output driver settings then;
-	 * else output setting for respective card
-	 */
-
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-				 qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
-		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
-					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
-}
-
-static void
-qeth_ipato_procfile_seq_stop(struct seq_file *s, void* it)
-{
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void *
-qeth_ipato_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
-{
-	struct device *prev, *next;
-
-	prev = (struct device *) it;
-	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
-				  NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
-	return (void *) next;
-}
-
-static int
-qeth_ipato_procfile_seq_show(struct seq_file *s, void *it)
-{
-	struct device *device;
-	struct qeth_card *card;
-
-	/* TODO: finish this */
-	/*
-	 * maybe SEQ_SATRT_TOKEN can be returned for offset 0
-	 * output driver settings then;
-	 * else output setting for respective card
-	 */
-	device = (struct device *) it;
-	card = device->driver_data;
-
-	return 0;
-}
-
-static struct seq_operations qeth_ipato_procfile_seq_ops = {
-	.start = qeth_ipato_procfile_seq_start,
-	.stop  = qeth_ipato_procfile_seq_stop,
-	.next  = qeth_ipato_procfile_seq_next,
-	.show  = qeth_ipato_procfile_seq_show,
-};
-
-static int
-qeth_ipato_procfile_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &qeth_ipato_procfile_seq_ops);
-}
-
-static struct file_operations qeth_ipato_procfile_fops = {
-	.owner   = THIS_MODULE,
-	.open    = qeth_ipato_procfile_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 int __init
 qeth_create_procfs_entries(void)
 {
@@ -426,13 +297,7 @@ qeth_create_procfs_entries(void)
 		qeth_perf_procfile->proc_fops = &qeth_perf_procfile_fops;
 #endif /* CONFIG_QETH_PERF_STATS */
 
-	qeth_ipato_procfile = create_proc_entry(QETH_IPATO_PROCFILE_NAME,
-					   S_IFREG | 0444, NULL);
-	if (qeth_ipato_procfile)
-		qeth_ipato_procfile->proc_fops = &qeth_ipato_procfile_fops;
-
 	if (qeth_procfile &&
-	    qeth_ipato_procfile &&
 	    qeth_perf_procfile_created)
 		return 0;
 	else
@@ -446,62 +311,5 @@ qeth_remove_procfs_entries(void)
 		remove_proc_entry(QETH_PROCFILE_NAME, NULL);
 	if (qeth_perf_procfile)
 		remove_proc_entry(QETH_PERF_PROCFILE_NAME, NULL);
-	if (qeth_ipato_procfile)
-		remove_proc_entry(QETH_IPATO_PROCFILE_NAME, NULL);
-}
-
-
-/* ONLY FOR DEVELOPMENT! -> make it as module */
-/*
-static void
-qeth_create_sysfs_entries(void)
-{
-	struct device *dev;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	list_for_each_entry(dev, &qeth_ccwgroup_driver.driver.devices,
-			driver_list)
-		qeth_create_device_attributes(dev);
-
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void
-qeth_remove_sysfs_entries(void)
-{
-	struct device *dev;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	list_for_each_entry(dev, &qeth_ccwgroup_driver.driver.devices,
-			driver_list)
-		qeth_remove_device_attributes(dev);
-
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static int __init
-qeth_fs_init(void)
-{
-	printk(KERN_INFO "qeth_fs_init\n");
-	qeth_create_procfs_entries();
-	qeth_create_sysfs_entries();
-
-	return 0;
 }
 
-static void __exit
-qeth_fs_exit(void)
-{
-	printk(KERN_INFO "qeth_fs_exit\n");
-	qeth_remove_procfs_entries();
-	qeth_remove_sysfs_entries();
-}
-
-
-module_init(qeth_fs_init);
-module_exit(qeth_fs_exit);
-
-MODULE_LICENSE("GPL");
-*/
diff -Naupr linux-orig/drivers/s390/net/qeth_sys.c linux-patched/drivers/s390/net/qeth_sys.c
--- linux-orig/drivers/s390/net/qeth_sys.c	2005-12-12 18:15:36.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_sys.c	2005-12-12 19:14:23.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.59 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.60 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.59 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.60 $";
 
 /*****************************************************************************/
 /*                                                                           */
diff -Naupr linux-orig/drivers/s390/net/qeth_tso.h linux-patched/drivers/s390/net/qeth_tso.h
--- linux-orig/drivers/s390/net/qeth_tso.h	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_tso.h	2005-12-12 19:14:53.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.7 $)
+ * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.8 $)
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,7 +7,7 @@
  *
  *    Author(s): Frank Pavlic <fpavlic@de.ibm.com>
  *
- *    $Revision: 1.7 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.8 $	 $Date: 2005/05/04 20:19:18 $
  *
  */
 #ifndef __QETH_TSO_H__
