Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbTCWJf3>; Sun, 23 Mar 2003 04:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbTCWJf3>; Sun, 23 Mar 2003 04:35:29 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22920
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262989AbTCWJf0>; Sun, 23 Mar 2003 04:35:26 -0500
Message-ID: <3E7D8263.20104@redhat.com>
Date: Sun, 23 Mar 2003 01:46:11 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: more generic syscall return bylue type fixes
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36F654704AC0820295C5AA45"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36F654704AC0820295C5AA45
Content-Type: multipart/mixed;
 boundary="------------070303070608050303050805"

This is a multi-part message in MIME format.
--------------070303070608050303050805
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It was good to see the syscall return value types being fixed but still
some cases are missing.  I attach a patch which fixes at least those
which cause problems to me in the moment.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------070303070608050303050805
Content-Type: text/plain;
 name="d-syscall-ret"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-syscall-ret"

--- linux-2.5.65/kernel/posix-timers.c-old	2003-03-21 23:09:34.000000000 -0800
+++ linux-2.5.65/kernel/posix-timers.c	2003-03-23 01:41:55.000000000 -0800
@@ -422,7 +422,7 @@
 
 /* Create a POSIX.1b interval timer. */
 
-asmlinkage int
+asmlinkage long
 sys_timer_create(clockid_t which_clock,
 		 struct sigevent *timer_event_spec, timer_t * created_timer_id)
 {
@@ -662,7 +662,7 @@
 	}
 }
 /* Get the time remaining on a POSIX.1b interval timer. */
-asmlinkage int
+asmlinkage long
 sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
 {
 	struct k_itimer *timr;
@@ -694,7 +694,7 @@
 
  */
 
-asmlinkage int
+asmlinkage long
 sys_timer_getoverrun(timer_t timer_id)
 {
 	struct k_itimer *timr;
@@ -847,7 +847,7 @@
 }
 
 /* Set a POSIX.1b interval timer */
-asmlinkage int
+asmlinkage long
 sys_timer_settime(timer_t timer_id, int flags,
 		  const struct itimerspec *new_setting,
 		  struct itimerspec *old_setting)
@@ -921,7 +921,7 @@
 }
 
 /* Delete a POSIX.1b interval timer. */
-asmlinkage int
+asmlinkage long
 sys_timer_delete(timer_t timer_id)
 {
 	struct k_itimer *timer;
@@ -1056,7 +1056,7 @@
 	return -EINVAL;
 }
 
-asmlinkage int
+asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec *tp)
 {
 	struct timespec new_tp;
@@ -1071,7 +1071,7 @@
 	new_tp.tv_nsec /= NSEC_PER_USEC;
 	return do_sys_settimeofday((struct timeval *) &new_tp, NULL);
 }
-asmlinkage int
+asmlinkage long
 sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;
@@ -1090,7 +1090,7 @@
 	return error;
 
 }
-asmlinkage int
+asmlinkage long
 sys_clock_getres(clockid_t which_clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;

--------------070303070608050303050805--

--------------enig36F654704AC0820295C5AA45
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+fYJj2ijCOnn/RHQRAuZuAKC1dY7X+FCbwVyLxj/BJ+u4LQW1EgCdERp9
rqBTJ4moy9qN9qrO6vA+9jk=
=n9+4
-----END PGP SIGNATURE-----

--------------enig36F654704AC0820295C5AA45--

