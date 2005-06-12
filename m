Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVFLWpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVFLWpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 18:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFLWpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 18:45:17 -0400
Received: from smtp06.auna.com ([62.81.186.16]:53383 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261268AbVFLWov convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 18:44:51 -0400
Date: Sun, 12 Jun 2005 22:44:33 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [RFC] Patch series to remove devfs [00/22]
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
References: <20050611074327.GA27785@kroah.com>
In-Reply-To: <20050611074327.GA27785@kroah.com> (from gregkh@suse.de on Sat
	Jun 11 09:43:27 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1118616273l.18059l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.85] Login:jamagallon@able.es Fecha:Mon, 13 Jun 2005 00:44:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.11, Greg KH wrote:
> As everyone knows[1], devfs is going to be removed from the kernel soon.
> To accomplish this, here is a series of patches (22 in all) that do just
> that.  Surprisingly enough, devfs was almost everywhere in the kernel,
> that's why it takes so many patches :)
> 

You missed this for -mm, do not know if they apply to mainline:

--- linux-2.6.11-jam25/drivers/scsi/ch.c.orig	2005-06-13 00:40:58.000000000 +0200
+++ linux-2.6.11-jam25/drivers/scsi/ch.c	2005-06-13 00:41:16.000000000 +0200
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/completion.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/chio.h>			/* here are all the ioctls */
@@ -940,8 +939,6 @@
 	if (init)
 		ch_init_elem(ch);
 
-	devfs_mk_cdev(MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
-		      S_IFCHR | S_IRUGO | S_IWUGO, ch->name);
 	class_device_create(ch_sysfs_class,
 			    MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
 			    dev, "s%s", ch->name);
@@ -974,7 +971,6 @@
 
 	class_device_destroy(ch_sysfs_class,
 			     MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
-	devfs_remove(ch->name);
 	kfree(ch->dt);
 	kfree(ch);
 	ch_devcount--;
--- linux-2.6.11-jam25/drivers/scsi/arcmsr/arcmsr.c.orig	2005-06-13 00:40:00.000000000 +0200
+++ linux-2.6.11-jam25/drivers/scsi/arcmsr/arcmsr.c	2005-06-13 00:40:33.000000000 +0200
@@ -101,7 +101,6 @@
 #include <linux/moduleparam.h>
 #include <linux/blkdev.h>
 #include <linux/timer.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/mc146818rtc.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
@@ -1654,7 +1653,6 @@
 **	int                     attached;		            %% # of high level drivers attached to this %%
 **	int                     access_count;	            %% Count of open channels/mounts %%
 **	void                    *hostdata;		            %% available to low-level driver %%
-**	devfs_handle_t          de;                         %% directory for the device %%
 **	char                    type;
 **	char                    scsi_level;
 **	char                    vendor[8], model[16], rev[4];


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam24 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


