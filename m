Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSKNXTV>; Thu, 14 Nov 2002 18:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSKNXTV>; Thu, 14 Nov 2002 18:19:21 -0500
Received: from pheriche.sun.com ([192.18.98.34]:34220 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S261855AbSKNXTU>;
	Thu, 14 Nov 2002 18:19:20 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200211142326.gAENQC931748@scl2.sfbay.sun.com>
Subject: [BK SUMMARY] Remove NGROUPS hardlimit (resend w/o qsort)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2002 15:26:12 -0800 (PST)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patchset removes the hard NGROUPS limit.  It has been in use in a similar
form on our systems for some time.

There is a small change needed for glibc, and I will send that patch to the
glibc people if/when this gets pulled.

Unlike prior versions of this patch, I have changed qsort() to a simple
non-recursive sort.  Several people indicated that this change would solve
their objections.

Lastly, this does not fixup all the architectures.  I have other patchsets for
that, which need to be reviewed by arch maintainers.

Tim


Please do a

	bk pull http://suncobalt.bkbits.net/ngroups-2.5

This will update the following files:

 fs/nfsd/auth.c                 |   11 ++-
 fs/proc/array.c                |    2 
 include/asm-i386/param.h       |    4 -
 include/linux/init_task.h      |    1 
 include/linux/kernel.h         |    3 +
 include/linux/limits.h         |    3 -
 include/linux/sched.h          |    3 -
 include/linux/sunrpc/svcauth.h |    3 -
 kernel/exit.c                  |    6 ++
 kernel/fork.c                  |    4 +
 kernel/sys.c                   |  115 +++++++++++++++++++++++++++++++++--------
 kernel/uid16.c                 |   63 +++++++++++++++++-----
 lib/Makefile                   |    4 -
 lib/bsearch.c                  |   49 +++++++++++++++++
 net/sunrpc/svcauth_unix.c      |    4 -
 15 files changed, 224 insertions(+), 51 deletions(-)

through these ChangeSets (diffs in separate email):

<thockin@freakshow.cobalt.com> (02/11/11 1.855)
   fix usage of NGROUPS in nfsd and svcauth

<thockin@freakshow.cobalt.com> (02/11/11 1.854)
   Remove the limit of 32 groups.  We now have a per-task, dynamic array of
   groups, which is kept sorted and refcounted.
   
   This ChangeSet incorporates all the core functionality. but does not fixup
   all the incorrect usages of groups.  That is in a seperate ChangeSet.

