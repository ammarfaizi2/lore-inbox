Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVIGRIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVIGRIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVIGRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:08:30 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:41675
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750986AbVIGRIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:08:30 -0400
Subject: [patch] synclink.c add loopback to async mode
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126112904.3984.25.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:08:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclink.c add loopback to async mode

From: Paul Fulghum <paulkf@microgate.com>

Add internal loopback support for
asynchronous mode operation.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclink.c	2005-09-07 11:43:56.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclink.c	2005-09-07 11:57:02.000000000 -0500
@@ -6149,6 +6149,11 @@ static void usc_set_async_mode( struct m
 		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
 	}
 
+	if (info->params.loopback) {
+		info->loopback_bits = 0x300;
+		outw(0x0300, info->io_base + CCAR);
+	}
+
 }	/* end of usc_set_async_mode() */
 
 /* usc_loopback_frame()


