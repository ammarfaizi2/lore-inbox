Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRLLOv1>; Wed, 12 Dec 2001 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280531AbRLLOvS>; Wed, 12 Dec 2001 09:51:18 -0500
Received: from dryas.atms.unca.edu ([152.18.35.216]:36744 "EHLO
	dryas.atms.unca.edu") by vger.kernel.org with ESMTP
	id <S280448AbRLLOvF>; Wed, 12 Dec 2001 09:51:05 -0500
Message-Id: <200112121451.fBCEp1619089@dryas.atms.unca.edu>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrea Arcangeli <andrea@suse.de>
From: Leigh Orf <orf@mailbag.com>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
        Ken Brownfield <brownfld@irridia.com>, Andrew Morton <akpm@zip.com.au>,
        Anton Altaparmakov <aia21@cam.ac.uk>
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: Your message of "Tue, 11 Dec 2001 23:59:08 +0100."
             <20011211235908.L4801@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Dec 2001 09:51:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

I disabled ntfs and as you suspected my problem went away. This worked
for both 2.4.16 and 2.4.17pre4aa1.

Thanks a lot,

Leigh Orf

Andrea Arcangeli wrote:

|   Even better would be to change fs/ntfs/* to avoid using vmalloc for tons
|   of little pieces. It's not only a matter of wasting direct mapped
|   address space, but it's also a matter of running fast, mainly on SMP
|   with the IPI for the tlb flushes...
|   
|   attr.c:233:		new = ntfs_vmalloc(new_size);
|   attr.c:235:			ntfs_error("ntfs_insert_run:
|   ntfs_vmalloc(new_size = "
|   attr.c:458:			rlt = ntfs_vmalloc(rl_size);
|   inode.c:1297:		rl = ntfs_vmalloc(rlen << sizeof(ntfs_runlist));
|   inode.c:1638:					rlt =
|   ntfs_vmalloc(rl_size);
|   inode.c:1942:		rl2 = ntfs_vmalloc(rl2_size);
|   inode.c:2006:			rlt = ntfs_vmalloc(rl_size);
|   super.c:810:				rlt = ntfs_vmalloc(rlsize);
|   super.c:1335:		buf = ntfs_vmalloc(buf_size);
|   support.h:29:#include <linux/vmalloc.h>
|   support.h:35:#define ntfs_vmalloc(size)	vmalloc_32(size)
|   
|   
|   In short there are three solutions avaialble:
|   
|   1) don't use ntfs
|   2) fix ntfs
|   3) enlarge vmalloc address space with the above patch, but this won't be
|      a final solution because you'll overflow again the vmalloc address
|      space by adding the double of files in your fs
|   
|   So I'd redirect this report to Anton Altaparmakov <aia21@cam.ac.uk> and
|   I still have no VM bugreport pending from my part.
|   
|   thanks,
|   
|   Andrea

