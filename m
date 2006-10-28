Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752135AbWJ1LWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWJ1LWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWJ1LWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 07:22:00 -0400
Received: from [87.201.200.205] ([87.201.200.205]:37534 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S1752135AbWJ1LV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 07:21:59 -0400
Message-ID: <45433D3E.3070109@0Bits.COM>
Date: Sat, 28 Oct 2006 15:21:34 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20061027)
MIME-Version: 1.0
To: jdike@addtoit.com, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       penberg@cs.helsinki.fi
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, all,

Sorry for the dealy but i've been out of the country.

Anyhow i did some investigation and i've figured out the bug.

Essentially if you try to compile a UML kernel on a 2.6.18.1 or above 
*host* kernel it will fail with the error messages shown (essentially 
offsetof macro undefined) because between 2.6.18 and 2.6.18.1 that macro 
in /usr/include/linux/stddef.h is now wrapped in a #ifdef __KERNEL__ . 
However since UML doesn't build it's sources with that defined we get an 
undefined macro and a build failure.

So i'm partly right and partly wrong in my statement below. Yes i did 
compile a guest UML kernel 2.6.18 fine on host kernel of 2.6.18, and i 
believe i will be able to compile 2.6.18.1 and above also on a host 
kernel of 2.6.18 but if i change my host kernel to 2.6.18.1 or above all 
UML guest builds will fail.

Can someone confirm they can build guest UML kernels on a host kernel >= 
2.6.18.1 ??

Thanks
M

-------- Original Message --------
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Date: Wed, 25 Oct 2006 11:41:30 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <453E7F07.9010804@0Bits.COM>

On Wed, Oct 25, 2006 at 01:00:55AM +0400, Mitch wrote:
> I've definetly not done any such change on my machine. Remember with the 
> same compile, same environment, if i go back to 2.6.18 i can build uml 
> fine. If i move to 2.6.18.1 or above it breaks...

You're sure about that?  I just looked through the 2.6.18.1 changelog and
I see nothing that would cause this.

> I do notice my gcc stddef does have this defined
> 
> % grep offsetof /usr/lib/gcc/i686-linux/4.0.3/include/stddef.h
> #define offsetof(TYPE, MEMBER) __builtin_offsetof (TYPE, MEMBER)

I would do a -E build and make sure that this header, or another one that
defines offsetof is getting pulled in.

				Jeff
