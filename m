Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSBGUAs>; Thu, 7 Feb 2002 15:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSBGT7k>; Thu, 7 Feb 2002 14:59:40 -0500
Received: from 1Cust15.tnt15.sfo3.da.uu.net ([67.218.75.15]:39948 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S291255AbSBGT7O>;
	Thu, 7 Feb 2002 14:59:14 -0500
Date: Thu, 7 Feb 2002 15:06:11 -0800 (PST)
Message-Id: <200202072306.PAA08272@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: jaharkes@cs.cmu.edu
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20020207165035.GA28384@ravel.coda.cs.cmu.edu> (message from Jan
	Harkes on Thu, 7 Feb 2002 11:50:35 -0500)
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   From: Jan Harkes <jaharkes@cs.cmu.edu>

   On Tue, Feb 05, 2002 at 11:33:34PM -0800, Jeramy B. Smith wrote:
   > Firstly, IANAFSN (I am not a Free Software Nazi) but there is this
   > new GPL decentralized version control program called arch that is small
   > and fits in well with the Unix way of using other small utils.

   Tom, I cc'd you on this,

   Yes it's very interesting and has several good ideas behind it, but it's
   not ready yet.

Arch will certainly need to be tuned for kernel hackers and perhaps
customized.  Some systems are still effected by portability bugs (arch
has been out for barely a month) Yes: because it is new, it isn't as
"off the shelf" a solution as bk.  Nevertheless, arch is self hosting,
rich in features, and has properties that I think are ideal for
projects such as the kernel.  So if there is to be a shift among
kernel developers to coordinating with a source code management tool,
one question is whether the effort should be directed toward deploying
bk, or towards helping to optimize arch for their use.


   $ du /opt/arch-1.0pre3
   12100   /opt/arch-1.0pre3/bin
   788     /opt/arch-1.0pre3/include
   2588    /opt/arch-1.0pre3/lib
   1640    /opt/arch-1.0pre3/libexec
   17120	/opt/arch-1.0pre3

   Hmm, I wouldn't call over 17MB small.

Most of that size is for generic utilities and a generic library that
I package up with arch distributions since they aren't already widely
installed.  The revision control system itself is, as reported, about
40K lines of code.  The significance of that distinction is that arch
itself is small enough to grok, maintain, extend, etc.


   It also has several name conflicts with existing binaries, amongst
   others /bin/arch and /bin/readlink. This breaks a lot when arch's
   binary directory is not first in the PATH environment variable.

There are instructions in the distribution for installing arch in a
way that avoids those conflicts (docs/examples/README.000.first-steps).



   Then it has these {arch} names all over the place, about as bad as CVS
   and SCCS, but it breaks tab-completion with GNU bash/readline too,
   wouldn't .arch (or .{arch}) be a less invasive naming scheme? 

It has {arch} files in the root of each project tree -- not in every
directory.  The arch distribution contains eight project trees (there
are eight separately developed components in the distribution).
Should there be an alternative name for that file?  Perhaps.

The name has curly braces so that it sorts reasonably (i.e. away from
ordinary source files).  It is not a dot file so that you can
recognize at a glance when you are looking at the root of a project
tree.

       It's changesets are definitely not close to being 'patch' compatible.

That's not quite true.  arch patch sets consist of unified diffs plus
additional material to cleanly describe file and directory renames,
added and removed files, changes to binary files, changes to symbolic
links, and changes to file permissions.  The arch command `dopatch'
applies the context diffs using `patch'.  arch contains reporting
tools that generate either plain text or HTML reports to help simplify
reviewing patch sets.

When you do need simple diff-format patch sets, the arch feature
called "revision libraries" makes it very easy to quicly create them
between arbitrary revisions.


   Have you tried to work your way through the arch sources yet? Just
   trying to figure out where 'sb' is compiled, what it does and where it
   is used took me a very long time.

You must have forgotten to try:

	find . -name "sb.c"  

The "=README" file in the parent directory of the `sb' source code
explains what the program does.  There are also installation auditing
files generated in the build directory, but I admit that as an obscure
way to find `sb'.



   Most of arch's helper libraries/programs (hackerlab/xxx-utils) already
   have in my opinion perfectly reasonable existing solutions, i.e. there
   is something called the POSIX standard, ftp/http file access by using
   wget/curl/ncftpget. And why it needs to have it's own ftp-server built
   in (which is what it looks like), I have no clue about that one.

arch does not have its own ftp-server.  It does have an ftp client.

arch doesn't use wget/curl/ncftpget because it needed a simplier
client with different performance characteristics and a different
interface for programming.  I wanted very much to save work by using
those tools, but they weren't suitable.

Should the shell utilities distributed with arch use only POSIX libc
and avoid libhackerlab?  Arguably so, and I considered doing it that
way while writing them.  However, libhackerlab has a bunch of nice
features that made it easier to write those utilities and get them
working quickly.

-t
