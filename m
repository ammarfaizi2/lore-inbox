Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSENCDj>; Mon, 13 May 2002 22:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315039AbSENCDi>; Mon, 13 May 2002 22:03:38 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:45045 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S314987AbSENCDh>;
	Mon, 13 May 2002 22:03:37 -0400
Date: Mon, 13 May 2002 22:03:34 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.1[345]-dj Add cpqarray_init() back into genhd.c
Message-ID: <20020514020334.GA24417@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.13-dj1, the call to cpqarray_init() in drivers/block/genhd.c was
dropped. I'm not sure what the intent was since the driver seems to work fine
as a module. In case it was a mistake, here's a patch (against 2.5.15-dj1) to
add it back in. Without it, cpqarray only works as a module. Works For Me (tm).

--Adam

--- linux-2.5.15-dj1-virgin/drivers/block/genhd.c	Mon May 13 21:21:59 2002
+++ linux-2.5.15-dj1/drivers/block/genhd.c	Mon May 13 21:18:48 2002
@@ -229,6 +229,9 @@
 	/* This has to be done before scsi_dev_init */
 	soc_probe();
 #endif
+#ifdef CONFIG_BLK_CPQ_DA
+	cpqarray_init();
+#endif
 #ifdef CONFIG_NET
 	net_dev_init();
 #endif
