Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157224AbQG1Xmo>; Fri, 28 Jul 2000 19:42:44 -0400
Received: by vger.rutgers.edu id <S157229AbQG1Xl5>; Fri, 28 Jul 2000 19:41:57 -0400
Received: from firewall-in.sch57.msk.ru ([195.178.195.6]:2133 "EHLO dell.sch57.msk.ru") by vger.rutgers.edu with ESMTP id <S161152AbQG1Uo4>; Fri, 28 Jul 2000 16:44:56 -0400
Date: Sat, 29 Jul 2000 01:02:06 +0400 (MSD)
From: Khimenko Victor <khim@dell.sch57.msk.ru>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Peter Jones <pjones@redhat.com>, clubneon@hereintown.net, linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: <3981ED0C.CBE0A0F9@transmeta.com>
Message-ID: <Pine.LNX.4.10.KSI2.10007290035410.28600-100000@dell.sch57.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 28 Jul 2000, H. Peter Anvin wrote:

> Peter Jones wrote:
> > >
> > > You missed the point here. Yes, /usr/lib/perl is just fine. But what
> > > about locally compiled modules ? You can download thing from CPAN,
> > > compile it and install. It's simple: perl Makefile.PL ; make ; make
> > > install ... It'll compile CPAN module and will install it ... where
> > > it'll install it ? Currently it'll install it in
> > > /usr/lib/perl5/site_perl/i386-linux (arch-dependant files) or in
> > > /usr/lib/perl5/site_perl (non-arch-dependant files). Emacs will search
> > > for additional packages in /usr/share/emacs/20.7/site-lisp (and
> > > /usr/share/emacs/site-lisp) and so on. And sysadmin can not change it
> > > easily: you need to recompile perl, emacs or tcl.
> > 
> 
> Ever heard of "symlinks"?
> 

Yeah, of course. Just FHS closed this way as well. Yes, I (as distribution
maker) can make /usr/lib/perl5/site_perl/i386-linux symlink to
/usr/local/lib/perl but since
-- cut --
This directory should always be empty after first installing a
FHS-compliant system.  No exceptions to this rule should be made other
than the listed directory stubs.
-- cut --
I (as distribution maker) can not create /usr/local/lib/perl directory.
Thus perl's make install will mysteriously fail while trying to install
stuff. Or I (as sysadmin) must GUESS that I should create /usr/local/lib/perl 
before using perl's `make install' ? Gosh. So much for FHS-compliance.
Or may be you can suggest some other clever way to solve this problem ?

P.S. May be I just poor in English and in fact creation of subdirectories
UNDER /usr/local (not IN /usr/local) is allowed ? At least it looks like
Debian mantainers think so:
-- cut --
  3.1.2 Site-specific programs

   As mandated by the FHS no package should place any files in
   /usr/local, either by putting them in the file system archive to be
   unpacked by dpkg or by manipulating them in their maintainer scripts.

   However, the package should create empty directories below /usr/local
   so that the system administrator knows where to place site-specific
   files. These directories should be removed on package removal if they
   are empty.

   Note, that this applies only to directories below /usr/local, not in
   /usr/local. The directory /usr/local itself may only contain the
   sub-directories listed in FHS, section 4.6. However, you may create
   directories below them as you wish. You may not remove any of the
   directories listed in 4.6, even if you created them.
-- cut --
It this is so then it's Ok: there are really no need to put anything in
/usr/local itself and under /usr/local only empty directoryes for local
stuff are needed...

Looks like FHS wording is too vague in this place...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
