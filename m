Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272427AbTHEEoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 00:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272428AbTHEEoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 00:44:10 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:51429 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272427AbTHEEoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 00:44:04 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: trivial@rustcorp.com.au
Date: Tue, 5 Aug 2003 14:43:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16175.13838.321410.599973@wombat.disy.cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH, TRIVIAL] Add do_setitimer prototype to linux/time.h)
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, do_setitimer() is used in several files, but doesn;t appear
in any header.  Thus its declaration is repeated in some files, and
its use causes a warning in others (because there is no declaration
present).

This patch:
     -- adds a couple of declarations to linux/times.h
     -- removes the (now duplicate) declarations from other files.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1610  -> 1.1611 
#	arch/alpha/kernel/osf_sys.c	1.28    -> 1.29   
#	     kernel/itimer.c	1.4     -> 1.5    
#	arch/x86_64/ia32/sys_ia32.c	1.34    -> 1.35   
#	     kernel/compat.c	1.19    -> 1.20   
#	include/linux/time.h	1.19    -> 1.20   
#	      kernel/timer.c	1.62    -> 1.63   
#	arch/mips/kernel/sysirix.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/05	peterc@gelato.unsw.edu.au	1.1611
# Put prototypes for do_[sg]etitimer() in linux/time.h and
# remove them from C files.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
--- a/arch/alpha/kernel/osf_sys.c	Tue Aug  5 14:43:21 2003
+++ b/arch/alpha/kernel/osf_sys.c	Tue Aug  5 14:43:21 2003
@@ -821,8 +821,6 @@
    affects all sorts of things, like timeval and itimerval.  */
 
 extern struct timezone sys_tz;
-extern int do_getitimer(int which, struct itimerval *value);
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
 extern asmlinkage int sys_utimes(char *, struct timeval *);
 extern int do_adjtimex(struct timex *);
 
diff -Nru a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c	Tue Aug  5 14:43:21 2003
+++ b/arch/mips/kernel/sysirix.c	Tue Aug  5 14:43:21 2003
@@ -636,9 +636,6 @@
 	return 0;
 }
 
-extern int do_setitimer(int which, struct itimerval *value,
-                        struct itimerval *ovalue);
-
 static inline void jiffiestotv(unsigned long jiffies, struct timeval *value)
 {
 	value->tv_usec = (jiffies % HZ) * (1000000 / HZ);
diff -Nru a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
--- a/arch/x86_64/ia32/sys_ia32.c	Tue Aug  5 14:43:21 2003
+++ b/arch/x86_64/ia32/sys_ia32.c	Tue Aug  5 14:43:21 2003
@@ -428,8 +428,6 @@
 	return err; 
 }
 
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
-
 asmlinkage long
 sys32_alarm(unsigned int seconds)
 {
diff -Nru a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	Tue Aug  5 14:43:21 2003
+++ b/include/linux/time.h	Tue Aug  5 14:43:21 2003
@@ -217,6 +217,9 @@
 extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
 extern long do_nanosleep(struct timespec *t);
 extern long do_utimes(char __user * filename, struct timeval * times);
+struct itimerval;
+extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
+extern int do_getitimer(int which, struct itimerval *value);
 
 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
diff -Nru a/kernel/compat.c b/kernel/compat.c
--- a/kernel/compat.c	Tue Aug  5 14:43:21 2003
+++ b/kernel/compat.c	Tue Aug  5 14:43:21 2003
@@ -116,8 +116,6 @@
 		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
 }
 
-extern int do_getitimer(int which, struct itimerval *value);
-
 asmlinkage long compat_sys_getitimer(int which, struct compat_itimerval *it)
 {
 	struct itimerval kit;
@@ -128,8 +126,6 @@
 		error = -EFAULT;
 	return error;
 }
-
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
 
 asmlinkage long compat_sys_setitimer(int which, struct compat_itimerval *in,
 		struct compat_itimerval *out)
diff -Nru a/kernel/itimer.c b/kernel/itimer.c
--- a/kernel/itimer.c	Tue Aug  5 14:43:21 2003
+++ b/kernel/itimer.c	Tue Aug  5 14:43:21 2003
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/time.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue Aug  5 14:43:21 2003
+++ b/kernel/timer.c	Tue Aug  5 14:43:21 2003
@@ -841,8 +841,6 @@
 
 #if !defined(__alpha__) && !defined(__ia64__)
 
-extern int do_setitimer(int, struct itimerval *, struct itimerval *);
-
 /*
  * For backwards compatibility?  This can be done in libc so Alpha
  * and all newer ports shouldn't need it.
