Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVG1W2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVG1W2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVG1W2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:28:44 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:37096 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261807AbVG1W23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JEtB4qKUJZ0XZmdhpu6ma1hP5RkGvo+rUkUyHe0979E/cPlITSHoPfvEMaeM3LNomLXc7le/QM9MJSjG+M8spTaYrFD6JKgR29FH3Ry2saeIJivkHy8pFYz8TteS4uV5shKicqY9d3jYpyFExkKn2BrJLk1IfJaI2iPLgFTQ2V4=
Message-ID: <42E95C05.7@pol.net>
Date: Fri, 29 Jul 2005 06:28:21 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
References: <200507280031.j6S0V3L3016861@hera.kernel.org>	 <42E8F0CD.6070500@gmail.com>	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>	 <9e473391050728092936794718@mail.gmail.com>	 <9e47339105072811183ac0f008@mail.gmail.com>	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>	 <9e4733910507281315419c3c12@mail.gmail.com>	 <9e47339105072813213db7cee4@mail.gmail.com>	 <9e47339105072813507c00687e@mail.gmail.com>	 <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be> <9e47339105072814505b6fe4f8@mail.gmail.com>
In-Reply-To: <9e47339105072814505b6fe4f8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, 28 Jul 2005, Jon Smirl wrote:
>>> I've verified now that all ATI R300+ chips have 10bit cmaps. These are
>>> pretty common so I'd be in favor of making this into a binary
>>> attribute where I can get/set the whole table at once. Given that
>>> OpenGL is already supporting 12 and 16 bits these tables are only
>>> going to get much larger.
>>>
>>> 1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text attribute.
>>>
>>> 65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text attribute.
>>>
>>> The bits_per_pixel sysfs attribute is an easy way to tell how many
>>> entries you need. You can just set it at 4, 8, 10, etc until you get
>>> an error. Now you know the max. 2^n and you know how many entries.
>> No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
>> ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.
> 
> So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
> bits_per_color and then let the driver sort it out.  Otherwise there
> is no way to set ARGB8888 versus ARGB2101010. With bits per color you
> would set 8 or 10.
> 

No, you have to add another attribute for {transp|red|green|blue}.{len,offset}
and another attribute for the pixelformat. Then using those, one can
easily deduce the cmap size.
 
> If that isn't good enough I can switch the attribute to take strings
> like ARGB8888.
> 

Please no.

> What do you think, should I just switch to fbconfig names and a binary
> cmap attribute?
> 

Does a binary attribute not have the same buffer size limitation as
the text attribute?  I really don't know, just asking.

Tony
