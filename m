Return-Path: <linux-kernel-owner+w=401wt.eu-S1751401AbXAOTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXAOTNR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbXAOTNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:13:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51500 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbXAOTNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:13:15 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Grant Likely <grant.likely@secretlab.ca>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 4/9] V4L/DVB (5024): Fix quickcam communicator driver for
	big endian architectures
Date: Mon, 15 Jan 2007 16:37:06 -0200
Message-id: <20070115183705.PS9920820004@infradead.org>
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


From: Grant Likely <grant.likely@secretlab.ca>

Host endianess does not affect the order that pixel rgb data comes
in from the quickcam (the values are bytes, not words or longs).  The
driver is erroniously swapping the order of rgb values for big endian
machines.  This patch is needed get the Quickcam communicator working
on big endian machines (tested on powerpc)

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvideo/quickcam_messenger.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/media/video/usbvideo/quickcam_messenger.h b/drivers/media/video/usbvideo/quickcam_messenger.h
index baab9c0..17ace39 100644
--- a/drivers/media/video/usbvideo/quickcam_messenger.h
+++ b/drivers/media/video/usbvideo/quickcam_messenger.h
@@ -35,27 +35,13 @@ struct rgb {
 };
 
 struct bayL0 {
-#ifdef __BIG_ENDIAN
-	u8 r;
-	u8 g;
-#elif __LITTLE_ENDIAN
 	u8 g;
 	u8 r;
-#else
-#error not byte order defined
-#endif
 };
 
 struct bayL1 {
-#ifdef __BIG_ENDIAN
-	u8 g;
-	u8 b;
-#elif __LITTLE_ENDIAN
 	u8 b;
 	u8 g;
-#else
-#error not byte order defined
-#endif
 };
 
 struct cam_size {

