Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264713AbTFEPGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbTFEPGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:06:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43012 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264713AbTFEPGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:06:19 -0400
Date: Thu, 5 Jun 2003 17:24:20 +0200
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm4 this helped but still no raid0
Message-ID: <20030605152420.GA951@hh.idb.hist.no>
References: <20030603231827.0e635332.akpm@digeo.com> <20030604211216.GA2436@hh.idb.hist.no> <16094.41647.614418.452777@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16094.41647.614418.452777@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 11:53:51AM +1000, Neil Brown wrote:
[...]
> grrr... I thought I had that right...
> 
> You need to remove the two calls to 'kfree' at the end of 
> create_strip_zones.
> 
I commented out the two kfree's, and the kernel managed to boot.
But the raid-0 array didn't work.  The boot scripts
tried to fsck it, but couldn't get a valid ext2 superblock.
(fsck -f under 2.5.69-mm8 showed no problems, the fs was clean.)

Then it was mount time.  Various partition and raid-1 based
fses mounted fine, but mounting the raid-0 on /usr/src killed the kernel:
 
unable to handle kernel NULL pointer deref at virtual address 00000014
PREEMPTSMP
EIP at raid0_make_request
process mount
bh_lru_install
generic_make_request
autoremove_wake_function
bio_alloc
submit_bio
__bread_slow_wq
__bread
ext2_fill_super
sb_set_blocksize
get_sb_bdev
alloc_vfsmnt
ext2_get_sb
ext2_fill_super
do_kern_mount
do_add_mount
do_mount
copy_mount_options
sys_mount
syscall_call


Looks like something else is wrong with raid-0.

> I have jsut sent some patches to Linus (and linux-raid@vger) which
> will update his tree to include this fix.
> 
Were there anything more than removal of the two kfrees?

Helge Hafting
