Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSESKn6>; Sun, 19 May 2002 06:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314321AbSESKn5>; Sun, 19 May 2002 06:43:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:36870 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S314291AbSESKn4>;
	Sun, 19 May 2002 06:43:56 -0400
Date: Sun, 19 May 2002 12:45:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@suse.de>, Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Drivers.conf and kbuild-2.5 [Was: kbuild 2.5 is ready ...]
Message-ID: <20020519124510.A9033@mars.ravnborg.org>
In-Reply-To: <Pine.LNX.4.44.0205172157540.4117-100000@xanadu.home> <15163.1021688371@ocs3.intra.ocs.com.au> <20020519001434.A4153@mars.ravnborg.org> <20020519003546.D15417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 12:35:46AM +0200, Dave Jones wrote:
>  > Does it make sense to introduce limited support for the drivers.conf idea
>  > in kbuild-2.5 already now?
> 
> kbuild-2.5 is big enough to already be a problem to be accepted
> 'all in one go'. Adding driver.conf support will just make this problem
> bigger. What Keith has already needs to somehow be done gradually.
> 
> How this happens isn't exactly obvious to me however. Due to the way
> things like dependancy calculation have changed, you can't for example
> do the merging on a per-directory basis and say "drivers this time",
> "now the filesystems" etc..
Thats why I tried to identify areas that could be merged even before
kbuild-2.5 got merged.
o "make dep" changes in for example split-include
o install target in config.in for i386
o asm-offset functionality for i386
o kwhich

I see no way to split the core part in smaller parts. It does not make sense
to merge only half of this for example.
The rest of the patch is a huge amount of makefile.in files, and some other
related files.
The patch as such could be splitted in several different ways, but again
it would not make sense to merge that gradually over time.

> Don't confuse the build system with the configuration system.
> Whilst they are somewhat intertwined, they are not dependant on each other.
I do not mix up the purpose of the two systems, but suggesting the
drivers.conf concept makes both systems rely on information in the same file.
Therefore I suggested a two step approach:
1) Let kbuild understand and accept the drivers.conf concept gradually
2) Let the configuration system accept the Drivers.conf concept gradually
With gradually I expect it to be on a directory basis.

>  > IMHO it would also be plain stupid to put a lot of effort in
>  > supporting the old makefile syntax, when the files are already converted.
> 
> That effort has already been done. kbuild2.5 can live alongside the
> existing build system.
What exists now is two parrallel systems. This has the negative effect that 
it fails to show how much old cruft can be removed from the kernel upon 
acceptance of kbuild-2.5. As it is now kbuild-2.5 either modify some
existing files or add some new files.

It would be nice to see how much could be cleaned up from the kernel
upon acceptance of kbuild-2.5.
The makefiles that can be removed alone counts ~2700 lines.

	Sam

