Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbRFCP13>; Sun, 3 Jun 2001 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbRFCP1T>; Sun, 3 Jun 2001 11:27:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13494 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263167AbRFCPL1>;
	Sun, 3 Jun 2001 11:11:27 -0400
Date: Sun, 3 Jun 2001 17:10:53 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106031510.RAA186549.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: symlink_prefix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Sun Jun  3 13:25:31 2001

    > [One could start a subdiscussion about that part.
    > The mount(2) system call needs to transport vfs information
    > and per-fs information. So far, the vfs information used
    > flag bits only, but sooner or later we'll want to have
    > strings, and need a vfs_parse_mount_options().
    > Indeed, many filesystems today have uid= and gid= and
    > umask= options that might be removed from the individual
    > filesystems and put into vfs. After all, such options
    > are also useful for (foreign) ext2 filesystems.]

    _Please_, if we do anything of that kind - let's use a new syscall.
    Ideally, I'd say
        fs_fd = open("/fs/ext2", O_RDWR);
        /* error -> no such filesystem */
        write(fs_fd. "/dev/sda1", strlen("/dev/sda1"));
        /* error handling */
        write(fs_fd, "reserve=5", strlen(....));
        ...
        dir = open("/usr/local", O_DIRECTORY);
        /* error handling */
        new_mount(dir, MNT_SET, fs_fd);    /* closes dir and fs_fd */
        /* error handling */

    Comments?

I do not think this is an improvement. Anyway, it is orthogonal
to what I discussed.

[My version: keep interface constant, reorganize kernel source
to do certain things in one place instead of in several places.
Advantage: treatment becomes uniform and some options that make sense
for all filesystem types but are available today for some only
are generalized.
Your version: invent a new interface, be silent about what happens
inside the kernel.]

Andries
