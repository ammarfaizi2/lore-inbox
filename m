Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVEWW0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEWW0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVEWW0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 18:26:23 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:55022 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261158AbVEWWZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:25:42 -0400
Message-Id: <200505232225.j4NMP5e1028530@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Mon, 23 May 2005 17:24:55 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 0/7] v9fs: Plan 9 resource sharing protocol (2.0-rc6)
Cc: v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [0/7] of the v9fs-2.0-rc6 patch against Linux v2.6.12-rc4.

Hi everyone, we'd like to announce v2.0-rc6 of our 9P2000 file system 
driver support for Linux in order to solicit comments and criticism.

BACKGROUND

Plan 9 (http://plan9.bell-labs.com/plan9) is a research operating
system and associated applications suite developed by the Computing
Science Research Center of AT&T Bell Laboratories (now a part of
Lucent Technologies), the same group that developed UNIX , C, and C++.
Plan 9 was initially released in 1993 to universities, and then made
generally available in 1995. Its core operating systems code laid the
foundation for the Inferno Operating System released as a product by
Lucent Bell-Labs in 1997. The Inferno venture was the only commercial
embodiment of Plan 9 and is currently maintained as a product by Vita
Nuova (http://www.vitanuova.com). After updated releases in 2000 and
2002, Plan 9 was open-sourced under the OSI approved Lucent Public
License in 2003.

The Plan 9 project was started by Ken Thompson and Rob Pike in 1985.
Their intent was to explore potential solutions to some of the
shortcomings of UNIX in the face of the widespread use of high-speed
networks to connect machines. In UNIX, networking was an afterthought
and UNIX clusters became little more than a network of stand-alone
systems. Plan 9 was designed from first principles as a seamless
distributed system with integrated secure network resource sharing.
Applications and services were architected in such a way as to allow
for implicit distribution across a cluster of systems. Configuring an
environment to use remote application components or services in place
of their local equivalent could be achieved with a few simple command
line instructions. For the most part, application implementations
operated independent of the location of their actual resources.

Commercial operating systems haven't changed much in the 20 years
since Plan 9 was conceived. Network and distributed systems support is
provided by a patchwork of middle-ware, with an endless number of
packages supplying pieces of the puzzle. Matters are complicated by
the use of different complicated protocols for individual services,
and separate implementations for kernel and application resources.  
The V9FS project (http://v9fs.sourceforge.net) is an attempt to bring
Plan 9's unified approach to resource sharing to Linux and other
operating systems via support for the 9P2000 resource sharing
protocol.

V9FS HISTORY

V9FS was originally developed by Ron Minnich and Maya Gokhale at Los
Alamos National Labs (LANL) in 1997.  In November of 2001, Greg Watson
setup a SourceForge project as a public repository for the code which
supported the Linux 2.4 kernel.

About a year ago, I picked up the initial attempt Ron Minnich had
made to provide 2.6 support and got the code integrated into a 2.6.5
kernel.   I then went through a line-for-line re-write attempting to
clean-up the code while more closely following the Linux Kernel style
guidelines.  I co-authored a paper with Ron Minnich on the V9FS Linux
support including performance comparisons to NFSv3 using Bonnie and
PostMark - this paper appeared at the USENIX/FREENIX 2005
conference in April 2005:
( http://www.usenix.org/events/usenix05/tech/freenix/hensbergen.html ).

CALL FOR PARTICIPATION/REQUEST FOR COMMENTS

Our 2.6 kernel support is stabilizing and we'd like to begin pursuing
its integration into the official kernel tree.  We would appreciate any
review, comments, critiques, and additions from this community and are
actively seeking people to join our project and help us produce
something that would be acceptable and useful to the Linux community.

STATUS

The code is reasonably stable, although there are no doubt corner cases
our regression tests haven't discovered yet.  It is in regular use by several 
of the developers and has been tested on x86 and PowerPC 
(32-bit and 64-bit) in both small and large (LANL cluster) deployments.
Our current regression tests include fsx, bonnie, and postmark.

It was our intention to keep things as simple as possible for this
release -- trying to focus on correctness within the core of the
protocol support versus a rich set of features.  For example: a more
complete security model and cache layer are in the road map, but
excluded from this release.   Additionally, we have removed support for
mmap operations at Al Viro's request.

PERFORMANCE

Detailed performance numbers and analysis are included in the FREENIX
paper, but we show comparable performance to NFSv3 for large file
operations based on the Bonnie benchmark, and superior performance for
many small file operations based on the PostMark benchmark.   Somewhat
preliminary graphs (from the FREENIX paper) are available
(http://v9fs.sourceforge.net/perf/index.html).

RESOURCES

The source code is available in a few different forms:

tarballs: http://v9fs.sf.net
CVSweb: http://cvs.sourceforge.net/viewcvs.py/v9fs/linux-9p/
CVS: :pserver:anonymous@cvs.sourceforge.net:/cvsroot/v9fs/linux-9p
BitKeeper: bk://linux-v9fs.bkbits.net
Git: rsync://v9fs.9grid.us/v9fs

The user-level server is available from either the Plan 9 distribution
or from http://v9fs.sf.net
Other support applications are still being developed, but preliminary
version can be downloaded from sourceforge.

Documentation on the protocol has historically been the Plan 9 Man
pages (http://plan9.bell-labs.com/sys/man/5/INDEX.html), but there is
an effort under way to write a more complete Internet-Draft style
specification (http://v9fs.sf.net/rfc).

There are a couple of mailing lists supporting v9fs, but the most used
is v9fs-developer@lists.sourceforge.net -- please direct/cc your
comments there so the other v9fs contributors can participate in the
conversation.  There is also an IRC channel: irc://freenode.net/#v9fs

THANKS

Thanks for your time in reading this message, I look forward to
hearing from all of you -- we are well aware that there is much work
to do, but I hope that with your help we can produce something that
everyone finds useful and valuable.

       -Eric Van Hensbergen
         V9FS Project


-----------------

v9fs-2.0-rc6 patch


-----------------
commit 329e34758086b5bbd5096e13e6501eb635f1c187
tree 178666ee376655ef8ec19a2ffc0490241b428110
parent e16fa6b9d2ad9467cf5bdf517e6b6f45e5867ad6
author Eric Van Hensbergen <ericvh@gmail.com> Mon, 23 May 2005 14:48:12 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Mon, 23 May 2005 14:48:12 -0500

 filesystems/v9fs.txt |   83 ++
 MAINTAINERS          |   11 
 9p/9p.c              |  359 +++++++++++
 9p/9p.h              |  339 +++++++++++
 9p/Makefile          |   16 
 9p/conv.c            |  729 ++++++++++++++++++++++++
 9p/conv.h            |   35 +
 9p/debug.h           |   69 ++
 9p/error.c           |   92 +++
 9p/error.h           |  171 +++++
 9p/fid.c             |  232 +++++++
 9p/fid.h             |   55 +
 9p/idpool.c          |  150 ++++
 9p/idpool.h          |   40 +
 9p/mux.c             |  440 ++++++++++++++
 9p/mux.h             |   37 +
 9p/trans_sock.c      |  276 +++++++++
 9p/transport.h       |   42 +
 9p/v9fs.c            |  573 +++++++++++++++++++
 9p/v9fs.h            |   89 ++
 9p/v9fs_vfs.h        |   51 +
 9p/vfs_dir.c         |  242 ++++++++
 9p/vfs_file.c        |  423 ++++++++++++++
 9p/vfs_inode.c       | 1534 +++++++++++++++++++++++++++++++++++++++++++++++++++
 9p/vfs_super.c       |  246 ++++++++
 Kconfig              |   11 
 Makefile             |    1 
 27 files changed, 6346 insertions(+)

