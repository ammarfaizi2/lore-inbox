Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRJNRcV>; Sun, 14 Oct 2001 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276957AbRJNRcP>; Sun, 14 Oct 2001 13:32:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1791 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275839AbRJNRcA> convert rfc822-to-8bit;
	Sun, 14 Oct 2001 13:32:00 -0400
Date: Sun, 14 Oct 2001 13:32:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <20011014202336.T1074@niksula.cs.hut.fi>
Message-ID: <Pine.GSO.4.21.0110141327080.6026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Ville Herva wrote:

> $ mount --bind -o ro /mnt/ext2-2 /tmp/test

i.e.
mount --bind /mnt/ext2-2 /tmp/test

> $ mount --bind -o remount,ro  /tmp/test           

i.e.
mount -o remount,ro /tmp/test

> $ mount
> (...)
> /dev/hde1 on /mnt/ext2-2 type reiserfs (rw,noatime,nodiratime)
> /mnt/ext2-2 on /tmp/test type none (ro,bind)

Confused mount(8) - apparently uses /etc/mtab and doesn't manage to deduce
the changes done by remounting (/etc/mtab is maintained by userland;
/proc/mounts is handled by kernel and is supposed to be accurate).

> $ touch /mnt/ext2-2/a
> touch: /mnt/ext2-2/a: Read-only file system

Sure, read-only is per-superblock right now.  Change it on one instance
and you've changed it on all of them.

