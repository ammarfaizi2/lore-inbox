Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTAKQUR>; Sat, 11 Jan 2003 11:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTAKQUR>; Sat, 11 Jan 2003 11:20:17 -0500
Received: from [132.69.253.254] ([132.69.253.254]:40832 "HELO
	vipe.technion.ac.il") by vger.kernel.org with SMTP
	id <S267268AbTAKQUO>; Sat, 11 Jan 2003 11:20:14 -0500
Date: Sat, 11 Jan 2003 18:28:54 +0200 (IST)
From: Shlomi Fish <shlomif@vipe.technion.ac.il>
To: <linux-kernel@vger.kernel.org>
Subject: Idea: CLAN - The Comprehensive Linux Archive Network
Message-ID: <Pine.LNX.4.33L2.0301111825200.458-100000@vipe.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

This is just a whitepaper, there isn't any code. In any case, I suggested
it to Rik van-Riel in the IRC, and he approved of the idea and me posting
it here.

Cheers!

	Shlomi Fish

CLAN - Comprehensive Linux Archive Network - Whitepaper
  An Automatic Framework to Download, Update and Install Kernel Modules and Entire Kernels
Version
    0.1.0

Author
    Shlomi Fish (shlomif"@"vipe.technion.ac.il)

Introduction
    The Comprehensive Linux Archive Network (or CLAN for short) would be the
    equivalent of Perl's CPAN, Debian's apt and similar systems for the
    Linux kernel. It would enable incrementaly downloading, updating and
    installing kernel modules (and even entire kernels) while resolving
    dependencies.

    CLAN at the moment is in the idea and planning stage.

Rationale
    The Linux Kernel distribution is getting bigger. Here are some numbers:

        linux-1.2.13.tar.gz    -  2,354,612 bytes
        linux-2.0.39.tar.gz    -  7,589,450 bytes
        linux-2.2.23.tar.gz    - 19,695,708 bytes
        linux-2.4.20.tar.gz    - 33,963,814 bytes
        linux-2.5.56.tar.gz    - 39,301,979 bytes

    These are the vanilla "Linus" kernels. Distribution kernels or the Alan
    Cox trees are even bigger. And they are bloated. My kernel contains
    about 50 Ethernet drivers, while a common computer (if it has Ethernet
    cards at all) needs only one or two such. Furthermore, while the USB
    subsystem is useful as a general rule, not many people have a USB mouse,
    whose driver is included in the kernel.

    There are many third-party extensions to the kernel, be it fully
    open-source (GPL or so), proprietary sourceware, or simply binary
    modules. If Linux is expected to grow, we can expect more of them to
    turn up as hardware manufacturer, and people who write "shrinkwrap"
    kernel-ware write more and more modules.

    Compiling one extra module requires going to the top tree, finding the
    option in the menuconfig or xconfig (or config - %-)) menu, and then
    compiling everyhting from the root. This may warn you of non valid
    dependencies. Obviously the current system "does not scale well".

    Everyone who used Perl (and have learned to make use of the CPAN.pm
    module) will tell you that installing and upgrading new modules is a non
    issue. A common session would be:

    <<<

        root:/home/shlomi# perl -MCPAN -e shell

        cpan shell -- CPAN exploration and modules installation (v1.63)
        ReadLine support enabled

        cpan> install XML::Parser::TwiCPAN: Storable loaded ok
        Going to read /root/.cpan/Metadata
          Database was generated on Sat, 11 Jan 2003 01:47:51 GMT
        cpan> install XML::Twig
        Running install for module XML::Twig
        Running make for M/MI/MIROD/XML-Twig-3.09.tar.gz
        CPAN: LWP::UserAgent loaded ok
        Fetching with LWP:
          ftp://ftp.iglu.org.il/pub/CPAN/authors/id/M/MI/MIROD/XML-Twig-3.09.tar.gz
        CPAN: Digest::MD5 loaded ok
        Fetching with LWP:
          ftp://ftp.iglu.org.il/pub/CPAN/authors/id/M/MI/MIROD/CHECKSUMS
        CPAN: Compress::Zlib loaded ok
        Checksum for /root/.cpan/sources/authors/id/M/MI/MIROD/XML-Twig-3.09.tar.gz ok
        Scanning cache /root/.cpan/build for sizes
        [ Begin installation ]
        .
        .
        .
        Running make install
        Installing /usr/lib/perl5/site_perl/5.8.0/XML/Twig.pm
        Installing /usr/share/man/man3pm/XML::Twig.3pm
        Writing /usr/lib/perl5/site_perl/5.8.0/i386-linux-thread-multi/auto/XML/Twig/.packlist
        Appending installation info to /usr/lib/perl5/5.8.0/i386-linux-thread-multi/perllocal.pod
        /usr/bin/make install  -- OK

        cpan> quit
        Lockfile removed.

    >>> There are similar systems in Debian GNU/Linux, and now in other
    distributions as well. What CLAN wishes to be is a system for doing just
    that: downloading, compiling, and installing kernel modules over the
    new, with dependency solving.

