Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRLLU4R>; Wed, 12 Dec 2001 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRLLU4H>; Wed, 12 Dec 2001 15:56:07 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:64006 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282129AbRLLUzy>;
	Wed, 12 Dec 2001 15:55:54 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pozsar Balazs <pozsy@sch.bme.hu>
Date: Wed, 12 Dec 2001 21:55:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FBdev remains in unusable state
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <BCF7BFC1D50@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 01 at 21:42, Pozsar Balazs wrote:
> On Wed, 12 Dec 2001, Petr Vandrovec wrote:
> > In that case even xfree mga driver cannot return hardware back to previous
> > state. It is expected and documented.
> 
> Sorry I didn't know that. Btw, where is it documented?

Documentation/fb/vesafb.txt, X11 paragraph, last sentence:
-------8<-----
The X-Server must restore the video mode correctly, else you end up
with a broken console (and vesafb cannot do anything about this). 
-------8<-----

> > > Why isn't it done by the vesafb driver?
> >
> > vesafb is VBE2.0 based. It does not know how to touch hardware, it uses
> > LILO to do all this dirty work.
> 
> I think got the point, but I don't really understand how lilo comes here,
> because I boot using grub or syslinux.

Sorry. arch/i386/boot/video.S loader
 
> > as framebuffer will be already acquired by matroxfb, but I never tested
> > it). On computers without Matrox you'll have /dev/fb0 VESAFB and
> > /dev/fb1 will not exist at all.
> 
> Thanks for this. Are there similar issues with other cards?
> Which fb drivers should I compile in?

I have no idea. I know that atyfb does not work on ATIs I have, and
I have no idea how X11 behaves on them. I do not have other hardware
at all.
 
> > P.S.: Also try 'Option "UseFBDev"' in /etc/X11/XF86Config-4 driver
> > section. I think that with this option X11 mga driver will not stomp
> > on your hardware, and instead it will refuse any videmode != vesafb
> > one.
> 
> I need 'real' X running, not X using fbdev...

With driver "mga" and option "usefbdev" you should get 'real' X, they'll
use acceleration. Only difference is that they'll use kernel fbdev
to set videomode (in XF4.0 there is a bug that DGA mode in X11 mga driver 
will go directly to hardware even if usefbdev is specified, but with XF4.1 
you should be safe).
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
