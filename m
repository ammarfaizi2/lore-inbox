Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTA2NqB>; Wed, 29 Jan 2003 08:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTA2NqA>; Wed, 29 Jan 2003 08:46:00 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:12754 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265982AbTA2NqA>;
	Wed, 29 Jan 2003 08:46:00 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15927.56648.966141.528675@harpo.it.uu.se>
Date: Wed, 29 Jan 2003 14:55:20 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.5.59 NFS server keeps local fs live after being stopped
CC: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.59. A local ext2 file system is mounted at $MNTPNT
and exported through NFS V3. A client mounts and unmounts it,
w/o any I/O in between. The NFS server is shut down. Nothing in
user-space refers to $MNTPNT.

The bug is that $MNTPNT now can't be unmounted. umount fails with
"device is busy". A forced umount at shutdown fails with "device
or resource busy" and "illegal seek", and leaves the underlying
fs marked dirty.

I can't say exactly when this began, but the problem is present
in 2.5.59 and 2.5.55. 2.4.21-pre4 does not have this problem.

/Mikael
