Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUBXVdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUBXVdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:33:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19328 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262314AbUBXVdm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:33:42 -0500
Date: Tue, 24 Feb 2004 16:34:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: /proc/mounts "stuff"
Message-ID: <Pine.LNX.4.53.0402241630500.4054@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux version 2.2.24 (actually since pivot-root), have a
problem with what's in /proc/mounts vs. what's written
to /etc/mtab when mounting file-systems.

/etc/mtab

/dev/sda1 / ext2 rw 0 0
none /proc proc rw 0 0
none /dev/pts devpts rw,gid=5,mode=620 0 0
none /dev/shm tmpfs rw 0 0
/dev/sdb1 /usr/src ext2 rw 0 0

/proc/mounts

rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/sdb1 /usr/src ext2 rw 0 0

/etc/issue

Red Hat Linux release 8.0 (Psyche)
Kernel 2.4.24 on a i586

On that system /dev/root doesn't even exist!
Neither does rootfs in any accessible way. Therefore,
the shutdown routine(s) that read /proc/mounts will
fail, leaving improperly dismounted volumes.  Basically,
if I execute `init 0` from the console, everything's
fine, but executing 'reboot' from a network connection
will result in a long fsucking startup.

I think the two unusable entries should not show in
/proc/mounts,
	rootfs / rootfs rw 0 0
	/dev/root / ext2 rw 0 0
That would fix the problem because there is no way to
umount either of them. Try it, `umount rootfs` returns
ENOENT as does `umount /dev/root'`.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


