Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281900AbRKUPOO>; Wed, 21 Nov 2001 10:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281897AbRKUPOE>; Wed, 21 Nov 2001 10:14:04 -0500
Received: from [195.66.192.167] ([195.66.192.167]:19212 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281896AbRKUPNt>; Wed, 21 Nov 2001 10:13:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mathijs Mohlmann <mathijs@knoware.nl>, Jan Hudec <bulb@ucw.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Date: Wed, 21 Nov 2001 17:12:27 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011121145237.mathijs@knoware.nl>
In-Reply-To: <XFMail.20011121145237.mathijs@knoware.nl>
MIME-Version: 1.0
Message-Id: <01112117122701.02798@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 November 2001 13:52, Mathijs Mohlmann wrote:
> On 21-Nov-2001 Jan Hudec wrote:
> >> Go read up on C operator precedence. Unary ++ comes before %, so if we
> >> rewrite the #define to make it more "readable" it would be #define
> >> MODINC(x,y) (x = (x+1) % y)
> >
> > *NO*
> > MODINC(x,y) (x = (x+1) % y)
> > is correct and beaves as expected. Unfortunately:
> > MODINC(x,y) (x = x++ % y)
> > is a nonsence, because the evaluation is something like this
> > x++ returns x
> > x++ % y returns x % y
> > x is assigned the result and it's incremented IN UNDEFINED ORDER!!!
> > AFAIK the ANSI C spec explicitly undefines the order.
>
> in fact, gcc does (according to my tests):
> MODINC(x,y) (x = (x % y) + 1)

drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)

Alan, can you clarify what this macro is doing?
What about making it less confusing?
--
vda
