Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDFJkQ>; Fri, 6 Apr 2001 05:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRDFJkH>; Fri, 6 Apr 2001 05:40:07 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:35494
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S131407AbRDFJj7>; Fri, 6 Apr 2001 05:39:59 -0400
Message-ID: <3ACD8ECC.F2518B90@math.ethz.ch>
Date: Fri, 06 Apr 2001 11:39:24 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Johan Adolfsson <johan.adolfsson@axis.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Arch specific/multiple Configure.help files?
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch> <018001c0be69$90dcb200$9db270d5@homeip.net> <3ACD73E0.2B1DFF6F@math.ethz.ch> <19da01c0be78$f9106c90$0a070d0a@axis.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson wrote:
> 
> > - IIRC there is only few ARCH specific configuration, thus we
> > don't
> >   reduce the size of che Configure.help
> >   Note that the arch/config.in have to much configuration item
> >   (but they repeat in (nearly) all arch/config.in files, thus
> > you
> >   should count only the really arch specific item.
> 
> Here are some results:
> $ wc arch/cris/Configure.help
>     621    4424   28373 arch/cris/Configure.help
> $ wc Documentation/Configure.help
>   17480  121037  773694 Documentation/Configure.help
> $ grep CONFIG arch/cris/Configure.help |wc
>      75     138    2337
> $ grep CONFIG Documentation/Configure.help |wc
>    1486    1640   30135
> 
> it's not entiraly correct since the CONFIG_BLUETOOTH help
> is in the arch/cris directory and that should probably be in
> Documentation/ or in the OpenBT package and merged from there.
> The file also contains the # LocalWords: rows from the original
> Configure.help.
> 
> But the ETRAX/CRIS config is 3-5% of the total config.

This seem too much. If all arch have a so big CONFIG space, I
think that your idea can do some improvement.
But: user don't see the difference. Do you think that
developers
would like your proposal? (If arch maintainers agree, you can
try to publish your patch)

> 
> Having the help close to the config sounds like a good idea
> from a maintenance point of view.

But in 2.5.x the config.in are centralized, thus also
Configure.help sould be centralized.
And in this case I think that a big file hurts nobody.

> > > > ESR CML2 have the defualt path for Configure.help build in
> > > > the rules files, but it can be overriden by command options
> > > > to use an other Configure.help (the format do not change).
> > >
> > > I want to be able to use two help files.
> >
> > I think it is not a big issue. In Makefile we can
> > : cat Conf.help.1 Conf.help2 > .Conf.help
> 
> Sounds better than dealing with two different help files in the
> config system.
> Is there an ETA when ESR CML2 will be in the official kernel?
> (I guess I should catch up on what it will provide instead of
>  wasting peoples time...)

In 2.5.2 kernel. What We don't know is when 2.5.2 will be
released!

> 
> Would adding support for merging help files in the current config
> system be accepted in the meanwhile?

In 2.4: No. Distribution expect a stable interface.
In 2.5 will be the new CML2.
Again if arch maintainer agree with your proposal, you can
change
the CML2. Not so difficult (and you change only in one place
for all interfaces (olconfig/config/menuconfig/xconfig)

> E.g. Configure, Menuconfig and header.tk is changed to use
> Documentation/Configure.help.generated
> and the top Makefile does
> cat $(HELPFILES) >Documentation/Configure.help.generated 2>/dev/null
> for oldconfig, config, menuconfig and xconfig targets?
> And HELPFILES is set to:
> HELPFILES = arch/$(ARCH)/Configure.help Documentation/Configure.help
> 
> External patches that add functionality could easaly add
> HELPFILES += some new help files
> rows to get the help as well.

This change is too big for 2.4 kernel.

	giacomo
