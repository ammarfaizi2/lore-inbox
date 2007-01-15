Return-Path: <linux-kernel-owner+w=401wt.eu-S1751415AbXAOTOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbXAOTOJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAOTOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:14:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51513 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbXAOTOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:14:07 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Martin Samuelsson <sam@home.se>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 5/9] V4L/DVB (5029): Ks0127 status flags
Date: Mon, 15 Jan 2007 16:37:06 -0200
Message-id: <20070115183706.PS2197160005@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Martin Samuelsson <sam@home.se>

Or status flags together in DECODER_GET_STATUS instead of and-zapping them.

Signed-off-by: Martin Samuelsson <sam@home.se>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/ks0127.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/ks0127.c b/drivers/media/video/ks0127.c
index c1a377f..b6cd21e 100644
--- a/drivers/media/video/ks0127.c
+++ b/drivers/media/video/ks0127.c
@@ -712,13 +712,13 @@ static int ks0127_command(struct i2c_cli
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

