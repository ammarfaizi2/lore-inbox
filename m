Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUGGLZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUGGLZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUGGLZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:25:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52868 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265074AbUGGLZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:25:23 -0400
Date: Wed, 7 Jul 2004 07:18:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: tom st denis <tomstdenis@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
In-Reply-To: <20040707111028.82649.qmail@web41111.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0407070715380.17430@chaos>
References: <20040707111028.82649.qmail@web41111.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, tom st denis wrote:

> --- viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Tue, Jul 06, 2004 at 05:06:12PM -0700, tom st denis wrote:
> > > --- David Eger <eger@havoc.gtf.org> wrote:
> > > > Is there a reason to add the 'L' to such a 32-bit constant like
> > this?
> > > > There doesn't seem a great rhyme to it in the headers...
> > >
> > > IIRC it should have the L [probably UL instead] since numerical
> > > constants are of type ``int'' by default.
> > >
> > > Normally this isn't a problem since int == long on most platforms
> > that
> > > run Linux.  However, by the standard 0xdeadbeef is not a valid
> > unsigned
> > > long constant.
> >
> > ... and that would be your F for C101.  Suggested remedial reading
> > before
> > you take the test again: any textbook on C, section describing
> > integer
> > constants; alternatively, you can look it up in any revision of C
> > standard.
> > Pay attention to difference in the set of acceptable types for
> > decimal
> > and heaxdecimal constants.
>
> You're f'ing kidding me right?  Dude, I write portable ISO C source
> code for a living.  My code has been built on dozens and dozens of
> platforms **WITHOUT** changes.  I know what I'm talking about.
>
> 0x01, 1 are 01 all **int** constants.
>
> On some platforms 0xdeadbeef may be a valid int, in most cases the
> compiler won't diagnostic it.  splint thought it was worth mentioning
> which is why I replied.
>
> In fact GCC has odd behaviour.  It will diagnostic
>
> char x = 0xFF;
>
> and
>
> int x = 0xFFFFFFFFULL;
>
> But not
>
> int x = 0xFFFFFFFF;
>
> [with --std=c99 -pedantic -O2 -Wall -W]
>
> So I'd say it thinks that all of the constants are "int".  In this case
> 0xFF is greater than 127 [max for char] and 0xFFFFFFFFFFULL is larger
> than max for int.  in the 3rd case the expression is converted
> implicitly to int before the assignment is performed which is why there
> is no warning.
>
> Before you step down to belittle others I'd suggest you actually make
> sure you're right.
>
> Tom
>

Tom is correct. A literal constant defaults to 'int'.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


