Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRIBWQb>; Sun, 2 Sep 2001 18:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRIBWQU>; Sun, 2 Sep 2001 18:16:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269770AbRIBWQG>; Sun, 2 Sep 2001 18:16:06 -0400
Subject: NFS client bug
To: linux-kernel@vger.kernel.org
Date: Sun, 2 Sep 2001 23:20:09 +0100 (BST)
Cc: trond.myklebust@fys.uio.no
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dfb7-0000Vd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During some discussion with Al Viro about the right way to do supermount he
complained that it probably wanted doing in userspace. Anyway I was actually
annoyed enough with the magicdev program to try and do this.

I have it working for a subset of working (only one device, hardcoded path)
except for what seems to be an NFS client bug.

For obvious reasons I mount with very little caching in the client. 
[mount -oport=497,mountprog=200005,noac,nolock,soft
	127.0.0.1:/var/cache/volumagic/cdrom /mnt/cdrom]

Everything is fine until I do 

	cd /mnt/cdrom/somedir

[remove CD, insert different CD]

	ls

	[stale NFS file handle - correct so far]

[remove CD, insert original CD]

	ls

	[stale NFS file handle - cached on client - wrong]

It then gets more bizarre

	cd /mnt/cdrom/somedir

	[Looks ok a new filehandle, works ok]
	ls
	[Immediate stale NFS file handle from client - no traffic]

It seems this 'dead' handle remains stuck in the system until umount.

Alan
