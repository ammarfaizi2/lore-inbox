Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFNSxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFNSxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUFNSxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:53:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6644 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263784AbUFNSxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:53:03 -0400
Date: Mon, 14 Jun 2004 20:52:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6: modular scsi/mca_53c9x doesn't work (fwd)
Message-ID: <20040614185256.GJ13951@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issue described in the mail forwarded below is still present in 
2.6.7-rc3-mm2 (but not specific to -mm).

I'd suggest the following workaround:

--- linux-2.6.7-rc3-mm2-modular-no-smp/drivers/scsi/Kconfig.old	2004-06-14 20:45:20.000000000 +0200
+++ linux-2.6.7-rc3-mm2-modular-no-smp/drivers/scsi/Kconfig	2004-06-14 20:51:40.000000000 +0200
@@ -1136,7 +1136,7 @@
 	  than 1 device on a SCSI bus. The normal answer therefore is N.
 
 config SCSI_MCA_53C9X
-	tristate "NCR MCA 53C9x SCSI support"
+	bool "NCR MCA 53C9x SCSI support"
 	depends on MCA_LEGACY && SCSI && BROKEN_ON_SMP
 	help
 	  Some MicroChannel machines, notably the NCR 35xx line, use a SCSI




----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sat, 20 Dec 2003 00:17:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: modular scsi/mca_53c9x doesn't work

I got the following mesage when trying to build modular a mca_53c9x in 
2.6.0-test11-mm1:

<--  snip  -->

...
*** Warning: "esp_reset" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_abort" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_queue" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esps_in_use" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_initialize" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_allocate" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_intr" [drivers/scsi/mca_53c9x.ko] undefined!
*** Warning: "esp_deallocate" [drivers/scsi/mca_53c9x.ko] undefined!
...

<--  snip  -->

It seems there are some EXPORT_SYMBOL's needed in NCR53C9x.c?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

