Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUEMJOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUEMJOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 05:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUEMJOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 05:14:24 -0400
Received: from verein.lst.de ([212.34.189.10]:2011 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263979AbUEMJNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 05:13:50 -0400
Date: Thu, 13 May 2004 11:13:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove driver model code in mwave driver
Message-ID: <20040513091342.GA28155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone blindly added sysfs support to the driver long time ago without
understanding the implications (and if they were understood the driver
would need half a rewrite for it).  Herber Xu recently noticed the
problems this causes on unload, so let's if 0 out all that code and get
the driver working again.


--- 1.12/drivers/char/mwave/mwavedd.c	Wed Sep 10 08:41:45 2003
+++ edited/drivers/char/mwave/mwavedd.c	Sun Apr 18 13:31:22 2004
@@ -466,6 +466,7 @@
 
 static struct miscdevice mwave_misc_dev = { MWAVE_MINOR, "mwave", &mwave_fops };
 
+#if 0 /* totally b0rked */
 /*
  * sysfs support <paulsch@us.ibm.com>
  */
@@ -499,6 +500,7 @@
 	&dev_attr_uart_irq,
 	&dev_attr_uart_io,
 };
+#endif
 
 /*
 * mwave_init is called on module load
@@ -508,11 +510,11 @@
 */
 static void mwave_exit(void)
 {
-	int i;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
 	PRINTK_1(TRACE_MWAVE, "mwavedd::mwave_exit entry\n");
 
+#if 0
 	for (i = 0; i < pDrvData->nr_registered_attrs; i++)
 		device_remove_file(&mwave_device, mwave_dev_attrs[i]);
 	pDrvData->nr_registered_attrs = 0;
@@ -521,6 +523,7 @@
 		device_unregister(&mwave_device);
 		pDrvData->device_registered = FALSE;
 	}
+#endif
 
 	if ( pDrvData->sLine >= 0 ) {
 		unregister_serial(pDrvData->sLine);
@@ -638,6 +641,7 @@
 	}
 	/* uart is registered */
 
+#if 0
 	/* sysfs */
 	memset(&mwave_device, 0, sizeof (struct device));
 	snprintf(mwave_device.bus_id, BUS_ID_SIZE, "mwave");
@@ -655,6 +659,7 @@
 		}
 		pDrvData->nr_registered_attrs++;
 	}
+#endif
 
 	/* SUCCESS! */
 	return 0;
