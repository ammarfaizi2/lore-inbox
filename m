Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317699AbSGRKP2>; Thu, 18 Jul 2002 06:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSGRKP2>; Thu, 18 Jul 2002 06:15:28 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:64786 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317699AbSGRKP1>;
	Thu, 18 Jul 2002 06:15:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Thu, 18 Jul 2002 12:17:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PS2 Input Core Support
CC: Linux Kernel <linux-kernel@vger.kernel.org>, gunther.mayer@gmx.net
X-mailer: Pegasus Mail v3.50
Message-ID: <B3D59960FB3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 02 at 16:01, Vojtech Pavlik wrote:
> On Wed, Jul 17, 2002 at 03:58:21PM +0200, Gunther Mayer wrote:
> 
> > > > Hi,
> > > >   any plans to support A4Tech mouse? It uses IMEX protocol, but
> > > >
> > > > switch(packet[3] & 0x0F) {
> > > >     case 0: /* nothing */
> > > >     case 1: vertical_wheel--; break;
> > > >     case 2: horizontal_wheel++; break;
> > > >     case 0xE: horizontal_wheel--; break;
> > > >     case 0xF: vertical_wheel++; break;
> > > > }
> > > >
> > > > and obviously it never reports wheel move > 1 in one sample.
> > >
> > > Is there a way to detect whether it's an ImEx or A4? Or will we need a
> > > command line parameter ... ?
> > 
> > from http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c :
> > 
> > char a4tech_id[]={ 0xf3,200, 0xf3,100, 0xf3,80, 0xf3,60, 0xf3,40, 0xf3,20};
> > 
> > if(a4tech) {
> > sendbuf(fd,f,a4tech_id,12);
> >         buf[0]=0xf2;
> >         write(fd,&buf,1);
> >         b=consumefa(f);
> >         printf("a4tech ID(f2) is %x\n",b);
> > 
> >         if(b==6 || b==8) printf("AUTODETECT: a4tech\n");
> >         // b=6: spiffy gyro-mouse "8D Profi-Mouse Point Stick"
> >         // b=8: boeder Smartmouse Pro (4Button, 2Scrollwheel, 520dpi) PSM_4DPLUS_ID MOUSE_MODEL_4DPLUS
> > }
> 
> Cool! Anyone send me a patch? ;)

Been there, done that... and unfortunately, my WOP35 insist on
taking first 6 bytes as PS/2->ImPS/2 sequence, and rest as normal
DPI settings. I tried it in reverse order, and couple of permutations,
but it still returns ExPS/2 id. I tried also other sequences from
gm_psauxprint-0.01, but I found nothing interesting, except that
mouse definitely does not support MS PNP id.

Answer from A4Tech support was that mouse is not supported under Linux,
and that I should use Windows and verify that mouse is properly connected.
So I'm on the best way to the command line switch, I think. Google
find couple of problem reporters, but nobody found detection method :-(

                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

