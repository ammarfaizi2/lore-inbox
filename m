Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGQMwp>; Wed, 17 Jul 2002 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSGQMwo>; Wed, 17 Jul 2002 08:52:44 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38927 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313416AbSGQMwm>;
	Wed, 17 Jul 2002 08:52:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Wed, 17 Jul 2002 14:55:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PS2 Input Core Support
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <B27F96E7240@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 02 at 14:44, Vojtech Pavlik wrote:

> > --- a/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > +++ b/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > @@ -142,7 +142,7 @@
> >   */
> > 
> >         if (psmouse->type == PSMOUSE_IMEX) {
> > -               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
> > +               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> >                 input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> >                 input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> >         }

Hi,
  any plans to support A4Tech mouse? It uses IMEX protocol, but
  
switch(packet[3] & 0x0F) {
    case 0: /* nothing */
    case 1: vertical_wheel--; break;
    case 2: horizontal_wheel++; break;
    case 0xE: horizontal_wheel--; break;
    case 0xF: vertical_wheel++; break;
}

and obviously it never reports wheel move > 1 in one sample.
                                                 Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
