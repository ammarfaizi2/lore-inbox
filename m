Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282276AbRLDCfY>; Mon, 3 Dec 2001 21:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282958AbRLDCfI>; Mon, 3 Dec 2001 21:35:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62336 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282992AbRLDCeD>;
	Mon, 3 Dec 2001 21:34:03 -0500
Date: Mon, 3 Dec 2001 21:34:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Donald Becker <becker@scyld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.40.0112031816280.1381-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.GSO.4.21.0112032122330.17686-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[apologies for over-the-head reply]

> On Mon, 3 Dec 2001, Donald Becker wrote:

> >    a SCSI device layer that isn't three half-finished clean-ups
<nod>

> >    a VFS layer that doesn't require the kernel to know a priori all of
> >      the filesystem types that might be loaded

WTF?  The only interpretation I can think of is about unions in struct
inode and struct superblock.  _If_ you add a filesystem that
	a) doesn't do separate allocation of fs-private parts of
inode/superblock (i.e. doesn't use ->u.gerneric_ip and ->u.generic_sbp) and
	b) hadn't been known at kernel compile time and
	c) has one of these fields (member in inode->u or sb->u) bigger than
all filesystems known at compile time

- yes, you've got a problem.

Solution: use ->u.generic_<...>.  Works fine.

Not to mention the fact that VFS per se doesn't give a damn for fs types.
All it needs is sizeof(struct inode) and sizeof(struct superblock).  And
any fs using ->generic_<...> (i.e. pointer to separately allocated private
objects) is OK, whether it was known at build time or not.

