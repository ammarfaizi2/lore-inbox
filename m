Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUHZAbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUHZAbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUHZA3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:29:45 -0400
Received: from [195.23.16.24] ([195.23.16.24]:36796 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266917AbUHZA1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:27:55 -0400
Message-ID: <412D2E7B.7000202@grupopie.com>
Date: Thu, 26 Aug 2004 01:27:39 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825205113.GA7258@mars.ravnborg.org>
In-Reply-To: <20040825205113.GA7258@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.32; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
> 
>>This patch is an improvement over my first kallsyms speedup patch posted about 2
>>weeks ago.
> 
> 
> My origianl comment still hold.
> Decoupling the compression and decompression part is not good.
> Better keep them close to each other.

In this case the decompression step is so simple that I don't think this 
is really a problem.
At least the source code is close to each other.

> Why not put all symbols in an __init section, compress them during kernel boot
> and then the original section get discarded.

In that case we should definitely change the algorithm as the 
compression step is quite hard. It was designed to run only at compile 
time, so code size / speed trade-offs would all tend to increase the 
code size, and even as it is it would slow down the boot sequence.

Anyway, even if the code and data is discarded as they would be in an 
__init section, the compression code would still be in the kernel image. 
This can reduce the areas of application of this code (boot from a 
floppy, embedded systems, etc.)

It _seems_ silly to have code in there that works over the same data 
every time it boots and produces the exact same result. I must say 
however that I realize that I'm a newcomer and I might not be seeing the 
hole picture. So, if it is the general consensus that this is the way to 
go, then fine by me :)

> After a quick browse of the code.
> - Use spaces around '=' etc.

I'm really sorry about this. I've tried to not let these escape, but 
some of them (many of them, in fact) did. I promise I'll be more 
thorough next time.

-- 
Paulo Marques - www.grupopie.com
