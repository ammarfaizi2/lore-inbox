Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTAOG1B>; Wed, 15 Jan 2003 01:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAOG1B>; Wed, 15 Jan 2003 01:27:01 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:693 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261398AbTAOG07>;
	Wed, 15 Jan 2003 01:26:59 -0500
Date: Wed, 15 Jan 2003 17:34:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_{old_}sigset_t generic part
Message-Id: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates compat_sigset_t and compat_old_sigset_t i.e. just the
types.  This is just the generic part, the architecture specific parts
follow. The diffstat for the whole patch looks like this:

 arch/ia64/ia32/ia32_signal.c      |   26 +++++++++++------------
 arch/mips64/kernel/signal32.c     |   33 +++++++++++------------------
 arch/parisc/kernel/signal.c       |    7 +++---
 arch/parisc/kernel/signal32.c     |   32 +++++++++++++---------------
 arch/parisc/kernel/sys32.h        |    7 ------
 arch/ppc64/kernel/signal32.c      |   42 +++++++++++++++++++-------------------
 arch/s390x/kernel/linux32.c       |   24 ++++++++++-----------
 arch/s390x/kernel/linux32.h       |   15 +++----------
 arch/s390x/kernel/signal32.c      |   15 +++++++------
 arch/sparc64/kernel/signal.c      |    5 +++-
 arch/sparc64/kernel/signal32.c    |   16 +++++++-------
 arch/sparc64/kernel/sys_sparc32.c |   34 +++++++++++++++---------------
 arch/sparc64/kernel/sys_sunos32.c |    2 -
 arch/x86_64/ia32/ia32_signal.c    |   11 +++++----
 arch/x86_64/ia32/sys_ia32.c       |   38 +++++++++++++++++-----------------
 include/asm-ia64/compat.h         |    7 ++++++
 include/asm-ia64/ia32.h           |   14 +-----------
 include/asm-mips64/compat.h       |    7 ++++++
 include/asm-mips64/signal.h       |    1 
 include/asm-parisc/compat.h       |    9 +++++++-
 include/asm-ppc64/compat.h        |    7 ++++++
 include/asm-ppc64/ppc32.h         |   14 +-----------
 include/asm-s390x/compat.h        |    9 +++++++-
 include/asm-sparc64/compat.h      |    7 ++++++
 include/asm-sparc64/signal.h      |   19 ++++-------------
 include/asm-x86_64/compat.h       |    7 ++++++
 include/asm-x86_64/ia32.h         |   16 ++------------
 include/linux/compat.h            |    6 +++++
 28 files changed, 215 insertions(+), 215 deletions(-)

So, overall no change :-)

Applying just this generic part will break all the 64 bit architectures.
Hopefully this will give the architecture maintainer incentive to apply my
other patches.  :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/include/linux/compat.h 2.5.58-32bit.5/include/linux/compat.h
--- 2.5.58-32bit.4/include/linux/compat.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.58-32bit.5/include/linux/compat.h	2003-01-15 16:33:09.000000000 +1100
@@ -33,6 +33,12 @@
 	compat_clock_t		tms_cstime;
 };
 
+#define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
+
+typedef struct {
+	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
+} compat_sigset_t;
+
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
 extern int get_compat_flock(struct flock *, struct compat_flock *);
 extern int put_compat_flock(struct flock *, struct compat_flock *);
