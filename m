Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVCOEmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVCOEmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVCOEmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:42:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:46263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262241AbVCOElw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:41:52 -0500
Date: Mon, 14 Mar 2005 20:38:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: saa7134-core.c compile error
Message-Id: <20050314203822.08b9c63e.akpm@osdl.org>
In-Reply-To: <20050312131813.GA3814@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
	<20050312131813.GA3814@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
>  >...
>  > Changes since 2.6.11-mm2:
>  >...
>  > +saa7134-update.patch
>  >...
>  >  v4l updates
>  >...
> 
>  This doesn't compile with CONFIG_MODULES=n:
> 
>  <--  snip  -->
> 
>  ...
>    CC      drivers/media/video/saa7134/saa7134-core.o
>  drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_fini':
>  drivers/media/video/saa7134/saa7134-core.c:1215: error: `pending_registered' undeclared (first use in this function)

Like this, I guess:

--- 25/drivers/media/video/saa7134/saa7134-core.c~saa7134-build-fix	2005-03-14 20:37:16.000000000 -0800
+++ 25-akpm/drivers/media/video/saa7134/saa7134-core.c	2005-03-14 20:37:27.000000000 -0800
@@ -1212,8 +1212,10 @@ static int saa7134_init(void)
 
 static void saa7134_fini(void)
 {
+#ifdef CONFIG_MODULES
 	if (pending_registered)
 		unregister_module_notifier(&pending_notifier);
+#endif
 	pci_unregister_driver(&saa7134_pci_driver);
 }
 
_

