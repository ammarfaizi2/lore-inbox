Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161528AbWI2RHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161528AbWI2RHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161672AbWI2RHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:07:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39041 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161772AbWI2RHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:07:10 -0400
Subject: [PATCH] libata: Don't believe bogus claims in the older PIO mode
	register
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:26:47 +0100
Message-Id: <1159550807.13029.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/libata-core.c linux-2.6.18-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.18-mm2/drivers/ata/libata-core.c	2006-09-28 14:33:46.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/libata-core.c	2006-09-29 17:33:53.000000000 +0100
@@ -870,7 +870,11 @@
 		 * the PIO timing number for the maximum. Turn it into
 		 * a mask.
 		 */
-		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+		u8 mode = id[ATA_ID_OLD_PIO_MODES] & 0xFF;
+		if( mode < 5)	/* Valid PIO range */
+                	pio_mask = (2 << mode) - 1 ;
+		else
+			pio_mask = 1;
 
 		/* But wait.. there's more. Design your standards by
 		 * committee and you too can get a free iordy field to

