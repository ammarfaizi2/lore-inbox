Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276763AbRJBWuo>; Tue, 2 Oct 2001 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRJBWue>; Tue, 2 Oct 2001 18:50:34 -0400
Received: from www.transvirtual.com ([206.14.214.140]:33033 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276763AbRJBWu0>; Tue, 2 Oct 2001 18:50:26 -0400
Date: Tue, 2 Oct 2001 15:50:35 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ricky Beam <jfbeam@bluetopia.net>, Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
In-Reply-To: <E15oYCP-0006Cm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110021536080.30587-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well the reason the framebuffer suck is because the current api sucks for
> > them. It draws pixel by pixel. Slow slow slow!!! I have developed a new
> > api that takes advantage of the accel engine of graphics hardware. It is
> 
> Great. VESAfb doesnt have one. Lots of older machines dont have one.

   True. Of course VESAfb exist because we lack so fbdev drivers. In time
that problem should go away. Also many embedded devices, which I do for a
living, lack hardware acceleration. Well okay alot of modern PDA's are
staring to have accel engines. This doesn't mean you can't write really
good optimized software code for devices that lack hardware acceleration.
   The software accel functions needed by the console layer (copyarea,
fillrect, and drawimage) have been already written. Okay the drawimage one
needs alot of work. I haven't benchmarked the new code versus the current
code but you can see the difference. One of the big changes I have have
made is that on write data to the framebuffer word aligned and a long at
a time. For 8bpp you have 4 pixels written at a time. This makes for a
much tigher loop. On ix86 you can see a huge difference in performance due
to the word alignment. I knwo because at first I had a bug that wasn't
doing it right. After I fix that bug you could see the difference. 
    We use the same techniques at work for embedded devices where the cpus 
don't have the horse power like desktops. Every single line of code counts. 
I haven't ported the assembly versions for different platforms yet but I
plan to. I know from experience writing proper assembly on ARM or using
MMX will increase preformance many fold. 

