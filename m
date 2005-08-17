Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVHQGAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVHQGAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVHQGAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:00:39 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:54952 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750912AbVHQGAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:00:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b3PL/vIES9WeRpeUk/mjSZtFZADTEGhYRkT9pDQRZtIrX7994d9KsStG7Q4DxuO+vV8u+98MndsjmSlFTIeU6QOXSW0fyy20+EF4HyLjMRWly9TtxWUXZ6+jSeo+gCSNv1EpP1eLYy4twSKrwbRbgPHSRmhUZq27uN/0jZsfiVk=
Message-ID: <4302D277.2000805@gmail.com>
Date: Wed, 17 Aug 2005 14:00:23 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: Steven Rostedt <rostedt@goodmis.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
References: <1124242875.8848.10.camel@gaston>	 <1124249381.8848.19.camel@gaston>	 <1124250271.5764.76.camel@localhost.localdomain> <1124250948.4855.93.camel@localhost.localdomain>
In-Reply-To: <1124250948.4855.93.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla Beeche wrote:
> On Tue, 2005-08-16 at 23:44 -0400, Steven Rostedt wrote:
>> On Wed, 2005-08-17 at 13:29 +1000, Benjamin Herrenschmidt wrote:
>>> On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
>>>
>>>> (I'm blind and I use a braille display. I use those functions to blank 
>>>> my laptop's screen so people don't read it, and hopefully to conserve 
>>>> power.)
>> At the OLS I learned that the backlight of a laptop (when the screen is
>> black, but still glows) actually spends more wattage than when the
>> screen is lit.  So, unless you actually turn the laptop display off,
>> switching it to black will actually burn the battery quicker.
> 
> This sounds stupid. Who told you this? The actual brightness is the one
> that consumes the most battery.
> 
> Seriously, who told you such thing?

In TFT displays, nontransmissive pixels consume more power than transmissive
pixels.  So a black background consumes more power than a white one. And
if you are using these ioctl's to blank the screen, it will default to
"normal blank" (if you don't set the vesa blanking mode first), which,
in vgacon or most of the fbdev's, will just turn the color palette to all
black.  So yes, you might be consuming more power with this method.

You're probably better off turning the brightness down, if you cannot turn
the backlight off. 

Tony

PS: I don't know the resulting power consumption if you use the vesa
blanking modes (TIOCL_SETVESABLANK) to blank while leaving the backlight on.
