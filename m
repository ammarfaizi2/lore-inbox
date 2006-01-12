Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWALTLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWALTLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWALTLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:11:53 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:24732 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161190AbWALTLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:11:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QBT1Y24rdNRNmxy7S2fZ5nDcUg2g0N3DqwdS8rZ8pRRiGST5sg6US+gg0tLNq2YkIT2cXJRUVR1e+0ITPFT8hRmemL2NFD1Rvha/buT8Nh4K1ci7Qi7CVkrY1I55ZUx4FQ8rD8x5tOW3Kt5rV2Qz9sPe+OpegmoG10bv5KVHZqU=
Date: Thu, 12 Jan 2006 22:28:56 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-$SHA1: VT <-> X sometimes odd
Message-ID: <20060112192856.GA7938@mipter.zuzino.mipt.ru>
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru> <43C4F114.9070308@gmail.com> <20060111153822.GA7879@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111153822.GA7879@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 06:38:22PM +0300, Alexey Dobriyan wrote:
> On Wed, Jan 11, 2006 at 07:50:44PM +0800, Antonino A. Daplas wrote:
> > Alexey Dobriyan wrote:
> > > Approximate sequence of event:
> > >
> > > 1. script which builds allmodconfig on 11 targets is left on otherwise
> > >    idle machine. Logged in on VT1. Logged of X.
> > > 2. After 5 hours I return, ensure script behaves OK, switch to X and see
> > >    black screen.
> > > 3. Now, trying to switch between VTs and X gives nothing but black
> > >    screen.
> > > 4. Alt+SysRq+K. After several seconds black screen switches to black
> > >    screen with text cursor in the upper-left corner.
> > > 5. Futher attempts to switch and SysRq+Ki'ing gave nothing.
> > > 6. In a minute or so X login prompt reappeared. Mouse os OK. Keyboard is
> > >    not. In particular, typing username doesn't work.
> > > 7. By some miracle, typing became OK (probably after I hit Ctrl, not
> > >    sure). I login to X successfully and fire up mutt to mail bugreport.
> > > 8. Devil turned me to switch to VT again...
> > > 9. goto #5.
> > > 10. Cold reboot.
> >
> > Can you reproduce this with another X driver, for example, vesa or
> > fbdev, and/or with another console driver? Maybe you can also try with
> > DRI enabled and disabled?
>
> OK, I'll try.
>
> > > The overall feeling is that X left without human interaction starts to
> > > reacts slooowly (probably after blanking kicks in?).
> >
> > That's also what I'm thinking, console blanking, X blanking, or power
> > management. You might want to shorten the console blanking interval with:
> >
> > setterm -blank 1.
>
> Strange freezing continues, probably blanking should be left alone:
>
> 1. while reading random patches with gitk with nothing more running. gitk
>    already read all patch headers from the whole Linux git archive.
>
>    gitk stops reacting on mouse clicks
>    "Ctrl+Alt+1" (switching to virtual desktop #1 in evilwm) -- OK
>    "Ctrl+Alt+2" (back) -- gitk shows its window but without actual
>    content as if something can't get a timeslice for redraw.
>
> 2. Two allmodconfig builds in parallel. mutt downloading email, /me
>    lazily browsing with Firefox.

I disabled DRI in xorg.conf but it happened again.

Now it's vim saving 5k proggie while X tarball was unpacking on reiserfs.
:wq and vim freezes. Switching to another virtual "desktops" works and
everything in general works except vim. But switching to VT and back
sends system to hell.

