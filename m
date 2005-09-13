Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVIML2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVIML2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVIML2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:28:17 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:20097 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932604AbVIML2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:28:17 -0400
Message-ID: <4326B799.70408@gmail.com>
Date: Tue, 13 Sep 2005 13:27:21 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Lion Vollnhals <lion.vollnhals@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
References: <200509130010.38483.lion.vollnhals@web.de> <200509130047.43301.lion.vollnhals@web.de> <200509130841.34104.vda@ilport.com.ua>
In-Reply-To: <200509130841.34104.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko napsal(a):

>On Tuesday 13 September 2005 01:47, Lion Vollnhals wrote:
>  
>
>>On Tuesday 13 September 2005 00:10, Lion Vollnhals wrote:
>>    
>>
>>>This patch against 2.6.13-mm3 replaces malloc and memset with kzalloc in
>>>drivers/base/class.c . 
>>>      
>>>
>>The following patch converts further kmalllocs and memsets in drivers/base/* to kzallocs.
>>
>>Please apply.
>>
>>Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>
>>    
>>
>
>  
>
>>diff -Nurp 2.6.13-mm3/drivers/base/platform.c 2.6.13-mm3-changed/drivers/base/platform.c
>>--- 2.6.13-mm3/drivers/base/platform.c	2005-09-12 23:42:47.000000000 +0200
>>+++ 2.6.13-mm3-changed/drivers/base/platform.c	2005-09-13 00:23:43.000000000 +0200
>>@@ -225,13 +225,12 @@ struct platform_device *platform_device_
>> 	struct platform_object *pobj;
>> 	int retval;
>> 
>>-	pobj = kmalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
>>+	pobj = kzalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
>> 	if (!pobj) {
>> 		retval = -ENOMEM;
>> 		goto error;
>> 	}
>> 
>>-	memset(pobj, 0, sizeof(*pobj));
>>    
>>
>
>Was this a bug or did you just introduced one?
>  
>
Yes, this was a bug.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

