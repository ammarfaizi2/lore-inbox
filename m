Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRL1WJc>; Fri, 28 Dec 2001 17:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281863AbRL1WJO>; Fri, 28 Dec 2001 17:09:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281691AbRL1WJE>; Fri, 28 Dec 2001 17:09:04 -0500
Date: Fri, 28 Dec 2001 14:06:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <E16K1fn-0001Ky-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112281400460.23445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Alan Cox wrote:
>
> > So if somebody really wants to help this, make scripts that generate
> > config files AND Configure.help files from a distributed set. And once you
> > do that, you could even imagine creating the old-style config files
>
> Something like:
>
> 	find $TOPDIR -name "*.cf" -exec cat {} \; > Configure.help

For old tools..

> or changing the tools to look for
>
> 	Documentation/Configure/CONFIG_SMALL_BANANA

"small banana"? Freud would go wild.

But no. I don't want it under the Documentation directory: I'd much rather
have them _together_ with the config file.

So the config file format could be something that includes the docs, and
you could do something like

	find . -name '*.cf' -exec grep '^+' {} \; > Configure.help

for old tools, and nw tools would just automatically get the docs from the
same place they get the config info.

And there would _never_ be more than a few entries per config file: you
can imagine having a separate config file for PCI 100Mbps ethernet drivers
and one for ISA drivers.

The current Configure.help is 25k _lines_, and over a megabyte in size. I
would never consider that good taste in programming, why should I consider
it good in documentation?

		Linus

