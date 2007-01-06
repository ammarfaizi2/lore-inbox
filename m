Return-Path: <linux-kernel-owner+w=401wt.eu-S1751338AbXAFKgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXAFKgN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 05:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXAFKgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 05:36:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:64480 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXAFKgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 05:36:12 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 05:36:11 EST
From: Torsten Kaiser <kernel@bardioc.dyndns.org>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Date: Sat, 6 Jan 2007 11:30:07 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org
References: <368051775.16914@ustc.edu.cn> <200701061052.00455.kernel@bardioc.dyndns.org> <20070106100255.GH11203@kernel.dk>
In-Reply-To: <20070106100255.GH11203@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061130.07467.kernel@bardioc.dyndns.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:22445e7a21522a805aae47a273aa1695
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2007 11:02, Jens Axboe wrote:
> On Sat, Jan 06 2007, Torsten Kaiser wrote:
> > On Saturday 06 January 2007 04:59, Andrew Morton wrote:
> > > http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically
> > > 2.6.20-rc3-mm1, minus git-block.patch.  Can you and Torsten please
> > > test that, see if the hangs go away?
> >
> > Works for me too.
>
> Torsten, can you test XFS with barriers disabled? I have a feeling that
> is where the problem lies.

With your patch from Bug 7775: Same hang detected by NMI watchdog
Pure rc3-mm1: Now triggers also the NMI watchdog:
[   34.942639] ACPI: (supports<6>Time: tsc clocksource has been installed.
[   34.962607] Clock event device lapic disabled
[   34.975717] Clock event device pit configured with caps set: 08
[   34.993526] Switched to high resolution mode on CPU 0
[   35.008720] Time: pit clocksource has been installed.
[   35.028823]  S0 S1 S4 S5)
[   35.052336] XFS mounting filesystem sdb6
[   40.940722] BUG: NMI Watchdog detected LOCKUP on CPU0, eip c0109ce5, 
registers:
[   40.962737] Modules linked in:
[   40.971991] CPU:    0
[   40.971992] EIP:    0060:[<c0109ce5>]    Not tainted VLI
[   40.971995] EFLAGS: 00000046   (2.6.20-rc3-mm1 #3)
[   41.009208] EIP is at pit_read+0x25/0xa0
[   41.021008] eax: 00000005   ebx: 00000052   ecx: 00000000   edx: 
00000082
[   41.041376] esi: 0009ba52   edi: 3922e0ca   ebp: 0004fc3a   esp: 
dff839e0
[   41.061742] ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
[   41.079253] Process swapper (pid: 1, ti=dff82000 task=dff81510 
task.ti=dff82000)
[   41.100915] Stack: 0004fc3a dff83a10 c01244c1 dff83a10 0004fc3a dff83a10 
3922e0ca dff83ad8
[   41.126659]        c0133081 00000000 dff83a30 c01330c6 459fa082 139adb41 
c052f080 80a5e194
[   41.152378]        c013344f 00000001 c052f130 c052f130 00000002 00000612 
c052f130 80a5e194
[   41.178099] Call Trace:
[   41.186077]  [<c01244c1>] getnstimeofday+0x31/0xc0
[   41.200569]  [<c0133081>] ktime_get_ts+0x11/0x40
[   41.214521]  [<c01330c6>] ktime_get+0x16/0x40
[   41.227692]  [<c013344f>] hrtimer_sched_tick+0x2f/0xd0
[   41.243199]  [<c0133a58>] hrtimer_interrupt+0x148/0x1e0
[   41.258969]  [<c010744f>] timer_interrupt+0x2f/0x40
[   41.273698]  [<c0143c60>] handle_IRQ_event+0x20/0x50
[   41.288689]  [<c0145391>] handle_level_irq+0x81/0x110
[   41.303937]  [<c01067f6>] do_IRQ+0x46/0x80
[   41.316329]  [<c011c4b1>] vprintk+0x201/0x2f0
[   41.329501]  [<c0104a96>] common_interrupt+0x2e/0x34
[   41.344490]  [<c023a88d>] cmn_err+0x9d/0xb0
[   41.357143]  [<c04202b7>] _spin_unlock_irqrestore+0x47/0x60
[   41.373976]  [<c023a88d>] cmn_err+0x9d/0xb0
[   41.386627]  [<c0218218>] xfs_log_mount+0x48/0x5d0
[   41.401098]  [<c021fbbd>] xfs_mountfs+0xb1d/0xfa0
[   41.415306]  [<c041fe09>] _spin_lock+0x29/0x40
[   41.428737]  [<c0231e93>] xfs_setsize_buftarg_flags+0x33/0xc0
[   41.446066]  [<c0227391>] xfs_mount+0x641/0x9c0
[   41.459758]  [<c0226d50>] xfs_mount+0x0/0x9c0
[   41.472928]  [<c0239e92>] vfs_mount+0x22/0x30
[   41.486099]  [<c0239cb8>] xfs_fs_fill_super+0x78/0x1e0
[   41.501608]  [<c025cf0f>] snprintf+0x1f/0x30
[   41.514518]  [<c01a2222>] disk_name+0x92/0xc0
[   41.527689]  [<c0169bd4>] get_sb_bdev+0x104/0x140
[   41.541900]  [<c0238ed0>] xfs_fs_get_sb+0x20/0x30
[   41.556109]  [<c0239c40>] xfs_fs_fill_super+0x0/0x1e0
[   41.572189]  [<c0169696>] vfs_kern_mount+0xb6/0x130
[   41.586920]  [<c0169769>] do_kern_mount+0x39/0x60
[   41.601130]  [<c017ec5c>] do_mount+0x42c/0x700
[   41.614560]  [<c041fd34>] _spin_unlock+0x14/0x20
[   41.628513]  [<c02585c6>] _atomic_dec_and_lock+0x16/0x60
[   41.644540]  [<c02585e1>] _atomic_dec_and_lock+0x31/0x60
[   41.660573]  [<c014c27a>] __get_free_pages+0x1a/0x40
[   41.675584]  [<c017d4d0>] copy_mount_options+0x40/0x150
[   41.691354]  [<c017efa2>] sys_mount+0x72/0xb0
[   41.704524]  [<c0576e9e>] mount_block_root+0x8e/0x270
[   41.719774]  [<c0171d57>] sys_mknod+0x27/0x30
[   41.732946]  [<c05770d0>] mount_root+0x50/0x90
[   41.746376]  [<c0577222>] prepare_namespace+0x112/0x150
[   41.762145]  [<c016658f>] sys_access+0x1f/0x30
[   41.775577]  [<c0576842>] init+0x132/0x1a0
[   41.787966]  [<c0576710>] init+0x0/0x1a0
[   41.799840]  [<c0576710>] init+0x0/0x1a0
[   41.811711]  [<c0104c2f>] kernel_thread_helper+0x7/0x18
[   41.827481]  =======================
[   41.838235] Code: 31 00 8d 74 26 00 56 b8 e0 b7 52 c0 53 e8 b4 64 31 00 
8b 35 20 e0 52 c0 89 c2 31 c0 e6 43 e6 80 e4 40 e6 80 0f b6 d8 e4 40 e6 80 
<0f> b6 c0 c1 e0 08 09 c3 81 fb 9c 2e 00 00 7e 1
[   41.899752]  [   41.903993]

I used the following kernel commandline:
root=/dev/sdb6 console=ttyS0,38400 console=tty1 lapic rootflags=nobarrier

I also added nobarrier to the fstab entry for my root.

Just to mention it: My system does not use any RAID devices, not even the 
drivers are getting complied.
