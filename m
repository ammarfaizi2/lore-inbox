Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWHFXqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWHFXqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWHFXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:46:48 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:11272 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWHFXqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:46:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dlngalR6cqZv/eI3hoylhF+XK1i4jtLj9CYN3pbAFJ86Btpov4B7pfvtBYwJoaQjMDm1lbjSGG56nVnzVcTrpp7LGuNc3d//YIV2aaDHuVEMHzFOVGRbsRVjt1PAq17B+E/Kv54lbAPUU+YAYwKSnwppMOSWje3mFnHYaijK5+w=
Message-ID: <44D67F63.4050200@gmail.com>
Date: Mon, 07 Aug 2006 07:46:43 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use persistent allocation for cursor blinking.
References: <20060801185618.GS22240@redhat.com> <20060805212639.GF5417@ucw.cz>
In-Reply-To: <20060805212639.GF5417@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> Every time the console cursor blinks, we do a kmalloc/kfree pair.
>> This patch turns that into a single allocation.
>>
>> This allocation was the most frequent kmalloc I saw on my test box.
>>
>> Signed-off-by: Dave Jones <davej@redhat.com>
>>
>>
>> --- linux-2.6.14/drivers/video/console/softcursor.c~	2005-12-28 18:40:08.000000000 -0500
>> +++ linux-2.6.14/drivers/video/console/softcursor.c	2005-12-28 18:45:50.000000000 -0500
>> @@ -23,7 +23,9 @@ int soft_cursor(struct fb_info *info, st
>>  	unsigned int buf_align = info->pixmap.buf_align - 1;
>>  	unsigned int i, size, dsize, s_pitch, d_pitch;
>>  	struct fb_image *image;
>> -	u8 *dst, *src;
>> +	u8 *dst;
>> +	static u8 *src=NULL;
>> +	static int allocsize=0;
>>  
> 
> Spaces around = ? And perhaps it does not need to be initialized when
> it is static?
> 

I already sent an updated patch, so your concerns are gone.

Tony


