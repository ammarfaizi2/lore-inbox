Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRH0XjM>; Mon, 27 Aug 2001 19:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRH0XjC>; Mon, 27 Aug 2001 19:39:02 -0400
Received: from oe44.law9.hotmail.com ([64.4.8.16]:25611 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269795AbRH0Xiz>;
	Mon, 27 Aug 2001 19:38:55 -0400
X-Originating-IP: [65.92.120.252]
From: "Camiel Vanderhoeven" <camiel_toronto@hotmail.com>
To: "'Bart Vandewoestyne'" <Bart.Vandewoestyne@pandora.be>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: RE: DOS2linux
Date: Mon, 27 Aug 2001 19:39:23 -0400
Message-ID: <005d01c12f51$80486890$99eefea9@kiosks.hospitaladmission.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <3B8AAB3E.1EC121EA@pandora.be>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
Importance: Normal
X-OriginalArrivalTime: 27 Aug 2001 23:39:07.0501 (UTC) FILETIME=[76CBD1D0:01C12F51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoesteyne wrote:
> That is also what I think, but the problem is that I don't know at
> which offset to look for that data...
> If you look at the code:
> 
> static int getslotinfo( void )
> {
>   static char buff[320], *s=&buff[0]; int valid;
> 
>   inregs.h.ah=0xd8; inregs.h.al=0x1; inregs.h.cl=DiSC_Id.slot>>12;
> inregs.h.ch=0;
>   sregs.ds=FP_SEG(s); inregs.x.si=FP_OFF(s);
>   int86x(0x15, &inregs, &outregs, &sregs);
>   valid=outregs.h.ah;
>   if(!valid) { DiSC_Id.it=buff[itconf]; DiSC_Id.dma=buff[dmachd]; }
>   return(valid);
> }
> 
> Would it help if i told you that itconf and dmachd are defined as (see
> http://mc303.ulyssis.org/heim/downloads/DISCINC.H )
> 
> #define itconf                0xb2
> #define dmachd                0xc0
> 
> So if my EISA board is at 0x1000, i should be able to read these
> values from 0x1000+0xb2 and 0x1000+0xc0 ???  And if 'yes', any idea
> about how to read them? (byte, word, long...? My guess would be as a
> byte, but I'm not sure...)

Looking at the above piece of sourcecode, I would say your guess is
correct. "buff" is declared as an array of chars (bytes), so I would try
to read a byte at 0x10b2 and at 0x10c0. Just try it out & see what you
get back...

Camiel.
