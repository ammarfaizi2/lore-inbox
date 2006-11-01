Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946413AbWKACOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946413AbWKACOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946427AbWKACOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:14:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6318 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946413AbWKACOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:14:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mro+hV7wBZqU7ZfOlaZu605bVopZ0IVCuPn/kIw8Qg9pgRkdYcsjCAHhty+Fxg4ijpwEzmk8smqBwudrN+oYJ14Kl8MncdcZay5/KMqXLjc6aqYu+nNekVPy5Q+8Laqynfctu1G7q/4SRcoREHHKHdKsUOGH1Bi6yN4vvUBfz4Y=
Date: Wed, 1 Nov 2006 05:12:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/cdrom/*: trivial vsnprintf() conversion
Message-ID: <20061101021231.GC5014@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing sbpcd.c baroque error printing in process.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/cdrom/optcd.c |    2 +-
 drivers/cdrom/sbpcd.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/cdrom/optcd.c
+++ b/drivers/cdrom/optcd.c
@@ -101,7 +101,7 @@ static void debug(int debug_this, const 
 		return;
 
 	va_start(args, fmt);
-	vsprintf(s, fmt, args);
+	vsnprintf(s, sizeof(s), fmt, args);
 	printk(KERN_DEBUG "optcd: %s\n", s);
 	va_end(args);
 }
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -770,11 +770,10 @@ #endif /* DISTRIBUTION */
 	
 	msgnum++;
 	if (msgnum>99) msgnum=0;
-	sprintf(buf, MSG_LEVEL "%s-%d [%02d]:  ", major_name, current_drive - D_S, msgnum);
 	va_start(args, fmt);
-	vsprintf(&buf[18], fmt, args);
+	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
-	printk(buf);
+	printk(MSG_LEVEL "%s-%d [%02d]:  %s", major_name, current_drive - D_S, msgnum, buf);
 #if KLOGD_PAUSE
 	sbp_sleep(KLOGD_PAUSE); /* else messages get lost */
 #endif /* KLOGD_PAUSE */ 

