Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUFUBbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUFUBbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUFUBbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:31:49 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:10377 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262080AbUFUBbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:31:37 -0400
Date: Mon, 21 Jun 2004 03:31:36 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040621013136.GB4683@vana.vc.cvut.cz>
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl> <20040620170114.GA4683@vana.vc.cvut.cz> <20040620213743.GA6974@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620213743.GA6974@irc.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:37:43PM +0200, Tomasz Torcz wrote:
> On Sun, Jun 20, 2004 at 07:01:14PM +0200, Petr Vandrovec wrote:
> > > > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > > > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> > > 
> > >  Neither one works. During kernel boot resolution is switched to 1280x1024, but
> > > screen become corrupted - there are some green points in upper part of
> > > monitor. 
> > 
> > It works exactly as your kernel is configured. It switched to graphics, but it does
> > not paint your console there because you told you kernel to not do that.
> > >  Also, the patch from platan do not compile:
> > 
> > And this one too - my patch needs fbcon.
> > > # CONFIG_FRAMEBUFFER_CONSOLE is not set
> > 
> > Enable this. Into the kernel, not as a module.
> 
>  Wow! It works! It not the same mode as in XFree (fb is moved lower by one line),
> but it is working!
>  I don't think if I've met CONFIG_FRAMEBUFFER_CONSOLE earlier in 2.6.x. Also
> method of selecing videomode (vesa:xxx stuff, not plain resolution and bpp) seems
> strange and alien, but it works with your patch. 

I bet that all this is not needed for you, now when you properly configured your system. 

1280x1024-60 just selects some videomode fbdev subsystem thinks your monitor should use,
while vesa:0x11A selects videomode I think you should use. And right/left/... modifies it
to match with your X setup. Maybe I made some math wrong somewhere if you see picture one
line lower. Try using upper=40 or 32 instead of 48 (or 47 if you are talking about
one pixel line, not about one character line).  All this is available in standard
kernel, and documented in matroxfb.txt.

>  When mergin with mainline is planned?

Never. Main thing that patch does is resurrecting 2.4.x fbcon subsystem. And 2.6.x uses
its own, 2.6.x fbcon subsystem. So you can either use what's in the kernel (and I see no 
reason why in-kernel driver should not work for you if you do not need svgalib compatibility
or multihead system or different resolution on each virtual terminal), or you'll have to 
patch your kernel. Except resurrecting 2.4.x fbcon patch only adds support for native
text mode (which is impossible with new fbcon), but otherwise in-kernel and in-patch
drivers should be identical.
							Best regards,
								Petr Vandrovec
	
