Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVBCI2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVBCI2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVBCI2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:28:46 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:6159 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262850AbVBCI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:27:41 -0500
Message-ID: <4201E28D.6080600@hist.no>
Date: Thu, 03 Feb 2005 09:36:29 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Haakon Riiser <haakon.riiser@fys.uio.no>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com> <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales> <20050202154139.GA3267@s> <9e4733910502020825434a477@mail.gmail.com> <20050202174509.GA773@s> <Pine.GSO.4.61.0502022037440.2069@waterleaf.sonytel.be> <20050202200810.GA2100@s>
In-Reply-To: <20050202200810.GA2100@s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haakon Riiser wrote:

>[Geert Uytterhoeven]
>
>  
>
>>mmap() the MMIO registers to userspace, and program the
>>acceleration engine from userspace, like DirectFB (and XF*_FBDev
>>3.x for Matrox and Mach64) does.
>>    
>>
>
>Right, this was how I originally intended to do it.  The reason
>why I started to obsess about the accelerated fb_ops functions was
>that I hoped that, by creating a driver that registered accelerated
>versions of these functions, other frame buffer-using applications
>would instantly take advantage of it, requiring no changes in those
>applications.  
>
The only framebuffer interface I know of is the framebuffer console.
It uses the fbdev acceleration when writing character strings
and scrolling.  So if your app writes data on the console and/or
scroll regions, then it certainly uses framebuffer acceleration.

>I thought the frame buffer device was supposed to
>serve as an an abstraction layer between the graphics card and
>the application, allowing for 2D acceleration without having to
>know anything about the underlying hardware.  But if no one uses the
>frame buffer device in this way, I might as well do as you suggest
>and mmap() the registers to userspace.
>  
>
I believe you also can write a small driver that connects to the
framebuffer the same way the fbconsole does.  It could then
export all the operations so userspace actually can call them.  This
have the advantage that your app can work on more than just one kind of
framebuffer.  Perhaps you run on one kind of hardware only today,
but who knows what hardware the future will bring?  Nice not having
to rewrite it all. . .

Helge Hafting
