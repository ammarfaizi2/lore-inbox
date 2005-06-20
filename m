Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFTJuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFTJuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 05:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFTJuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 05:50:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40721 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261303AbVFTJs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 05:48:56 -0400
Date: Mon, 20 Jun 2005 11:48:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org,
       Fabrice Aeschbacher <fabrice.aeschbacher@laposte.net>,
       Hermann Pitton <hermann.pitton@onlinehome.de>,
       Nickolay V Shmyrev <nshmyrev@yandex.ru>, kraxel@bytesex.org,
       video4linux-list@redhat.com
Subject: [patch] 2.6.12-mm1: saa7134-core.c compile error
Message-ID: <20050620094855.GA3666@stusta.de>
References: <20050619233029.45dd66b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:30:29PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc6-mm1:
>...
> +v4l-update-for-saa7134-cards.patch
>...
>  v4l updates
>...

The bogus saa7134-core.c part of this patch has to be dropped since it 
causes the following compile error with CONFIG_MODULES=n:

<--  snip  -->

...
  CC      drivers/media/video/saa7134/saa7134-core.o
drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_fini':
drivers/media/video/saa7134/saa7134-core.c:1215: error: `pending_registered' undeclared (first use in this function)
drivers/media/video/saa7134/saa7134-core.c:1215: error: (Each undeclared identifier is reported only once
drivers/media/video/saa7134/saa7134-core.c:1215: error: for each function it appears in.)
drivers/media/video/saa7134/saa7134-core.c:1216: error: `pending_notifier' undeclared (first use in this function)
make[4]: *** [drivers/media/video/saa7134/saa7134-core.o] Error 1

<--  snip  -->


This patch reverts this bogus patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm1-modular/drivers/media/video/saa7134/saa7134-core.c	2005-06-20 10:59:33.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/media/video/saa7134/saa7134-core.c	2005-06-20 11:46:20.000000000 +0200
@@ -1212,8 +1212,10 @@
 
 static void saa7134_fini(void)
 {
+#ifdef CONFIG_MODULES
 	if (pending_registered)
 		unregister_module_notifier(&pending_notifier);
+#endif
 	pci_unregister_driver(&saa7134_pci_driver);
 }
 

