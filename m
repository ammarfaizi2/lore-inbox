Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281932AbRLLUd1>; Wed, 12 Dec 2001 15:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRLLUdS>; Wed, 12 Dec 2001 15:33:18 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:47110 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S281932AbRLLUdJ>;
	Wed, 12 Dec 2001 15:33:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pozsar Balazs <pozsy@sch.bme.hu>
Date: Wed, 12 Dec 2001 21:32:53 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FBdev remains in unusable state
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <BCF1AF35606@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 01 at 21:14, Pozsar Balazs wrote:
> > No. vesafb does not work together with mga driver in X (although
> > I believe that vesafb works with XFree mga driver, only Matrox driver
> > is binary bad citizen).
> 
> I don't clearly understand you. I am using mga driver which is in the
> official xfrr86 release.

In that case even xfree mga driver cannot return hardware back to previous
state. It is expected and documented.
 
> > Neither. X restore R/W registers to their previous values, while write-only
> > registers to their values for normal text mode. Yes, there is a
> > 'workaround'. Use (much faster) matroxfb.
> 
> What if setting those W-only registers to their appropiate values on
> console-switches?

It is hardware dependent and undocumented. matroxfb does it...

> Why isn't it done by the vesafb driver?

vesafb is VBE2.0 based. It does not know how to touch hardware, it uses
LILO to do all this dirty work.

> How is the mga fb driver handle handling this situation better?

Because of it actually drives hardware, instead of touching it once before
boot, and then trusting all citizens that it will work. So it can restore
any mode it wants, on any head it wants.
 
> ps: My problem is that I have to use exactly the same kernel on different
> machines, and I need fb. If not all machines have mga, than mga fb is
> no-go.

I do not understand. If you'll compile both vesafb & matroxfb into kernel,
and you'll boot with

Linux vga=769 video=matrox:vesa:769 

on computers with Matrox inside you'll have /dev/fb0 accelerated fb,
and /dev/fb1 VESAFB 'do not use' (maybe vesafb even will not load
as framebuffer will be already acquired by matroxfb, but I never tested
it). On computers without Matrox you'll have /dev/fb0 VESAFB and 
/dev/fb1 will not exist at all.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
P.S.: Also try 'Option "UseFBDev"' in /etc/X11/XF86Config-4 driver
section. I think that with this option X11 mga driver will not stomp 
on your hardware, and instead it will refuse any videmode != vesafb
one.

