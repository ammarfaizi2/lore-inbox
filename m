Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBRHTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBRHTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:19:39 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:896 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262838AbUBRHTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:19:24 -0500
Date: Wed, 18 Feb 2004 08:19:18 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Judith Lebzelter <judith@osdl.org>
Cc: wookie@osdl.org, cherry@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
Message-ID: <20040218071918.GA4257@MAIL.13thfloor.at>
Mail-Followup-To: Judith Lebzelter <judith@osdl.org>,
	wookie@osdl.org, cherry@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0402171329200.24135-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0402171329200.24135-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judith!

On Tue, Feb 17, 2004 at 01:51:19PM -0800, Judith Lebzelter wrote:
> > tried that one for vs1.20 (2.4.21,2.4.22,2.4.23) was
> > a little inflexible, but I didn't understand the results:
> >
> > PPC-Cross Compile Regress 447 warnings, 21 errors PASS?
> 
> The Compile Regress is John Cherry's filter which we run through plm,
> and I include with the plm package.  The 'PASS' status is based only
> on the main compiles, due to the fact that some for the compiles of the
> 'defconfig', 'allnoconfig', 'allyesconfig' and 'allmodconfig'.  It also
> goes though the directories and compiles the objects individually, but
> this does contribute to fail the test.
> 
> There is a -s option to only run 'defconfig' and 'allmodconfig' in the
> newer versions of this script.
> 
> > and what I would need is the following:
> >
> >  - vanilla kernel + config which compiles for arch X
> >  - vanilla kernel + vserver patches + same config
> >    which is tested for arch X
> >  - differences in the warnings/errors to the default
> >    (vanilla) build
> >  - ability to check a 'special' config
> 
> PLM is as application for tracking base releases and patches to the
> release, on which you can configure 'filters' to run and store the
> results.  Each architecture or type of config you want to check could be
> set up as an individual filter.  The kconfig files I use are generally
> part of the specific filter which I've set up.

okay, sounds basically useful ...

> The source trees (base + patches) are then also easily available to other
> plm clients.  In our case STP.
> 
> > > Basically, the farm here at OSDL auto-builds
> > > - each release
> > > - a daily BK snapshot ( from kernel.org )
> > > - each new tree from a few maintainers ( -mm, -ac, -mjb, -osdl )
> >
> > currently there are three linux-vserver branches,
> > stable (2.4), devel (2.4) and experimental (2.6)
> > very soon the experimental branch will become the
> > devel branch, and the devel branch the last stable
> > for (2.4) devel and stable will move on to 2.6 then
> >
> > > We do some cross compiles, using Dan Kegel's fine tools.
> >
> > tried those, but decided not to use them, as they require
> > building the (g)libc which isN#t required for kernel
> > builds at all ...
> >
> > > Several things you/we could do:
> > > - You could of course use our stuff to run your compilie farm, we're
> > > 	always glad to help. :)
> >
> > okay, how could this be done, and what would be my part
> > especially:
> >
> >  - how to add new patches/releases/branches
> >  - how to activate a testbuild for a kernel/patch
> >    combination
> >  - how to use it 'just' for a test, to detect and
> >    correct build errors (the main purpose)
> >
> 
> To use our PLM:
>    *  We would need to build the cross-compilers here on our compile farm.
>       The cross-compilers would need to be built in an easily reproduced
>       manner--to be installed on multiple machines and easily re-built

thought so, that was also my concern in the first place
(see details below)

>    *  Design/edit filters to suit your purpose with a reasonably short
>       run time.  We would set them up in PLM.
>    *  Patch submission is through the PLM web interface:
>             https://www.osdl.org/plm-cgi/plm?module=addpatch
>       You just upload a text diff file.
>    *  The results are summarised in the output of the filter which you set
>       up and available online.

basically the only missing feature would be building the
differences between a 'vanilla' build run and a vserver
kernel build run, which I think could be done via the
web interface or, if this is interesting for you too,
as addition to the PLM ...

