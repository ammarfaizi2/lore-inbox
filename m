Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131641AbRCSXH3>; Mon, 19 Mar 2001 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbRCSXHT>; Mon, 19 Mar 2001 18:07:19 -0500
Received: from [63.109.146.2] ([63.109.146.2]:19444 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131641AbRCSXHN>;
	Mon, 19 Mar 2001 18:07:13 -0500
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B42@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Jeremy Jackson'" <jerj@coplanar.net>, root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: on /etc/mtab vs. /proc/mounts (Was RE: Linux should better cope w
	ith power failure)
Date: Mon, 19 Mar 2001 15:05:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Recipients trimmed, as this is a major change of topic...)
[big cut]

> Actually, I think /etc/mtab is not needed at all.   

This is already mostly correct, AFAIK.

My embedded system uses "busybox" for mount and umount, /etc/mtab 
does not exist, and the root file system is readonly.  

But if I do "umount -a" it works.  So the busybox umount is already 
reading /proc/mounts.

The only oddity I see with using /proc/mounts is that it shows:
/dev/root / ext2 rw 0 0
instead of
/dev/hda1 / ext2 rw 0 0

but this doesn't seem to cause any problems... even though /dev/root
does not exist (!)

In fact, the "mount" man page on my Mandrake 7.2 system says:

"It is possible to replace /etc/mtab by a symbolic link to 
/proc/mounts..."  and then goes on to describe some of the issues and
problems with doing so - loopback, and paths with spaces seem to
be the significant ones.

Hopefully those problems can and will be solved soon, and then
we can get rid of /etc/mtab completely, and keep the root partition
read only almost all the time.

Torrey Hoffman
