Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbQLEVfz>; Tue, 5 Dec 2000 16:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130120AbQLEVfp>; Tue, 5 Dec 2000 16:35:45 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:33288 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129985AbQLEVfk>;
	Tue, 5 Dec 2000 16:35:40 -0500
Date: Tue, 5 Dec 2000 21:07:16 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: [bug] vfsmount->count accounting broken again?
Message-ID: <Pine.LNX.4.21.0012052102440.1683-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Imagine two ext2 filesystems

/dev/hda1 mounted rw on /boot
/dev/hda3 mounted rw on /usr/src

now mount /dev/hda3 also on /boot

mount -t ext2 /dev/hda3 /boot

this succeeds, which is expected. Now umount it.

umount /boot

this also succeeds, which is expected. Now do df(1) and notice that
/etc/mtab is corrupted and no longer shows the old /boot filesystem even
though we know (from /proc/mounts) that it is mounted. This is a bug but a
userspace one (should mail Andries later, probably util-linux). Now, the
interesting bit, i.e. the kernel bug:

umount /boot

this fails with EBUSY. So, I think the reference count has gone wrong
somewhere -- I will put debugging code in do_umount() and see, but
everyone is welcome to fix it before I do so...

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
