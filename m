Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318126AbSGRNel>; Thu, 18 Jul 2002 09:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSGRNek>; Thu, 18 Jul 2002 09:34:40 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:64774 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318126AbSGRNej>;
	Thu, 18 Jul 2002 09:34:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Thu, 18 Jul 2002 15:36:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PS2 Input Core Support
CC: Linux Kernel <linux-kernel@vger.kernel.org>, gunther.mayer@gmx.net
X-mailer: Pegasus Mail v3.50
Message-ID: <B40AB0625BF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 02 at 14:58, Vojtech Pavlik wrote:
> On Thu, Jul 18, 2002 at 12:17:51PM +0200, Petr Vandrovec wrote:
> 
> > > Cool! Anyone send me a patch? ;)
> > 
> > Been there, done that... and unfortunately, my WOP35 insist on
> > taking first 6 bytes as PS/2->ImPS/2 sequence, and rest as normal
> > DPI settings. I tried it in reverse order, and couple of permutations,
> > but it still returns ExPS/2 id. I tried also other sequences from
> > gm_psauxprint-0.01, but I found nothing interesting, except that
> > mouse definitely does not support MS PNP id.
> > 
> > Answer from A4Tech support was that mouse is not supported under Linux,
> > and that I should use Windows and verify that mouse is properly connected.
> > So I'm on the best way to the command line switch, I think. Google
> > find couple of problem reporters, but nobody found detection method :-(
> 
> Well, it should be possible to snoop the mouse data off the wire using
> a slightly modified parkbd.c module on a different machine and a split
> PS/2 mouse cable ...

Problem is that A4Tech driver does not care. It just interprets incoming
data in the way I described: +-1 is vertical move, +-2 is horizontal,
0 is no move, and everything else is ignored... This is A4Tech's 
interpretation of ImPS/2 and ExPS/2 protocols.

So we can either assume (like GPM does) that wheel movement can be
only +-1, and so we can safely assume that +-2 is horizontal move,
and then everything is fine, or we need some option which will affect
mouse driver behavior.

All my (A4Tech...) PS/2 wheel mouse report wheel movement only +-1 even
with 10Hz sample rate, but I do not think that my mouses are representative
sample of available ExPS/2 implementations.
                                            Petr Vandrovec
                                            
