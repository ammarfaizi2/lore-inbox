Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262261AbSJKB2J>; Thu, 10 Oct 2002 21:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSJKB2J>; Thu, 10 Oct 2002 21:28:09 -0400
Received: from pheriche.sun.com ([192.18.98.34]:19890 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S262261AbSJKB2C>;
	Thu, 10 Oct 2002 21:28:02 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210110133.g9B1Xjb18401@scl2.sfbay.sun.com>
Subject: [BK SUMMARY] fix NGROUPS hard limit
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 18:33:45 -0700 (PDT)
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

 fs/nfsd/auth.c                 |   11 +-
 fs/proc/array.c                |    2 
 include/asm-i386/param.h       |    4 
 include/linux/init_task.h      |    1 
 include/linux/kernel.h         |    5 +
 include/linux/limits.h         |    3 
 include/linux/nfsiod.h         |    3 
 include/linux/sched.h          |    3 
 include/linux/sunrpc/svcauth.h |    4 
 kernel/exit.c                  |    7 +
 kernel/fork.c                  |    4 
 kernel/sys.c                   |   88 +++++++++++++++-----
 kernel/uid16.c                 |   63 ++++++++++----
 lib/Makefile                   |    5 -
 lib/bsearch.c                  |   49 +++++++++++
 lib/qsort.c                    |  180 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svcauth.c           |    4 
 17 files changed, 384 insertions(+), 52 deletions(-)

through these ChangeSets (diffs in separate email):

<thockin@freakshow.cobalt.com> (02/10/10 1.742)
   convert nfsiod to use OLD_NGROUPS - does anyone _use_ this file anymore?

<thockin@freakshow.cobalt.com> (02/10/10 1.741)
   fix usage of NGROUPS in nfsd and svcauth

<thockin@freakshow.cobalt.com> (02/10/10 1.740)
   Remove the limit of 32 groups.  We now have a per-task, dynamic array of
   groups, which is kept sorted and refcounted.

   This ChangeSet incorporates all the core functionality. but does not fixup
   all the incorrect usages of groups.  That is in a seperate ChangeSet.

<thockin@freakshow.cobalt.com> (02/10/10 1.739)
   Add generic qsort() and bsearch(): qsort() from BSD, bsearch() from glibc

