Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284370AbRLMRBE>; Thu, 13 Dec 2001 12:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284398AbRLMRA5>; Thu, 13 Dec 2001 12:00:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:2824 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S284370AbRLMRAm>;
	Thu, 13 Dec 2001 12:00:42 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pozsar Balazs <pozsy@sch.bme.hu>
Date: Thu, 13 Dec 2001 18:00:26 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FBdev remains in unusable state 
CC: linux-kernel <linux-kernel@vger.kernel.org>, dwmw2@infradead.org
X-mailer: Pegasus Mail v3.40
Message-ID: <BE390EC144E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 01 at 14:29, Pozsar Balazs wrote:
> On Thu, 13 Dec 2001, David Woodhouse wrote:
> >
> > VANDROVE@vc.cvut.cz said:
> > > Documentation/fb/vesafb.txt, X11 paragraph, last sentence:
> > > -------8<-----
> > > The X-Server must restore the video mode correctly, else you end up
> > > with a broken console (and vesafb cannot do anything about this).
> > > -------8<-----
> >
> > This isn't strictly true. We could just call the VESA BIOS to set it up
> > again for us. The 'vesa' XFree86 driver manages to do this perfectly well
> > from userspace, even.
> 
> Then why not include this set up code into vesafb?

As it requires userspace, complete realmode 16bit DOS environment, it 
should not live in kernel (due to being 16bit code, and requiring its 
own mm). There was some patch which used protected mode VESA services 
to set videomode, but as nobody uses these services, BIOSes either do 
not provide them at all, or services provided are buggy and unusable.

If VESA BIOS virtualization it is something like (debian) 'read-edid' 
package does - then please no. It prints dozens of messages to screen 
for about 2 minutes on Matrox hardware, and if you switch consoles 
during that, CRTC setting is hopelessly damaged and only starting X 
brings picture back to you. And it does not read any EDID, of course...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