> To Set up your own PLM:
>    *  You could use our PLM software to set up your own automated
>       source/filter tracking system.
>           Home:  http://developer.osdl.org/dev/plm/
>           Download:  http://sourceforge.net/projects/plm
>    *  There is a script to build an rpm in the source.   There are some
>       admin tools to set-up filters, which you grab from a web server.
>    *  It runs on a MySQL database.
>    *  You design/edit filters to suit exactly your purpose.

that would wbe an option, maybe for testing purposes
but as many people pointed out, not as useful ...

> > > - we always need help with the project. Mailing list is
> > >       plm-devel@lists.sourceforge.net.
> >
> > how could I help?
> 
> We are planning quite a few updates to PLM soon, including creating base
> patches from CVS and bk pulls, Storing build information with the patch
> sets,  Improving the installation scripts, etc.
> 
> If the tool doesn't do all you would like any input would be great too.
> It sounds like maybe a page to display all the recent results of a
> particular filter (ie sparc64_default_compile) would be nice.
> 
> >
> > > - we're planning on expanding the number of arch's we cross-compile for,
> > > 	x86_64 and ppc64 are the next two probable targets. We probably
> > > 	wouldn't want to add a lot of other archs doing large compiles,
> > > 	but if you have a simple target, we can add quite a few.
> >
> > currently my cross compile toolchains support the
> > following archs:
> >
> >   alpha arm cris hppa hppa64 i386 ia64 m68k mips mips64
> >   ppc ppc64 s390 sh sh64 sparc sparc64 v850 x86_64
> 
> A very impressive list. :) Do you have automated scripts for setting up
> your toolchains on other systems? Like ours?

sure, made them available some time ago, you can get
the spec files and patches for binutils and gcc at 

 http://vserver.13thfloor.at/Stuff/Cross/

I'm currently building Dan's toolschains (or better
working on it, as they refuse to compile with my gcc,
which I have to admit, is a little outdated) to
compare my toolchains (gcc) with them, because it was
mentioned that building gcc the way I do it, would
introduce subtle compiler bugs, which I want to verify 

of course they can be built without RPMs too, but that
was the simplest way for me atm ...

> > the 'defconfig' only works for a subset of those and
> > some arch have even troubles building without heavy
> > patches ...
> >
> > so planning sounds good, but we are already supporting
> >   alpha, hppa64, i386, s390, sparc/64 and x86_64
> 
> Nobody had shown much interest in the others, so we set our
> priorities...

okay *showing interest* in at least the vserver 
supported platforms alpha, hppa64, s390, sparc/64
and x86_64 (ia32/64 and ppc/64 are already supported)

TIA,
Herbert

