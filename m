Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSARRVc>; Fri, 18 Jan 2002 12:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSARRVM>; Fri, 18 Jan 2002 12:21:12 -0500
Received: from www.transvirtual.com ([206.14.214.140]:25348 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290755AbSARRVD>; Fri, 18 Jan 2002 12:21:03 -0500
Date: Fri, 18 Jan 2002 09:20:47 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Sven <luther@dpt-info.u-strasbg.fr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <20020118112640.A23763@dpt-info.u-strasbg.fr>
Message-ID: <Pine.LNX.4.10.10201180909380.20679-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >     On to the massive fbdev cleanup. The second patch requires the first
> > patch. The first patch is the currcon one that I posted earlier. Every
> 
> Mmm, what is the current status on all this.

Right now the cleanup of the massive code duplication for the color map
handling is happening. I have fbgen.c compiled in by default for every
driver and I'm gradually moving everything over to it. 

> How does the new fbdev api compare with ruby, is it the same thing or not,

It pretty much is the same thing. The only difference will be hooks for
fb_read and fb_write. Some framebuffers like the i810 or the epson 1385 
are not the run of the mill linear framebuffers. So they need special
hooks. Also the addition of EDID/DDC and othe rrelated protocols. The
third difference will be something that has been discussed in public with
Scott from intel. At present most fbdev drivers reset the accel engine
even when you do something like increasing the refresh rate. This is not
needed. Most sane hardware has the timings seperate from the accel engine. 
Now change the color depth or resolution does effect it. So that will be
cleared up. 
 
> and how does the ruby tree compare with the -dj one ?

I gradually placing the ruby stuff into the -dj tree. This way it gets
more testing. Plus I can see what is really a bug in ruby. For example
their is a nasty bug in the new console locking. So it has been removed
from the dj tree. I need to break it up more and slowly put it into place.
This way I can see what the problem is. 

> And what is the current status of fbdev in 2.5.x ? 2.5.1 + ruby hang my box
> early in the boot process, but that is probably because pm3fb is not working
> yet for ruby. Does matroxfb work ? i have an older pci matrox board that i
> could install to test and do some pm3fb work if needed (and if i get the time
> for it :(((0

Only a hand full of drivers have truly been converted over in the console
CVS. The hanging is most likely due to the new console lock. I have
decided that the ruby tree will be used for code deposting and the DJ tree
will be the real testing ground. 

