Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVFTW5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVFTW5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVFTW4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:56:52 -0400
Received: from kirby.webscope.com ([204.141.84.57]:26082 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S262296AbVFTWVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:21:17 -0400
Message-ID: <42B740E9.40708@m1k.net>
Date: Mon, 20 Jun 2005 18:19:21 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, kraxel@bytesex.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.12-mm1: saa7134-core.c compile error
References: <20050619233029.45dd66b8.akpm@osdl.org> <20050620094855.GA3666@stusta.de>
In-Reply-To: <20050620094855.GA3666@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sun, Jun 19, 2005 at 11:30:29PM -0700, Andrew Morton wrote:
>  
>
>>...
>>Changes since 2.6.12-rc6-mm1:
>>...
>>+v4l-update-for-saa7134-cards.patch
>>...
>> v4l updates
>>...
>>    
>>
>
>The bogus saa7134-core.c part of this patch has to be dropped since it 
>causes the following compile error with CONFIG_MODULES=n:
>
><--  snip  -->
>
>...
>  CC      drivers/media/video/saa7134/saa7134-core.o
>drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_fini':
>drivers/media/video/saa7134/saa7134-core.c:1215: error: `pending_registered' undeclared (first use in this function)
>drivers/media/video/saa7134/saa7134-core.c:1215: error: (Each undeclared identifier is reported only once
>drivers/media/video/saa7134/saa7134-core.c:1215: error: for each function it appears in.)
>drivers/media/video/saa7134/saa7134-core.c:1216: error: `pending_notifier' undeclared (first use in this function)
>make[4]: *** [drivers/media/video/saa7134/saa7134-core.o] Error 1
>
><--  snip  -->
>
>
>This patch reverts this bogus patch.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.12-mm1-modular/drivers/media/video/saa7134/saa7134-core.c	2005-06-20 10:59:33.000000000 +0200
>+++ linux-2.6.12-mm1-full/drivers/media/video/saa7134/saa7134-core.c	2005-06-20 11:46:20.000000000 +0200
>@@ -1212,8 +1212,10 @@
> 
> static void saa7134_fini(void)
> {
>+#ifdef CONFIG_MODULES
> 	if (pending_registered)
> 		unregister_module_notifier(&pending_notifier);
>+#endif
> 	pci_unregister_driver(&saa7134_pci_driver);
> }
> 
>
>--
>video4linux-list mailing list
>Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
>https://www.redhat.com/mailman/listinfo/video4linux-list
>  
>
committed to video4linux CVS:

/Mon Jun 20 22:06:52 2005 UTC/ (6 minutes, 55 seconds ago) by /mkrufky/

        * saa7134-core.c:
        - Fix kernel compile error with CONFIG_MODULES=n

Signed-off-by: Adrian Bunk <bunk@stusta.de <mailto:bunk@stusta.de>>

Thank you!

-- 
Michael Krufky


