Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281678AbRKUONg>; Wed, 21 Nov 2001 09:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKUONZ>; Wed, 21 Nov 2001 09:13:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52612 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281381AbRKUONL>; Wed, 21 Nov 2001 09:13:11 -0500
Date: Wed, 21 Nov 2001 09:12:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jan Hudec <bulb@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <20011121143738.D2196@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Jan Hudec wrote:

> > >     *a++ = byte_rev[*a]
> > It looks perferctly okay to me. Anyway, whenever would you listen to a
> > C++ book talking about good C coding :p
> 

It's simple. If any object is modified twice without an intervening
sequence point, the results are undefined. The sequence-point in

	*a++ = byte_rev[*a];

... is the ';'.

So, we look at 'a' and see if it's modified twice. It isn't. It
gets modified once with '++'. Now we look at the object to which
'a' points. Is it modified twice? No, it's read once in [*a], and
written once in "*a++ =".

So, it's perfectly good code with a well defined behavior as far as
'C' is concerned. I think it is ugly, however, the writer probably
thought it was beautiful. If somebody went around and fixed all
the ugly code, it would still be ugly in someone else's eyes.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


