Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283672AbRL1WZC>; Fri, 28 Dec 2001 17:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRL1WYw>; Fri, 28 Dec 2001 17:24:52 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41435
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S282941AbRL1WYp>; Fri, 28 Dec 2001 17:24:45 -0500
Date: Fri, 28 Dec 2001 17:08:40 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011228170840.A20254@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16K1fn-0001Ky-00@the-village.bc.nu> <Pine.LNX.4.33.0112281400460.23445-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112281400460.23445-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 02:06:25PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>:
> So the config file format could be something that includes the docs, and
> you could do something like
> 
> 	find . -name '*.cf' -exec grep '^+' {} \; > Configure.help
> 
> for old tools, and nw tools would just automatically get the docs from the
> same place they get the config info.

OK.  Background, for anyone who doesn't know this: the equivalent of 
Configure.help in CML2 is the symbols.cml file.  It's actually generated
fat CML2 installation time from Configure.help.

Here's what a sample entry looks like in Configure.help form:

Support the foo feature
CONFIG_FOO
  This is a sample help entry.

Here's the same entry in CML2 format:

FOO	"Support the foo feature" text
This is a sample help entry.
.

Now.  It would be dead easy to split symbols.cml into bunch of little
files and distribute them through the source tree.  It would be just as
easy to write a script to reassemble Configure.help, but there won't be
any reason to do it.  Once CML2 goes in, nothing will use Configure.help

> The current Configure.help is 25k _lines_, and over a megabyte in size. I
> would never consider that good taste in programming, why should I consider
> it good in documentation?

Um...because the cases aren't parallel?

What makes megabyte-large blocks of code bad is that they tend to be
tangled messes with unmaintainable reference and control structures.
Configure.help isn't; the entries are atoms that don't interact with
each other.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

We shall not cease from exploration, and the end of all our exploring will be
to arrive where we started and know the place for the first time.
	-- T.S. Eliot
