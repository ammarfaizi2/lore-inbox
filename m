Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271623AbRHUJs2>; Tue, 21 Aug 2001 05:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271624AbRHUJsT>; Tue, 21 Aug 2001 05:48:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46098 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S271623AbRHUJsI>; Tue, 21 Aug 2001 05:48:08 -0400
Message-ID: <3B822D2E.69D4380A@evision-ventures.com>
Date: Tue, 21 Aug 2001 11:43:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Theodore Tso <tytso@mit.edu>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan Adolfsson <johan.adolfsson@axis.com>,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
		<2248596630.998319423@[10.132.112.53]>
		<3B811DD6.9648BE0E@evision-ventures.com>
		<20010820211107.A20957@thunk.org> <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Theodore Tso writes:
> > On Mon, Aug 20, 2001 at 04:25:26PM +0200, Martin Dalecki wrote:
> > >
> > > The primary reson of invention of /dev/random was the need
> > > for a bit of salt to the initial packet sequence number inside
> > > the networking code in linux. And for this purspose the
> > > whole /dev/*random stuff is INDEED a gratitious overdesign.
> > > For anything else crypto related it just doesn't cut the corner.
> >
> > A number of other people helped me with the design and development of
> > the /dev/random driver, including one of the primary authors of the
> > random number generation routines in PGP 2.x and 5.0.  Most folks feel
> > that it does a good job.
> 
> Indeed. If Martin has some deep insight as to why the /dev/random
> implementation is insufficient for strong crypto, I'd like to hear
> it.

I don't think that it's unsufficient. In fact I think that it just
doesn't
have to be done all inside the kernel. And I oppose further extending
the
places where the event gathering code goes in between.

BTW> There is one strong flaw in the resoning behing this whole entropy
stuff.

Iff you trust the cryptographic algorithm for the one way function you
are
using then if you initialize it once - there will be only one chance for
an attacker to tamper with the values. The possibility
for tampering with it will have a certain value, which remains CONSTANT
over
the time. You could call it: breaking risk as well.

If you continuously reinitialize your one way function, the propabilitie
to
tamper with them will ADD (of course not in pure arithmetic terms). An
attacer simply
get's multiple chances. And therefore the overall propability of
tampering 
with the values delivered to the user by this device WILL INCREASE.

Multiple initializations help only against cryptographic attacks - but
THEY HURT
overall security of the system, becouse they "open it up".

So this is indeed a serious FLAW inside the logics behind the
implementation of this device.
