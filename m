Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWG0VC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWG0VC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWG0VCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:55 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:54415 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1751241AbWG0VCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:43 -0400
Subject: Re: 2.6.17-mm5
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: Andrew Morton <akpm@osdl.org>
Cc: Grant Wilson <grant.wilson@zen.co.uk>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@suse.de>, linux-scsi@vger.kernel.org
In-Reply-To: <20060701143047.b3975472.akpm@osdl.org>
References: <20060701033524.3c478698.akpm@osdl.org>
	 <20060701142419.GB28750@tlg.swandive.local>
	 <20060701143047.b3975472.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 17:02:16 -0400
Message-Id: <1154034137.2783.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 14:30 -0700, Andrew Morton wrote:
> On Sat, 1 Jul 2006 15:24:19 +0100
<...>

> 
> > [  155.123022] Unable to handle kernel NULL pointer dereference at 0000000000000048 RIP: 
> > [  155.155867]  [<ffffffff8047157a>] md_error+0x45/0x91
> > [  155.200353] PGD 77954067 PUD 726e5067 PMD 0 
> > [  155.226233] Oops: 0000 [1] PREEMPT SMP 
> > [  155.249516] last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> > [  155.292808] CPU 0 
> > [  155.304968] Modules linked in: dm_mod evdev
> > [  155.330331] Pid: 0, comm: swapper Not tainted 2.6.17-mm5 #1
> > [  155.363697] RIP: 0010:[<ffffffff8047157a>]  [<ffffffff8047157a>] md_error+0x45/0x91
> > [  155.409638] RSP: 0018:ffffffff807a0c50  EFLAGS: 00010046
> > [  155.441445] RAX: 0000000000000000 RBX: ffff81007aa34708 RCX: 000000000000003f
> > [  155.484216] RDX: 00000000fffffffb RSI: ffff81007a821d28 RDI: ffff81007aa34708
> > [  155.526989] RBP: ffffffff807a0c60 R08: 0000000000000000 R09: ffff81007aac43b0
> > [  155.569759] R10: ffffffff804221e5 R11: 0000000000000058 R12: ffff81007aac4ab0
> > [  155.612533] R13: ffff81007aac43b0 R14: ffff81007aac4ab0 R15: 00000000fffffffb
> > [  155.655303] FS:  00002aeb361606d0(0000) GS:ffffffff80a46000(0000) knlGS:0000000000000000
> > [  155.703791] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > [  155.738195] CR2: 0000000000000048 CR3: 0000000070997000 CR4: 00000000000006e0
> > [  155.780969] Process swapper (pid: 0, threadinfo ffffffff80a64000, task ffffffff80696a00)
> > [  155.829404] Stack:  ffff81007a821d28 ffff81007aa34708 ffffffff807a0c80 ffffffff804728d9
> > [  155.877840]  ffff81007a821d28 ffff81007aa34708 ffffffff807a0cc0 ffffffff8047409c
> > [  155.922535]  00001000807a0d00 ffff81007aac4ab0 00000000fffffffb ffff81007aac4ab0
> > [  155.966085] Call Trace:
> > [  155.982416]  [<ffffffff804728d9>] super_written+0x30/0x65
> > [  156.015292]  [<ffffffff8047409c>] super_written_barrier+0xc4/0xd1
> > [  156.052297]  [<ffffffff8023a5a5>] bio_endio+0x56/0x5b
> > [  156.082688]  [<ffffffff8022d21b>] __end_that_request_first+0x1c9/0x4c9
> > [  156.122068]  [<ffffffff8024a0d6>] end_that_request_first+0xc/0xe
> > [  156.158343]  [<ffffffff8036a692>] blk_ordered_complete_seq+0x7c/0x8b
> > [  156.196705]  [<ffffffff8036a6d1>] post_flush_end_io+0x30/0x35
> > [  156.231419]  [<ffffffff8036a5b5>] end_that_request_last+0xd9/0xf6
> > [  156.268215]  [<ffffffff80422204>] scsi_end_request+0xad/0xd7
> > [  156.302573]  [<ffffffff80422637>] scsi_io_completion+0x3e1/0x3f0
> > [  156.339004]  [<ffffffff8042266c>] scsi_blk_pc_done+0x26/0x28
> > [  156.373357]  [<ffffffff8041d11e>] scsi_finish_command+0xa9/0xb2
> > [  156.409264]  [<ffffffff804229f9>] scsi_softirq_done+0xf4/0xfd
> > [  156.444143]  [<ffffffff80237f66>] blk_done_softirq+0x70/0x7f
> > [  156.478323]  [<ffffffff80211366>] __do_softirq+0x67/0xf4
> > [  156.510224]  [<ffffffff8025f95e>] call_softirq+0x1e/0x28
> > [  156.542083] 
> > [  156.542083] Code: 48 8b 40 48 48 85 c0 74 3f ff d0 f0 0f ba ab e0 01 00 00 03 
> 
> The barrier code is in there again.
> 
> mddev->pers is NULL in md_error(), so the test of


feel curious, how did you find out it is because "mddev->pers is NULL"?

thanks!


> !mddev->pers->error_handler oopsed.  Perhaps this is a real MD bug which is
> now being exposed by the new barrier-handling problem.
> 
> 
> This should get you further, but...
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Cc: Neil Brown <neilb@suse.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/md/md.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN drivers/md/md.c~md-oops-workaround drivers/md/md.c
> --- a/drivers/md/md.c~md-oops-workaround
> +++ a/drivers/md/md.c
> @@ -4586,6 +4586,8 @@ void md_error(mddev_t *mddev, mdk_rdev_t
>  		__builtin_return_address(0),__builtin_return_address(1),
>  		__builtin_return_address(2),__builtin_return_address(3));
>  */
> +	if (!mddev->pers)
> +		return;
>  	if (!mddev->pers->error_handler)
>  		return;
>  	mddev->pers->error_handler(mddev,rdev);
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

