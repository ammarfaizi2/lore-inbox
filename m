Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGQNV6>; Wed, 17 Jul 2002 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGQNV6>; Wed, 17 Jul 2002 09:21:58 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:10000 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313537AbSGQNV5>;
	Wed, 17 Jul 2002 09:21:57 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Wed, 17 Jul 2002 15:24:39 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PS2 Input Core Support
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <B2875E55BFC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 02 at 15:01, Vojtech Pavlik wrote:
> On Wed, Jul 17, 2002 at 02:55:21PM +0200, Petr Vandrovec wrote:
> > On 17 Jul 02 at 14:44, Vojtech Pavlik wrote:
> > 
> > > > --- a/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > > > +++ b/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > > > @@ -142,7 +142,7 @@
> > > >   */
> > > > 
> > > >         if (psmouse->type == PSMOUSE_IMEX) {
> > > > -               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
> > > > +               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> > > >                 input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> > > >                 input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> > > >         }
> > 
> > Hi,
> >   any plans to support A4Tech mouse? It uses IMEX protocol, but
> >   
> > switch(packet[3] & 0x0F) {
> >     case 0: /* nothing */
> >     case 1: vertical_wheel--; break;
> >     case 2: horizontal_wheel++; break;
> >     case 0xE: horizontal_wheel--; break;
> >     case 0xF: vertical_wheel++; break;
> > }
> > 
> > and obviously it never reports wheel move > 1 in one sample.
> 
> Is there a way to detect whether it's an ImEx or A4? Or will we need a
> command line parameter ... ?

I'm not aware of any way. It behaves like proper ExPS/2 mouse: after reset
it returns id0, after ImPS/2 sequence 3, and after ExPS/2 sequence 4.
In both ImPS/2 and ExPS/2 modes it uses 2/0xE(0xFE) in fourth byte of
packet for horizontal wheel.

Windows .INF talks about "A4M0004", but it looks to me like an internal
.INF identifier and not as an identification string obtainable from mouse.

I'll try to write email to them, maybe they'll answer.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
