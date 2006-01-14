Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWANWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWANWtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWANWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:49:15 -0500
Received: from tornado.reub.net ([202.89.145.182]:225 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751342AbWANWtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:49:14 -0500
Message-ID: <43C97FE6.8040402@reub.net>
Date: Sun, 15 Jan 2006 11:49:10 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060114)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm4
References: <20060114055153.04684592.akpm@osdl.org>
In-Reply-To: <20060114055153.04684592.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2006 2:51 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/
> 
> (Will take an hour or so to mirror)
> 
> 
> 
> - Lots of mutex conversions
> 
> - FUSE update
> 
> - nfsd update (mainly nfs4)
> 
> - CPU scheduler update
> 
> - A few new syscalls.

A couple of issues to look at with this kernel, it seems.  I'll report them one 
by one, each in a different message so as to work the threading properly.

A trace:

Freeing unused kernel memory: 196k freed
Write protecting the kernel read-only data: 655k
Badness in blk_do_ordered at block/ll_rw_blk.c:549
  [<b01040d1>] show_trace+0xd/0xf
  [<b0104172>] dump_stack+0x17/0x19
  [<b01e2926>] blk_do_ordered+0x301/0x306
  [<b01de3a5>] elv_next_request+0x3a/0x120
  [<b0257ed1>] scsi_request_fn+0x57/0x2d5
  [<b01e0fc3>] __generic_unplug_device+0x22/0x25
  [<b01e119a>] generic_unplug_device+0x2c/0x39
  [<b028fb2c>] unplug_slaves+0x5d/0xea
  [<b028fbca>] raid1_unplug+0x11/0x1f
  [<b01ded12>] blk_backing_dev_unplug+0xf/0x11
  [<b01596a0>] sync_buffer+0x2e/0x37
  [<b030ab61>] __wait_on_bit+0x45/0x62
  [<b030abe9>] out_of_line_wait_on_bit+0x6b/0x82
  [<b0159600>] __wait_on_buffer+0x27/0x2d
  [<b01a7888>] search_by_key+0x14e/0x11a5
  [<b019431f>] reiserfs_read_locked_inode+0x64/0x561
  [<b019488c>] reiserfs_iget+0x70/0x88
  [<b01917c0>] reiserfs_lookup+0xbf/0x10e
  [<b016366e>] do_lookup+0x105/0x132
  [<b01647fd>] __link_path_walk+0x11e/0xd4b
  [<b0165470>] link_path_walk+0x46/0xd2
  [<b0165715>] do_path_lookup+0xa9/0x215
  [<b01661c0>] __path_lookup_intent_open+0x44/0x7f
  [<b0166273>] path_lookup_open+0x21/0x27
  [<b0166367>] open_namei+0x62/0x5a0
  [<b0155a52>] do_filp_open+0x26/0x43
  [<b0155ab0>] do_sys_open+0x41/0xc2
  [<b0155b69>] sys_open+0x1c/0x1e
  [<b0100460>] init+0x193/0x325
  [<b0100d25>] kernel_thread_helper+0x5/0xb
INIT: version 2.86 booting

It has never properly blown up into a full detailed oops, just spews out the 
trace to console and then hangs.

I've seen this multiple times today, it is however fatal as every time it has 
occurred the box needs a reset.

reuben




