Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281899AbRKUOyP>; Wed, 21 Nov 2001 09:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUOx6>; Wed, 21 Nov 2001 09:53:58 -0500
Received: from [195.66.192.167] ([195.66.192.167]:55560 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281255AbRKUOxe>; Wed, 21 Nov 2001 09:53:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Richard B. Johnson" <root@chaos.analogic.com>, Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Date: Wed, 21 Nov 2001 16:52:53 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <01112116525300.02798@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 November 2001 14:12, Richard B. Johnson wrote:
> On Wed, 21 Nov 2001, Jan Hudec wrote:
> > > >     *a++ = byte_rev[*a]
> > >
> > > It looks perferctly okay to me. Anyway, whenever would you listen to a
> > > C++ book talking about good C coding :p
>
> It's simple. If any object is modified twice without an intervening
> sequence point, the results are undefined. The sequence-point in
>
> 	*a++ = byte_rev[*a];
>
> ... is the ';'.
>
> So, we look at 'a' and see if it's modified twice. It isn't. It
> gets modified once with '++'. Now we look at the object to which
> 'a' points. Is it modified twice? No, it's read once in [*a], and
> written once in "*a++ =".

The question is, byte_rev[*a] gets fetched before or after a is ++'ed?
As you may see from the length of this thread, one has to think
too much on this tiny piece of code and nevertheless can get it wrong.

Let's change code to be obvious:

*a = byte_rev[*a]; a++;

and noone will have to waste his/her time re-checking validity of it
(or worse, figuring out why kernel breaks with new GCC).
--
vda
