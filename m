Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRAVXdr>; Mon, 22 Jan 2001 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRAVXdh>; Mon, 22 Jan 2001 18:33:37 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:20561
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135624AbRAVXd2>; Mon, 22 Jan 2001 18:33:28 -0500
Date: Tue, 23 Jan 2001 00:33:21 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux@3ware.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/3w-xxxx.c check_region -> request_region (241p9)
Message-ID: <20010123003321.H602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, forgot lk.)

Hi.

The following patch makes drivers/scsi/3w-xxxx.c use the return
code from request_region instead of check_region. 

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/3w-xxxx.c	Thu Nov  9 02:09:50 2000
+++ linux-ac10/drivers/scsi/3w-xxxx.c	Tue Jan 23 00:22:28 2001
@@ -659,8 +659,8 @@
 			continue;
 		}
 
-		/* Make sure that io region isn't already taken */
-		if (check_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE)) {
+		/* Reserve the io address space */
+		if (!request_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE, TW_DEVICE_NAME)) {
 			printk(KERN_WARNING "3w-xxxx: tw_findcards(): Couldn't get io range 0x%lx-0x%lx for card %d.\n", 
 				(tw_dev->tw_pci_dev->resource[0].start), 
 				(tw_dev->tw_pci_dev->resource[0].start) + 
@@ -670,8 +670,6 @@
 			continue;
 		}
     
-		/* Reserve the io address space */
-		request_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE, TW_DEVICE_NAME);
 		error = tw_initialize_units(tw_dev);
 		if (error) {
 			printk(KERN_WARNING "3w-xxxx: tw_findcards(): Couldn't initialize units for card %d.\n", numcards);

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"I begin by taking. I shall find scholars later to demonstrate my 
perfect right." - Frederick (II) the Great
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
