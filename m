Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFEBlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTFEBlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:41:17 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:5866 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264015AbTFEBlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:41:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Thu, 5 Jun 2003 11:53:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16094.41647.614418.452777@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm4
In-Reply-To: message from Helge Hafting on Wednesday June 4
References: <20030603231827.0e635332.akpm@digeo.com>
	<20030604211216.GA2436@hh.idb.hist.no>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 4, helgehaf@aitel.hist.no wrote:
> Raid-1 seems to work in 2.5.70-mm4, but raid-0 still fail.
> 
> Trying to boot with raid-0 autodetect yields a long string of:
> Slab error in cache_free_debugcheck
> cache 'size-32' double free or
> memory after object overwritten.
> (Is this something "Page alloc debugging"may be used for?)
> kfree+0xfc/0x330
> raid0_run
> raid0_run
> printk
> blk_queue_make_request
> do_md_run
> md_ioctl
> dput
> blkdev_ioctl
> sys_ioctl
> syscall_call
> 
> I get a ton of these, in between normal
> initialization messages.  Then the thing
> dies with a panic due to exception in interrupt.
> 
> This is a monolithic smp preempt kernel on a dual celeron.
> The disks are scsi, the filesystems ext2.  There is one
> raid-0 array and two raid-1 arrays, as well as some
> ordinary partitions.  Root is on raid-1.
> 
> Helge Hafting

grrr... I thought I had that right...

You need to remove the two calls to 'kfree' at the end of 
create_strip_zones.

I have jsut sent some patches to Linus (and linux-raid@vger) which
will update his tree to include this fix.

NeilBrown
