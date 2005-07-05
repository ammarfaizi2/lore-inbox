Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVGETSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVGETSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGETSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:18:10 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:28295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261557AbVGETRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:17:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l7uLH99EpNCabkncX8ft/czELtiLJmuXpNfVK3o1xZnnRu1HOOagtvheudH3wRt+9rITbaiWhZ4f8/xFKRJZFI01gApU3kvHBoBNT1PMys4wx0Ucg9K90uKcoOr5kO48ypELDnoICwK4Hm/YbYf5ACMFGPsV9pZdzX/CV4YVl+I=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] iteraid: remove ITE_IOC_GET_DRIVER_VERSION
Date: Tue, 5 Jul 2005 23:24:24 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Donald.Huang@ite.com.tw
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507052324.24654.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until too late.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

diff -uprN linux-2.6.13-rc1-mm1/drivers/scsi/iteraid.c linux-2.6.13-rc1-mm1-iteraid/drivers/scsi/iteraid.c
--- linux-2.6.13-rc1-mm1/drivers/scsi/iteraid.c	2005-07-03 04:13:08.000000000 +0400
+++ linux-2.6.13-rc1-mm1-iteraid/drivers/scsi/iteraid.c	2005-07-05 23:12:31.000000000 +0400
@@ -301,7 +301,7 @@ static int itedev_ioctl(struct inode *, 
 static int itedev_close(struct inode *, struct file *);
 
 #define DRV_VER_8212 "1.45"
-static int driver_ver = 145;
+MODULE_VERSION(DRV_VER_8212);
 static int ite_major = 0;
 
 static struct file_operations itedev_fops = {
@@ -5112,11 +5112,6 @@ exit:
 
 		put_user(status, (u8 __user *) arg);
 		return 0;
-	case ITE_IOC_GET_DRIVER_VERSION:
-		dprintk("ITE_IOC_GET_DRIVER_VERSION\n");
-
-		put_user(driver_ver, (int __user *)arg);
-		return 0;
 	default:
 		return -EINVAL;
 	}			/* end switch */
diff -uprN linux-2.6.13-rc1-mm1/drivers/scsi/iteraid.h linux-2.6.13-rc1-mm1-iteraid/drivers/scsi/iteraid.h
--- linux-2.6.13-rc1-mm1/drivers/scsi/iteraid.h	2005-07-03 04:13:08.000000000 +0400
+++ linux-2.6.13-rc1-mm1-iteraid/drivers/scsi/iteraid.h	2005-07-05 23:10:18.000000000 +0400
@@ -988,7 +988,6 @@ typedef struct _uioctl_t {
 #define ITE_IOC_REBUILD_START		_IO(ITE_IOCMAGIC, 3)
 #define ITE_IOC_GET_REBUILD_STATUS	_IO(ITE_IOCMAGIC, 4)
 #define ITE_IOC_RESET_ADAPTER		_IO(ITE_IOCMAGIC, 5)
-#define ITE_IOC_GET_DRIVER_VERSION	_IO(ITE_IOCMAGIC, 6)
 
 typedef struct _Channel {
 	/*
