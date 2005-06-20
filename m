Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVFTUTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFTUTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFTUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:17:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23454 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261475AbVFTUNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:13:16 -0400
Subject: PATCH: IDE fix ide-disk inability to handle LBA only devices.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119298254.3325.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:10:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Years old bug, has to be fixed for it8212 to work

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/ide-disk.c linux-2.6.12/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.12/drivers/ide/ide-disk.c	2005-06-19 11:30:47.000000000 +0100
+++ linux-2.6.12/drivers/ide/ide-disk.c	2005-06-20 20:43:04.000000000 +0100
@@ -119,6 +119,10 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
+	/* No non-LBA info .. so valid! */
+	if (id->cyls == 0)
+		return 1;
+		
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.

