Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbUDFQwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbUDFQwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:52:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18172 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263908AbUDFQv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:51:57 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "John Stoffel" <stoffel@lucent.com>
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
Date: Tue, 6 Apr 2004 19:00:36 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
References: <16496.41345.341470.807320@gargle.gargle.HOWL> <16498.54669.886834.727923@gargle.gargle.HOWL>
In-Reply-To: <16498.54669.886834.727923@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404061900.36497.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you try this patch?

It seems somebody tried to do write access
from /proc handler without _any_ locking.

Regards,
Bartlomiej

--- linux-2.6.5/drivers/ide/pci/hpt366.c	2004-04-05 21:53:45.000000000 +0200
+++ linux/drivers/ide/pci/hpt366.c	2004-04-06 18:54:24.756073752 +0200
@@ -107,7 +107,7 @@
 				"                             %s\n",
 			(c0 & 0x80) ? "no" : "yes",
 			(c1 & 0x80) ? "no" : "yes");
-
+#if 0
 		if (hpt_minimum_revision(dev, 3)) {
 			u8 cbl;
 			cbl = inb(iobase + 0x7b);
@@ -120,7 +120,7 @@
 				(cbl & 0x01) ? 33 : 66);
 			p += sprintf(p, "\n");
 		}
-
+#endif
 		p += sprintf(p, "--------------- drive0 --------- drive1 "
 				"------- drive0 ---------- drive1 -------\n");
 		p += sprintf(p, "DMA capable:    %s              %s" 

