Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTDDAJu (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTDDAJu (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 19:09:50 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53982 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263582AbTDDAJp convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 19:09:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: mounting 4000 disks
Date: Thu, 3 Apr 2003 16:19:01 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304031520.52138.pbadari@us.ibm.com> <20030403154314.7b8604c9.akpm@digeo.com>
In-Reply-To: <20030403154314.7b8604c9.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304031619.01424.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 April 2003 03:43 pm, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > Hi,
> >
> > I have been playing with testing 4000 disk support. (using 32bit dev_t).
> >
> > I created 4000 disks using scsi_debug and mounted them.
> > We consumed 84MB of low memory by just mouting 4000 filesystems.
> > Out of 84MB lowmem 48MB is in slabs. 33 MB is used by buffers.
>
> 20 kbytes per disk+filesystem seems reasonable.
>
> The "Buffers" will be the superblock (4k) and the group descriptor blocks
> (256 bytes per gigabyte of disk).  These are pinned memory.
>
> And the ext2 superblock got bigger in -mm due to the recent scalability
> patches.
>
> What is using the "size-8192" allocation there?  It could be the ext2
> superblock if you have NR_CPUS=32.

I think so..

Apr  3 17:21:46 elm3b78 kernel:  [<c013f71b>] kmalloc+0x5b/0x1d0
Apr  3 17:21:46 elm3b78 kernel:  [<c0208d62>] vsnprintf+0x2a2/0x430
Apr  3 17:21:46 elm3b78 kernel:  [<c01aae3b>] ext2_fill_super+0x2b/0x8f0
Apr  3 17:21:46 elm3b78 kernel:  [<c0208f09>] snprintf+0x19/0x20
Apr  3 17:21:46 elm3b78 kernel:  [<c025ad88>] __bdevname+0xc8/0x110
Apr  3 17:21:46 elm3b78 kernel:  [<c015cd60>] get_sb_bdev+0xe0/0x130
Apr  3 17:21:46 elm3b78 kernel:  [<c0172579>] alloc_vfsmnt+0x79/0xb0
Apr  3 17:21:46 elm3b78 kernel:  [<c016330e>] real_lookup+0x5e/0xd0
Apr  3 17:21:46 elm3b78 kernel:  [<c01aba8e>] ext2_get_sb+0x1e/0x30
Apr  3 17:21:46 elm3b78 kernel:  [<c01aae10>] ext2_fill_super+0x0/0x8f0
Apr  3 17:21:46 elm3b78 kernel:  [<c015cf34>] do_kern_mount+0x44/0xc0
Apr  3 17:21:46 elm3b78 kernel:  [<c0173ba9>] do_add_mount+0x79/0x170
Apr  3 17:21:46 elm3b78 kernel:  [<c0109d8d>] error_code+0x2d/0x38
Apr  3 17:21:46 elm3b78 kernel:  [<c0173ebb>] do_mount+0x14b/0x170
Apr  3 17:21:46 elm3b78 kernel:  [<c0173d13>] copy_mount_options+0x73/0xd0
Apr  3 17:21:46 elm3b78 kernel:  [<c017455d>] sys_mount+0xed/0x180
Apr  3 17:21:46 elm3b78 kernel:  [<c0109303>] syscall_call+0x7/0xb

