Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbTCXWLB>; Mon, 24 Mar 2003 17:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264457AbTCXWLB>; Mon, 24 Mar 2003 17:11:01 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:57233
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264456AbTCXWK6>; Mon, 24 Mar 2003 17:10:58 -0500
Message-ID: <3E7F8505.8020708@redhat.com>
Date: Mon, 24 Mar 2003 14:21:57 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: clone or ptrace bug?
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using strace on an MT application I see strange output from restarted
clone() calls.  Something like this:

[pid 17862]
clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED
  ->  child_stack=0x41147ab0,
flags=CLONE_FILES|CLONE_IDLETASK|CLONE_PTRACE|CLONE_VFORK|CLONE_PARENT|CLONE_THREAD|CLONE_NEWNS|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED|CLONE_UNTRACED|CLONE_CHILD_SETTID|0xbe0000f8,
[17884], {entry_number:6, base_addr:0x41147d40, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, 0x41147d88) = 17884


This is the output of a hacked version of strace.  The part before the
"->" is printed when the syscall enters the kernel.  Normally nothing
gets printed at that time.

The problem is that the flags word is different after the syscall.  This
/might/ not cause any real problems in this case but what happens if the
syscall gets restarted?

In any case, the parameters should be modified.

This is with the 2.5 BK kernel from yesterady or the day before with gcc
3.2.2-5.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+f4UF2ijCOnn/RHQRAuYzAKCpVPRV8rG+NetG3REIC9OrIZLBwQCgsNt6
S5xj6kjpbKCwZl6WVuadcrA=
=tvm4
-----END PGP SIGNATURE-----

