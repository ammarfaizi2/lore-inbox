Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUIAVP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUIAVP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUIAVKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:10:04 -0400
Received: from baikonur.stro.at ([213.239.196.228]:17558 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267864AbUIAUzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:55:50 -0400
Subject: [patch 02/25]  drivers/char/epca.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:55:49 +0200
Message-ID: <E1C2c8z-0007Gb-Tz@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/epca.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/epca.c~min-max-char_epca drivers/char/epca.c
--- linux-2.6.9-rc1-bk7/drivers/char/epca.c~min-max-char_epca	2004-09-01 19:33:31.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/epca.c	2004-09-01 19:33:31.000000000 +0200
@@ -74,7 +74,6 @@
 #define DIGIINFOMAJOR       35  /* For Digi specific ioctl */ 
 
 
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
 #define MAXCARDS 7
 #define epcaassert(x, msg)  if (!(x)) epca_error(__LINE__, msg)
 
@@ -826,7 +825,7 @@ static int pc_write(struct tty_struct * 
 			bytesAvailable will then take on this newly calculated value.
 		---------------------------------------------------------------------- */
 
-		bytesAvailable = MIN(dataLen, bytesAvailable);
+		bytesAvailable = min(dataLen, bytesAvailable);
 
 		/* First we read the data in from the file system into a temp buffer */
 
@@ -912,7 +911,7 @@ static int pc_write(struct tty_struct * 
 			space; reduce the amount of data to fit the space.
 	---------------------------------------------------------------------- */
 
-	bytesAvailable = MIN(remain, bytesAvailable);
+	bytesAvailable = min(remain, bytesAvailable);
 
 	txwinon(ch);
 	while (bytesAvailable > 0) 
@@ -923,7 +922,7 @@ static int pc_write(struct tty_struct * 
 			data copy fills to the end of card buffer.
 		------------------------------------------------------------------- */
 
-		dataLen = MIN(bytesAvailable, dataLen);
+		dataLen = min(bytesAvailable, dataLen);
 		memcpy(ch->txptr + head, buf, dataLen);
 		buf += dataLen;
 		head += dataLen;

_
