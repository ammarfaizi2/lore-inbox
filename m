Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbWCQVB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWCQVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWCQU4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932771AbWCQU4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 18/21] Fix a bug when more than MAXBOARDS were plugged on
	em28xx
Date: Fri, 17 Mar 2006 17:54:38 -0300
Message-id: <20060317205438.PS02056800018@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1142367897 \-0300

Coverity reported a bug at checking max number of supported boards by
em28xx init code.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/em28xx/em28xx-video.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 94a14a2..d58a12c 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -1859,7 +1859,7 @@ static int em28xx_usb_probe(struct usb_i
 	model=id->driver_info;
 	nr=interface->minor;
 
-	if (nr>EM28XX_MAXBOARDS) {
+	if (nr >= EM28XX_MAXBOARDS) {
 		printk (DRIVER_NAME ": Supports only %i em28xx boards.\n",EM28XX_MAXBOARDS);
 		return -ENOMEM;
 	}

