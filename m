Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbRH1Gyq>; Tue, 28 Aug 2001 02:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270280AbRH1Gyg>; Tue, 28 Aug 2001 02:54:36 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:13731 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S270279AbRH1GyT>; Tue, 28 Aug 2001 02:54:19 -0400
Message-ID: <3B8B4027.5DE84CE9@pandora.be>
Date: Tue, 28 Aug 2001 08:54:31 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: Camiel Vanderhoeven <camiel_toronto@hotmail.com>
CC: linux-kernel@vger.kernel.org, Wesley Daemen <wesley@daemen.net>
Subject: Re: DOS2linux
In-Reply-To: <005d01c12f51$80486890$99eefea9@kiosks.hospitaladmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camiel Vanderhoeven wrote:
> 
> > static int getslotinfo( void )
> > {
> >   static char buff[320], *s=&buff[0]; int valid;
> >
> >   inregs.h.ah=0xd8; inregs.h.al=0x1; inregs.h.cl=DiSC_Id.slot>>12;
> > inregs.h.ch=0;
> >   sregs.ds=FP_SEG(s); inregs.x.si=FP_OFF(s);
> >   int86x(0x15, &inregs, &outregs, &sregs);
> >   valid=outregs.h.ah;
> >   if(!valid) { DiSC_Id.it=buff[itconf]; DiSC_Id.dma=buff[dmachd]; }
> >   return(valid);
> > }
> >
> > Would it help if i told you that itconf and dmachd are defined as (see
> > http://mc303.ulyssis.org/heim/downloads/DISCINC.H )
> >
> > #define itconf                0xb2
> > #define dmachd                0xc0
> >
> > So if my EISA board is at 0x1000, i should be able to read these
> > values from 0x1000+0xb2 and 0x1000+0xc0 ???  And if 'yes', any idea
> > about how to read them? (byte, word, long...? My guess would be as a
> > byte, but I'm not sure...)
> 
> Looking at the above piece of sourcecode, I would say your guess is
> correct. "buff" is declared as an array of chars (bytes), so I would try
> to read a byte at 0x10b2 and at 0x10c0. Just try it out & see what you
> get back...

I tried reading bytes from the following locations:

0x1000+0xb2		-> gives me 255
0x1000+0xc80+0xb2	-> gives me 255
0x1000+0xc84+0xb2	-> gives me 255

same for 0xc0

I guess these aren't the values I should be expecting... :-(

Greetzzz,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
