Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281893AbRKUO0q>; Wed, 21 Nov 2001 09:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKUO0j>; Wed, 21 Nov 2001 09:26:39 -0500
Received: from [195.157.147.30] ([195.157.147.30]:35090 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S281255AbRKUO0d>; Wed, 21 Nov 2001 09:26:33 -0500
Date: Wed, 21 Nov 2001 14:24:37 +0000
From: Sean Hunter <sean@uncarved.com>
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121142437.A24408@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>, Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01112112401703.01961@nemo> <3BFB9FAE.DB9B6003@dexterus.com> <20011121143738.D2196@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121143738.D2196@artax.karlin.mff.cuni.cz>; from bulb@ucw.cz on Wed, Nov 21, 2001 at 02:37:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The great thing about the C standard is that you don't have to know, or guess,
or remember.  I respectfully suggest that all of those who are interested in
this topic buy a copy of K&R Second Edition (ISBN 0-13-110370-9), and read
chapter 2, particularly section 2.12 "Precedence and order of Evaluation".

And take this facinating topic off-line.

Sean

On Wed, Nov 21, 2001 at 02:37:38PM +0100, Jan Hudec wrote:
> > >     *a++ = byte_rev[*a]
> > It looks perferctly okay to me. Anyway, whenever would you listen to a
> > C++ book talking about good C coding :p
> 
> AFAIK the ANSI C specification explicitely claims, that it's not defined.
> The trick is, that the specification explicitly allows the compiler to
> choose wether it does the inc/dec right after/before the fetch, or at the
> begin/end of evaluation. Thus the second reference to a might return the
> original or incremented value at compiler's will.
> 
> > Go read up on C operator precedence. Unary ++ comes before %, so if we
> > rewrite the #define to make it more "readable" it would be #define
> > MODINC(x,y) (x = (x+1) % y)
> 
> *NO* 
> MODINC(x,y) (x = (x+1) % y)
> is correct and beaves as expected. Unfortunately:
> MODINC(x,y) (x = x++ % y)
> is a nonsence, because the evaluation is something like this
> x++ returns x
> x++ % y returns x % y
> x is assigned the result and it's incremented IN UNDEFINED ORDER!!!
> AFAIK the ANSI C spec explicitly undefines the order.
> 
> > >     *a++ = byte_rev[*a];
> > C std says *always* evaluate from right to left for = operators, so this
> > will always make perfect sense.
> Yes, this should make perfect sense, but I fear the spec talks about
> operand used twice, once with side-efect generaly. So to be ANSI C
> correct, it's not good.
> 
> -------------------------------------------------------------------------------
>                   				- Jan Hudec `Bulb' <bulb@ucw.cz>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
