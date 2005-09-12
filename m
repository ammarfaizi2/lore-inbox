Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVILW6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVILW6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVILW6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:58:35 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16262 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751072AbVILW6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:58:34 -0400
Message-ID: <43260817.7070907@gmail.com>
Date: Tue, 13 Sep 2005 00:58:31 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Lion Vollnhals <lion.vollnhals@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
References: <200509130010.38483.lion.vollnhals@web.de>
In-Reply-To: <200509130010.38483.lion.vollnhals@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lion Vollnhals napsal(a):

>This patch against 2.6.13-mm3 replaces malloc and memset with kzalloc in drivers/base/class.c .
>Furthermore this patch fixes actually two bugs:
>  The memset arguments were occasionally swaped and therefore wrong.
>
>Usage of kzalloc makes this code shorter and more bugfree.
>
>Please apply.
>
>Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>
>
>--- 2.6.13-mm3/drivers/base/class.c	2005-09-12 23:42:47.000000000 +0200
>+++ 2.6.13-mm3-changed/drivers/base/class.c	2005-09-12 23:54:56.000000000 +0200
>@@ -190,12 +190,11 @@ struct class *class_create(struct module
> 	struct class *cls;
> 	int retval;
> 
>-	cls = kmalloc(sizeof(struct class), GFP_KERNEL);
>+	cls = kzalloc(sizeof(struct class), GFP_KERNEL);
>  
>
maybe, the better way is to write `*cls' instead of `struct class', 
better for further changes

> 	if (!cls) {
> 		retval = -ENOMEM;
> 		goto error;
> 	}
>-	memset(cls, 0x00, sizeof(struct class));
> 
> 	cls->name = name;
> 	cls->owner = owner;
>  
>
[snip]

>@@ -611,12 +610,11 @@ struct class_device *class_device_create
> 	if (cls == NULL || IS_ERR(cls))
> 		goto error;
> 
>-	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
>+	class_dev = kzalloc(sizeof(struct class_device), GFP_KERNEL);
>  
>
`*class_dev' instead of `struct class_device'

> 	if (!class_dev) {
> 		retval = -ENOMEM;
> 		goto error;
> 	}
>-	memset(class_dev, 0x00, sizeof(struct class_device));
> 
> 	class_dev->devt = devt;
> 	class_dev->dev = device;
>  
>
thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

