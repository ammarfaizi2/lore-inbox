Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRAWWXW>; Tue, 23 Jan 2001 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbRAWWXN>; Tue, 23 Jan 2001 17:23:13 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:53845
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131103AbRAWWWx>; Tue, 23 Jan 2001 17:22:53 -0500
Date: Tue, 23 Jan 2001 23:22:46 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/qla1280.c check_region -> request->region (241p9)
Message-ID: <20010123232246.J607@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/qla1280.c use the return code
of request_region instead of a call to check_region. It applies cleanly
against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/qla1280.c	Wed Dec  6 21:06:18 2000
+++ linux-ac10/drivers/scsi/qla1280.c	Sat Jan 20 23:07:09 2001
@@ -939,7 +939,7 @@
        }
 
        /* Register the I/O space with Linux */
-       if (check_region(host->io_port, 0xff))
+       if (!request_region(host->io_port, 0xff, "qla1280"))
        {
            printk("qla1280 : Failed to reserved i/o region 0x%04lx-0x%04lx already in use\n",
               host->io_port, host->io_port + 0xff);
@@ -948,8 +948,6 @@
            scsi_unregister(host);
 	     return 1;
        }
-
-       request_region(host->io_port, 0xff, "qla1280");
 
 	return 0;
 }

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"It's like an Alcatraz around my neck."
-Boston mayor Menino on the shortage of city parking spaces
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
