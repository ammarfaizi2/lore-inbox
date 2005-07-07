Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVGGBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVGGBXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVGGBVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:21:44 -0400
Received: from [217.7.64.195] ([217.7.64.195]:6332 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S262343AbVGGBTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:19:16 -0400
From: Ernst Herzberg <earny@net4u.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dirty md raid5 slab bio leak [FIXED]
Date: Thu, 7 Jul 2005 03:19:07 +0200
User-Agent: KMail/1.8.1
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <200506272222.51993.list-lkml@net4u.de> <17088.59816.277303.588185@cse.unsw.edu.au> <20050627231718.2f6c3bbf.akpm@osdl.org>
In-Reply-To: <20050627231718.2f6c3bbf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507070319.10065.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2005 08:17, Andrew Morton wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > On Monday June 27, akpm@osdl.org wrote:
> > > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > > > It's OK, I found it.  The bio leaks when writing the md superblock.
> > >
> > > Thanks.
> > >
> > > >  insert a missing bio_put when writting the md superblock.
> > >
> > > Does 2.6.12.x need this?
> >
> > Hmmm.. probably, though it isn't Ooopsable, and isn't a security
> > problem.  Just a slow leak with a trivial patch...
>
> It's a pretty sad bug if it hits you though.
>
> > Is there a web-page somewhere that lists the acceptance criterea? I
> > didn't save the mail message.
>
> Me either.  Just send 'em any old thing and let them decide ;)
>
> > Do I just mail the patch to stable@kernel.org ??
>
> That's OK, I'll add it to my backport queue - we should leave it to bake in
> 2.6.13-rc1 for a bit first.
>

2.6.13-rc1 fixed this. Verified on the same machine, same hardware, same 
disk-failure, but new kernel.

Jul  6 06:33:47 c64 ata4: command 0x35 timeout, stat 0xd8 host_stat 0x0
Jul  6 06:33:47 c64 ata4: status=0xd8 { Busy }
Jul  6 06:33:47 c64 SCSI error : <3 0 0 0> return code = 0x8000002
Jul  6 06:33:47 c64 sdd: Current: sense key: Aborted Command
Jul  6 06:33:47 c64 Additional sense: Scsi parity error
Jul  6 06:33:47 c64 end_request: I/O error, dev sdd, sector 234436299
Jul  6 06:33:47 c64 raid5: Disk failure on sdd3, disabling device. Operation 
continuing on 3 devices

-----------------------
 Active / Total Objects (% used)    : 277222 / 287112 (96.6%)
 Active / Total Slabs (% used)      : 11137 / 11137 (100.0%)
 Active / Total Caches (% used)     : 77 / 118 (65.3%)
 Active / Total Size (% used)       : 42630.65K / 44791.06K (95.2%)
 Minimum / Average / Maximum Object : 0.02K / 0.16K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
220455 216543  98%    0.09K   4899       45     19596K buffer_head
 17283  14714  85%    0.52K   2469        7      9876K radix_tree_node
 11250  10616  94%    0.21K    625       18      2500K dentry_cache
  5940   5930  99%    0.69K    540       11      4320K shmem_inode_cache
  4620   4620 100%    0.17K    210       22       840K vm_area_struct
 [....]


Ordering a new disk drive now:-)

Thanks

<earny>
