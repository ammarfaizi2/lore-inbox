Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUIAVgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUIAVgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUIAVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:07:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:34694 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267935AbUIAU4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:17 -0400
Subject: [patch 07/25]  drivers/char/pcxx.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:16 +0200
Message-ID: <E1C2c9R-0007K9-7M@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/pcxx.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/pcxx.c~min-max-char_pcxx drivers/char/pcxx.c
--- linux-2.6.9-rc1-bk7/drivers/char/pcxx.c~min-max-char_pcxx	2004-09-01 19:33:55.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/pcxx.c	2004-09-01 19:33:55.000000000 +0200
@@ -130,7 +130,6 @@ static struct channel    *digi_channels;
 int pcxx_ncook=sizeof(pcxx_cook);
 int pcxx_nbios=sizeof(pcxx_bios);
 
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
 #define pcxxassert(x, msg)  if(!(x)) pcxx_error(__LINE__, msg)
 
 #define FEPTIMEOUT 200000  
@@ -626,7 +625,7 @@ static int pcxe_write(struct tty_struct 
 		
 		tail &= (size - 1);
 		stlen = (head >= tail) ? (size - (head - tail) - 1) : (tail - head - 1);
-		count = MIN(stlen, count);
+		count = min(stlen, count);
 		memoff(ch);
 		restore_flags(flags);
 
@@ -658,11 +657,11 @@ static int pcxe_write(struct tty_struct 
 		remain = tail - head - 1;
 		stlen = remain;
 	}
-	count = MIN(remain, count);
+	count = min(remain, count);
 
 	txwinon(ch);
 	while (count > 0) {
-		stlen = MIN(count, stlen);
+		stlen = min(count, stlen);
 		memcpy(ch->txptr + head, buf, stlen);
 		buf += stlen;
 		count -= stlen;

_
