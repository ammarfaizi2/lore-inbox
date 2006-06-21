Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWFUVAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWFUVAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWFUVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:00:23 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:51431 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030281AbWFUU7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:59:52 -0400
Date: Wed, 21 Jun 2006 22:59:51 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm 3/6] cpu_relax(): floppy.c wait_til_ready()
Message-ID: <20060621205951.GC22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add cpu_relax() to drivers/block/floppy.c/wait_til_ready()


Should be very useful, methinks.

Tested on 2.6.17-mm1 (load-time only, no floppy media here right now ;).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/drivers/block/floppy.c linux-2.6.17-mm1.my/drivers/block/floppy.c
--- linux-2.6.17-mm1.orig/drivers/block/floppy.c	2006-06-21 14:28:16.000000000 +0200
+++ linux-2.6.17-mm1.my/drivers/block/floppy.c	2006-06-21 18:50:37.000000000 +0200
@@ -1155,6 +1155,7 @@
 		status = fd_inb(FD_STATUS);
 		if (status & STATUS_READY)
 			return status;
+		cpu_relax();
 	}
 	if (!initialising) {
 		DPRINT("Getstatus times out (%x) on fdc %d\n", status, fdc);
