Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWBDUE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWBDUE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBDUE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:04:59 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:45838 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932556AbWBDUE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:04:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ig5F/tvNz4EymX1BgBaipaQ2GB1K+frSsTjvtUUeNnu714L7Y97qxcoSrlgkdGHM6UEw8wtD99GS/NMnnFsgORNXGiZnV2Ap+xtsKcdzcJmioyR3OOMwByNMLFi0QWU1i/UpZwvVq1sYBuNiz2zPZefuznZbvXboi899qV9bfy8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][OSS] no need to check vfree() argument for NULL
Date: Sat, 4 Feb 2006 21:05:01 +0100
User-Agent: KMail/1.9
Cc: Paul Laufer <paul@laufernet.com>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042105.01179.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check the vfree() argument for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sb_card.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/oss/sb_card.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/oss/sb_card.c	2006-02-04 21:01:40.000000000 +0100
@@ -337,10 +337,8 @@ static void __exit sb_exit(void)
 	pnp_unregister_card_driver(&sb_pnp_driver);
 #endif
 
-	if (smw_free) {
-		vfree(smw_free);
-		smw_free = NULL;
-	}
+	vfree(smw_free);
+	smw_free = NULL;
 }
 
 module_init(sb_init);



