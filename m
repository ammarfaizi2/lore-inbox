Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKVLrk>; Thu, 22 Nov 2001 06:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277532AbRKVLr3>; Thu, 22 Nov 2001 06:47:29 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:43280 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277514AbRKVLrR>; Thu, 22 Nov 2001 06:47:17 -0500
Message-Id: <200111221146.fAMBk8XF006908@pincoya.inf.utfsm.cl>
To: Stevie O <stevie@qrpff.net>
cc: Vincent Sweeney <v.sweeney@dexterus.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {} 
In-Reply-To: Message from Stevie O <stevie@qrpff.net> 
   of "Wed, 21 Nov 2001 23:24:02 CDT." <5.1.0.14.2.20011121232051.01dab468@whisper.qrpff.net> 
Date: Thu, 22 Nov 2001 08:46:08 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stevie O <stevie@qrpff.net> said:
> At 12:35 PM 11/21/2001 +0000, Vincent Sweeney wrote:
> > > Bad code style. Bad name (sounds like 'module inc').
> > > I can't even tell from this define what the hell it is trying to do:
> > > x++ will return unchanged x, then we obtain (x mod y),
> > > then we store it into x... and why x++ then??!
> > > Alan, seems like you can help here...
> >
> >Go read up on C operator precedence. Unary ++ comes before %, so if we
> >rewrite the #define to make it more "readable" it would be #define
> >MODINC(x,y) (x = (x+1) % y)
> 
> But x++ is postincrement though. That means the value of 'x' is inserted, 
> and after the expression is evaluated, x is incremented. Right?

Nope. x++ increments x sometime (not defined when) after taking the value. 

   x = x++ % y

is wrong: There is just one sequence point at the end of the expression,
and x is modified twice in between (++ and =). If this gives the same as:

   x = (x + 1) % y

gcc is smoking potent stuff... but it could legally do anything at all.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
