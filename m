Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKMXhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKMXhf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 18:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKMXhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 18:37:35 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:56846 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750787AbVKMXhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 18:37:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=R2vrewuEssmEekKQApx+MB2xmdV3Am19YAKcBaELES5NdKY5wEwphSkfXsQz8fq0XbHkdqq2ia5KcN9YmjWcg2SBsTgp74u1HIyb72p7nfDrXx80VaIU+jcJ91dYzTTboXJ71pSukjmjf5ZwxEwYL+d7+FHZGrvr6T2CGCNbzfQ=
Message-ID: <4377CE2D.2070304@gmail.com>
Date: Mon, 14 Nov 2005 07:37:17 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
References: <43766AC5.9080406@gmail.com> <20051113110618.GD4117@implementation> <43774EAE.90004@gmail.com> <20051113222514.GK4972@bouh.residence.ens-lyon.fr>
In-Reply-To: <20051113222514.GK4972@bouh.residence.ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Antonino A. Daplas, le Sun 13 Nov 2005 22:33:18 +0800, a écrit :
>> Samuel Thibault wrote:
>>> Antonino A. Daplas, le Sun 13 Nov 2005 06:20:53 +0800, a écrit :
>>>> "I updated to the development kernel and now during boot only the top of the
>>>> text is visable. For example the monitor screen the is the lines and I can
>>>> only  see text in the asterik area.
>>>> ---------------------
>>>> | ****************  |
>>>> | *              *  |
>>>> | *              *  |
>>>> | ****************  |
>>>> |                   |
>>>> |                   |
>>>> |                   |
>>>> ---------------------
>>> Are you missing some left and right part too? What are the dimensions of
>>> the text screen at bootup? What bootloader are you using? (It could be a
>>> bug in the boot up text screen dimension discovery).
>> It was just the height.  All numbers (done with printk's) look okay from
>> bootup. He gets 80 and 25 for ORIG_VIDEO_NUM_COLS and ORIG_VIDEO_NUM_LINES
>> respectively.
> 
> And you got less than 25 lines? How many exactly?

If the original size was at 80x25, and vgacon_doresize() was called, the
the resulting screen is only 80x12.5. The 13th line has its bottom half
chopped off, and the rest of the lines (14-25) is invisible.

If he sets it at < 25, he gets a window much smaller than 12.5, but he did
not specify. So my guess is his chipset programs the screen height by 1/2
of the value of the requested rows.

Tony
