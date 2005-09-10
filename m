Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVIJUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVIJUWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVIJUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:22:48 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:57523 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbVIJUWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=l9qP/ewZ7FIFdL/GSzcA1u2BrcCZvbxQnwwXqsTLLuEpTddq8wjd07s7X+4cU1iXUiG7Co0hSLmrSxXWRA6FQeZyZqHDzIt9Xy3TCyicCyz8K6lzvERgAYjhLBYXyQ9RZYCFqzzD7ccsw0HKEmF5gT4OIKo5/ev8l5pLZdb+QYo=
Message-ID: <43234055.6060406@gmail.com>
Date: Sun, 11 Sep 2005 04:21:41 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manuel Lauss <mano@roarinelk.homelinux.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org> <4322C741.9060808@roarinelk.homelinux.net> <4322D49D.5040506@pol.net> <4322E3A3.5010903@roarinelk.homelinux.net>
In-Reply-To: <4322E3A3.5010903@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss wrote:
> 
>> Ah, yes, sorry about that.  Can you try this patch?
>>
>> Fix kernel oops when CONFIG_FB_I810_I2C is set to 'n'.
>>
>> Signed-off-by: Antonino Daplas <adaplas@pol.net>
>>
>> diff --git a/drivers/video/i810/i810_main.c
>> b/drivers/video/i810/i810_main.c
>> --- a/drivers/video/i810/i810_main.c
>> +++ b/drivers/video/i810/i810_main.c
>> @@ -1830,7 +1830,7 @@ static void __devinit i810fb_find_init_m
>>  {
>>      struct fb_videomode mode;
>>      struct fb_var_screeninfo var;
>> -    struct fb_monspecs *specs = NULL;
>> +    struct fb_monspecs *specs = &info->monspecs;
>>      int found = 0;
>>  #ifdef CONFIG_FB_I810_I2C
>>      int i;
>> @@ -1853,12 +1853,11 @@ static void __devinit i810fb_find_init_m
>>      if (!err)
>>          printk("i810fb_init_pci: DDC probe successful\n");
>>  
>> -    fb_edid_to_monspecs(par->edid, &info->monspecs);
>> +    fb_edid_to_monspecs(par->edid, specs);
>>  
>> -    if (info->monspecs.modedb == NULL)
>> +    if (specs->modedb == NULL)
>>          printk("i810fb_init_pci: Unable to get Mode Database\n");
>>  
>> -    specs = &info->monspecs;
>>      fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
>>                   &info->modelist);
>>      if (specs->modedb != NULL) {
> 
> Thanks, it boots now, but doesnt set video mode. Spews
> a bunch of "i810fb: invalid video mode" lines and defaults
> to 640x480.

Set CONFIG_FB_I810_I2C to n.  Your display does not have an EDID block.
Even getting the EDID from the BIOS failed.

Tony
