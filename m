Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbREPKjR>; Wed, 16 May 2001 06:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbREPKi6>; Wed, 16 May 2001 06:38:58 -0400
Received: from ns.caldera.de ([212.34.180.1]:39891 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261867AbREPKir>;
	Wed, 16 May 2001 06:38:47 -0400
Date: Wed, 16 May 2001 12:35:32 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: wd7000 missing release_region
Message-ID: <20010516123532.A1567@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One else case in wd7000.c did not have a release_region().

Ciao, Marcus

Index: drivers/scsi/wd7000.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/wd7000.c,v
retrieving revision 1.7
diff -u -r1.7 wd7000.c
--- drivers/scsi/wd7000.c	2001/05/03 13:03:59	1.7
+++ drivers/scsi/wd7000.c	2001/05/16 10:05:21
@@ -1676,7 +1676,8 @@
 			host->iobase, host->irq, host->dma);
                 printk ("  BUS_ON time: %dns, BUS_OFF time: %dns\n",
                         host->bus_on * 125, host->bus_off * 125);
-	    }
+	    } else 
+		goto err_release;
 	}
 
 #ifdef WD7000_DEBUG
