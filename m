Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbSI1Wnl>; Sat, 28 Sep 2002 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbSI1Wnl>; Sat, 28 Sep 2002 18:43:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13324 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262342AbSI1Wnk>;
	Sat, 28 Sep 2002 18:43:40 -0400
Date: Sun, 29 Sep 2002 00:48:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.7
Message-ID: <20020929004821.A11497@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0209281529580.338-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209281529580.338-100000@serv>; from zippel@linux-m68k.org on Sat, Sep 28, 2002 at 04:25:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 04:25:43PM +0200, Roman Zippel wrote:
> Hi,
> 
> At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of the
> new config system.
Played with 0.7.1 just a little. Looks good so far.

1) Old tools zapped <file:> tags around filenames.

> An issue (which was also mentioned by Jeff Garzik) is the help text
> format. Jeff likes to have an endhelp, where I think it's redundant.
2) The current way forces the layout of the help text. I would prefer a way
that allowed the tools to use the space available instead.
Then a "." followed by newline could be interpreted as "forced-new-line"
or similar.
If endhelp is needed for that I vote for this as well.

3) The syntax seems to be:
config SYMBOL
	type-of-symbol optional-text
I would like "optional-text" to become mandatory. Then you could bail out
with an error when it does not exist.
An empty string should be legal "", to cope with symbols not having any
associated text today.
4) Did not find the documentation you mentioned, but on the other hand I
applied only the 2.3.39 diff.


Minor details:

5) Show All intuitively is a shortcut for selecting all the three
possibilities {NAME, RANGE, DATA}, but is about showing all symbols.
6) The ARCH specific options does not fit well into the tree.
GENERIC_ISA_DMA in top of tree, X86_SMP in bottom of tree.
Visible only with SHOW ALL enabled.
7) I can step down in the tree but I need to select each sibling in the tree
induvidially. I expected to be able to select Cirrus logic under ALSA, and
let the selection boil up to the top.
8) File|Save followed by File|Quit. Still it ask if I want to save, even
no changes made inbetween.


9) Renames a file in a source statement:
[sam@mars lkc-2.5.39]$ make xconfig
make[1]: `qconf' is up to date.
./scripts/lkc/qconf arch/i386/Build.conf
can't find file ssound/arm/Build.conf
make: *** [xconfig] Error 1

Error shall tell where the file is sourced. [.../Build.conf:27]

10) Deleted endmenu tag in sound/Build.conf:
[sam@mars lkc-2.5.39]$ make xconfig
make[1]: `qconf' is up to date.
./scripts/lkc/qconf arch/i386/Build.conf
<none>:0:parse error, unexpected $
make: *** [xconfig] Error 1

Some errorhandling needs to be improved a little.


	Sam

