Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSGRNmY>; Thu, 18 Jul 2002 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSGRNmY>; Thu, 18 Jul 2002 09:42:24 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9673 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318078AbSGRNmX>;
	Thu, 18 Jul 2002 09:42:23 -0400
Date: Thu, 18 Jul 2002 15:45:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gunther.mayer@gmx.net
Subject: Re: PS2 Input Core Support
Message-ID: <20020718154521.A29928@ucw.cz>
References: <B40AB0625BF@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B40AB0625BF@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 18, 2002 at 03:36:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 03:36:59PM +0200, Petr Vandrovec wrote:
> On 18 Jul 02 at 14:58, Vojtech Pavlik wrote:
> > On Thu, Jul 18, 2002 at 12:17:51PM +0200, Petr Vandrovec wrote:
> > 
> > > > Cool! Anyone send me a patch? ;)
> > > 
> > > Been there, done that... and unfortunately, my WOP35 insist on
> > > taking first 6 bytes as PS/2->ImPS/2 sequence, and rest as normal
> > > DPI settings. I tried it in reverse order, and couple of permutations,
> > > but it still returns ExPS/2 id. I tried also other sequences from
> > > gm_psauxprint-0.01, but I found nothing interesting, except that
> > > mouse definitely does not support MS PNP id.
> > > 
> > > Answer from A4Tech support was that mouse is not supported under Linux,
> > > and that I should use Windows and verify that mouse is properly connected.
> > > So I'm on the best way to the command line switch, I think. Google
> > > find couple of problem reporters, but nobody found detection method :-(
> > 
> > Well, it should be possible to snoop the mouse data off the wire using
> > a slightly modified parkbd.c module on a different machine and a split
> > PS/2 mouse cable ...
> 
> Problem is that A4Tech driver does not care. It just interprets incoming
> data in the way I described: +-1 is vertical move, +-2 is horizontal,
> 0 is no move, and everything else is ignored... This is A4Tech's 
> interpretation of ImPS/2 and ExPS/2 protocols.
> 
> So we can either assume (like GPM does) that wheel movement can be
> only +-1, and so we can safely assume that +-2 is horizontal move,
> and then everything is fine, or we need some option which will affect
> mouse driver behavior.
> 
> All my (A4Tech...) PS/2 wheel mouse report wheel movement only +-1 even
> with 10Hz sample rate, but I do not think that my mouses are representative
> sample of available ExPS/2 implementations.

No, normal ImPS/2 and ExPS/2 mice indeed can report values greater than 1
for wheel movement.

We can either make some heuristic (ever saw movement of 3? If yes, then
it's not an A4Tech mouse ...), or go for the command line parameter.

I guess I'll pull out some of my A4Tech mice and torture them a bit to
see if they'd react to some sequence ...

Another thing is then USB A4Tech mice, which use a button to
differentiate between the wheels, while the USB spec has provisions for
two wheels on a mouse :(. But those are at least possible to detect.

-- 
Vojtech Pavlik
SuSE Labs
