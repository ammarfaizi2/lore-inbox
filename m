Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQLAXo5>; Fri, 1 Dec 2000 18:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129844AbQLAXor>; Fri, 1 Dec 2000 18:44:47 -0500
Received: from web9503.mail.yahoo.com ([216.136.129.133]:18961 "HELO
	web9503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129724AbQLAXob>; Fri, 1 Dec 2000 18:44:31 -0500
Message-ID: <20001201231359.94203.qmail@web9503.mail.yahoo.com>
Date: Fri, 1 Dec 2000 15:13:59 -0800 (PST)
From: Georgina Russell <sfbebe@yahoo.com>
Subject: /proc/mounts doesn't resolve user names
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm using kernel version 2.2.14.  When the mount
syscall or mount command is called, the user given
name of the mount point isn't resolved.  These means
that /proc/mounts will have entries with symlinks
while /etc/mtab will have the real directory.

In the case of smbmnt, chdir is called on the mount
point, and subsequently, the mount syscall is given
"." as it's second arguemnt.

This means "." is in /proc/mounts, and when a samba
mount is left unmounted at time of shutdown, the
shutdown routine goes through /proc/mount and tries to
remove all of the processes in directories which are
still mounted.   As you might have figured, it tries
to remove all processes in the cwd, which includes
itself.   The shutdown hangs forever.


I heard this was fixed in 2.40 testx, but I can't use
that kernel.  Does anyone know of a fix for 2.2.14?


Thanks so much,
Georgina






__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
