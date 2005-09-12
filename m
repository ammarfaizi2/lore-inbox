Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVILSXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVILSXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVILSXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:23:54 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:33920 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932128AbVILSXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:23:53 -0400
Message-ID: <4325C7A8.30805@gmail.com>
Date: Mon, 12 Sep 2005 20:23:36 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/class.c: fix swapped memset() arguments
References: <20050912135847.GA9673@mipter.zuzino.mipt.ru>
In-Reply-To: <20050912135847.GA9673@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan napsal(a):

>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>---
>
> drivers/base/class.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>--- linux-vanilla/drivers/base/class.c
>+++ linux-memset/drivers/base/class.c
>@@ -506,7 +506,7 @@ int class_device_add(struct class_device
> 			kobject_del(&class_dev->kobj);
> 			goto register_done;
> 		}
>-		memset(attr, sizeof(*attr), 0x00);
>+		memset(attr, 0x00, sizeof(*attr));
> 		attr->attr.name = "dev";
> 		attr->attr.mode = S_IRUGO;
> 		attr->attr.owner = parent->owner;
>  
>
Consider use of kzalloc, some of latest git snapshot contains it yet.
Maybe you want to replace all occurences of memset in this source with 
that as I took a look.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

