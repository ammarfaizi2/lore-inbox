Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWGCT06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWGCT06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGCT06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:26:58 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:30212 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751236AbWGCT06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:26:58 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 20:27:21 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032027.21879.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 11:03, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17
>-mm6/

Doesn't boot reliably as an x86-64 kernel on my X2 system, 3/4 times it oopses 
horribly. Is there some way to supress an oops flood so I can get a decent 
picture of it with vga=extended? Right now I get two useless oopses after the 
first (probably useful) one.

The one time I did get it to boot, I get a lockdep problem (possibly already 
reported, if so I'm sorry);

 =============================================
 [ INFO: possible recursive locking detected ]
 ---------------------------------------------
 mount/1095 is trying to acquire lock:
  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80328ef7>] 
xfs_ilock+0x67/0xa0

 but task is already holding lock:
  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80328ef7>] 
xfs_ilock+0x67/0xa0

 other info that might help us debug this:
 2 locks held by mount/1095:
  #0:  (&inode->i_mutex){--..}, at: [<ffffffff8026ead5>] mutex_lock+0x25/0x30
  #1:  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80328ef7>] 
xfs_ilock+0x67/0xa0

 stack backtrace:

 Call Trace:
  [<ffffffff8027479e>] show_trace+0xae/0x280
  [<ffffffff80274985>] dump_stack+0x15/0x20
  [<ffffffff802afa06>] __lock_acquire+0x936/0xcd0
  [<ffffffff802afe28>] lock_acquire+0x88/0xc0
  [<ffffffff802abe49>] down_write+0x39/0x50
  [<ffffffff80328ef7>] xfs_ilock+0x67/0xa0
  [<ffffffff80329b3a>] xfs_iget+0x2da/0x760
  [<ffffffff80341804>] xfs_trans_iget+0xc4/0x150
  [<ffffffff8032df8e>] xfs_ialloc+0x9e/0x4d0
  [<ffffffff803423df>] xfs_dir_ialloc+0x7f/0x2d0
  [<ffffffff80348e24>] xfs_create+0x364/0x6d0
  [<ffffffff80352e9a>] xfs_vn_mknod+0x16a/0x300
  [<ffffffff8035304b>] xfs_vn_create+0xb/0x10
  [<ffffffff8023f92d>] vfs_create+0x8d/0xf0
  [<ffffffff8021cd42>] open_namei+0x1c2/0x700
  [<ffffffff80229e32>] do_filp_open+0x22/0x50
  [<ffffffff8021b78a>] do_sys_open+0x5a/0xf0
  [<ffffffff80235e5b>] sys_open+0x1b/0x20
  [<ffffffff8026894e>] system_call+0x7e/0x83
  [<000000337b1ac6e2>]
 XFS mounting filesystem sdb1

I'm also getting the same:

kobject_add failed for 0000:00:0b.0:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

..that Reuben reported, multiple times.

Otherwise it's all good.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
