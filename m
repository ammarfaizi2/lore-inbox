Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUGGME0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUGGME0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGGME0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:04:26 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19914 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265084AbUGGMEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:04:11 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: root@chaos.analogic.com, tom st denis <tomstdenis@yahoo.com>
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
Date: Wed, 7 Jul 2004 14:13:18 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040707111028.82649.qmail@web41111.mail.yahoo.com> <Pine.LNX.4.53.0407070715380.17430@chaos>
In-Reply-To: <Pine.LNX.4.53.0407070715380.17430@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407071413.18608.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 of July 2004 13:18, Richard B. Johnson wrote:
> On Wed, 7 Jul 2004, tom st denis wrote:
> > --- viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > On Tue, Jul 06, 2004 at 05:06:12PM -0700, tom st denis wrote:
> > > > --- David Eger <eger@havoc.gtf.org> wrote:
> > > > > Is there a reason to add the 'L' to such a 32-bit constant like
> > >
> > > this?
> > >
> > > > > There doesn't seem a great rhyme to it in the headers...
> > > >
> > > > IIRC it should have the L [probably UL instead] since numerical
> > > > constants are of type ``int'' by default.
> > > >
> > > > Normally this isn't a problem since int == long on most platforms
> > >
> > > that
> > >
> > > > run Linux.  However, by the standard 0xdeadbeef is not a valid
> > >
> > > unsigned
> > >
> > > > long constant.
> > >
> > > ... and that would be your F for C101.  Suggested remedial reading
> > > before
> > > you take the test again: any textbook on C, section describing
> > > integer
> > > constants; alternatively, you can look it up in any revision of C
> > > standard.
> > > Pay attention to difference in the set of acceptable types for
> > > decimal
> > > and heaxdecimal constants.
> >
> > You're f'ing kidding me right?  Dude, I write portable ISO C source
> > code for a living.  My code has been built on dozens and dozens of
> > platforms **WITHOUT** changes.  I know what I'm talking about.
> >
> > 0x01, 1 are 01 all **int** constants.
> >
> > On some platforms 0xdeadbeef may be a valid int, in most cases the
> > compiler won't diagnostic it.  splint thought it was worth mentioning
> > which is why I replied.
> >
> > In fact GCC has odd behaviour.  It will diagnostic
> >
> > char x = 0xFF;
> >
> > and
> >
> > int x = 0xFFFFFFFFULL;
> >
> > But not
> >
> > int x = 0xFFFFFFFF;
> >
> > [with --std=c99 -pedantic -O2 -Wall -W]
> >
> > So I'd say it thinks that all of the constants are "int".  In this case
> > 0xFF is greater than 127 [max for char] and 0xFFFFFFFFFFULL is larger
> > than max for int.  in the 3rd case the expression is converted
> > implicitly to int before the assignment is performed which is why there
> > is no warning.
> >
> > Before you step down to belittle others I'd suggest you actually make
> > sure you're right.
> >
> > Tom
>
> Tom is correct. A literal constant defaults to 'int'.

Anyway, I think it's a good idea to put L wherever a constant is meant to be 
'long' and U wherever it's meant to be 'unsigned' etc., because it may be 
useful in debigging, eg.:

1) identifying wrong types being used (eg. int vs long, int vs unsigned, long 
vs unsigned long),
2) identifying typos (eg. 0x100000000 vs 0x10000000)

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
