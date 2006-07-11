Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWGKNMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGKNMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGKNMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:12:14 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25645 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWGKNMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:12:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RaWgsH6/kWHumJgs9wJZRJmxH3lkQa3umuu5PSEMAaUkKclxDtyAKO29seGcJ4GSTE0vO5ZWEqn/Y2HGzJwzWSsD4bkOr5B079vhZO2uLn7v13XOrBbLgR/a1oE0OlbSZnz4/R2AgNO1cGzxOtzy98XQHPEWU5WkTlBj+ffNN5s=
Message-ID: <44B3A3A5.5030208@gmail.com>
Date: Tue, 11 Jul 2006 21:12:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
References: <200607100833.00461.mreuther@umich.edu> <200607102327.38426.mreuther@umich.edu> <44B34BBA.4010806@gmail.com> <200607110720.54119.mreuther@umich.edu>
In-Reply-To: <200607110720.54119.mreuther@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
> On Tuesday 11 July 2006 02:56 am, Antonino A. Daplas wrote:
>> Matt Reuther wrote:
>>> On Monday 10 July 2006 11:58 am, Antonino A. Daplas wrote:
>>>> Matt Reuther wrote:
>>> I ran 'make menuconfig' and I got the same warnings. Perhaps CONFIG_FB
>>> needs to be part of the 'selects' line for any option that selects the
>>> backlight support. I think the USB Apple Cinema display support, which I
>>> set as modular, might have selected backlight. I don't need framebuffer
>>> support, so I have that shut off. Here are the depmod warnings once
>>> again:
>> Yes, that's the culprit.  I've been thinking for some time to eliminate
>> the framebuffer dependency from lcd/backlight.  Can you try the patch I
>> sent in another thread?
>>
>> Tony
> 
> OK. I will give that a shot, probably this evening.
> 
> Shouldn't kconfig recursively figure out dependencies for stuff like this?

'select' doesn't. So does 'depends on'. Anyway, I consider it wasteful to
also compile in fb when backlight/lcd is the only one needed. So try instead
the other patch (Statically link the framebuffer notification functions).

> 
> I turned on Apple Cinema support without turning on the framebuffer, but 
> Cinema needed backlight, which needed framebuffer. I can see kconfig turning 
> on backlight, but not checking to see what backlight needed.

Yes, known problem with select.

> 
> There might be similar issues with snd-miro, which seems to want stuff in 
> snd_cs4231, which I think I have shut off.
> 
> Thanks for your help. I try out your patch later on today, when I can get back 
> to my computer.
> 

Thanks for the report too.

Tony
