Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUJUQlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUJUQlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJUQiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:38:03 -0400
Received: from mailgate0.sover.net ([209.198.87.43]:53200 "EHLO mx0.sover.net")
	by vger.kernel.org with ESMTP id S266263AbUJUQeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:34:24 -0400
Message-ID: <4177E50F.9030702@sover.net>
Date: Thu, 21 Oct 2004 12:34:23 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com>	 <9e4733910410201808c0796c8@mail.gmail.com> <9e473391041020181150638b4@mail.gmail.com> <4177185A.9080708@sover.net> <4177DF15.8010007@techsource.com>
In-Reply-To: <4177DF15.8010007@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> You're right, and you're not.  There are two reasons why modern 3D 
> GPUs put the world mesh into the card framebuffer and do all the T&L 
> in the GPU.  One reason is that it's faster to do it in dedicated 
> hardware. The other more pressing reason is that the host interface 
> (PCI or AGP) puts a very low upper-bound on your triangle rendering rate.

I'm thinking more like microcode.  The functional blocks on the chip 
would be capable of being "rewired" by the OS, depending on the 
applications being run.  All of the functions would still operate out of 
card-local memory.

> The number of parameters necessary to specify a single texture-mapped 
> triangle are literally in the dozens.  If you did only 32-bit fixed 
> point (16.16) for coordinates, that's still a huge amount of 
> information to move across the bus to instruct the chip to render a 
> single triangle.  And what if that triangle ends up amounting to a 
> single pixel?  Think about the waste!
>
> Instead, the un-transformed geometry is loaded into the card memory 
> only once, and the GPU is instructed to render the scene based on the 
> camera perspective and lighting information.  Aside from the need to 
> cache textures on-card, this is another reason for the need to have 
> LOTS of graphics memory.

Yep - reminds me of the days with the old SGI Iris, which did OpenGL 
processing directly on the card, with the display list local to the 
GPU(s) (1280x1024@100 bit depth -24 bit color, 24-bit Z, another 48 bits 
for double-buffering, and 2 bits of overlay + 2 more underlay - those 
were the days :)

>> I guess I would look at this as an opportunity to make a "visual 
>> coprocessor", that also has the hardware necessary to output to a 
>> monitor (preferably multiple monitors).
>
> I don't think that's realistic.  We could do that, but it would have 
> terrible performance.

Sorry - I wasn't thinking in terms of an 8087 - more like a dedicated 
processor for image related functions - like a DSP card.  A display list 
based coprocessor would certainly be better than anything that has to 
repeatedly transfer commands over a slow bus.

- Steve