> Thanks;
> Judith Lebzelter
> OSDL
> 
> >
> > > ( we noticed you are doing a defconfig. We've done separate config
> > > files for those builds, to reduce time )
> >
> > sounds like a reasonable approach ...
> >
> > > hope to hear from you
> > > cliffw
> >
> > TIA,
> > Herbert
> >
> > > > TIA,
> > > > Herbert
> > > >
> > > > > Tim
> > > > >
> > > > > On Fri, 2004-02-13 at 12:57, Herbert Poetzl wrote:
> > > > > > Hi Folks!
> > > > > >
> > > > > > I'm currently investigating the requirements/doability
> > > > > > of a kernel cross compiling test bed/setup, able to do
> > > > > > automated kernel builds for different architecture,
> > > > > > just to see if it compiles and later to verify if a
> > > > > > given patch breaks that compile on any of the tested
> > > > > > archs ...
> > > > > >
> > > > > > here a short status, and some issues I ran into so far,
> > > > > > some of them with solutions, others without, and some
> > > > > > interesting? observations ...
> > > > > >
> > > > > > I would be happy if somebody who has done similar, or
> > > > > > knows how to do it properly ;) could comment on that,
> > > > > > and/or point out possible improvements ...
> > > > > >
> > > > > > TIA,
> > > > > > Herbert
> > > > > >
> > > > > >
> > > > > > 1) CROSS COMPILER / TOOLCHAIN
> > > > > >
> > > > > >    after reading and testing several cross build and
> > > > > >    toolchain building howtos, I decided to do it a little
> > > > > >    different, because I do not need glibc to compile the
> > > > > >    kernel ...
> > > > > >
> > > > > >    the result are two .spec files[1], or the commands
> > > > > >    used to build an appropriate toolchain ...
> > > > > >
> > > > > >    for the binutils the required commands are:
> > > > > >
> > > > > >    	configure  	    	    	    	    	\
> > > > > > 		--disable-nls                           \
> > > > > > 		--prefix=/usr                           \
> > > > > > 		--mandir=/usr/share/man                 \
> > > > > > 		--infodir=/usr/share/info               \
> > > > > > 		--target=${CROSS_ARCH}-linux
> > > > > >    	make
> > > > > >
> > > > > >    and for the gcc (after the binutils have been
> > > > > >    installed on the host):
> > > > > >
> > > > > >    	configure  	    	    	    	    	\
> > > > > > 		--enable-languages=c			\
> > > > > >         	--disable-nls                           \
> > > > > > 		--disable-threads			\
> > > > > > 		--disable-shared			\
> > > > > > 		--disable-checking			\
> > > > > >         	--prefix=/usr                           \
> > > > > >         	--mandir=/usr/share/man                 \
> > > > > >         	--infodir=/usr/share/info               \
> > > > > >         	--target=${CROSS_ARCH}-linux
> > > > > >    	make  TARGET_LIBGCC2_CFLAGS='-Dinhibit_libc  \
> > > > > > 		-D__gthr_posix_h'
> > > > > >
> > > > > >    where ${CROSS_ARCH} is the target architecture you want
> > > > > >    to compile the toochain for, in my case, this where one
> > > > > >    of the following:
> > > > > >
> > > > > >    	alpha, hppa, hppa64, i386, ia64, m68k, mips,
> > > > > > 	mips64, ppc, ppc64, s390, sparc, sparc64, x86_64
> > > > > >
> > > > > >   PROBLEMS HERE:
> > > > > >
> > > > > >    I decided to use binutils 2.14.90.0.8, and gcc 3.3.2,
> > > > > >    but soon discovered that gcc-3.3.2 will not be able
> > > > > >    to build a cross compiler for some archs like the
> > > > > >    alpha, ia64, powerpc and even i386 ;) without some
> > > > > >    modifications[2] but with some help, I got all headers
> > > > > >    fixed, except for the ia64, which still doesn't work
> > > > > >
> > > > > >
> > > > > > 2) KERNEL CROSS COMPILING
> > > > > >
> > > > > >    equipped with the cross compiling toolchains for all
> > > > > >    but one of the architectures mentioned above, I wrote
> > > > > >    a little script, which basically does nothing else
> > > > > >    but compiling a given kernel for all possible archs.
> > > > > >
> > > > > >    basically this can be accomplished by doing:
> > > > > >
> > > > > > 	make ARCH=<arch> CROSS_COMPILE=<arch>-linux-
> > > > > >
> > > > > >
> > > > > >    the first result was harrowing:
> > > > > >
> > > > > > 				2.4.25-pre  2.6.2-rc
> > > > > >    ----------------------------------------------------
> > > > > > 	[ARCH alpha/alpha]      succeeded.  succeeded.
> > > > > > 	[ARCH hppa/parisc]      failed.     failed.
> > > > > > 	[ARCH hppa64/parisc]    failed.     failed.
> > > > > > 	[ARCH i386/i386]        succeeded.  succeeded.
> > > > > > 	[ARCH m68k/m68k]        failed.     failed.
> > > > > > 	[ARCH mips/mips]        failed.     failed.
> > > > > > 	[ARCH mips64/mips]      failed.     failed.
> > > > > > 	[ARCH ppc/ppc]          succeeded.  succeeded.
> > > > > > 	[ARCH ppc64/ppc64]      failed.     failed.
> > > > > > 	[ARCH s390/s390]        failed.     failed.
> > > > > > 	[ARCH sparc/sparc]      failed.     succeeded.
> > > > > > 	[ARCH sparc64/sparc]    failed.     failed.
> > > > > > 	[ARCH x86_64/x86_64]    failed.     succeeded.
> > > > > >
> > > > > >    so only alpha, i386 and ppc did work on the first run.
> > > > > >
> > > > > >    what I discovered was, that there IS a big difference
> > > > > >    between an empty .config file and a non exististing
> > > > > >    one, where latter allowed the make oldconfig to work
> > > > > >    similar to the make defaultconfig available on 2.6,
> > > > > >    and added some archs (see [3] for details)
> > > > > >
> > > > > >   PROBLEMS & SOLUTIONS HERE:
> > > > > >
> > > > > >    ppc64:
> > > > > > 	CROSS32_COMPILE=ppc-linux-
> > > > > > 	is needed to make this work as expected.
> > > > > >
> > > > > >    hppa/hppa64:
> > > > > > 	seems not to compile without using a very big
> > > > > > 	patch, which changes a lot inside the kernel
> > > > > >
> > > > > >    mips/mips64:
> > > > > > 	seem to use the 'obsoleted' -mcpu= option
> > > > > > 	which results in a cc1: error: invalid option
> > > > > > 	`cpu=<cpu-here>'
> > > > > >
> > > > > >    m68k:
> > > > > > 	fails with a hundred errors in the includes
> > > > > >
> > > > > >
> > > > > > 3) CONCLUSIONS
> > > > > >
> > > > > >    it seems that recent kernels (2.4 and 2.6) do not support
> > > > > >    most of the architectures they contain without heavy
> > > > > >    patching (haven't tested for arm, sh3/4, ...)
> > > > > >
> > > > > >    building cross compiler toolchains isn't that often done
> > > > > >    otherwise it would not require such modifications, and
> > > > > >    the documentation would be up to date ...
> > > > > >
> > > > > >    it seems that with some minor patches and kernel tweaks
> > > > > >    an automated build is in reach, although some archs seem
> > > > > >    to break from one release to the other ...
> > > > > >
> > > > > >    the non mainline branches, if they exist are some kernel
> > > > > >    versions behind the current mainstream kernel, which
> > > > > >    might not mean anything ...
> > > > > >
> > > > > >
> > > > > > 4) LINKS & REFERENCES
> > > > > >
> > > > > >    [1]	http://vserver.13thfloor.at/Stuff/Cross/binutils-cross.spec
> > > > > > 	http://vserver.13thfloor.at/Stuff/Cross/gcc-cross.spec
> > > > > >
> > > > > >    [2]  http://vserver.13thfloor.at/Stuff/Cross/
> > > > > > 		gcc-3.3.2-cross-alpha-fix.diff.bz2
> > > > > > 		gcc-3.3.2-cross-i386-fix.diff.bz2
> > > > > > 		gcc-3.3.2-cross-ia64-fix.diff.bz2
> > > > > > 		gcc-3.3.2-cross-powerpc-fix.diff.bz2
> > > > > >
> > > > > >    [3]  http://vserver.13thfloor.at/Stuff/Cross/compile.info
> > > > > >
> > > > > >    ia64:	http://www.gelato.unsw.edu.au/kerncomp/
> > > > > >    mips:	http://www.linux-mips.org/kernel.html
> > > > > >    hppa:	http://www.parisc-linux.org/kernel/index.html
> > > > > >    ppc64:	http://linuxppc64.org/
> > > > > >
> > > > > >
> > > > > > -
> > > > > > To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > --
> > > > > Timothy D. Witham - Lab Director - wookie@osdl.org
> > > > > Open Source Development Lab Inc - A non-profit corporation
> > > > > 12725 SW Millikan Way - Suite 400 - Beaverton OR, 97005
> > > > > (503)-626-2455 x11 (office)    (503)-702-2871     (cell)
> > > > > (503)-626-2436     (fax)
> > > > >
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > >
> > >
> > > --
> > > The church is near, but the road is icy.
> > > The bar is far, but i will walk carefully. - Russian proverb
> >
> >
> >
> >
> 
> 
> 
> 
> 
