Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132903AbRA3XcE>; Tue, 30 Jan 2001 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRA3Xby>; Tue, 30 Jan 2001 18:31:54 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:46865 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132903AbRA3Xbt>;
	Tue, 30 Jan 2001 18:31:49 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Date: Wed, 31 Jan 2001 00:30:40 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
CC: linux-kernel@vger.kernel.org, tcl@bunzy.net
X-mailer: Pegasus Mail v3.40
Message-ID: <14179DC03097@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 01 at 0:06, Marcel J.E. Mol wrote:

> > > Installed a Matrox G450 on my linux system. Now it has problems
> > > booting. The kernel is compiled with framebuffer support so is supposed
> > > to boot up with the Linux logo. Unfortunately the systems hangs when 
> > > the kernel switches to the graphics mode. When I first boot into windoze
> > > and the reboot to linux it works fine. So it looks like an
> > > initialisation problem...

Well, first to problem with G450. I was trying very hard to find what's
wrong, last few weeks together with guys from some other OSes (I'm
not sure if I can mention them publicaly) and we were not able to find
what's wrong - and without datasheets we hardly can.

Problem is that sometime G450 is in strange state, where doing accelerated
operations which does both read and write (not simple fill) locks
accelerator. Windows drivers works around somehow, as after booting
to Windows matroxfb works fine - but without Windows it is just pure luck.
You can try powering off your box again and again - and sometime
it will boot, and from this time it will boot always until you poweroff
computer.

It looks like that if you compile 'agpgart' into kernel, chances that it
will work are better, but I have also reports that it did not changed
anything.

So currently I do not know. Only 100% safe way I know is booting with
'video=matrox:noaccel' - but at cost of completely disabled acceleration.
And if you'll start accelerated X with non-matrox mga driver (and with 
'Option "UseFBDev"', of course) on such hardware, your computer locks 
again...

> On Tue, Jan 30, 2001 at 04:53:45PM -0500, tc lewis wrote:
> > 
> > try the latest driver that matrox provides.  i had to do this with just a
> > stock redhat 7.0 system.  i don't think the standard kernel distributions
> > redhat packages use a driver that knows about the 450 yet.
> > 
> > http://www.matrox.com/mga/support/drivers/files/linux_04.cfm
> 
> In the G400 time I tried the 1.0.1, 1.0.3 and 1.0.4 matrox driver
> with XFree 4.0.1 but only 1.0.1 worked. After installing XFree 4.0.2
> I get the same results (the matrox drivers are build for XFree 4.0.1
> but I guess the should work for 4.0.2 to as they are 'modules'...).

I'm currently using Matrox driver 1.0.4 and XF 4.0.2 with 
'Options "UseFBDev"' and 'Options "HWCursor" "off"' - I'm using 'UseFBDev'
because of I want to manage first/second head by hand (matroxset) and
not by XFree.

You can get it to work with xfree mga driver too (using usefbdev), but 
mga driver in XF4.0.2 ignores usefbdev option when using DGA - so for
VMware you need mga driver from Matrox, anything else fails...

> > > Previously I had a matrox G400 card and that worked without any problems.
> > > 
> > > Also xfree fails when using the svga module (Xfree 4.0.2). When using the
> > > fbdev module it works fine. Again, using the G400 card works fine with svga
> > > module.
> > > 
> > > And yes, it really is a G450!

Revision >= 80 => G450 : G400, DDRAM memory interface, different VCO, 
                         better dualhead... And probably another BES
                         used by CRTC2 in TVOut mode...

                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
