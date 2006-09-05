Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWIEJT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWIEJT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWIEJT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:19:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8681 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965112AbWIEJTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:19:25 -0400
Date: Tue, 5 Sep 2006 11:19:24 +0200
From: Jan Kara <jack@suse.cz>
To: Bernd Schubert <bernd-schubert@gmx.de>
Cc: reiserfs-list@namesys.org, linux-kernel@vger.kernel.org
Subject: Re: quota problem with 2.6.15.7
Message-ID: <20060905091924.GC3830@atrey.karlin.mff.cuni.cz>
References: <200609021557.03885.bernd-schubert@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609021557.03885.bernd-schubert@gmx.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I just wanted to enable quotas on one of our server systems and got an oops.
> This is an opteron system with a kernel in 64bit mode. 
> As you can see, the filesystem is reiserfs.
  Hmm, is this reproducible? Any chances of trying out some newer
kernel?

> [8278222.836924] Unable to handle kernel paging request at 000000000fd00007 RIP:
> [8278222.842655] <ffffffff80394699>{__down_read+101}
> [8278222.851260] PGD f3509067 PUD adf61067 PMD 0
> [8278222.856596] Oops: 0002 [1] SMP
> [8278222.860597] CPU 1
> [8278222.863231] Modules linked in: ipt_MASQUERADE ipt_state iptable_filter nfsd exportfs iptable_nat ip_nat ip_conntrack ip_tables i2c_
> amd8111 pl2303 usbserial ohci_hcd usbcore bluesmoke_k8 bluesmoke_mc w83627hf i2c_isa lm85 adm1026 hwmon_vid i2c_amd756 i2c_core bcm5700
> [8278222.891808] Pid: 16212, comm: quotaon Not tainted 2.6.15.7 #1
> [8278222.898891] RIP: 0010:[<ffffffff80394699>] <ffffffff80394699>{__down_read+101}
> [8278222.907557] RSP: 0018:ffff81003b987b50  EFLAGS: 00010206
> [8278222.914370] RAX: ffff8100f81b1408 RBX: ffff810043336180 RCX: ffff8100f81b1530
> [8278222.923148] RDX: 000000000fd00007 RSI: 0000000000000000 RDI: ffff81003b987bc8
> [8278222.931931] RBP: ffff8100f81b1400 R08: 0000000000000000 R09: ffff810081ad9440
> [8278222.940723] R10: 0000000000001000 R11: ffffffff80394646 R12: 0000000000000001
> [8278222.949497] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> [8278222.958273] FS:  00002aaaaae00090(0000) GS:ffffffff80515880(0000) knlGS:00000000558dd2a0
> [8278222.968202] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [8278222.975283] CR2: 000000000fd00007 CR3: 00000000dc0aa000 CR4: 00000000000006e0
> [8278222.984061] Process quotaon (pid: 16212, threadinfo ffff81003b986000, task ffff810043336180)
> [8278222.994398] Stack: ffff8100f81b1408 0000000000000000 ffff810043336180 ffff810000000001
> [8278223.004002]        ffff8100f9fb23c0 0000000100000001 ffffffff00000000 0000000100000001
> [8278223.013841]        ffff810000000000 0000000000000000
> [8278223.020126] Call Trace:<ffffffff8017bc08>{link_path_walk+194} <ffffffff80394646>{__down_read+18}
> [8278223.030894]        <ffffffff80229853>{_atomic_dec_and_lock+43} <ffffffff801bc1f1>{reiserfs_quota_on+191}
> [8278223.042504]        <ffffffff8017bc08>{link_path_walk+194} <ffffffff80394646>{__down_read+18}
> [8278223.052854]        <ffffffff8019f482>{sys_quotactl+960} <ffffffff8014e2c5>{find_get_page+31}
> [8278223.063186]        <ffffffff8014ed81>{filemap_nopage+364} <ffffffff8015ec3e>{__handle_mm_fault+1740}
> [8278223.074364]        <ffffffff801766ac>{vfs_getattr_it+72} <ffffffff80176852>{vfs_fstat+108}
> [8278223.084496]        <ffffffff80176add>{cp_new_stat+233} <ffffffff80229853>{_atomic_dec_and_lock+43}
> [8278223.095483]        <ffffffff80183702>{dput+49} <ffffffff80187f9b>{mntput_no_expire+23}
> [8278223.105218]        <ffffffff8016dd9f>{filp_close+89} <ffffffff8010d852>{system_call+126}
> [8278223.115142]
> [8278223.118114]
> [8278223.118115] Code: 48 89 22 48 89 54 24 08 c7 45 04 01 00 00 00 fb 48 83 7c 24
> [8278223.129157] RIP <ffffffff80394699>{__down_read+101} RSP <ffff81003b987b50>
> [8278223.137621] CR2: 000000000fd00007
  Hmm, the trace looks strange... It is definitely mixed with some old
data. We definitely reached reiserfs_quota_on() but didn't reach
vfs_quota_on() so it seems we crashed somewhere in path_lookup() (also
link_path_walk() in the beginning of the trace suggests that). That's
generic VFS code so maybe this is nothing quota specific. So this looks
quite hard to debug if there's no reasonable way of reproducing it.

									Honza
