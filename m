Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281132AbRKUNiD>; Wed, 21 Nov 2001 08:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKUNhx>; Wed, 21 Nov 2001 08:37:53 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1808 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281028AbRKUNhk>; Wed, 21 Nov 2001 08:37:40 -0500
Date: Wed, 21 Nov 2001 14:37:38 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121143738.D2196@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <01112112401703.01961@nemo> <3BFB9FAE.DB9B6003@dexterus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFB9FAE.DB9B6003@dexterus.com>; from v.sweeney@dexterus.com on Wed, Nov 21, 2001 at 12:35:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     *a++ = byte_rev[*a]
> It looks perferctly okay to me. Anyway, whenever would you listen to a
> C++ book talking about good C coding :p

AFAIK the ANSI C specification explicitely claims, that it's not defined.
The trick is, that the specification explicitly allows the compiler to
choose wether it does the inc/dec right after/before the fetch, or at the
begin/end of evaluation. Thus the second reference to a might return the
original or incremented value at compiler's will.

> Go read up on C operator precedence. Unary ++ comes before %, so if we
> rewrite the #define to make it more "readable" it would be #define
> MODINC(x,y) (x = (x+1) % y)

*NO* 
MODINC(x,y) (x = (x+1) % y)
is correct and beaves as expected. Unfortunately:
MODINC(x,y) (x = x++ % y)
is a nonsence, because the evaluation is something like this
x++ returns x
x++ % y returns x % y
x is assigned the result and it's incremented IN UNDEFINED ORDER!!!
AFAIK the ANSI C spec explicitly undefines the order.

> >     *a++ = byte_rev[*a];
> C std says *always* evaluate from right to left for = operators, so this
> will always make perfect sense.
Yes, this should make perfect sense, but I fear the spec talks about
operand used twice, once with side-efect generaly. So to be ANSI C
correct, it's not good.

-------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
