Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSGCGWf>; Wed, 3 Jul 2002 02:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSGCGWe>; Wed, 3 Jul 2002 02:22:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63404 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316933AbSGCGWd>;
	Wed, 3 Jul 2002 02:22:33 -0400
Date: Wed, 3 Jul 2002 02:25:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs()
In-Reply-To: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0207030208080.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jul 2002, Paul Menage wrote:

> 
> This patch removes BKL protection from the invocation of the
> super_operations ->statfs() method, and shifts it into the filesystems
> where necessary. Any out-of-tree filesystems may need to take the BKL in
> their statfs() methods if they were relying on it for synchronisation.
> 
> All ->statfs() implementations have been modified to take the BKL,
> except for the following, which don't reference any external mutable
> data:
> 
> simple_statfs
> isofs_statfs
> ncp_statfs
> cramfs_statfs
> romfs_statfs
> 
> Additionally, capifs is changed to use simple_statfs rather than its 
> own home-grown version.

Patch makes sense.  However

	1) please, let's keep Documentation/filesystems/porting more or less
in chronological order.  I.e. somebody who wants to check what's new should
be able to check the end of the list, not hunt through the middle for changes.
IOW, I'd rather see duplicate sections (or even "->statfs() had lost BKL; see
section on ->write_super()")

	2) ext2, shmem, FAT, minix and sysv ->statfs() don't need BKL.

	3) efs and vxfs are read-only.

