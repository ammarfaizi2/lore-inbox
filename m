Return-Path: <linux-kernel-owner+w=401wt.eu-S964999AbXADQPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbXADQPT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbXADQPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:15:19 -0500
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57774 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964999AbXADQPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:15:17 -0500
X-Greylist: delayed 1361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 11:15:17 EST
Date: Thu, 4 Jan 2007 16:53:15 +0100
From: Martin Samuelsson <sam@home.se>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] ks0127 status flags
Message-Id: <20070104165315.7899e82a.sam@home.se>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scan-Result: No virus found in message 1H2UuF-0007lZ-6S.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1H2UuF-0007lZ-6S f9325dcd1a1c2147b46bbe5c0ed46627
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or status flags together in DECODER_GET_STATUS instead of and-zapping them.

Signed-off-by: Martin Samuelsson <sam@home.se>
---
 ks0127.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -ruN linux-2.6.20-rc3/drivers/media/video/ks0127.c linux-2.6.20-rc3-sam/drivers/media/video/ks0127.c
--- linux-2.6.20-rc3/drivers/media/video/ks0127.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc3-sam/drivers/media/video/ks0127.c	2006-12-31 17:01:35.000000000 +0100
@@ -712,13 +712,13 @@
 		*iarg = 0;
 		status = ks0127_read(ks, KS_STAT);
 		if (!(status & 0x20))		 /* NOVID not set */
-			*iarg = (*iarg & DECODER_STATUS_GOOD);
+			*iarg = (*iarg | DECODER_STATUS_GOOD);
 		if ((status & 0x01))		      /* CLOCK set */
-			*iarg = (*iarg & DECODER_STATUS_COLOR);
+			*iarg = (*iarg | DECODER_STATUS_COLOR);
 		if ((status & 0x08))		   /* PALDET set */
-			*iarg = (*iarg & DECODER_STATUS_PAL);
+			*iarg = (*iarg | DECODER_STATUS_PAL);
 		else
-			*iarg = (*iarg & DECODER_STATUS_NTSC);
+			*iarg = (*iarg | DECODER_STATUS_NTSC);
 		break;
 
 	//Catch any unknown command
