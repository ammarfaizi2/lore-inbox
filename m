Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJVAcO>; Mon, 21 Oct 2002 20:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJVAbK>; Mon, 21 Oct 2002 20:31:10 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:17399 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S261845AbSJVAa2>; Mon, 21 Oct 2002 20:30:28 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210220036.g9M0aOo31343@scl2.sfbay.sun.com>
Subject: [BK SUMMARY] fix NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2002 17:36:24 -0700 (PDT)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patchset removes the hard NGROUPS limit.  It has been in use in a similar
form (but with a sysctl-set limit) on our systems for some time.

The last changeset is of questionable value - nfsiod is not included by or
referenced by anything.  Perhaps it should just be removed?

I have a separate patch to convert XFS to the generic qsort(), which I will
bounce to SGI if/when this gets pulled.

There is a small change needed for glibc, and I will send that patch to the
glibc people if/when this gets pulled.

Lastly, this does not fixup all the architectures.  I have other patchsets for
that, which need to be reviewed by arch maintainers.

Tim


Please do a

	bk pull http://suncobalt.bkbits.net/ngroups-2.5

This will update the following files:

 include/linux/nfsiod.h         |   52 -----------
 fs/nfsd/auth.c                 |   11 +-
 fs/proc/array.c                |    2 
 include/asm-i386/param.h       |    4 
 include/linux/init_task.h      |    1 
 include/linux/kernel.h         |    5 +
 include/linux/limits.h         |    3 
 include/linux/sched.h          |    3 
 include/linux/sunrpc/svcauth.h |    3 
 kernel/exit.c                  |    6 +
 kernel/fork.c                  |    4 
 kernel/sys.c                   |   88 +++++++++++++++-----
 kernel/uid16.c                 |   63 ++++++++++----
 lib/Makefile                   |    5 -
 lib/bsearch.c                  |   49 +++++++++++
 lib/qsort.c                    |  180 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svcauth_unix.c      |    4 
 17 files changed, 380 insertions(+), 103 deletions(-)

through these ChangeSets (diffs in separate email):

<thockin@freakshow.cobalt.com> (02/10/21 1.812)
   no one references nfsiod.h anymore - nix it.

<thockin@freakshow.cobalt.com> (02/10/21 1.811)
   fix usage of NGROUPS in nfsd and svcauth

<thockin@freakshow.cobalt.com> (02/10/21 1.810)
   Remove the limit of 32 groups.  We now have a per-task, dynamic array of
   groups, which is kept sorted and refcounted.
   
   This ChangeSet incorporates all the core functionality. but does not fixup
   all the incorrect usages of groups.  That is in a seperate ChangeSet.

<thockin@freakshow.cobalt.com> (02/10/21 1.809)
   Add generic qsort() and bsearch(): qsort() from BSD, bsearch() from glibc

