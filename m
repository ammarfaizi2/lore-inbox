Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135714AbRDXStu>; Tue, 24 Apr 2001 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbRDXStl>; Tue, 24 Apr 2001 14:49:41 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:40692 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135714AbRDXStd>; Tue, 24 Apr 2001 14:49:33 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104241847.f3OIlc7T016933@webber.adilger.int>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010424152729.Z2615@arthur.ubicom.tudelft.nl> "from Erik Mouw
 at Apr 24, 2001 03:27:30 pm"
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Date: Tue, 24 Apr 2001 12:47:38 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>,
        Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Mouw writes:
> Al is right, it is no rocket science. Here is a patch against
> 2.4.4-pre6 for procfs and isofs. It took me an hour to do because I'm
> not familiar with the fs code. It compiles, and the procfs code even
> runs (sorry, no CDROM player availeble on my embedded StrongARM
> system), though it is possible that there are some bugs in it.

While I applaud your initiative, you made an unfortunate choice of
filesystems to convert.  The iso_inode_info is only 4*__u32, as is
proc_inode_info.  Given that we still need to keep a pointer to the
external info structs, and the overhead of the slab cache itself
(both CPU usage and memory overhead, however small), I don't think
it is worthwhile to have isofs and procfs in separate slabs.

On the other hand, sockets and shmem are both relatively large...
Watch out that the *_inode_info structs have all of the fields
initialized, because the union field is zeroed for us, but slab is not.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
