Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbRAQWo2>; Wed, 17 Jan 2001 17:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbRAQWoR>; Wed, 17 Jan 2001 17:44:17 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:56633
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130391AbRAQWoF>; Wed, 17 Jan 2001 17:44:05 -0500
Date: Wed, 17 Jan 2001 23:43:57 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: tsbogend@alpha.franken.de
Cc: linux-kernel@vger.kernel.org
Subject: [rasmus@jaquet.dk: [PATCH] make drivers/scsi/sun3x_esp.c check request_irq's return value (240p3)]
Message-ID: <20010117234357.A1212@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Ooops. Forgot to cc linux-kernel.)

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch makes drivers/scsi/sun3x_esp.c check the return
value of request_irq.

Comments?


--- linux-ac9/drivers/scsi/sun3x_esp.c~	Thu Jan  4 22:00:55 2001
+++ linux-ac9/drivers/scsi/sun3x_esp.c	Tue Jan 16 22:03:02 2001
@@ -103,7 +103,11 @@
 					   sizeof (cmd_buffer));
 
 	esp->irq = 2;
-	request_irq(esp->irq, esp_intr, SA_INTERRUPT, "SUN3X SCSI", NULL);
+	if (request_irq(esp->irq, esp_intr, SA_INTERRUPT, 
+			"SUN3X SCSI", NULL)) {
+		esp_deallocate(esp);
+		return 0;
+	}
 
 	esp->scsi_id = 7;
 	esp->diff = 0;


----- End forwarded message -----

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

The police are not here to create disorder.  They're here to preserve
disorder." -Former Chicago mayor Daley during the infamous 1968 Democratic
Party convention
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
