Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSF2HTa>; Sat, 29 Jun 2002 03:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSF2HTa>; Sat, 29 Jun 2002 03:19:30 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:53002 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317152AbSF2HT3>;
	Sat, 29 Jun 2002 03:19:29 -0400
Date: Sat, 29 Jun 2002 09:26:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree
Message-ID: <20020629092601.A2019@mars.ravnborg.org>
References: <20020628192807.A2142@mars.ravnborg.org> <5050.1025315441@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5050.1025315441@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Jun 29, 2002 at 11:50:41AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2002 at 11:50:41AM +1000, Keith Owens wrote:
> What happens when you want to support multiple source trees?
Nothing!

> Your
> approach prevents the use of multiple source trees, either shadow or
> separate (add on) code and breaks kbuild 2.5.  My approach puts all the
> complexity (once) in the makefile, not replicated over multiple CML
> programs.
Could you please go read the patch..
There is NO change in functionality in the config tools, the only
thing that is added is the possibility to tell the config tools that
the src is located somewhere else than current directory - the same
for the output files.

> What happens when the config data is not in monolithic files but is
> supplied in per-driver files (driver.inf)?  Linus wants that feature
> eventually.  Note that driver.inf will contain more than just config
> data, it will contain all the data required to build a driver.  With
> your approach every CML program would have to be changed to understand
> the format of the driver.inf files, replicating the code over multiple
> parsers.  With my approach you need one program that extracts the
> relevant data for config and builds the config tree, then the existing
> CML programs run unchanged.
So what you actually try to say is that the better approach is to
copy files to a common place, eventually extracted from different
source trees and eventually extracted from driver.inf files.

So this is where we disagree:
Every CML program
-----------------
There are 3 CML programs within the kernel tree (Configure, menuconfig
and xconfig). To me the best thing that could happen was that they
disappeared, being replaced by a single config tool - that provided
the same type of interfaces. This tools we could extend to do a little
more semantic checks etc.
There exist several not-in-the-tree config tools, and they just have
to adapt. No-one told them they could rely on current behaviour
forever.
I hope that one of the existing out-of-tree tools (mconfig, llc, autoconf,
CML2, GCML2 - others?) one day will get mature enough to replace the
existing tools.

driver.inf / driver.conf
------------------------
One could extract the information before running the config tool,
or one could let the config tool do the job.
I prefer the latter since I see no point in having to put knowledge
of the driver.inf format in more than one place.

Create a shadow structure for config tools to use
-------------------------------------------------
The only sole reason why kbuild.2-5 needs to create a shadow tree
of all the config related files is simply that you have decided
what you consider the best way to support shadow trees are.
So in our discussion about shadow-tress I recall you mentioned 
several times that using a built-only tree of src-files would create
a lot of problems when changes were made, and you had to distribute
changes back in the original trees.
My point then was that changes were always made in the original tree.
And now I see that you use the exact same apporach for config-files
within kbuild-2.5. So do you agree that creating a built-only tree
suddenly becomes an OK solution?

I disagree with the approach you have chosen to support shadow trees.
I have stated before that your approach with intiminate knowledge
of shadow trees built-in to kbuild resulted in too much complexity.
This is a good example of such complexity, that a tree needs to be
built only with the purpose to support the config tools.

Therefor I see a good point optimizing the current config tools
to current kbuild. I see no point in keeping the current behaviour
if this is only for the sake of kbuild-2.5.

	Sam
