Return-Path: <linux-kernel-owner+w=401wt.eu-S932804AbWL0NBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbWL0NBd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932808AbWL0NBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:01:33 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:36755 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932804AbWL0NBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:01:32 -0500
Message-ID: <041601c729b6$f81e4af0$0400a8c0@dcccs>
From: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "David Chinner" <dgc@sgi.com>
Cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>, <dgc@sgi.com>
References: <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs> <20061219025229.GT33919298@melbourne.sgi.com> <20061219044700.GW33919298@melbourne.sgi.com>
Subject: Re: xfslogd-spinlock bug?
Date: Wed, 27 Dec 2006 13:58:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

----- Original Message ----- 
From: "David Chinner" <dgc@sgi.com>
To: "David Chinner" <dgc@sgi.com>
Cc: "Haar János" <djani22@netcenter.hu>; <linux-xfs@oss.sgi.com>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, December 19, 2006 5:47 AM
Subject: Re: xfslogd-spinlock bug?


> On Tue, Dec 19, 2006 at 01:52:29PM +1100, David Chinner wrote:
> > On Tue, Dec 19, 2006 at 12:39:46AM +0100, Haar János wrote:
> > > From: "David Chinner" <dgc@sgi.com>
> > > > #define POISON_FREE 0x6b
> > > >
> > > > Can you confirm that you are running with CONFIG_DEBUG_SLAB=y?
> > >
> > > Yes, i build with this option enabled.
>
> ......
>
> > FWIW, I've run XFSQA twice now on a scsi disk with slab debuggin turned
> > on and I haven't seen this problem. I'm not sure how to track down
> > the source of the problem without a test case, but as a quick test, can
> > you try the following patch?
>
> Third try an I got a crash on a poisoned object:
>
> [1]kdb> md8c40 e00000300d7d5100
> 0xe00000300d7d5100 000000005a2cf071 0000000000000000   q.,Z............
> 0xe00000300d7d5110 000000005a2cf071 6b6b6b6b6b6b6b6b   q.,Z....kkkkkkkk
> 0xe00000300d7d5120 e0000039eb7b6320 6b6b6b6b6b6b6b6b    c{.9...kkkkkkkk
> 0xe00000300d7d5130 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d5140 6b6b6b6f6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkokkkkkkkkkkk
> 0xe00000300d7d5150 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d5160 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d5170 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d5180 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d5190 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d51a0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d51b0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d51c0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
> 0xe00000300d7d51d0 6b6b6b6b6b6b6b6b a56b6b6b6b6b6b6b   kkkkkkkkkkkkkkk.
> 0xe00000300d7d51e0 000000005a2cf071 a000000100468c30   q.,Z....0.F.....
> [1]kdb> mds 0xe00000300d7d51e0
> 0xe00000300d7d51e0 5a2cf071   q.,Z....
> 0xe00000300d7d51e8 a000000100468c30 xfs_inode_item_destroy+0x30
>
> So the use-after-free here is on an inode item. You're tripping
> over a buffer item.
>
> Unfortunately, it is not the same problem - the problem I've just
> hit is to do with a QA test that does a forced shutdown on an active
> filesystem, and:
>
> [1]kdb> xmount 0xe00000304393e238
> .....
> flags 0x440010 <FSSHUTDOWN IDELETE COMPAT_IOSIZE >
>
> The filesystem was being shutdown so xfs_inode_item_destroy() just
> frees the inode log item without removing it from the AIL. I'll fix that,
> and see if i have any luck....
>
> So I'd still try that patch i sent in the previous email...

I still using the patch, but didnt shows any messages at this point.

I'v got 3 crash/reboot, but 2 causes nbd disconneted, and this one:

Dec 27 13:41:29 dy-base BUG: warning at
kernel/mutex.c:220/__mutex_unlock_common_slowpath()
Dec 27 13:41:29 dy-base Unable to handle kernel paging request at
0000000066604480 RIP:
Dec 27 13:41:29 dy-base  [<ffffffff80222c64>] resched_task+0x12/0x64
Dec 27 13:41:29 dy-base PGD 115246067 PUD 0
Dec 27 13:41:29 dy-base Oops: 0000 [1] SMP
Dec 27 13:41:29 dy-base CPU 1
Dec 27 13:41:29 dy-base Modules linked in: nbd rd netconsole e1000 video
Dec 27 13:41:29 dy-base Pid: 4069, comm: httpd Not tainted 2.6.19 #3
Dec 27 13:41:29 dy-base RIP: 0010:[<ffffffff80222c64>]  [<ffffffff80222c64>]
resched_task+0x12/0x64
Dec 27 13:41:29 dy-base RSP: 0018:ffff810105c01b78  EFLAGS: 00010083
Dec 27 13:41:29 dy-base RAX: ffffffff807d5800 RBX: 00001749fd97c214 RCX:
ffff81001cbd0000
Dec 27 13:41:29 dy-base RDX: 000000001cbd0048 RSI: ffff810005834068 RDI:
ffff8101047bf040
Dec 27 13:41:29 dy-base RBP: ffff810105c01b78 R08: 0000000000000001 R09:
0000000000000000
Dec 27 13:41:29 dy-base R10: 0000000000000057 R11: ffff81000583cd80 R12:
ffff810116693140
Dec 27 13:41:29 dy-base R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
Dec 27 13:41:29 dy-base FS:  00002ba3c1ad07d0(0000)
GS:ffff81011fc769c8(0000) knlGS:0000000000000000
Dec 27 13:41:29 dy-base CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 27 13:41:29 dy-base CR2: 0000000066604480 CR3: 0000000118196000 CR4:
00000000000006e0
Dec 27 13:41:29 dy-base Process httpd (pid: 4069, threadinfo
ffff810105c00000, task ffff8101166e1040)
Dec 27 13:41:29 dy-base Stack:  ffff810105c01bf8 ffffffff80223f37
ffff810002996a00 0000000002cba600
Dec 27 13:41:29 dy-base  000000000000000f 0000000000000001 ffff810005833700
0000000100000000
Dec 27 13:41:29 dy-base  0000000000000005 0000000000000296 ffff810105c01bd8
ffff810117fef690
Dec 27 13:41:29 dy-base Call Trace:
Dec 27 13:41:29 dy-base  [<ffffffff80223f37>] try_to_wake_up+0x3a7/0x3dc
Dec 27 13:41:29 dy-base  [<ffffffff80223f98>] wake_up_process+0x10/0x12
Dec 27 13:41:29 dy-base  [<ffffffff803c9186>] xfsbufd_wakeup+0x34/0x61
Dec 27 13:41:29 dy-base  [<ffffffff8025cdf9>] shrink_slab+0x64/0x163
Dec 27 13:41:29 dy-base  [<ffffffff8025d913>] try_to_free_pages+0x19c/0x289
Dec 27 13:41:29 dy-base  [<ffffffff80258b62>] __alloc_pages+0x1b8/0x2c0
Dec 27 13:41:29 dy-base  [<ffffffff80267f94>] anon_vma_prepare+0x29/0xf1
Dec 27 13:41:29 dy-base  [<ffffffff80260d52>] __handle_mm_fault+0x496/0x9e3
Dec 27 13:41:29 dy-base  [<ffffffff805e7dfd>] _spin_unlock+0x9/0xb
Dec 27 13:41:29 dy-base  [<ffffffff8021a1b6>] do_page_fault+0x418/0x7b6
Dec 27 13:41:29 dy-base  [<ffffffff802082ed>] __switch_to+0x280/0x28f
Dec 27 13:41:29 dy-base  [<ffffffff805e7efb>] _spin_unlock_irq+0x9/0xc
Dec 27 13:41:29 dy-base  [<ffffffff805e5ca8>] thread_return+0x5e/0xf7
Dec 27 13:41:29 dy-base  [<ffffffff805e809d>] error_exit+0x0/0x84
Dec 27 13:41:29 dy-base
Dec 27 13:41:29 dy-base
Dec 27 13:41:29 dy-base Code: 48 8b 14 d5 40 42 78 80 48 03 42 08 8b 00 85
c0 7e 0a 0f 0b
Dec 27 13:41:29 dy-base RIP  [<ffffffff80222c64>] resched_task+0x12/0x64
Dec 27 13:41:29 dy-base  RSP <ffff810105c01b78>
Dec 27 13:41:29 dy-base CR2: 0000000066604480
Dec 27 13:41:29 dy-base  <0>Kernel panic - not syncing: Fatal exception
Dec 27 13:41:29 dy-base
Dec 27 13:41:29 dy-base Rebooting in 5 seconds..

I found one bug on my apache config, and i think, the test case is changed.
:-(
Before the config is fixed, some users can stress the xfs source device
readahead, and can periodically overload the system, with this action.
I think, the original bug only comes on the highly overloaded system, and
about readahead+buffering/caching.

Thanks,
Janos

>
> Cheers,
>
> Dave.
> -- 
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group

