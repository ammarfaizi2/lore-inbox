Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265173AbSKETza>; Tue, 5 Nov 2002 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSKETza>; Tue, 5 Nov 2002 14:55:30 -0500
Received: from pheriche.sun.com ([192.18.98.34]:60637 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S265173AbSKETz2>;
	Tue, 5 Nov 2002 14:55:28 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200211052002.gA5K24o05701@scl2.sfbay.sun.com>
Subject: [BK SUMMARY] remove NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 5 Nov 2002 12:02:04 -0800 (PST)
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

 include/linux/nfsiod.h         |   52 ------------
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
 kernel/uid16.c                 |   63 +++++++++++---
 lib/Makefile                   |    4 
 lib/bsearch.c                  |   49 +++++++++++
 lib/qsort.c                    |  177 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svcauth_unix.c      |    4 
 17 files changed, 376 insertions(+), 103 deletions(-)

through these ChangeSets (diffs in separate email):

<thockin@freakshow.cobalt.com> (02/11/05 1.933)
   no one references nfsiod.h anymore - nix it.

<thockin@freakshow.cobalt.com> (02/11/05 1.932)
   fix usage of NGROUPS in nfsd and svcauth

<thockin@freakshow.cobalt.com> (02/11/05 1.931)
   Remove the limit of 32 groups.  We now have a per-task, dynamic array of
   groups, which is kept sorted and refcounted.
   
   This ChangeSet incorporates all the core functionality. but does not fixup
   all the incorrect usages of groups.  That is in a seperate ChangeSet.

<thockin@freakshow.cobalt.com> (02/11/05 1.930)
   Add generic qsort() and bsearch(): qsort() from BSD, bsearch() from glibc

