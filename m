Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278960AbRKAOMW>; Thu, 1 Nov 2001 09:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278974AbRKAOMK>; Thu, 1 Nov 2001 09:12:10 -0500
Received: from 20dyn100.com21.casema.net ([213.17.90.100]:59029 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S278961AbRKAOLb>; Thu, 1 Nov 2001 09:11:31 -0500
Date: Thu, 1 Nov 2001 15:11:11 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>
Subject: [PATCH} Specialix IO8+
Message-ID: <Pine.LNX.4.33.0111011507080.16828-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan,

This patch makes the IO8+ driver able to share it's interrupt if it's an
PCI card.

	Patrick


diff -u -r linux-2.4.13.clean/drivers/char/specialix.c linux-2.4.13.io8/drivers/char/specialix.c
--- linux-2.4.13.clean/drivers/char/specialix.c	Thu Nov  1 14:31:49 2001
+++ linux-2.4.13.io8/drivers/char/specialix.c	Thu Nov  1 14:41:20 2001
@@ -969,7 +969,10 @@
 	if (bp->flags & SX_BOARD_ACTIVE)
 		return 0;

-	error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT, "specialix IO8+", bp);
+	if (bp->flags & SX_BOARD_IS_PCI)
+		error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT | SA_SHIRQ, "specialix IO8+", bp);
+	else
+		error = request_irq(bp->irq, sx_interrupt, SA_INTERRUPT, "specialix IO8+", bp);

 	if (error)
 		return error;

