Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTHJUcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTHJUcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:32:21 -0400
Received: from AMarseille-201-1-6-8.w80-11.abo.wanadoo.fr ([80.11.137.8]:8487
	"EHLO gaston") by vger.kernel.org with ESMTP id S270663AbTHJUcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:32:17 -0400
Subject: Re: [PATCH] IDE (& PowerMac): Let an hwif have a real parent
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308101630280.1330-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0308101630280.1330-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060547504.1405.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 22:31:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks good.
> 
> > Please apply,
> > Ben.
> 
> Can you fix intendation, or I should do it?

Hrm... I don't know how I fucked it up, probably when merging
between my trees. Here's the fixed version:

diff -urN linux-2.5/drivers/ide/ide-probe.c linux-2.5-benh-merge/drivers/ide/ide-probe.c
--- linux-2.5/drivers/ide/ide-probe.c	2003-08-09 11:05:27.000000000 +0200
+++ linux-2.5-benh-merge/drivers/ide/ide-probe.c	2003-08-10 22:30:14.000000000 +0200
@@ -650,10 +650,13 @@
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
 	hwif->gendev.driver_data = hwif;
-	if (hwif->pci_dev)
-		hwif->gendev.parent = &hwif->pci_dev->dev;
-	else
-		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	if (hwif->gendev.parent == NULL) {
+		if (hwif->pci_dev)
+			hwif->gendev.parent = &hwif->pci_dev->dev;
+		else
+			/* Would like to do = &device_legacy */
+			hwif->gendev.parent = NULL;
+	}
 	device_register(&hwif->gendev);
 }
 

