Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUL0Ax3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUL0Ax3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbUL0Ax3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:53:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41882 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261535AbUL0Aut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:50:49 -0500
Subject: PATCH: 2.6.10 - scsi ioctls warnings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104104811.16888.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:46:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI ioctls can ask for a lot of memory and fail. We don't need to vomit
in the log file for this case. Again taken from the Red Hat minor
patches applied for FC3.

Signed-off-by: Alan Cox <alan@redhat.com>
Original-patch: Arjan van de Ven <arjanv@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/block/scsi_ioctl.c linux-2.6.10/drivers/block/scsi_ioctl.c
--- linux.vanilla-2.6.10/drivers/block/scsi_ioctl.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/block/scsi_ioctl.c	2004-12-26 17:27:50.889059496 +0000
@@ -356,7 +356,7 @@
 
 	bytes = max(in_len, out_len);
 	if (bytes) {
-		buffer = kmalloc(bytes, q->bounce_gfp | GFP_USER);
+		buffer = kmalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
 		if (!buffer)
 			return -ENOMEM;
 

