Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUFVSHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUFVSHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUFVSE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:04:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:41909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265062AbUFVRn1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:27 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926109288@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <10879261101948@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.51, 2004/06/04 11:09:29-07:00, greg@kroah.com

Driver Model: And even more cleanup of silly scsi use of the *ATTR macros...
  
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/scsi/scsi_sysfs.c         |   10 +++++-----
 drivers/scsi/scsi_transport_spi.c |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Tue Jun 22 09:48:30 2004
+++ b/drivers/scsi/scsi_sysfs.c	Tue Jun 22 09:48:30 2004
@@ -99,7 +99,7 @@
  */
 #define shost_rd_attr2(name, field, format_string)			\
 	shost_show_function(name, field, format_string)			\
-static CLASS_DEVICE_ATTR(name, S_IRUGO, show_##name, NULL)
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_##name, NULL);
 
 #define shost_rd_attr(field, format_string) \
 shost_rd_attr2(field, field, format_string)
@@ -228,8 +228,8 @@
  * read only field.
  */
 #define sdev_rd_attr(field, format_string)				\
-	sdev_show_function(field, format_string)				\
-static DEVICE_ATTR(field, S_IRUGO, sdev_show_##field, NULL)
+	sdev_show_function(field, format_string)			\
+static DEVICE_ATTR(field, S_IRUGO, sdev_show_##field, NULL);
 
 
 /*
@@ -247,7 +247,7 @@
 	snscanf (buf, 20, format_string, &sdev->field);			\
 	return count;							\
 }									\
-static DEVICE_ATTR(field, S_IRUGO | S_IWUSR, sdev_show_##field, sdev_store_##field)
+static DEVICE_ATTR(field, S_IRUGO | S_IWUSR, sdev_show_##field, sdev_store_##field);
 
 /* Currently we don't export bit fields, but we might in future,
  * so leave this code in */
@@ -272,7 +272,7 @@
 	}								\
 	return ret;							\
 }									\
-static DEVICE_ATTR(field, S_IRUGO | S_IWUSR, sdev_show_##field, sdev_store_##field)
+static DEVICE_ATTR(field, S_IRUGO | S_IWUSR, sdev_show_##field, sdev_store_##field);
 
 /*
  * scsi_sdev_check_buf_bit: return 0 if buf is "0", return 1 if buf is "1",
diff -Nru a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c	Tue Jun 22 09:48:30 2004
+++ b/drivers/scsi/scsi_transport_spi.c	Tue Jun 22 09:48:30 2004
@@ -152,7 +152,7 @@
 	spi_transport_store_function(field, format_string)		\
 static CLASS_DEVICE_ATTR(field, S_IRUGO | S_IWUSR,			\
 			 show_spi_transport_##field,			\
-			 store_spi_transport_##field)
+			 store_spi_transport_##field);
 
 /* The Parallel SCSI Tranport Attributes: */
 spi_transport_rd_attr(offset, "%d\n");
@@ -173,7 +173,7 @@
 	spi_dv_device(sdev);
 	return count;
 }
-static CLASS_DEVICE_ATTR(revalidate, S_IWUSR, NULL, store_spi_revalidate)
+static CLASS_DEVICE_ATTR(revalidate, S_IWUSR, NULL, store_spi_revalidate);
 
 /* Translate the period into ns according to the current spec
  * for SDTR/PPR messages */

