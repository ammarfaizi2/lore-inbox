Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbTGOWoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbTGOWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:44:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25989 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S269798AbTGOWoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:44:24 -0400
Date: Wed, 16 Jul 2003 00:58:53 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Art Haas <ahaas@airmail.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can you try this patch?  It seems

--- alim15x3.c.orig	2003-04-20 04:49:10.000000000 +0200
+++ alim15x3.c	2003-07-16 00:39:15.351639072 +0200
@@ -753,7 +753,8 @@
 		return;
 	}

-	hwif->atapi_dma = 1;
+	if (m5229_revision <= 0x20)
+		hwif->atapi_dma = 1;

 	if (m5229_revision > 0x20)
 		hwif->ultra_mask = 0x3f;

