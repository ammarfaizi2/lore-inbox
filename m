Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135752AbRAGG0N>; Sun, 7 Jan 2001 01:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135766AbRAGG0C>; Sun, 7 Jan 2001 01:26:02 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:28859 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135752AbRAGGZu>; Sun, 7 Jan 2001 01:25:50 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 6 Jan 2001 22:25:43 -0800
Message-Id: <200101070625.WAA01585@adam.yggdrasil.com>
To: pavenis@latnet.lv
Subject: Re: devfs breakage in 2.4.0 release
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	On my Sony PictureBook PCG-C1VN, 2.4.0 hangs in the boot
process while 2.4.0-prerelease boots just fine.  At first I thought
the problem was devfs-related, but skipping devfsd just caused the
hang to occur a little later, this time in ifconfig.  The kernel
call trace looked something like this:

	neigh_ifdown
	sys_ioctl
	sock_ioctl
	[some addresses in modules]
	stext_lock
	__down_failed
	__down

	What surprised me more was that attempting to remount the
root filesystem for writing just before this (to record the module
kernel symbols) caused a kenel BUG() in slab.c:1542 becuase kmalloc
was being called with a huge negative number.

	I know I could run ksymoops to get this trace, but I now
think the cause of the problem probably happens much earlier than
the symptoms.  So, I trying backing out different 2.4.0 changes.
So far, I can tell you that reverting the linux/mm subdirectory to
its 2.4.0-prerelease contents had no effect.  I will let you know
if I diagnose or fix the problem, as I think you may be experiencing
the same problem.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
