Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282039AbRKVE2S>; Wed, 21 Nov 2001 23:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282040AbRKVE2J>; Wed, 21 Nov 2001 23:28:09 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:39942
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S282039AbRKVE2D>; Wed, 21 Nov 2001 23:28:03 -0500
Message-Id: <5.1.0.14.2.20011121232051.01dab468@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 23:24:02 -0500
To: Vincent Sweeney <v.sweeney@dexterus.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>
From: Stevie O <stevie@qrpff.net>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BFB9FAE.DB9B6003@dexterus.com>
In-Reply-To: <01112112401703.01961@nemo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:35 PM 11/21/2001 +0000, Vincent Sweeney wrote:
> > Bad code style. Bad name (sounds like 'module inc').
> > I can't even tell from this define what the hell it is trying to do:
> > x++ will return unchanged x, then we obtain (x mod y),
> > then we store it into x... and why x++ then??!
> > Alan, seems like you can help here...
>
>Go read up on C operator precedence. Unary ++ comes before %, so if we
>rewrite the #define to make it more "readable" it would be #define
>MODINC(x,y) (x = (x+1) % y)

But x++ is postincrement though. That means the value of 'x' is inserted, 
and after the expression is evaluated, x is incremented. Right?

If we were going to be semiobscure, wouldn't the correct code be

#define MODINC(x,y) (x = ++x % y)

Btw, to the original guy: this loops 'x' around between 0 and (y-1) -- 
i.e., if y=5, and x=0, successive "calls" to this #define would do

MODINC(x,y);  // x=1
MODINC(x,y);  // x=2
MODINC(x,y);  // x=3
MODINC(x,y);  // x=4
MODINC(x,y);  // x=0
MODINC(x,y);  // x=1
MODINC(x,y);  // x=2
MODINC(x,y);  // x=3
...




--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

