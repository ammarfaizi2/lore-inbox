Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRLHROG>; Sat, 8 Dec 2001 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282928AbRLHRN4>; Sat, 8 Dec 2001 12:13:56 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37110 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282898AbRLHRNn>; Sat, 8 Dec 2001 12:13:43 -0500
Date: Sat, 8 Dec 2001 12:13:36 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: ymfpci bugfix
Message-ID: <20011208121336.A14614@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo:

In a true display of "never say never" case, here is an unanticipated
bugfix for ymfpci in 2.4 (RH Bug 56977). It applies on top and/or
independently from other 2.4 fixes (perhaps with offset to 41 lines).

Thanks,
-- Pete

--- linux-2.4.16/drivers/sound/ymfpci.c	Mon Nov 19 14:53:19 2001
+++ linux-2.4.16-niph/drivers/sound/ymfpci.c	Fri Dec  7 23:52:39 2001
@@ -2162,12 +2203,15 @@
 {
 	u8 cmd;
 
+	/*
+	 * In the 744, 754 only 0x01 exists, 0x02 is undefined.
+	 * It does not seem to hurt to trip both regardless of revision.
+	 */
 	pci_read_config_byte(pci, PCIR_DSXGCTRL, &cmd);
-	if (cmd & 0x03) {
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd | 0x03);
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
-	}
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd | 0x03);
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
+
 	pci_write_config_word(pci, PCIR_DSXPWRCTRL1, 0);
 	pci_write_config_word(pci, PCIR_DSXPWRCTRL2, 0);
 }