Features
    After CLAN is installed on the system it compiles a basic kernel that
    fullfills all of the system requirements. These may be found out using a
    hardware manager (such as MandrakeSoft's hard-drake) or explicitly. It
    then compiles a basic kernel and installs it. This requires a reboot.

    Afterwards, whenever the user needs a new module, he invokes CLAN
    (something like "clan -e shell") and installs this module by downloading
    it, verifying it for cryptographic validity (if necessary), compiling it
    and installing it.

    That's not all. If CLAN detects that the current kernel does not support
    this module it will accept the admin explicit or implicit permission to
    recompile the kernel with this option added, and install the new kernel
    as well.

    CLAN will require no bootstrapping. It would be able to prepare
    standalone source kernel packages that can be compiled without CLAN
    installed.

    And like I said earlier, installing a module will install all of its
    dependencies as well.

    CLAN will support multiple sources for modules (controlled by editing a
    text file), and will be able to handle source packages, binary packages
    and restrict each one to various architectures (i386, SPARC, Alpha, ARM)
    and sub- architectures (i386, i486, i586, i686).

    Some sources of CLAN will be able to carry non-GPL-compliant code and so
    the free software ideals will not be violated anywhere.

    I hope that CLAN will be able to play nice with the underlying package
    systems. I.e: build modules and kernels as RPMs on RPM based systems ,
    as deb packages on Debian and derived systems, etc.

Requirements
    CLAN will require a GNU system with gcc, GNU make, GNU awk, etc. This
    includes Linux as well as cygwin, a GNUish BSD, a GNUish Solaris box,
    etc.

    Furthermore, I believe it would be a good idea to make it perl5 based
    and use whatever CPAN modules we can use that are up-to-date and
    accesible. We might even put its bootstrap package on CPAN (;-))

    If anyone prefers a Python based solution (or a Ruby, Tcl, OCaml or
    whatever one) feel free to write one yourself. I prefer Perl and think
    it is the most suitable, accessible and flexible language for the task,
    and don't have the time to wage language wars. I do, however, object for
    writing it in C, because I am sure such code will unnecessary be buggy,
    incredibly large, and completely frustrating to maintain. You don't
    write such things in C<tm<.

Current Status
    We passed the idea stage which took 1 unit of effort. We have also
    written this whitepaper which is an extra unit of effort of the
    development stage that totals about 10 units. Now we need 9 more units
    of development, 100 of mass production (should be fairly trivial), and
    1000 of mass distribution. So its just the early beginning and it works
    nicely only inside my text editor.

    CLAN is ideaware, and needs to be written, and the current kernel code
    needs to be adapted to it.

Some Thoughts about Implementation
    One thing obvious about CPAN Modules is that they have no duplicacy. The
    "Makefile.PL" script is very short and all its logic is implemented in
    the core Perl distribution. On the other hand, the packages of the GNU
    distribution (on ftp.gnu.org) or those of GNOME have a lot of duplicacy.
    They each contain a very large configure script (that is very much the
    same), configure.in files (which also share similarity), Makefile.in's,
    Makefile.am, aclocal.m4's and other things that expect it to be able to
    bootstrap on any POSIX system (even partially broken and obsolete ones)
    and still be developed on a GNU system.

    I wish that CLAN packages will have as little duplicacy as possible.
    However, the CLAN framework may transform them into full-fledged
    Makefile packages, autoconf packages, or the system native packaging
    system (RPMs, DEBs, etc).

    I wish CLAN specific modules to reside only in the Linux::CLAN namespace
    of CPAN. Note that some of them may eventually be found to be generic
    enough to be moved to a more global namespace, but we'll cross the
    bridge when we get there.

Availability
    The Perl POD source for this document is available on
    <http://fc-solve.berlios.de/clan/>. (note that it is a temporary
    location and you should probably STFW or RTFM for it).

Thanks
    Shlomi Fish would like to thank Rik-van-Riel (riel on the IRC) and a
    certain irc.kernelnewbies.org lurker by the name of rh (please identify
    yourself) for their assistance in developing and inspiring this idea,
    and for having a nice chat about Perl and other matters.


----------------------------------------------------------------------
Shlomi Fish        shlomif@vipe.technion.ac.il
Home Page:         http://t2.technion.ac.il/~shlomif/

He who re-invents the wheel, understands much better how a wheel works.


