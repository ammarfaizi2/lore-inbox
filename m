Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTBTSTy>; Thu, 20 Feb 2003 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBTSTy>; Thu, 20 Feb 2003 13:19:54 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:24478 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S266761AbTBTSTt>;
	Thu, 20 Feb 2003 13:19:49 -0500
Date: Thu, 20 Feb 2003 10:29:41 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Dave Jones <davej@codemonkey.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBdev updates.
Message-ID: <20030220182941.GK14445@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220150201.GD13507@codemonkey.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 03:02:01PM +0000, Dave Jones wrote:
> On Thu, Feb 20, 2003 at 01:09:33AM +0000, James Simmons wrote:
> 
>  > New updates to the fbdev layer. You can grab the diff from 
>  > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> James,
>  Whats the current status with matroxfb ? Its been broken
> for months now, and hasn't seen any progress wrt getting it
> back on its feet.
> 
> I understand Petr had some concerns with the new API, but
> *something* needs to be done to get this back up and running.
> 
> I'd understand if this was a neglected hardly-used-by-anyone
> driver, but there's an awful lot of matrox cards out there.
> 
> This was first reported broken way back in 2.5.53, but I believe
> was broken even longer before that.

Since 2.5.51, when rewrite came in... 

You can get patch which reverts most of James's work at
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.59.gz.

I was for five weeks in U.S., so I did not do anything with
matroxfb during that time. I plan to use fillrect and copyrect
from generic code (although it means unnecessary multiply on
generic side, and division in matroxfb, but well, if we gave
up on reasonable speed for fbdev long ago...). But I simply
want loadfont and putcs hooks for character painting. And if 
fbdev maintainer does not want to give me them, well, then 
matroxfb and fbdev are not compatible.

I refuse to remove features from matroxfb driver, and textmode
support is one of current features (needed and required to be
able to run VMware on fullscreen - and as main part of my
job happens in VMware...). So there is couple of choices:
(1) new maintainer, or
(2) remove matroxfb from kernel, or
(3) persuade me that I want to write matroxcon and forget about fbcon at all, or
(4) something else I do not know about.

Besides that with that strange additional copy in accel_putcs
I get much slower output than with 2.4.x... and although I
understand that for 2.6.x we'll all have faster computers than
we had for 2.4.x, I still think that speed should be primary
concern, and code extensibility and readability secondary.
But well, I told it dozens of time, so why I bother. I do
not want to end up as Larry.
					Petr Vandrovec
					vandrove@vc.cvut.cz

