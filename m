Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbTGLFIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267652AbTGLFIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:08:24 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:10692
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S267638AbTGLFIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:08:21 -0400
Message-ID: <3F0F9B0C.10604@redhat.com>
Date: Fri, 11 Jul 2003 22:22:20 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030710 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: utimes/futimes/lutimes syscalls
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With the introduction of the nanosecond fields in struct stat the
utime() syscall is kind of obsolete.  It's not possible anymore to
restore the exact access/modification time of a file.

Unix defines the utimes() function for this.  It is currently
implementated in glibc on top of the utime() syscall which used to be OK
but isn't anymore today.  In addition some systems provide the futimes()
and lutimes() functions which appropriate semantics.

The question: would a patch introducing these syscalls be accepted?  If
there are filesystems which store the sub-seconds on disk I think this
is necessary since otherwise all kinds of programs (including archives)
cannot be written correctly.  If the sub-seconds only live in memory I
still think it would be good to have the syscalls but it would not be
that urgent.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/D5sS2ijCOnn/RHQRAjhgAJoCHPLGWjvK6VUxVmyJx/MPnwzjeQCggpmy
1qKasu1RgrliP4QA0t9QuUE=
=NQyO
-----END PGP SIGNATURE-----

