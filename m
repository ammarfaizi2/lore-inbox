Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRKVUIo>; Thu, 22 Nov 2001 15:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280822AbRKVUIf>; Thu, 22 Nov 2001 15:08:35 -0500
Received: from jalon.able.es ([212.97.163.2]:28821 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279201AbRKVUIX>;
	Thu, 22 Nov 2001 15:08:23 -0500
Date: Thu, 22 Nov 2001 21:08:01 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Stevie O <stevie@qrpff.net>
Cc: Vincent Sweeney <v.sweeney@dexterus.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011122210801.A1514@werewolf.able.es>
In-Reply-To: <01112112401703.01961@nemo> <3BFB9FAE.DB9B6003@dexterus.com> <5.1.0.14.2.20011121232051.01dab468@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <5.1.0.14.2.20011121232051.01dab468@whisper.qrpff.net>; from stevie@qrpff.net on Thu, Nov 22, 2001 at 05:24:02 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011122 Stevie O wrote:
>At 12:35 PM 11/21/2001 +0000, Vincent Sweeney wrote:
>> > Bad code style. Bad name (sounds like 'module inc').
>> > I can't even tell from this define what the hell it is trying to do:
>> > x++ will return unchanged x, then we obtain (x mod y),
>> > then we store it into x... and why x++ then??!
>> > Alan, seems like you can help here...
>>
>>Go read up on C operator precedence. Unary ++ comes before %, so if we
>>rewrite the #define to make it more "readable" it would be #define
>>MODINC(x,y) (x = (x+1) % y)
>
>But x++ is postincrement though. That means the value of 'x' is inserted, 
>and after the expression is evaluated, x is incremented. Right?
>
>If we were going to be semiobscure, wouldn't the correct code be
>
>#define MODINC(x,y) (x = ++x % y)
>

But the question is: Is this kind of code worth the discussion ? AFAIK,
gcc is enough smart to change *2 to <<1, so wouldn't it be smart to
detect a +1 and use and inc (and perhaps to detect that x is overwritten so it
can do the op in place).
So write it as
x = (x+1)%y
and make it readable.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre9 #1 SMP Thu Nov 22 16:16:54 CET 2001 i686
