Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSGQNyz>; Wed, 17 Jul 2002 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSGQNyz>; Wed, 17 Jul 2002 09:54:55 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:56824 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314340AbSGQNyy>;
	Wed, 17 Jul 2002 09:54:54 -0400
Message-ID: <3D3577FD.ED42443C@gmx.net>
Date: Wed, 17 Jul 2002 15:58:21 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <B27F96E7240@vcnet.vc.cvut.cz> <20020717150153.B19609@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

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

from http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c :

char a4tech_id[]={ 0xf3,200, 0xf3,100, 0xf3,80, 0xf3,60, 0xf3,40, 0xf3,20};

if(a4tech) {
sendbuf(fd,f,a4tech_id,12);
        buf[0]=0xf2;
        write(fd,&buf,1);
        b=consumefa(f);
        printf("a4tech ID(f2) is %x\n",b);

        if(b==6 || b==8) printf("AUTODETECT: a4tech\n");
        // b=6: spiffy gyro-mouse "8D Profi-Mouse Point Stick"
        // b=8: boeder Smartmouse Pro (4Button, 2Scrollwheel, 520dpi) PSM_4DPLUS_ID MOUSE_MODEL_4DPLUS
}


