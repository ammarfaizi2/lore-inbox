Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSIJXKK>; Tue, 10 Sep 2002 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSIJXKK>; Tue, 10 Sep 2002 19:10:10 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1257 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318211AbSIJXKJ>;
	Tue, 10 Sep 2002 19:10:09 -0400
Date: Tue, 10 Sep 2002 16:14:24 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020910231424.GA30612@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote :
> >...
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >...
> >   o more irda __FUNCTION__ stuff
> >...
> 
> This adds the use of TIOCM_MODEM_BITS to irtty.c but not the corresponding
> addition of it to asm-i386/termios.h:

	I would personally would have veto'ed that change, because it
will work only on i386 (and PA-Risc), whereas the IrDA stack is
routinely used on ARM and PPC and also work on Alpha.
	That's the kind of shortsighted quick hack that make life
painfull for everybody, because we now have to fix a dozen
platforms. Last time I heard, 2.4.X was supposed to be the "stable"
kernel.
	I would personally perfer the header to define a "default"
value, and only the broken architecture would need to override it
(#undef + #define).
	Actually, the previous solution of having the cruft hidden in
the irtty driver with #ifdef and not poluting the generic kernel was
also pretty good IMHO, and I don't understand why the original author
didn't go along those lines (sure he didn't told me why).

	Of course, I'm opiniated...

	So, as people like quick'n'dirty hacks, just make sure that
TIOCM_MODEM_BITS is also defined in ARM, SH, PPC and Alpha (at least),
just to make sure I'm the only one complaining.

	Thanks in advance...

	Jean
