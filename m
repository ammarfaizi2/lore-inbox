Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265235AbTLFTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLFTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:35:57 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:48797
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265235AbTLFTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:35:54 -0500
Message-ID: <3FD22F5D.1000806@redhat.com>
Date: Sat, 06 Dec 2003 11:34:53 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031121 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FIx  'noexec' behavior
References: <20031206191829.23188.qmail@web14904.mail.yahoo.com>
In-Reply-To: <20031206191829.23188.qmail@web14904.mail.yahoo.com>
X-Enigmail-Version: 0.82.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jon Smirl wrote:

> /dev/sda5               /                       ext3    defaults        1 1
> /dev/sda1               /boot                   ext3    defaults        1 2
> LABEL=/dos              /rh9                    ext3    defaults        1 2
> /dev/sda2               swap                    swap    defaults        0 0
> /dev/hda3               swap                    swap    defaults        0 0
> /dev/cdrom              /mnt/cdrom              udf,iso9660
> noauto,owner,kudzu,ro 0 0
> /dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0
> none                    /sys                    sysfs   defaults        0 0
> tmpfs                   /tmp                    tmpfs   defaults,size=800M 0 0
> none                    /dev/pts                devpts  gid=5,mode=620  0 0
> none                    /proc                   proc    defaults        0 0
> none                    /dev/shm                tmpfs   defaults        0 0
> /dev/md0                /home                   ext3    defaults        1 2
> /dev/cdrom1             /mnt/cdrom1             udf,iso9660
> noauto,owner,kudzu,ro 0 0

Unless one of the filesystems does something funny and sets the noexec
bit automatically, I see nothing which could cause the problem since
there is no "noexec" anywhere.  Maybe you have additional mounts.
Instead of looking at fstab, send the output of running "mount" without
any parameter.

Also, you can try running mozilla with strace -f.  Redirect the strace
output to a file with the -o option.  Mozilla should work if you use an
updated RHL9 or FC1 installation.  This will show where the program
tries to use mmap in a way conflicting with the patch.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0i9d2ijCOnn/RHQRAhojAKC/PCc9Q7zStuglTS7jql9OOW65+gCeJkmm
7Dm7Kd72Sju/Km977wGFGxY=
=DGsA
-----END PGP SIGNATURE-----
