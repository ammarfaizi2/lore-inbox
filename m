Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287625AbSAPVJM>; Wed, 16 Jan 2002 16:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSAPVHo>; Wed, 16 Jan 2002 16:07:44 -0500
Received: from femail9.sdc1.sfba.home.com ([24.0.95.89]:57843 "EHLO
	femail9.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287591AbSAPVH0>; Wed, 16 Jan 2002 16:07:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Wed, 16 Jan 2002 08:05:22 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20020116074700.IUTL28557.femail14.sdc1.sfba.home.com@there> <83880343.1011191608@[10.132.113.67]>
In-Reply-To: <83880343.1011191608@[10.132.113.67]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116210725.AOD5017.femail9.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 January 2002 09:33 am, Alex Bligh - linux-kernel wrote:

> IE is the minimum amount of automation to simulate typing the thing
> into google. (the advantage of doing this over using google
> alone is that X may not be working at this stage and lynx
> might daunt Aunt Tillie).

So you're advocating feeding random stuff from the internet directly to end 
users without any sturgeon's law filter at all, and this is an improvement 
over automated probing of mostly standards-compliant busses for known 
hardware?

> Obviously you will need some magic tag at the top of a config
> file to make it easilly identifiable to search engines. And no
> doubt some fools will fill files with crap.

I was specifically thinking Microsoft, actually.  And every script kiddie in 
existence who thinks screwing up the linux automated install gives them 31337 
status.  (A new reason to crack webservers: add links to poison the google 
cache.  Sigh...)

> > So no-name assembled white boxes from e-machines and stuff wouldn't be
> > supported?
>
> Correct; I'm sure the probing configurator has a place too.

I'm all for having a "known strange" list.  Eric volunteered to maintain one 
in regards to DMI, which is sort of per-motherboard anyway.

But I tend to lean in favor of a having a maintainer for a database people 
contribute exceptions to.  Which basically means we might as well just make 
the autoprober smarter via an exception list...

> > Have you TRIED the current auto-configurator?
>
> No, to be honest. However, now you have set me the challenge, I'll
> report back on how well or otherwise it works.

At the moment, "make autoprobe" is a really nice tool for setting 99% of the 
questions in "make menuconfig" to the correct answers.

However, it's also a great tool for squeezing obscure bugs out of the 
database like the fact if you DO switch on a PCMCIA network card that doesn't 
automatically switch on CONFIG_NET.  (Missing dependency, not yet in 2.1.3.  
One of the four questions it gets wrong about my laptop.  Out of a hundred 
and something, that's not bad...)

As a result "make autoconfigure" generally needs a couple of switches 
manually flipped before you get the config you want.  (But we're working on 
it.  More boxes to probe is always a good thing...  Send the results to Eric. 
 Or me, since Eric will be on the road this weekend.  Or that Gicacamo 
Catanazi dude, whose name I am highly unlikely to have spelled correctly 
because the deck is stacked against me here.)

> > Assuming every IBM T23 has the same hardware in it, which oddly enough is
> > a  bit of a gamble.  (OK, IBM is better at this than Dell, largely due to
> > inventory management reasons.)  And assuming the finite number of
> > database  maintainers has yet bought an IBM T23, and that the rest of the
> > world can  wait until then.
>
> Well, you'd wait until either your distro vendor had done one, or
> someone else had posted one and it had reached search-engine
> du-jour.

Sure.  If you want your distribution vendor to build your kernel for you, 
that's great.  We're just trying to give you another option.

> > Giacamo and Eric started work on the autoprobe as a way to reduce the
> > number  of questions the configurator showed people by eliminating
> > hardware that they  provably do not have, and defaulting the stuff they
> > DO have to on.  But it  turns out that on any relatively recent machine,
> > it's an easy enough problem  that you can autoprobe EVERYTHING and build
> > straight from that.  So the Linux  kernel could finally do "configure;
> > make; make install".
> >
> > I consider that a neat hack.
>
> Sure I agree, if it works; my speculation is that it doesn't, if one
> boots with a default vendor kernel, on many machines.

Right now, you're right.  It ALMOST works, but the bugs are still being 
squeezed out.  And about half the bugs are in the configuration rulebase 
rather than in the autoprober.  (It's amazing how many bad combinations CML1 
would allow you to do.  Did you know if you accidentally turn off the 
networking menu in the old menuconfig, there's no way to get it back without 
editing the config file by hand?  Sigh...)

> I would love
> to be proved wrong, so rather than debate further here, I have another
> T23 to set up so I'll boot it up from scratch, run the configurator,
> and see what happens.

Please let me know how it breaks.  (No, I'm not going to say "if", I'm not 
that optimistic yet.  2.2.0 perhaps...)

Rob
